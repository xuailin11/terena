#!/bin/bash
a=0cc0b5fc62af6f35638b637ecb990fb8
while :
  do
    for j in 12 13
     do
       m=`curl 192.168.4.${j} 2> /dev/null | md5sum`
       if [ ${m:0:32} != $a ];then
          ipvsadm -ln | grep "192.168.4.${j}" &> /dev/null
         [ $? -eq 0 ] && ipvsadm -d -t 192.168.4.20:80 -r 192.168.4.${j}
      else
          ipvsadm -ln | grep "192.168.4.${j}" &> /dev/null
         [ $? -ne 0 ] && systemctl restart keepalived && iptables -F
       fi
     done
   done
