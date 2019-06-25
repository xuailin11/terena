#!/bin/bash
#一键安装
install(){
for i in {51..56}
do
sh root@192.168.4.$i "cd /redis ; tar -xf redis-4.0.8.tar.gz ; yum -y install gcc ; cd redis-4.0.8 ; make && make install"
sh root@192.168.4.$i "/redis/redis-4.0.8/utils/install_server.sh"
done
}
##########################################################################################################################
#配置文件修改
change(){
for i in {51..56}
do
sh root@192.168.4.$i "sed -r -i '93s/^(.*)(6379)$/\163$i/' /etc/redis/6379.conf"
ssh root@192.168.4.$i "sed -r -i '70s/^(.*)(127.0.0.1)$/\1 192.168.4.$i/' /etc/redis/6379.conf"
ssh root@192.168.4.$i "sed -r -i '43s/^(.*CLIEXEC)(.*)(shutdown)/\1 -h 192.168.4.$i -p 63$i \3/' /etc/init.d/redis_6379"
done
}
##########################################################################################################################
#集群配置文件
jiqun(){
for i in {51..56}
do
ssh root@192.168.4.$i "sed -i -r '815s/^(# )(.*)/\2/' /etc/redis/6379.conf"
ssh root@192.168.4.$i "sed -i -r '823s/^(# )(.*)(6379.conf)/\263$i.conf/' /etc/redis/6379.conf"
ssh root@192.168.4.$i "sed -i -r '829s/^(# )(.*)(15000)/\25000/' /etc/redis/6379.conf"
done
}

install
change
jiqun




