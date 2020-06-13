#/bin/bash
#Program:
#   该脚本用于对特定目标主机进行常见端口扫描(加载端口字典)或者指定端口扫描,判断目标主机开放来哪些端口
#用telnet方式
#History
#2020/6/6   1.0 alex
IP=$1
#获得IP的前三位
threeIP=$(echo $IP |awk -F. '{print $1"."$2"."$3"."}') 
#获得IP的第四位
endIP=$(echo $IP | awk -F. '{print $4}')
if [ $1 ]
then
  if [ $2 ]
    then
    #IP的第四位为0表明是一个网段,对整个网段进行特定端口的扫描,发现哪个主机开放特定端口
    if [ $endIP -eq 0 ]
    then
      for ((i=128;i<=140;i++))
      do
        (sleep 1;)|telnet $threeIP$i $2 2>&1 |grep "Connected to $threeIP$i">/dev/null 
        if [ $? -eq 0 ]
        then
          echo "主机$threeIP$i开放$2端口!"
        else
          echo "主机$threeIP$i的$2端口关闭!"         
        fi
      done
    else
      #IP的第四位不为0,说明是单个IP,对单个IP进行特定端口扫描
      (sleep 1;)|telnet $1 $2 2>&1 |grep "Connected to $1">>./dev/null.txt
       if [ $? -eq 0 ]
       then
         echo "主机$1开放$2端口！"
       else
         echo "主机$1的$2端口关闭!"      
       fi
    fi  
  else
      #脚本只有一个IP参数,根据IP的第四位是否为0来判断是否为网段,因为没有端口参数,扫描默认端口
    if [ $endIP -eq 0 ]
    then
      for ((i=128;i<=130;i++))
      do
        for port in $(cat defaultport.txt)
        do
          (sleep 1;)|telnet $threeIP$i $port 2>&1 |grep "Connected to $threeIP$i">/dev/null
          if [ $? -eq 0 ]
          then
            echo "主机$threeIP$i开放$port端口!"
          else
            echo "主机$threeIP$i的$port端口关闭!"          
          fi
        done
      done
    else
      #脚本只有IP一个参数,没有端口参数,加载端口字典扫描默认端口
      for i in `cat defaultport.txt`
      do
        #与目标主机的特定端口只通信1秒,根据返回的数据来判断目标是否开放特定端口
        (sleep 1;)|telnet $1 $i 2>&1 |grep "Connected to">>./dev/null.txt
        if [ $? -eq 0 ]
        then
	  echo "主机$1开放$i端口"
          echo "主机$1开放$i端口">>./dev/null.txt
        else
	  echo "主机$1关闭$i端口"
          echo "主机$1关闭$i端口">>./dev/null.txt
        fi
      done
    fi
  fi       
else
  echo "******************************************* 
  该脚本的用法示例:  
  $0 192.168.1.1(扫描默认端口)
  $0 192.168.1.1 portx(扫描指定IP指定端口portx)
  $0 192.168.1.0(扫描指定网段,扫描默认端口)
  $0 192.168.1.0 portx(扫描指定网段指定端口portx) 
******************************************** "  
fi
