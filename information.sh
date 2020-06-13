#!/bin/bash
#Program:
#  信息收集
#History
#2020/6/6 1.0  alex
function gethostip(){
	result=`dig +short $1 | awk 'NR==1{print $0}'`
	url=$1
	#echo $result
	num=`echo $result | grep -E "^(([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+))$" | wc -l`
	#echo $num

	if [ $num -eq 0 ];then
		#echo "This is CNAME"
		gethostip $result
	else
		dig +short $url
	fi
}
gethostip $1
