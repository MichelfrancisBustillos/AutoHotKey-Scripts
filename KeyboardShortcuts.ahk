; #NoTrayIcon
#SingleInstance, Force

;***Windows Logo Key Shortcuts***

#n::Run, C:\Windows\system32\notepad.exe ;WindowsLogoKey + N = Open New Notepad
#c::Run, C:\Windows\system32\calc.exe ;WindowsLogoKey + C = Open Calculator

;***AppsKey Shortcuts***

;AppsKey + W,A,S,D = Up,Left,Down,Right
AppsKey & s::send, {down} ;AppsKey + S = Move Cursor Down
AppsKey & a::send, {left} ;AppsKey + D = Move Cursor Left
AppsKey & d::send, {right} ;AppsKey + A = Move Cursor Right
AppsKey & w::send, {up} ;AppsKey + W = Move Cursor Up

;Appskey + Arrow Keys = Move Mouse
AppsKey & Left::MouseMove, -10, 0, 0, R ;AppsKey + Left = Move Mouse Left
AppsKey & Right::MouseMove, 10, 0, 0, R ;AppsKey + Right = Move Mouse Right
AppsKey & Up::MouseMove, 0, -10, 0, R ;AppsKey + Up = Move Mouse Up
AppsKey & Down::MouseMove, 0, 10, 0, R ;AppsKey + Down = Move Mouse Down
AppsKey & RCtrl::Click ;Appskey + RCtrl = Left Click

AppsKey & m::Run, Explorer C:\ ;Appskey + M = Open Windows Explorer

AppsKey & c::Run, C:\Windows\system32\cmd.exe, C:\ ;AppsKey + C = Open Command Propt

;***Other Shortcuts***

Esc:: ;In browser: Esc = Close tab
SetTitleMatchMode, 2
#IfWinActive, explorer
    Esc::^w ;In browser: Esc = Close tab
#IfWinActive

Esc::!f4 ;Esc = Close Window

!Esc:: ;In browser: Alt+Esc = Reopen closed tab (tap Esc twice)
SetTitleMatchMode, 2
#IfWinActive, explorer
	!Esc::send, ^T ;In browser: Alt+Esc = Reopen closed tab (tap Esc twice)
#IfWinActive

