#NoTrayIcon
#SingleInstance, Force
#n::Run, C:\Windows\system32\notepad.exe ;WindowsLogoKey + N = Open New Notepad
#c::Run, C:\Windows\system32\calc.exe ;WindowsLogoKey + C = Open Calculator

;AppsKey + W,A,S,D = Up,Left,Down,Right
AppsKey & s::send, {down}
AppsKey & a::send, {left}
AppsKey & d::send, {right}
AppsKey & w::send, {up}

;Appskey + Arrow Keys = Move Mouse
AppsKey & Left::MouseMove, -10, 0, 0, R
AppsKey & Right::MouseMove, 10, 0, 0, R
AppsKey & Up::MouseMove, 0, -10, 0, R
AppsKey & Down::MouseMove, 0, 10, 0, R
AppsKey & RCtrl::Click

AppsKey & m::Run, Explorer C:\Users\Mike

AppsKey & c::Run, C:\Windows\system32\cmd.exe, C:\Users\Mike ;AppsKey + C = Open Command Propt

PRINTSCREEN::Run, "C:\Windows\System32\SnippingTool.exe" ;PrintScreen = Open Snipping Tool
