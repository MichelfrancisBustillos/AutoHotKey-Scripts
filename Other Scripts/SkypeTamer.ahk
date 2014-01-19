#NoTrayIcon
#SingleInstance, Force
;
; Skype Tamer
;

#Persistent
SetTimer, Skype_Clean, 200
Return

; ------ ------ ------

Skype_Clean:
	Max_Wins = 1 ; maximum # of Skype call windows open at one time
	
	SetTitleMatchMode, 2
	WinGet, num, count, ahk_class TConversationForm
	if (num > Max_Wins)
	{
		WinGet, id, list, ahk_class TConversationForm
		v := id%id%
		winclose, ahk_id %v%
		num -= 1
	}
	
	if (num = 1) {
		; pin skype conversation window to upper right
		WinGetPos, X, Y, W, H, ahk_class TConversationForm
		NewX := A_ScreenWidth - W
		WinMove, ahk_class TConversationForm,, NewX, 0
	}
	
; Move Skype recorder gadgets to background, out of the way
	
	SetTitleMatchMode, 3
	WinMove, MP3 Skype Recorder,, 0, 0
	WinSet, Bottom,, MP3 Skype Recorder
	WinSet, Bottom,, ahk_class TRecordPopup
	
	; is that call quality feedback window up?  kill it.
	
	SetTitleMatchMode, Regex
	WinClose, ^Skype.*Call quality feedback$
Return