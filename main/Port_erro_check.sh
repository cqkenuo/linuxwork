#!/bin/bash
#Program:
#  该脚本用于检测端口所存在的问题
#History
#2020/6/8 alex
Port_server=([21]=ftp/tftp/vsftpd [22]=ssh [23]=Telnet [25]=SMTP [53]=DNS [67]=dhcp [68]=dhcp [110]=pop3 [139]=Samba [143]=Imap [161]=SNMP [389]=Ldap [445]=smb [512]=Linux Rexec [513]=Linux Rexec [514]=Linux Rexec [873]=Rsync [1080]=socket [1352]=Lotus domino [1433]=mssql [1521]=oracle [2049]=Nfs [2181]=zookeeper [2375]=docker remote api [3306]=mysql [3389]=Rdp [4848]=GlassFish [5000]=sybase/DB2 [5432]=postgresql [5632]=pcanywhere [5900]=vnc [6379]=Redis [7001]=weblogic [7002]=weblogic [80]=http/https [443]=http/https [8069]=zabbix [8161]=activemq [8080]=Jboss/Tomcat/Resin [8089]=Jboss/Tomcat/Resin [8083]=influxDB [8086]=influxDB [9000]=fastcgi [9090]=Websphere [9200]=elasticsearch [9300]=elasticsearch [11211]=memcached [27017]=mongodb [27018]=mongodb)
Port_error=([21]=爆破/嗅探/溢出/后门 [22]=爆破/opemssh)
Port=$1
echo ${Port_server[$Port]}
echo ${Port_error[$Port]}
