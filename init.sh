CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    # 此处插入你要执行的命令或者脚本文件
    # 根据参数修改config.json
    # 再执行trojan -c config.json
    if [ "$3" = 'redis-server' -a "$(id -u)" = '0' ]; then
        echo "如果第一个参数为:redis-server"
    fi
    # $SERVER $PASSWORD $SP
    # sed -i "s/trojan_server/$1/g;s/trojan_pwd/$2/g;s/trojan_prot/$3/" /trojan-cli/config.json
    sed -i "s/trojan_server/$1/g;s/trojan_pwd/$2/g;s/1080/$3/" /trojan/config.json
    mkdir /trojan-cli
    mv /trojan/trojan /trojan-cli/trojan
    mv /trojan/config.json /trojan-cli/config.json
    pwd
    ls ./
    ls /trojan-cli
    /trojan-cli/trojan -c /trojan-cli/config.json
else
    echo "-- Not first container startup --"
    # 直接执行trojan -c config.json
    cat /trojan-cli/config.json
    pwd
    ls ./
    ls /trojan-cli
    /trojan-cli/trojan -c /trojan-cli/config.json
fi
