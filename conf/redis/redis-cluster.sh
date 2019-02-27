#!/bin/bash

# 1、注意redis配置信息的路径
# 2、以上的代码都是centOS命令行上输入的
# 3、阿里云上要添加安全组，除了7000-7005端口，还要开放17000-17005端口

docker network create redis-net

for port in `seq 7000 7005`; do
  mkdir -p /data/webserver/dnmp/conf/redis/${port}/conf \
  && PORT=${port} envsubst < /data/webserver/dnmp/conf/redis/redis-cluster.tmpl > /data/webserver/dnmp/conf/redis/${port}/conf/redis.conf \
  && mkdir -p /data/webserver/dnmp/conf/redis/${port}/data;
done

for port in `seq 7000 7005`; do
  docker run -d -ti -p ${port}:${port} -p 1${port}:1${port} \
  -v /data/webserver/dnmp/conf/redis/${port}/conf/redis.conf:/usr/local/etc/redis/redis.conf \
  -v /data/webserver/dnmp/conf/redis/${port}/data:/data \
  --restart always --name redis-${port} --net redis-net \
  --sysctl net.core.somaxconn=1024 redis redis-server /usr/local/etc/redis/redis.conf
done

echo yes | docker run -i --rm --net redis-net ruby sh -c '\
  gem install redis \
  && wget http://download.redis.io/redis-stable/src/redis-trib.rb \
  && ruby redis-trib.rb create --replicas 1 \
  '"$(for port in `seq 7000 7005`; do \
    echo -n "$(docker inspect --format '{{ (index .NetworkSettings.Networks "redis-net").IPAddress }}' "redis-${port}")":${port} ' ' ; \
  done)"
# redis-cli --cluster create 172.19.0.2:7000 172.19.0.3:7001 172.19.0.4:7002 172.19.0.5:7003 172.19.0.6:7004 172.19.0.7:7005 --cluster-replicas 1
echo yes | sh -c '\
  redis-cli --cluster-replicas 1 --cluster create  \
  '"$(for port in `seq 7000 7005`; do \
    echo -n "$(docker inspect --format '{{ (index .NetworkSettings.Networks "redis-net").IPAddress }}' "redis-${port}")":${port} '  ' ; \
  done)"  