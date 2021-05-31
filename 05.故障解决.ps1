#清理凭据
cmdkey /delete:domain:target=afsadtest01.file.core.chinacloudapi.cn
net use z: /delete

#重新装载
net use z: \\afsadtest01.file.core.chinacloudapi.cn\share01