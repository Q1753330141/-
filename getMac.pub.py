#!/usr/bin/env python

import Connectivity
import Systems 
import re
import MySQLdb
import time

def db_insert(d_time,host,vlan,macadd,port_type,port_id):
	conn=MySQLdb.connect(host='localhost',user='root',passwd='passwd',db='Cisco_Dev_Info',port=3306)
	cur=conn.cursor()
	cur.execute('insert into MacAdd_Info values(\''+d_time+'\',\''+host+'\',\''+vlan+'\',\''+macadd+'\',\''+port_type+'\',\''+port_id+'\')')
	cur.close()
	conn.close()
	
#telnet to a cisco switch
def getMAC(d_time,host,host_ip,usr,pwd,pwd_en):
	m = Systems.OperatingSystems['IOS']
	s = Connectivity.Session(host_ip,23,"telnet",m)
	s.login(usr, pwd)

	s.escalateprivileges(pwd_en)
	str=s.sendcommand("show mac address-table")
	str_re='.*Fa.*'
	rows=re.findall(str_re,str)
	for row in rows:
		cols=row.split()
		db_insert(d_time,host,cols[0],cols[1],cols[2],cols[3])
	s.logout()

hosts=[]
hosts.append(['SH-SH-25FN-SW01','10.xxx.xxx.21','','passwd','passwd_en'])
hosts.append(['SH-SH-25FN-SW-02','10.xxx.xxx.20','','passwd_en','passwd_en'])
hosts.append(['SH-SH-25FS-SW-01','10.xxx.xxx.22','','passwd_en','passwd_en'])
hosts.append(['SH-SH-25FS-SW-02','10.xxx.xxx.23','','passwd_en','passwd_en'])
hosts.append(['SH-SH-28FS-SW-03','10.xxx.xxx.24','','passwd_en','passwd_en'])
hosts.append(['SH-SH-25FS-SW-04','10.xxx.xxx.25','','passwd_en','passwd_en'])

ISOTIMEFORMAT='%Y-%m-%d %X'
d_time=time.strftime( ISOTIMEFORMAT, time.localtime() )

for host in hosts: 
  getMAC(d_time,host[0],host[1],host[2],host[3],host[4])
