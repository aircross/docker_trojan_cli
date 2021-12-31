# 3.8版
#FROM alpine:3.8
# 安装最新版
FROM alpine:latest
# 安装curl
RUN apk add --update wget curl jq && rm -rf /var/cache/apk/*
MAINTAINER John <admin@vps.la>


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
	mkdir /trojan-cli && \
	cd ${WORKDIR}/${RUN_PATH} && \
	VER=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/latest | grep tag_name | cut -d '"' -f 4) && \
	URL=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/tags/${VER} | jq .assets[0].browser_download_url | tr -d \") && \
	echo $VER >> ${WORKDIR}/${RUN_PATH}/setup.log && \
	echo $URL >> ${WORKDIR}/${RUN_PATH}/setup.log && \
	echo $VER
RUN set -x && \
	URL=https://github.com/trojan-gfw/trojan/releases/download/${DEF_VERSION}/trojan-${DEF_VERSION}-linux-amd64.tar.xz && \
	echo URL && \
	wget --no-check-certificate URL
RUN set -x && \
	tar -xf trojan-${DEF_VERSION}-linux-amd64.tar.xz
RUN set -x && \
	cd trojan-${DEF_VERSION}-linux-amd64
RUN set -x && \
	mv trojan ${WORKDIR}/${RUN_PATH}/
RUN set -x && \
	mv config.json ${WORKDIR}/${RUN_PATH}/


VOLUME ${WORKDIR}/${RUN_PATH}

CMD ${WORKDIR}/${RUN_PATH}/trojan -c config.json