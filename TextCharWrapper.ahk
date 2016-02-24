;***Automatically Wrap Selected Text With Character
;Attn: Will overwrite clipboard on use!

#NoTrayIcon
#SingleInstance, Force

^':: ;Ctrl + ' = Wrap with single quotes ('')
ClipSave := ClipboardAll
Send ^c
clipboard = '%clipboard%'
StringReplace, clipboard, clipboard,%A_SPACE%",", All
Send ^v
Clipboard := ClipSave
ClipSave = 
return

^":: ;Ctrl + " = Wrap with Double quotes (" ")
ClipSave := ClipboardAll
Send ^c
clipboard = "%clipboard%"
StringReplace, clipboard, clipboard,%A_SPACE%",", All
Send ^v
Clipboard := ClipSave
ClipSave = 
return

^{:: ;Ctrl + { = Wrap with French Braces ({ })
ClipSave := ClipboardAll
Send ^c
clipboard = {%clipboard%}
StringReplace, clipboard, clipboard,%A_SPACE%",", All
Send ^v
Clipboard := ClipSave
ClipSave = 
return

^[:: ;Ctrl + [ = Wrap with Square Braces ([ ])
ClipSave := ClipboardAll
Send ^c
clipboard = [%clipboard%]
StringReplace, clipboard, clipboard,%A_SPACE%",", All
Send ^v
Clipboard := ClipSave
ClipSave = 
return

^(:: ;Ctrl + ( = Wrap with Parenthesis (( ))
ClipSave := ClipboardAll
Send ^c
clipboard = (%clipboard%)
StringReplace, clipboard, clipboard,%A_SPACE%",", All
Send ^v
Clipboard := ClipSave
ClipSave = 
return

#IfWinActive ahk_class ConsoleWindowClass
^V:: ;Ctrl + V = Paste (enabled in CMD)
SendInput {Raw}%clipboard%
return