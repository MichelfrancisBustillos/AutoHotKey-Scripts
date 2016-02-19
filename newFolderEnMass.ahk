#NoTrayIcon
#SingleInstance, Force

#IfWinActive, ahk_class CabinetWClass 
!n:: ;Ctrl + N = Create new folder with selected items
Gui, Add, Text, , Would you like to Copy or Move the files?

Gui, Add, Button, gLabel1, Copy

Gui, Add, Button, gLabel2, Move

Gui, Show, w250 h100

Return



label1:
Gui, Submit
{
inputbox, foldername, Create new Folder, What would you like to name the folder?
If (foldername="")
{
return
}
send ^c
sleep 100
 send ^+n
send %foldername%
send {enter}
sleep 100
send {enter}
sleep 300
send ^v
Return
}
label2:
Gui, Submit
{
inputbox, foldername, Create new Folder, What would you like to name the folder?
If (foldername="")
{
return
}
send ^x
sleep 100
 send ^+n
send %foldername%
send {enter}
sleep 100
send {enter}
sleep 300
send ^v
Return
}