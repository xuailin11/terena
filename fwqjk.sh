#!/bin/bash
echo -ne "系统负载:\t"
uptime | awk '{print $8}' | sed -nr 's/,//p'
echo -ne "网卡流量:\t"
ifconfig eth0 | awk '/RX p/{print $5/1024/1024"M"}'
echo -ne "剩余容量:\t"
free -h | awk '$1~/Mem/{print $4}'
echo -ne "磁盘剩余容量:\t"
df -h | awk '$6=="/"{print $4}'
echo -ne "用户数量:\t"
cat /etc/passwd | wc -l
echo -ne "登录账户数:\t"
who | awk '$1~/[^(unknown)]/{A[$1]++}END{for(i in A)print A[i]}'
echo -ne "软件包数:\t"
rpm -qa | wc -l
