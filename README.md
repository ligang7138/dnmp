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
