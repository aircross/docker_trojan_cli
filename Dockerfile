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
# 默认SOCK端口
ENV SP 1080
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
	# mkdir ${RUN_PATH} && \
	# cd ${RUN_PATH} && \
	VER=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/latest | grep tag_name | cut -d '"' -f 4) && \
	VER_NUM=${VER:1} && \
	URL=$(curl -s https://api.github.com/repos/trojan-gfw/trojan/releases/tags/${VER} | jq .assets[0].browser_download_url | tr -d \") && \
	wget --no-check-certificate $URL && \
	tar -xf trojan-${VER_NUM}-linux-amd64.tar.xz && \
	mv trojan ${RUN_PATH} && \
	echo "ls输出当前目录：" && \
	ls ./ && \
	pwd && \
	# mv trojan/trojan ${RUN_PATH}/trojan && \
	echo "ls输出目录：${RUN_PATH}/" && \
	ls ${RUN_PATH} && \
	pwd && \
	# cd trojan-${VER_NUM}-linux-amd64 && \
	wget --no-check-certificate https://raw.githubusercontent.com/aircross/docker_trojan_cli/master/config.json && \
	wget --no-check-certificate https://raw.githubusercontent.com/aircross/docker_trojan_cli/master/init.sh && \
	echo "ls输出当前目录(下载后)：" && \
	ls ./ && \
	pwd && \
    mv /trojan-cli/config.json /trojan-cli/config.json.sample && \
    mv /config.json /trojan-cli/config.json && \
    mv /init.sh /trojan-cli/init.sh && \
    chmod +x /trojan-cli/init.sh && \
	# mv config.json /${RUN_PATH}/config.json && \
	# mv init.sh /${RUN_PATH}/init.sh && \
	echo "ls输出当前目录（移动后）：" && \
	ls ./ && \
	pwd && \
	echo "ls输出目录：${RUN_PATH}/" && \
	ls ${RUN_PATH} && \
	pwd
	# chmod +x /${RUN_PATH}/init.sh && \
	# chmod +x /${RUN_PATH}/trojan
	# cat config.json && \
	# sed -i '/\/sbin\/nologin/s/login/LOGIN/g' passwd && \
	# ls && \
	# mv trojan/config.json ${RUN_PATH}/config.json && \
	# rm -rf trojan && \
	# rm -rf trojan-${VER_NUM}-linux-amd64.tar.xz

# VOLUME ${RUN_PATH}/
# COPY config.json ${RUN_PATH}/config.json
# ENTRYPOINT ["/$RUN_PATH/init.sh $SERVER $PASSWORD $SP"]

# ENTRYPOINT /${RUN_PATH}/init.sh ${SERVER} ${PASSWORD} ${SP} tt
ENTRYPOINT  ["/$RUN_PATH/init.sh"]
CMD  ["$SERVER", "$PASSWORD", "$SP"]

# CMD ${RUN_PATH}/trojan -c config.json

# 错误的
# https://github.com/trojan-gfw/trojan/releases/download/1.16.0/trojan-1.16.0-linux-amd64.tar.xz
# 在线复制的
# https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.xz

# ${substring/string/replacement}	