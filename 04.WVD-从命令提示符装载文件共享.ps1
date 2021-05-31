#！！！请修改！！！！！
$StorageAccountName = "wvdfslogix"
$SAkey = "zBuRHaGYSIo2hygFBFU8tq8HN+Afe+kw1dKFGkHVAxTg5Jg1APz8qupj5LEy8RBrKU2yWb4n/YZVSeAeHSjBfQ=="
$sharename = "wvduserprofile"
$DesiredDriveLetter = "z:"

#无需修改
$ComputerName = "$StorageAccountName.file.core.chinacloudapi.cn"
$UNCPath = "\\$ComputerName\$sharename"

#从命令提示符装载文件共享
$connectTestResult = Test-NetConnection -ComputerName $ComputerName -Port 445
if ($connectTestResult.TcpTestSucceeded)
{
  net use $DesiredDriveLetter $UNCPath /user:Azure\$StorageAccountName $SAkey
} 
else
{
  Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN,   Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}

#获取UNCPath信息
$UNCPath


#！！！请使用admin权限运行命令提示符（cmd）来执行！！！！！！！！！！！！！！！！！！！！
#查看对 Azure 文件共享的访问权限
icacls $DesiredDriveLetter

#运行以下命令可允许 Windows 虚拟机用户创建自己的配置文件容器，同时阻止其他用户访问其配置文件容器
icacls z: /grant WVDUserGroup@njlab.cn:(M)
icacls z: /grant "Creator Owner":(OI)(CI)(IO)(M)
icacls z: /remove "Authenticated Users"
icacls z: /remove "Builtin\Users"