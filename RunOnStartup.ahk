#NoTrayIcon
#SingleInstance, Force
DetectHiddenWindows, On
SetTitleMatchMode, 2

MsgBox,, AutoHotKey Startup, Starting AutoHotKeyScripts..., 5


IfWinNotExist, KeyboardShortcuts.ahk
	Run, KeyboardShortcuts.ahk
	MsgBox,, AutoHotKey Startup, Starting KeyboardShortcuts.ahk..., 5
return
IfWinExist, KeyboardShortcuts.ahk
	MsgBox,, AutoHotKey Startup, KeyboardShortcuts.ahk Already Running..., 5
return

IfWinNotExist, ListShortcuts.ahk
	Run, ListShortcuts.ahk
	MsgBox,, AutoHotKey Startup, Starting ListShortcuts.ahk..., 5
return
IfWinExist, ListShortcuts.ahk
	MsgBox,, AutoHotKey Startup, ListShortcuts.ahk Already Running..., 5
return

IfWinNotExist, newFolderEnMass.ahk
	Run, newFolderEnMass.ahk
	MsgBox,, AutoHotKey Startup, Starting newFolderEnMass.ahk..., 5
return
IfWinExist, newFolderEnMass.ahk
	MsgBox,, AutoHotKey Startup, newFolderEnMass.ahk Already Running..., 5
return