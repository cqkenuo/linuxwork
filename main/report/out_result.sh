#!/bin/bash
#program:
#      以时间格式命名测试报告  format:url_yyyy/m/d/h/m/s
#History
#2020/6/11    alex
if [ ! -d "$*_result" ]; then  #判断目录是否存在
        mkdir "$*_result"
        echo "mkdir successful"
fi
touch  "$*_result/$*_`date +%Y%m%d`_`date +%H%M%S`.txt"
exit 0;
