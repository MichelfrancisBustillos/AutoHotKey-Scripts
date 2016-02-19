#NoTrayIcon
#SingleInstance, Force

;***Windows Logo Key Shortcuts***
#n::Run, C:\Windows\system32\notepad.exe ;WindowsLogoKey + N = Open New Notepad
#c::Run, C:\Windows\system32\calc.exe ;WindowsLogoKey + C = Open Calculator

;***AppsKey Shortcuts***
AppsKey::AppsKey ;Preserve AppsKey non-HotKey functionality
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

;***Mouse Shortcuts***
WheelLeft::Browser_Back ;MouseWheelLeft = Browser Back
WheelRight::Browser_Forward ;MouseWheelRight = Browser Forward
^RButton::WinMinimize, A ;Ctrl + RightClick = Minimize Active Window
!RButton:: ;Alt + RightClick = Pin Active Window
	WinGetActiveTitle, t
	WinGet, ExStyle, ExStyle, %t%
	if (ExStyle & 0x8)
	{
		WinSet, AlwaysOnTop, Off, %t%
		WinSetTitle, %t%,, % RegexReplace(t, " - AlwaysOnTop")
	}
	else
	{
		WinSet, AlwaysOnTop, On, %t%
		WinSetTitle, %t%,, %t% - AlwaysOnTop
	}
return