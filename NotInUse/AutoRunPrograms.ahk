; #NoTrayIcon
#SingleInstance, force
Loop
{
	Sleep 300000 ;
	Process, Exist, Start.exe
	If (ErrorLevel = 0)
	{
		Run, E:\Portable Apps\Start.exe
	}
	Else
	{
		Sleep 5
	}
	Process, Exist, explorer.exe
	If (ErrorLevel = 0)
	{
		Run, C:\Windows\explorer.exe
	}
	Else
	{
		Sleep 5
	}
	Process, Exist, AutoHotKey.exe
	If (ErrorLevel = 0)
	{
		Run, E:\Portable Apps\PortableApps\AutoHotkey_LPortable\AutoHotkey_LPortable.exe
	}
	Else
	{
		Sleep 5
	}
}
Return