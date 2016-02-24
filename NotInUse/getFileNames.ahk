; #NoTrayIcon
#SingleInstance, Force

!e::
	Send, ^c
	clipboard = %clipboard%
	clipboard = A_WinDir
return