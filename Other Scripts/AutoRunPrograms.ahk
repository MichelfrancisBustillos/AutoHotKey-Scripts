#NoTrayIcon
#SingleInstance, force

Loop
{
Sleep 60 ;
Process, Exist, AutoHotKey.exe
If (ErrorLevel = 0)
 {
 Run, C:\Program Files\AutoHotkey\AutoHotKey.exe
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
Process, Exist, Rainmeter.exe
If (ErrorLevel = 0)
 {
 Run, C:\Program Files\Rainmeter\Rainmeter.exe
 }
 Else
 {
 Sleep 5
 }
}
Return