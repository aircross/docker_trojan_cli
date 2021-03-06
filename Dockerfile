# 3.8版
#FROM alpine:3.8
# 安装最新版
FROM ubuntu:20.04
# 安装curl
LABEL org.opencontainers.image.authors="John <admin@vps.la>" version="0.01"

# 说明：本Docker是Linux版本的Trojan客户端
# 默认版本
# 当前只支持
ENV DEF_VERSION 1.16.0
ENV RUN_PATH trojan-cli
# 默认SOCK端口
ENV SP 1080
WORKDIR /

# 安装编译器
RUN apt-get update
RUN apt-get install gcc -y
RUN apt-get install g++ -y
RUN apt-get install make -y
RUN apt-get install wget curl jq xz-utils -y

# 暴露80端口
EXPOSE $SP

# 添加时区，并设置为上海

# 读取平台类型并保存到PLATFORM
# 下载执行文件
# https://github.com/trojan-gfw/trojan/releases/download/v1.14.1/trojan-1.14.1-linux-amd64.tar.xz

RUN set -x && \
	# mkdir ${RUN_PATH} && \
	# cd ${RUN_PATH} && \
	VER=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/latest | grep tag_name | cut -d '"' -f 4) && \
	# VER_NUM=bash ${VER:1} && \
	VER_NUM=$(echo $VER|cut -b 2-) && \
	echo VER_NUM && \
	URL=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/tags/${VER} | jq .assets[0].browser_download_url | tr -d \") && \
	wget --no-check-certificate $URL && \
	tar -xf trojan-${VER_NUM}-linux-amd64.tar.xz && \
	# mv trojan ${RUN_PATH} && \
	chmod +x trojan/trojan && \
	# mv trojan/trojan ${RUN_PATH}/trojan && \
	# cd trojan-${VER_NUM}-linux-amd64 && \
	wget --no-check-certificate https://raw.githubusercontent.com/aircross/docker_trojan_cli/master/config.json && \
	wget --no-check-certificate https://raw.githubusercontent.com/aircross/docker_trojan_cli/master/init.sh && \
	echo "ls输出当前目录(下载后)：" && \
	ls ./ && \
	pwd && \
    mv /trojan/config.json /trojan/config.json.sample && \
    mv /config.json /trojan/config.json && \
    # mv /init.sh /trojan-cli/init.sh && \
    chmod +x /init.sh
ENTRYPOINT  /bin/bash /init.sh $SERVER $PASSWORD $SP
# CMD  ["echo $SERVER", "echo $PASSWORD", "echo $SP"]

# CMD ${RUN_PATH}/trojan -c config.json

# 错误的
# https://github.com/trojan-gfw/trojan/releases/download/1.16.0/trojan-1.16.0-linux-amd64.tar.xz
# 在线复制的
# https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.xz
