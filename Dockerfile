# 3.8版
#FROM alpine:3.8
# 安装最新版
FROM alpine:latest
# 安装curl
RUN apk add --update curl jq && rm -rf /var/cache/apk/*
MAINTAINER John <admin@vps.la>


# 说明：本Docker是Linux版本的Trojan客户端
# 默认版本
# 当前只支持
ENV DEF_VERSION 1.16.0
WORKDIR /trojan-cli

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
	mkdir ${WORKDIR} && \
	cd ${WORKDIR} && \
	VER=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/latest | grep tag_name | cut -d '"' -f 4) && \
	URL=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/tags/${VER} | jq .assets[0].browser_download_url | tr -d \") && \
	echo $VER >> ${WORKDIR}/setup.log && \
	echo $URL >> ${WORKDIR}/setup.log && \
	wget --no-check-certificate ${URL}
	tar -xf trojan-${VER}-linux-amd64.tar && \


VOLUME $WORKDIR

CMD ${WORKDIR}/trojan -c config.json