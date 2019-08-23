# dnmp
Docker deploying Nginx MySQL PHP7 in one key, support full feature functions.

![Demo Image](./dnmp.png)


### Usage
1. Install `git`, `docker` and `docker-compose`;
2. Clone project:
    ```
    $ git clone https://github.com/ligang7138/dnmp.git
    ```
4. Start docker containers:
    ```
    $ docker-compose up -d
    ```
    You may need use `sudo` before this command in Linux.
5. Go to your browser and type `localhost`, you will see:

![Demo Image](./snapshot.png)

The index file is located in `./www/site1/`.

### HTTPS and HTTP/2
Default demo include 2 sites:
* http://www.site1.com (same with http://localhost)
* https://www.site2.com

To preview them, add 2 lines to your hosts file (at `/etc/hosts` on Linux and `C:\Windows\System32\drivers\etc\hosts` on Windows):
```
127.0.0.1 www.site1.com
127.0.0.1 www.site2.com
```
Then you can visit from browser.

docker-compose 来部署本地测试环境,频繁地执行docker-compose up/down 命令导致大量的创建container并且没有清空。

解决方法：docker system prune -a  删除所有没有使用的images，container，volume

停止docker 服务：#  systemctl stop docker.service


修改 /lib/systemd/system/docker.service

# vim /lib/systemd/system/docker.service

在 ExecStart=/usr/bin/dockerd 后面添加 --storage-driver devicemapper --storage-opt dm.loopdatasize=1000G --storage-opt dm.loopmetadatasize=10G --storage-opt dm.fs=ext4 --storage-opt dm.basesize=100G 
修改后为
ExecStart=/usr/bin/dockerd --storage-driver devicemapper --storage-opt dm.loopdatasize=1000G --storage-opt dm.loopmetadatasize=10G --storage-opt dm.fs=ext4 --storage-opt dm.basesize=100G
DOCKER最大空间为1000G，容器最大空间为100G


执行  #systemctl daemon-reload  重新加载配置启动文件


#  rm -rf   /var/lib/docker

#  systemctl start docker.service