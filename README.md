# Docker版的Trojan客户端

目的在于搭建Docker版的Trojan客户端，可以方便地运行在群辉之类的Docker容器中

# 功能介绍

## 服用方法
此 docker 教程与 docker 镜像由https://vps.la提供
1. 安装docker
```shell
curl -fsSL https://get.docker.com | sh
```
2. 安装trojan-cli
```shell
mkdir /opt/trojan-cli && cd /opt/trojan-cli
docker run -itd --network=host \
    -v /opt/trojan-cli:/trojan-cli/ \
    --name trojan-cli --restart=alway \
    aircross/docker_trojan_cli:latest
```

3. 修改配置文件
3.1 在Docker宿主机器执行修改配置文件命令
```shell
nano /trojan-cli/config.json
```
3.2 将文件中的trojan_server修改为自己的Trojan服务器地址
3.3 将文件中的443修改为自己的Trojan服务器端口，如果是443则忽略
3.4 将文件中的trojan_pwd修改为自己的Trojan连接密码
3.5 将文件中的1080修改为自己的Sock5服务端口，也可以保留默认

4. Build 自己的镜像
```shell
docker build -t docker_trojan_cli .
```
## 建议系统
- CentOS 7+
- Ubuntu 16+
- Debian 8+

## 计划

1、根据传入的参数生成配置文件config.json

2、自动启动进程

3、增加自定义端口支持
