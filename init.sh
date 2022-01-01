CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    # 此处插入你要执行的命令或者脚本文件
    # 根据参数修改config.json
    # 再执行trojan -c config.json
    # $SERVER $PASSWORD $SP
    # sed -i '/\/trojan_server/s/trojan_server/$SERVER/g' /trojan-cli/config.json
    # sed -i '/\/trojan_pwd/s/trojan_server/$PASSWORD/g' /trojan-cli/config.json
    # sed -i '/\/1080/s/1080/$SP/g' /trojan-cli/config.json
    # /trojan-cli/trojan -c /trojan-cli/config.json
else
    echo "-- Not first container startup --"
    # 直接执行trojan -c config.json
    # /trojan-cli/trojan -c /trojan-cli/config.json
fi
