'Auth:Qing.Yu
'Mail:1753330141@qq.com
' Ver:V1.3
'Date:2017-08-01

on error resume next
'net use \\xxx.xx.xx.33\c$ /delete

dim wshshell
set wshshell = createobject("wscript.shell")

dateStr=year(now) & right("0" & month(now),2) & right("0" & day(now),2)
Set fso = CreateObject("Scripting.FileSystemObject")
if not fso.DriveExists("D:") then
	mapFolder "D:","\\xx.xxx.xx.154\d$","administrator","1qaz@WSX"
end if
if not fso.FolderExists("D:\Trade\" & dateStr) then
	set desFolder=fso.CreateFolder("D:\Trade\" & dateStr)
	else 
	set desFolder=fso.GetFolder("D:\Trade\" & dateStr)
end if 

'ӳ��EzSRȡ�Ͻ�������
mapFolder "G:","\\xxx.xx.xx.33\c$\EzSR_DATA","administrator","xxxxxxxxx"
'�����Ͻ��������ļ�
fso.CopyFile "G:\mktdt00.txt", desFolder.path & "\mktdt00.txt"
fso.CopyFile "G:\mktdt03.txt", desFolder.path & "\mktdt03.txt"
'ӳ��biTransClientV3ȡfjy
mapFolder "G:","\\xxx.xx.xx.33\c$\biTransClientV3\Data\shfile","administrator","xxxxxxxxx"
'���Ʒǽ�����Ѷ
fso.CopyFile "G:\fjy" & dateStr &".txt", desFolder.path & "\fjy" & dateStr &".txt"
'ӳ��FxClientȡ�������
mapFolder "G:","\\xxx.xx.xx.51\c$\Users\Administrator\Desktop\FxClient\temp\F000000X0001","administrator","xxxxxxxxx"
'������������ļ�
fso.CopyFile "G:\cashsecurityclosemd_" & dateStr & ".xml", desFolder.path & "\cashsecurityclosemd_" & dateStr & ".xml"
fso.CopyFile "G:\securities_" & dateStr & ".xml", desFolder.path & "\securities_" & dateStr & ".xml"
fso.CopyFile "G:\issueparams_" & dateStr & ".xml", desFolder.path & "\issueparams_" & dateStr & ".xml"
'ӳ��EzTransȡ�Ͻ�������
mapFolder "G:","\\xxx.xx.xx.34\c$\EzTrans_Data","administrator","xxxxxxxxx"
'�ȴ��ļ���������
sleep(3000)
'��ѹ��GH�ļ�
wshshell.exec "c:\Program Files\WinRAR\WinRAR.exe x " & desFolder.path & "\*.zip " & desFolder.path & " -o+"
'�����Ͻ��������ļ���
fso.CopyFolder "G:\" & dateStr, desFolder.path
'wshshell.exec "c:\Program Files\WinRAR\WinRAR.exe x " & "G:\" & dateStr & "\*.zip " & desFolder.path & " -o+"
'ӳ��PROP���е������ļ�
mapFolder "G:","\\xxx.xx.xx.41\c$\prop2000\mailbox","administrator","xxxxxxxxx"
'����PROP���е������ļ�
fso.CopyFolder "G:\" & dateStr, desFolder.path
'ӳ��D-COMȡ���е�����
mapFolder "G:","\\xxx.xx.xx.57\c$\DownloadFiles","administrator","xxxxxxxxx"
'����D-COM����
fso.CopyFolder "G:\" & dateStr, desFolder.path
'�����������ݵ���ֵ
fso.CopyFolder "D:\Trade\" & dateStr, "D:\Hundsun\����\" & dateStr

sub mapFolder(drv,pathStr,usr,usrpwd)'"Y:","\\xxx.xx.xx.33\EzSR_DATA"
	'on error resume next
	Set WshNetwork = WScript.CreateObject("WScript.Network")
	'ɾ������ӳ��
	if fso.DriveExists(drv) then
		WshNetwork.RemoveNetworkDrive drv
	end if
	'���ӳ��
	WshNetwork.MapNetworkDrive drv, pathStr,false,usr,usrpwd
end sub