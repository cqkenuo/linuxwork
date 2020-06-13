# -*- coding: utf-8 -*-

import os
import sys
import re
import time

rulelist = [
    '(\$_(GET|POST|REQUEST)\[.{0,15}\]\s{0,10}\(\s{0,10}\$_(GET|POST|REQUEST)\[.{0,15}\]\))',
    '(base64_decode\([\&;"][\w\+/=]{200,}[\&;"]\))',
    '(eval(\s|\n)*\(base64_decode(\s|\n)*\((.|\n){1,200})',
    '((eval|assert)(\s|\n)*\((\s|\n)*\$_(POST|GET|REQUEST)\[.{0,15}\]\))',
    '(\$[\w_]{0,15}(\s|\n)*\((\s|\n)*\$_(POST|GET|REQUEST)\[.{0,15}\]\))',
    '(call_user_func\(.{0,15}\$_(GET|POST|REQUEST))',
    '(preg_replace(\s|\n)*\(.{1,100}[/@].{0,3}e.{1,6},.{0,10}\$_(GET|POST|REQUEST))',
    '(wscript\.shell)',
    '(cmd\.exe)',
    '(shell\.application)',
    '(documents\s+and\s+settings)',
    '(system32)',
    '(serv-u)',
    '(phpspy)',
    '(jspspy)',
    '(webshell)',
    '(Program\s+Files)'
]

def Scan(path):
    print('               可疑文件                 ')
    print('########################################')    
    for root,dirs,files in os.walk(path):
        for filespath in files:
            if os.path.getsize(os.path.join(root,filespath))<1024000:
                file= open(os.path.join(root,filespath))
                filestr = file.read()
                file.close()
                for rule in rulelist:
                    result = re.compile(rule).findall(filestr)
                    if result:
                        print( '文件：'+os.path.join(root,filespath))
                        print( '恶意代码：'+str(result[0])[0:200])
                        print('最后修改时间：'+time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(os.path.getmtime(os.path.join(root,filespath)))))
                        print ('\n\n')
                        break

#由文件最后修改时间扫描
def _Get_Time_Files(_path,_time):
    _time = time.mktime(time.strptime(_time, '%Y-%m-%d %H:%M:%S'))
    print('\n')
    print('             可疑文件                   ')
    print('########################################')
    print('文件路径           最后修改时间   \n')
        
    for _root,_dirs,_files in os.walk(_path):
        for _file in _files:
            if _file.find('.')!=-1:
                _txt = _file[(_file.rindex('.')+1):].lower()
                    
                if _txt=='php' or _txt=='jsp': 
                    _File_Time =os.path.getmtime(_root+'/'+_file)
                    if _File_Time>_time:
                        print(_root+'/'+_file+'    '+ time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(os.path.getmtime(_root+'/'+_file))))
                        

if len(sys.argv)!=3 and len(sys.argv)!=2:
    print('【参数错误】:')
    print('\t按恶意代码查杀: '+sys.argv[0]+' 目录名')
    print('\t按修改时间查杀: '+sys.argv[0]+' 目录名 修改时间(格式:"2013-09-09 12:00:00")')
if os.path.lexists(sys.argv[1])==False:
    print('提示：指定的扫描目录不存在--- 囧')

print('\n\n开始查杀：'+sys.argv[1])   

if len(sys.argv)==2:
    Scan(sys.argv[1])
else:
    _Get_Time_Files(sys.argv[1],sys.argv[2])

print('提示：查杀完成')
