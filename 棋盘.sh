#!/bin/bash
for i in {1..8}
   do
     for j in {1..8}
       do
          if [ $[(i+j)%2] -eq 0 ];then  #变量重点
             echo -ne "\033[43m  \033[0m"
          else
             echo -ne "\033[41m  \033[0m"
          fi
       done
      echo
   done
