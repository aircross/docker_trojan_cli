# 3.8版
#FROM alpine:3.8
# 安装最新版
FROM alpine:latest
# 安装curl
RUN apk add --update wget curl jq && rm -rf /var/cache/apk/*
LABEL org.opencontainers.image.authors="John <admin@vps.la>" version="0.01"



# 说明：本Docker是Linux版本的Trojan客户端
# 默认版本
# 当前只支持
ENV DEF_VERSION 1.16.0
ENV RUN_PATH trojan-cli
WORKDIR /

# 添加时区，并设置为上海
RUN set -xe && \
    apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

# 读取平台类型并保存到PLATFORM
# 下载执行文件
# https://github.com/trojan-gfw/trojan/releases/download/v1.14.1/trojan-1.14.1-linux-amd64.tar.xz

RUN set -x && \
	mkdir ${WORKDIR}/${RUN_PATH} && \
	cd ${WORKDIR}/${RUN_PATH} && \
	VER=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/latest | grep tag_name | cut -d '"' -f 4) && \
	VER_NUM=${VER:1} && \
	echo "数字版本号" && \
	echo $VER_NUM && \
	echo "数字版本号" && \
	URL=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/tags/${VER} | jq .assets[0].browser_download_url | tr -d \") && \
	echo "在线获取的======================" && \
	echo $URL && \
	echo "在线获取的======================" && \
	echo $VER >> ${WORKDIR}/${RUN_PATH}/setup.log && \
	echo $URL >> ${WORKDIR}/${RUN_PATH}/setup.log && \
	echo $VER && \
	wget --no-check-certificate $URL && \
	tar -xf trojan-${VER_NUM}-linux-amd64.tar.xz && \
	# cd trojan-${VER_NUM}-linux-amd64 && \
	# cd trojan && \
	mv trojan/trojan ${WORKDIR}/${RUN_PATH}/trojan && \
	mv trojan/config.json ${WORKDIR}/${RUN_PATH}/config.json && \
	rm -rf trojan && \
	rm -rf trojan-${VER_NUM}-linux-amd64.tar.xz

VOLUME ${WORKDIR}/${RUN_PATH}/

CMD ${WORKDIR}/${RUN_PATH}/trojan -c config.json
# 错误的
# https://github.com/trojan-gfw/trojan/releases/download/1.16.0/trojan-1.16.0-linux-amd64.tar.xz
# 在线复制的
# https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.xz

# ${substring/string/replacement}	