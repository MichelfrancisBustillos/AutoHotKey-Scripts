#NoTrayIcon
#InstallKeybdHook
; Hotkey Help
; Fanatic Guru
; 2013 09 18
; Verison 2.88
;
; Inspired by Jade Dragon's Infile Hotkey Scanner
; PostMessage Information and Script Status derived from Lexikos
;
; Creates a Help Dialog that Shows Current AHK Hotkeys
;
;{-----------------------------------------------
;
; Wings around file names mean
; ===== AHK File with Hotkeys or Hotstrings =====
; ----- AHK File with no Hotkeys or Hotstrings -----
; ==o== AHK Include File with Hotkeys or Hotstrings ==o==
; --o-- AHK Include File with no Hotkeys or Hotstrings --o--
; +++++ AHK or Text File Derived from EXE File Name with Hotkeys or Hotstrings +++++
; +-+-+ AHK or Text File Derived from EXE File Name with no Hotkeys or Hotstrings +-+-+
; ?+?+? EXE File for which no AHK or Text File was Found ?+?+?
;
; May create a txt file with same name as hotkey file to be searched for help information
;}
; INITIALIZATION - ENVIROMENT
;{-----------------------------------------------
;
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance force ; Ensures that only the last executed instance of script is running
;}
; INITIALIZATION - VARIABLES
;{-----------------------------------------------
;
; File Names with Out Ext Seperated by |
; Files_Excluded := "Test|Debugging"
Files_Excluded := " "
; Long or Short Hotkey and Hotstring Names (Modifier Order Matters)
; Hot_Excluded := "Win+Ctrl+Alt+Escape|If|IfWinActive|#a|fyi|brb"
Hot_Excluded := " "
; Text File Extension List for Text Help Files
Text_Ext_List := [
(Join,
"txt"
)]
; Spacing for Position of Information Column in Help Dialog
Pos_Info = 25
; Parse Delimiter and OmitChar. Sometimes changing these can give better results.
Parse_Delimiter := "`n"
Parse_OmitChar := "`r"
; Default Settings if Not Changed by Ini File
Set_ShowBlank	= 1
Set_ShowBlankInclude	= 1
Set_ShowExe	= 1
Set_ShowHotkey	= 1	; Hotkeys created with the Hotkey Command Tend to be Unusal
Set_VarHotkey	= 1	; Attempt to Resolve a Variable Used in Hotkeys Definition
Set_FlagHotkey	= 1	; Flag Hotkeys created with the Hotkey Command with <HK>
Set_ShowString	= 1
Set_AhkExe	= 1
Set_AhkTxt	= 1
Set_AhkTxtOver	= 1
Set_SortInfo	= 1
Set_CapHotkey	= 1	; Set to 0 to not change Capitalization of Hotkey, 1 for Capitalization as Determined by Set_CapHotkey_Radio
Set_CapHotkey_Radio	= 1	; Set to 1 to use Title Capitalization, 2 for UPPER Capitalization
Set_HideFold	= 1
Set_IniSet	= 1	; Set to 0 to Use Defaults Settings and Not Use INI File
Set_IniExcluded	= 1	; Set to 0 to Use Default Excluded Information and Not Use INI File
Set_Hotkey_Mod_Delimiter := "+"	; Delimiter Character to Display Between Hotkey Modifiers
; Get Settings From Ini File
if Set_IniSet
if FileExist("Hotkey Help.ini")
{
IniRead, Set_ShowBlank, Hotkey Help.ini, Settings, Set_ShowBlank, %Set_ShowBlank%
IniRead, Set_ShowBlankInclude, Hotkey Help.ini, Settings, Set_ShowBlankInclude, %Set_ShowBlankInclude%
IniRead, Set_ShowExe, Hotkey Help.ini, Settings, Set_ShowExe, %Set_ShowExe%
IniRead, Set_ShowHotkey, Hotkey Help.ini, Settings, Set_ShowHotkey, %Set_ShowHotkey%
IniRead, Set_VarHotkey, Hotkey Help.ini, Settings, Set_ShowHotkey, %Set_VarHotkey%
IniRead, Set_FlagHotkey, Hotkey Help.ini, Settings, Set_ShowHotkey, %Set_FlagHotkey%
IniRead, Set_ShowString, Hotkey Help.ini, Settings, Set_ShowString, %Set_ShowString%
IniRead, Set_AhkExe, Hotkey Help.ini, Settings, Set_AhkExe, %Set_AhkExe%
IniRead, Set_AhkTxt, Hotkey Help.ini, Settings, Set_AhkTxt, %Set_AhkTxt%
IniRead, Set_AhkTxtOver, Hotkey Help.ini, Settings, Set_AhkTxtOver, %Set_AhkTxtOver%
IniRead, Set_SortInfo, Hotkey Help.ini, Settings, Set_SortInfo, %Set_SortInfo%
IniRead, Set_CapHotkey, Hotkey Help.ini, Settings, Set_CapHotkey, %Set_CapHotkey%
IniRead, Set_CapHotkey_Radio, Hotkey Help.ini, Settings, Set_CapHotkey_Radio, %Set_CapHotkey_Radio%
IniRead, Set_HideFold, Hotkey Help.ini, Settings, Set_HideFold, %Set_HideFold%
IniRead, Set_IniSet, Hotkey Help.ini, Settings, Set_IniSet, %Set_IniSet%
IniRead, Set_IniExcluded, Hotkey Help.ini, Settings, Set_IniExcluded, %Set_IniExcluded%
IniRead, Set_Hotkey_Mod_Delimiter, Hotkey Help.ini, Settings, Set_Hotkey_Mod_Delimiter, %Set_Hotkey_Mod_Delimiter%
}
; Get Excluded Information From Ini File
if Set_IniExcluded
if FileExist("Hotkey Help.ini")
{
IniRead, Files_Excluded, Hotkey Help.ini, Excluded, Files_Excluded, %Files_Excluded%
IniRead, Hot_Excluded, Hotkey Help.ini, Excluded, Hot_Excluded, %Hot_Excluded%
}
;}
; INITIALIZATION - GUI
;{-----------------------------------------------
;
; Create Setting Gui
Gui, Set:Font, s10
Gui, Set:Add, Text, x120 y10 w200 h20 , Hotkey Help - Pick Settings
Gui, Set:Add, Text, x30 y40 w390 h2 0x7
Gui, Set:Add, CheckBox, x60 y50 w380 h30 vSet_ShowBlank, Show Files With No Hotkeys
Gui, Set:Add, CheckBox, x60 y90 w380 h30 vSet_ShowBlankInclude, Show Include Files With No Hotkeys
Gui, Set:Add, CheckBox, x60 y130 w380 h30 vSet_ShowExe, Show EXE Files (Help Comments Do Not Exist in EXE)
Gui, Set:Add, CheckBox, x60 y170 w380 h30 vSet_AhkExe, Scan AHK File with Same Name as Running EXE
Gui, Set:Add, CheckBox, x60 y210 w380 h30 vSet_AhkTxt, Scan Text Files with Same Name as Running Script
Gui, Set:Add, CheckBox, x60 y250 w380 h30 vSet_AhkTxtOver, Text File Help will Overwrite Duplicate Help
Gui, Set:Add, CheckBox, x60 y290 w380 h30 vSet_ShowHotkey, Show Created with Hotkey Command
Gui, Set:Add, CheckBox, x60 y330 w380 h30 vSet_VarHotkey, Attempt to Resolve Variables in Dynamic Hotkeys
Gui, Set:Add, CheckBox, x60 y370 w380 h30 vSet_FlagHotkey, Flag Hotkeys created with the Hotkey Command with <HK>
Gui, Set:Add, CheckBox, x60 y410 w380 h30 vSet_SortInfo, Sort by Hotkey Description (Otherwise by Hotkey Name)
Gui, Set:Add, CheckBox, x60 y450 w180 h30 vSet_CapHotkey, Hotkey Capitalization
Gui, Set:Add, Radio, x240 y450 w80 h30 vSet_CapHotkey_Radio, Title
Gui, Set:Add, Radio, x320 y450 w120 h30, UPPER
Gui, Set:Add, CheckBox, x60 y490 w380 h30 vSet_ShowString, Show Hotstrings
Gui, Set:Add, CheckBox, x60 y530 w380 h30 vSet_HideFold, Hide Fold Start `;`{ from Help Comment
Gui, Set:Add, CheckBox, x60 y570 w380 h30 vSet_IniSet, Use INI File to Save Settings
Gui, Set:Add, CheckBox, x60 y610 w380 h30 vSet_IniExcluded, Use INI File to Save Excluded Files and Hotkeys
Gui, Set:Add, ComboBox, x60 y650 w60 h30 R5 Choose1 vSet_Hotkey_Mod_Delimiter, "%Set_Hotkey_Mod_Delimiter%"|"+"|"-"|" + "|" - "
Gui, Set:Add, Text, x130 y650 w250 h30, Delimiter to Separate Hotkey Modifiers
Gui, Set:Add, Button, Default x60 y710 w330 h30, Finished
GuiControl, Set:, Set_ShowBlank, %Set_ShowBlank%
GuiControl, Set:, Set_ShowBlankInclude, %Set_ShowBlankInclude%
GuiControl, Set:, Set_ShowExe, %Set_ShowExe%
GuiControl, Set:, Set_ShowHotkey, %Set_ShowHotkey%
GuiControl, Set:, Set_VarHotkey, %Set_VarHotkey%
GuiControl, Set:, Set_FlagHotkey, %Set_FlagHotkey%
GuiControl, Set:, Set_ShowString, %Set_ShowString%
GuiControl, Set:, Set_AhkExe, %Set_AhkExe%
GuiControl, Set:, Set_AhkTxt, %Set_AhkTxt%
GuiControl, Set:, Set_AhkTxtOver, %Set_AhkTxtOver%
GuiControl, Set:, Set_SortInfo, %Set_SortInfo%
GuiControl, Set:, Set_CapHotkey, %Set_CapHotkey%
GuiControl, Set:, Title, % Set_CapHotkey_Radio = 1 ? 1 : 0
GuiControl, Set:, UPPER, % Set_CapHotkey_Radio = 2 ? 1 : 0
GuiControl, Set:, Set_HideFold, %Set_HideFold%
GuiControl, Set:, Set_IniSet, %Set_IniSet%
GuiControl, Set:, Set_IniExcluded, %Set_IniExcluded%
;GuiControl, Set:, Set_Hotkey_Mod_Delimiter, %Set_Hotkey_Mod_Delimiter%
; Get Information to Display in Excluded Gui
Gui_Excluded := String_Wings(" EXCLUDED SCRIPTS AND FILES ",40) "`n" Files_Excluded "`n`n`n" String_Wings(" EXCLUDED HOTKEYS & HOTSTRINGS ",40) "`n" Hot_Excluded
StringReplace, Gui_Excluded, Gui_Excluded, |, `n, All
; Create Excluded Gui
Gui, Excluded:+MinSize400x600 +Resize
Gui, Excluded:Color, FFFFFF
Gui, Excluded:Font, s10, Courier New
Gui, Excluded:Add, Text, x10, Enter Information Below the Appropriate Headings
Gui, Excluded:Add, Text, x60, Do Not Modify Heading Lines
Gui, Excluded:Add, Button, Default x20 y60 w350 h30, Confirm Edit
Gui, Excluded:Add, Edit, x20 y100 vGui_Excluded -E0x200, %Gui_Excluded%
;}
;{-----------------------------------------------
;
;}-----------------------------------------------
; END OF AUTO-EXECUTE
; HOTKEYS
;{-----------------------------------------------
;
#f1::	;{ <-- ~ Display Help ~
Refresh:
global Scripts := {}	; AHK Scripts Running
Help := {}	; Main Array for Storing Help Information
Scripts_Scan := {}	; AHK Scripts to Scan
Scripts_Include := {}	; Scripts Added with #Include
File_Paths_Txt := {}	; File Paths of Text
Setting_AutoTrim := A_AutoTrim
AutoTrim, On
Setting_WorkingDir := A_WorkingDir
Scripts_List := AHK_Scripts("Scripts")	; Get Path of all AHK Scripts
Scripts_Scan := Scripts
Recursive:
Include_Found := false
for index, Script in Scripts_Scan	; Loop Through AHK Script Files
{
Txt_Ahk := false
SetWorkingDir, %Setting_WorkingDir%
File_Path := Script.Path
SplitPath, File_Path, File_Name, File_Dir, File_Ext, File_Title
if RegExMatch(Files_Excluded,"i)(^|\|)" File_Title "($|\|)")
continue
Help[File_Title,"Type"] := "AHK"
Exe_Ahk := false
if (File_Ext = "exe")
{
Help[File_Title,"Type"] := "EXE_UNKNOWN"
if Set_AhkExe
{
if FileExist(File_Dir "\" File_Title ".ahk")
{
Exe_Ahk := true
Help[File_Title,"Type"] := "EXE2AHK"
File_Path := File_Dir "\" File_Title ".ahk"
}
else if FileExist(A_ScriptDir "\" File_Title ".ahk")
{
Help[File_Title,"Type"] := "EXE2AHK"
Exe_Ahk := true
File_Path := A_ScriptDir "\" File_Title ".ahk"
}
else if FileExist(A_WorkingDir "\" File_Title ".ahk")
{
Help[File_Title,"Type"] := "EXE2AHK"
Exe_Ahk := true
File_Path := A_WorkingDir "\" File_Title ".ahk"
}
}
}
Txt_Ahk := false
if Set_AhkTxt
{
File_Paths_Txt := {} ; Clear File Paths of Text
for index_Text_Ext, Text_Ext in Text_Ext_List
{
if FileExist(File_Dir "\" File_Title "." Text_Ext)
{
Txt_Ahk := true
File_Paths_Txt.Insert(File_Dir "\" File_Title "." Text_Ext)
}
else if FileExist(A_ScriptDir "\" File_Title "." Text_Ext)
{
Txt_Ahk := true
File_Paths_Txt.Insert(A_ScriptDir "\" File_Title "." Text_Ext)
}
else if FileExist(A_WorkingDir "\" File_Title "." Text_Ext)
{
Txt_Ahk := true
File_Paths_Txt.Insert(A_WorkingDir "\" File_Title "." Text_Ext)
}
}
}
If (Help[File_Title,"Type"] = "EXE_UNKNOWN" and Txt_Ahk)
Help[File_Title,"Type"] := "EXE2TEXT"
if (!Txt_Ahk and !Exe_Ahk and !(File_Ext = "ahk" or File_Ext = "ahkl"))	; No File Found to Scan
continue
Script_File := ""
if !(RegExMatch(Files_Excluded,"i)(^|\|)" File_Title "($|\|)") or RegExMatch(Files_Excluded,"i)(^|\|)" File_Title "." File_Ext "($|\|)"))
FileRead, Script_File, %File_Path%	; Read AHK Script File into String
if Txt_Ahk
{
for index_File_Path_Txt, File_Path_Txt in File_Paths_Txt
{
FileRead, Script_File_Txt, %File_Path_Txt%	; Read Text File with Same Name as AHK Script File into String
if not ErrorLevel
Script_File .= Parse_Delimiter "� Hotkey Help Text File �" Parse_Delimiter Script_File_Txt	; Append Txt File onto AHK File
}
}
if !Script_File
continue
Script_File := RegExReplace(Script_File, "ms`a)^\s*/\*.*?^\s*\*/\s*|^\s*\(.*?^\s*\)\s*")	; Removes /* ... */ and ( ... ) Blocks
Txt_Ahk_Started := false
Loop, Parse, Script_File, %Parse_Delimiter%, %Parse_OmitChar%	; Parse Each Line of Script File
{
File_Line := A_LoopField
if (File_Line = "� Hotkey Help Text File �")
{
Txt_Ahk_Started := true
continue
}
; RegEx to Identify Hotkey Command Lines
if (RegExMatch(File_Line, "i)^\s*hotkey,(.*?),(.*)", Match) and Set_ShowHotkey)	; Check if Line Contains Hotkey Command
{
if Set_VarHotkey
if RegExMatch(Match1,"%.*%")
Match1 := HotkeyVariable(Script.Path,Match1)
File_Line := Match1 ":: " Match2
Hotkey_Command := true
}
else
Hotkey_Command := false
if RegExMatch(File_Line,"::")	; Simple check for Possible Hotkey or Hotstring (for speed)
{
if RegExMatch(File_Line,"^\s*:[0-9\*\?BbCcKkOoPpRrSsIiEeZz]*?:(.*?)::(.*)",Match)	; Complex Check if Line Contains Hotstring
{
if (Set_ShowString and !(RegExMatch(Hot_Excluded,"i)(^|\|)\Q" Match1 "\E($|\|)")))	; Check for Excluded Hotstring
{
Line_Hot := "<HS> " Match1
Line_Help := "= " Match2
if Txt_Ahk_Started
{
if (Help[File_Title,"Hot_Text",Line_Hot,"Count"] = "")
Count := 1
else
Count += Help[File_Title,"Hot_Text",Line_Hot,"Count"]
Help[File_Title,"Hot_Text",Line_Hot,"Count"] := Count
Help[File_Title,"Hot_Text",Line_Hot,Count] := Line_Help
}
else
{
if (Help[File_Title,"Hot",Line_Hot,"Count"] = "")
Count := 1
else
Count += Help[File_Title,"Hot",Line_Hot,"Count"]
Help[File_Title,"Hot",Line_Hot,"Count"] := Count
Help[File_Title,"Hot",Line_Hot,Count] := Line_Help
}
}
else
continue
}
else if RegExMatch(File_Line, "Umi)^\s*[\Q#!^+<>*~$\E]*((LButton|RButton|MButton|XButton1|XButton2|WheelDown|WheelUp|WheelLeft|WheelRight|CapsLock|Space|Tab|Enter|Return|Escape|Esc|Backspace|BS|ScrollLock|Delete|Del|Insert|Ins|Home|End|PgUp|PgDn|Up|Down|Left|Right|NumLock|Numpad0|Numpad1|Numpad2|Numpad3|Numpad4|Numpad5|Numpad6|Numpad7|Numpad8|Numpad9|NumpadDot|NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|NumpadEnter|NumpadIns|NumpadEnd|NumpadDown|NumpadPgDn|NumpadLeft|NumpadClear|NumpadRight|NumpadHome|NumpadUp|NumpadPgUp|NumpadDel|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|F13|F14|F15|F16|F17|F18|F19|F20|F21|F22|F23|F24|LWin|RWin|Control|Ctrl|Alt|Shift|LControl|LCtrl|RControl|RCtrl|LShift|RShift|LAlt|RAlt|Browser_Back|Browser_Forward|Browser_Refresh|Browser_Stop|Browser_Search|Browser_Favorites|Browser_Home|Volume_Mute|Volume_Down|Volume_Up|Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|AppsKey|PrintScreen|CtrlBreak|Pause|Break|Help|Sleep|\S)(?<!;)|```;)(\s+&\s+((LButton|RButton|MButton|XButton1|XButton2|WheelDown|WheelUp|WheelLeft|WheelRight|CapsLock|Space|Tab|Enter|Return|Escape|Esc|Backspace|BS|ScrollLock|Delete|Del|Insert|Ins|Home|End|PgUp|PgDn|Up|Down|Left|Right|NumLock|Numpad0|Numpad1|Numpad2|Numpad3|Numpad4|Numpad5|Numpad6|Numpad7|Numpad8|Numpad9|NumpadDot|NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|NumpadEnter|NumpadIns|NumpadEnd|NumpadDown|NumpadPgDn|NumpadLeft|NumpadClear|NumpadRight|NumpadHome|NumpadUp|NumpadPgUp|NumpadDel|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|F13|F14|F15|F16|F17|F18|F19|F20|F21|F22|F23|F24|LWin|RWin|Control|Ctrl|Alt|Shift|LControl|LCtrl|RControl|RCtrl|LShift|RShift|LAlt|RAlt|Browser_Back|Browser_Forward|Browser_Refresh|Browser_Stop|Browser_Search|Browser_Favorites|Browser_Home|Volume_Mute|Volume_Down|Volume_Up|Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|AppsKey|PrintScreen|CtrlBreak|Pause|Break|Help|Sleep|\S)(?<!;)|```;))?(\s+Up)?::") ; Complex Check if Line Contains Hotkey
{
Pos_Hotkey := RegExMatch(File_Line,"(.*?[:]?)::",Match)
Match1 := Trim(Match1)
if RegExMatch(Hot_Excluded,"i)(^|\|)\Q" Match1 "\E($|\|)")	; Check for Excluded Short Hotkey Name
continue
if !RegExMatch(Match1,"(Shift|Alt|Ctrl|Win)")
{
StringReplace, Match1, Match1, +, Shift%Set_Hotkey_Mod_Delimiter%
StringReplace, Match1, Match1, <^>!, AltGr%Set_Hotkey_Mod_Delimiter%
StringReplace, Match1, Match1, <, Left, All
StringReplace, Match1, Match1, >, Right, All
StringReplace, Match1, Match1, !, Alt%Set_Hotkey_Mod_Delimiter%
StringReplace, Match1, Match1, ^, Ctrl%Set_Hotkey_Mod_Delimiter%
StringReplace, Match1, Match1, #, Win%Set_Hotkey_Mod_Delimiter%
}
StringReplace, Match1, Match1, ```;, `;
if RegExMatch(Hot_Excluded,"i)(^|\|)\Q" Match1 "\E($|\|)")	; Check for Excluded Long Hotkey Name
continue
Line_Hot := Match1
if Set_CapHotkey
if (Set_CapHotkey_Radio = 1)
Line_Hot := RegExReplace(Line_Hot,"((^[^\Q" Set_Hotkey_Mod_Delimiter "\E]*|\Q" Set_Hotkey_Mod_Delimiter "\E[^\Q" Set_Hotkey_Mod_Delimiter "\E]*))","$T1")
else
Line_Hot := RegExReplace(Line_Hot,"((^[^\Q" Set_Hotkey_Mod_Delimiter "\E]*|\Q" Set_Hotkey_Mod_Delimiter "\E[^\Q" Set_Hotkey_Mod_Delimiter "\E]*))","$U1")
Pos := RegExMatch(File_Line,"::.*?;(.*)",Match)
if Set_HideFold
if (SubStr(Match1,1,1) = "{")
Match1 := SubStr(Match1,2)
Line_Help := Trim(Match1)
if Hotkey_Command
if Set_FlagHotkey
Line_Hot := "<HK> " Line_Hot
if Txt_Ahk_Started
{
if (Help[File_Title,"Hot_Text",Line_Hot,"Count"] = "")
Count := 1
else
Count += Help[File_Title,"Hot_Text",Line_Hot,"Count"]
Help[File_Title,"Hot_Text",Line_Hot,"Count"] := Count
Help[File_Title,"Hot_Text",Line_Hot,Count] := Line_Help
}
else
{
if (Help[File_Title,"Hot",Line_Hot,"Count"] = "")
Count := 1
else
Count += Help[File_Title,"Hot",Line_Hot,"Count"]
Help[File_Title,"Hot",Line_Hot,"Count"] := Count
Help[File_Title,"Hot",Line_Hot,Count] := Line_Help
}
}
}
if RegExMatch(File_Line, "mi`a)^\s*#include(?:again)?(?:\s+|\s*,\s*)(?:\*i[ `t]?)?(.+)", Match)	; Check for #Include
{
StringReplace, Match1, Match1, `%A_ScriptDir`%, %File_Dir%
StringReplace, Match1, Match1, `%A_AppData`%, %A_AppData%
StringReplace, Match1, Match1, `%A_AppDataCommon`%, %A_AppDataCommon%
StringReplace, Match1, Match1,```;,;, All
if InStr(FileExist(Match1), "D")
{
SetWorkingDir, %Match1%
continue
}
if Match1
{
Match1 := Get_Full_Path(Match1)
Scripts_Include.Insert({"Path":Match1})
Include_Found := true
}
}
}
}
; Do Recursive for Found #Include
if Include_Found
{
Scripts_Scan := Scripts_Include
goto Recursive
}
; Get Count of Hot in Each File
for File, element in Help
{
count = 0
for Hot, Info in Help[File,"Hot"]
count += 1
for Hot_Text, Info_Text in Help[File,"Hot_Text"]
count += 1
Help[File,"Count"] := count
}
; Remove Duplicate Help Created by Text Help if Text File Overwrite Set
if (Set_AhkTxtOver)
for File, element in Help
for Hot_Text, Info_Text in Help[File,"Hot_Text"]
for Hot, Info in Help[File,"Hot"]
if (Hot = Hot_Text or Hot = "<HK> " Hot_Text)
{
Removed := Help[File,"Hot"].Remove(Hot)
Help[File,"Count"] -= 1
}
; Add Include Information to Help Array
for File, element in Help
{
Include_Found := true
for index, Script in Scripts
if (File = Script.Title)
Include_Found := false
if Include_Found
Help[File, "Include"] := true
else
Help[File, "Include"] := false
}
; Build Display String from Help Array
Display := ""
for File, element in Help
{
if (Help[File,"Count"] > 0 and Help[File,"Type"] = "AHK")
{
if Help[File,"Include"]
Display .= "`n" String_Wings(" " File " ",,"==o==") "`n"
else
Display .= "`n" String_Wings(" " File " ") "`n"
Display_Section := ""
for Hot, Hot_Index in Help[File,"Hot"]
for Hot_Index2, Info in Help[File,"Hot",Hot]
if (Hot_Index2 != "Count")
Display_Section .= Format_Line(Hot,Info,Pos_Info) "`n"
for Hot_Text, Hot_Text_Index in Help[File,"Hot_Text"]
for Hot_Text_Index2, Info_Text in Help[File,"Hot_Text",Hot_Text]
if (Hot_Text_Index2 != "Count")
Display_Section .= Format_Line(Hot_Text,Info_Text,Pos_Info) "`n"
if Set_SortInfo
Sort, Display_Section, P%Pos_Info%
else
Sort, Display_Section
Display .= Display_Section
}
}
for File, element in Help
{
if (Help[File,"Count"] > 0 and (Help[File,"Type"] = "EXE2AHK" or Help[File,"Type"] = "EXE2TEXT"))
{
Display .= "`n" String_Wings(" " File " ",,"+") "`n"
Display_Section := ""
for Hot, Hot_Index in Help[File,"Hot"]
for Hot_Index2, Info in Help[File,"Hot",Hot]
if (Hot_Index2 != "Count")
Display_Section .= Format_Line(Hot,Info,Pos_Info) "`n"
for Hot_Text, Hot_Text_Index in Help[File,"Hot_Text"]
for Hot_Text_Index2, Info_Text in Help[File,"Hot_Text",Hot_Text]
if (Hot_Text_Index2 != "Count")
Display_Section .= Format_Line(Hot_Text,Info_Text,Pos_Info) "`n"
if Set_SortInfo
Sort, Display_Section, P%Pos_Info%
else
Sort, Display_Section
Display .= Display_Section
}
}
if Set_ShowBlank
{
for File, element in Help
{
if (Help[File,"Count"] = 0 and Help[File,"Type"] = "EXE2AHK" and Set_ShowExe)
Display .= "`n" String_Wings(" " File " ",,"+-")
}
for File, element in Help
{
if (Help[File,"Type"] = "EXE_UNKNOWN" and Set_ShowExe)
Display .= "`n" String_Wings(" " File " ",,"?+")
}
for File, element in Help
{
if (Help[File,"Count"] = 0 and Help[File,"Type"] = "AHK" and !Help[File,"Include"])
Display .= "`n" String_Wings(" " File " ",,"-")
}
for File, element in Help
{
if (Help[File,"Count"] = 0 and Help[File,"Type"] = "AHK" and Help[File,"Include"] and Set_ShowBlankInclude)
Display .= "`n" String_Wings(" " File " ",,"--o--")
}
}
Display := RegExReplace(Display,"^\s*(.*)\s*$", "$1")
; Create Main Gui first time then only display unless contents change then recreate to get automatic sizing of Edit
if Gui_Created
{
if !(Display == Previous_Display)
{
Gui, Destroy
gosub MenuBuild
Gui, +MinSize660x100 +Resize
Gui, Color, FFFFFF
Gui, Font, s10, Courier New
Gui, Menu, MenuMain
Gui, Add, Edit, vGui_Display ReadOnly -E0x200, %Display%
Gui, Show, AutoSize, Hotkey Help
Send ^{Home}
}
else
{
Gui, Show,, Hotkey Help
Send ^{Home}
}
}
else
{
gosub MenuBuild
Gui, +MinSize660x100 +Resize
Gui, Color, FFFFFF
Gui, Font, s10, Courier New
Gui, Menu, MenuMain
Gui, Add, Edit, vGui_Display ReadOnly -E0x200, %Display%
Gui, Show, AutoSize, Hotkey Help
Send ^{Home}
Gui_Created := true
}
Previous_Display := Display
AutoTrim, %Setting_AutoTrim%
return
;}
#!f1::	;{ <-- Settings
Gui, Set:Show,, Hotkey Help - Settings
return
;}
#^f1::	;{ <-- Excluded Files, Hotkeys, and Hotstrings
Gui, Excluded:Show, AutoSize, Hotkey Help - Excluded
Send ^{Home}
return
;}
#!^f1::	;{ <-- Raw Hotkey List
Scripts_List := AHK_Scripts("Scripts")	; Get Path of all AHK Scripts
Raw_Hotkeys := {}
for index, Script in Scripts	; Loop Through All AHK Script Files
{
File_Path := Script.Path
SplitPath, File_Path, File_Name, File_Dir, File_Ext, File_Title
Raw_Hotkeys[File_Title] := ScriptHotkeys(Script.Path)
}
Raw_Display := ""
for Script, element in Raw_Hotkeys
{
Raw_Display .= "`n" String_Wings(" " Script " ",30) "`n"
for index, Hotkey_Short in Raw_Hotkeys[Script]
{
Hotkey_Keys := Hotkey_Short
StringReplace, Hotkey_Keys, Hotkey_Keys, +, Shift%Set_Hotkey_Mod_Delimiter%
StringReplace, Hotkey_Keys, Hotkey_Keys, <^>!, AltGr%Set_Hotkey_Mod_Delimiter%
StringReplace, Hotkey_Keys, Hotkey_Keys, <, Left, All
StringReplace, Hotkey_Keys, Hotkey_Keys, >, Right, All
StringReplace, Hotkey_Keys, Hotkey_Keys, !, Alt%Set_Hotkey_Mod_Delimiter%
StringReplace, Hotkey_Keys, Hotkey_Keys, ^, Ctrl%Set_Hotkey_Mod_Delimiter%
StringReplace, Hotkey_Keys, Hotkey_Keys, #, Win%Set_Hotkey_Mod_Delimiter%
if Set_CapHotkey
if (Set_CapHotkey_Radio = 1)
Hotkey_Keys := RegExReplace(Hotkey_Keys,"((^[^\Q" Set_Hotkey_Mod_Delimiter "\E]*|\Q" Set_Hotkey_Mod_Delimiter "\E[^\Q" Set_Hotkey_Mod_Delimiter "\E]*))","$T1")
else
Hotkey_Keys := RegExReplace(Hotkey_Keys,"((^[^\Q" Set_Hotkey_Mod_Delimiter "\E]*|\Q" Set_Hotkey_Mod_Delimiter "\E[^\Q" Set_Hotkey_Mod_Delimiter "\E]*))","$U1")
Raw_Display .= Hotkey_Keys "`n"
}
}
Raw_Display := Trim(Raw_Display," `n")
if Gui_Raw_Created
{
if !(Raw_Display = Previous_Raw_Display)
{
Gui, Raw:Destroy
Gui, Raw:+Resize
Gui, Raw:Color, FFFFFF
Gui, Raw:Font, s10, Courier New
Gui, Raw:Add, Edit, vGui_Raw_Display ReadOnly -E0x200, %Raw_Display%
Gui, Raw:Show, AutoSize, Hotkey Help
Send ^{Home}
}
else
{
Gui, Raw:Show, AutoSize, Hotkey Help - Raw Hotkeys
Send ^{Home}
}
}
else
{
Gui, Raw:+Resize
Gui, Raw:Color, FFFFFF
Gui, Raw:Font, s10, Courier New
Gui, Raw:Add, Edit, vGui_Raw_Display ReadOnly -E0x200, %Raw_Display%
Gui, Raw:Show, AutoSize, Hotkey Help - Raw Hotkeys
Send ^{Home}
Gui_Raw_Created := true
}
Previous_Raw_Display := Raw_Display
return
;}
~#^!Escape::ExitApp
;}
; SUBROUTINES - GUI
;{-----------------------------------------------
;
; Default Help Gui
GuiSize:
NewWidth := A_GuiWidth - 20
NewHeight := A_GuiHeight - 20
GuiControl, Move, Gui_Display, W%NewWidth% H%NewHeight%
return
GuiEscape:
Gui, Show, Hide
return
; Default Help Gui Menu
ScriptStop:
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
WinID := ArrayCrossRef(Scripts,"Title",A_ThisMenuItem,"ID")
WinKill, ahk_id %WinID%
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
Menu, MenuStop, Delete, %A_ThisMenuItem%
Menu, MenuPause, Delete, %A_ThisMenuItem%
Menu, MenuSuspend, Delete, %A_ThisMenuItem%
Menu, MenuEdit, Delete, %A_ThisMenuItem%
Menu, MenuReload, Delete, %A_ThisMenuItem%
Menu, MenuOpen, Delete, %A_ThisMenuItem%
goto Refresh
return
ScriptPause:
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
WinID := ArrayCrossRef(Scripts,"Title",A_ThisMenuItem,"ID")
PostMessage, 0x111, 65403,,, ahk_id %WinID%
sleep 100
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
gosub MenuBuild
return
ScriptSuspend:
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
WinID := ArrayCrossRef(Scripts,"Title",A_ThisMenuItem,"ID")
PostMessage, 0x111, 65404,,, ahk_id %WinID%
sleep 100
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
gosub MenuBuild
return
ScriptEdit:
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
WinID := ArrayCrossRef(Scripts,"Title",A_ThisMenuItem,"ID")
PostMessage, 0x111, 65401,,, ahk_id %WinID%
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
return
ScriptReload:
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
WinID := ArrayCrossRef(Scripts,"Title",A_ThisMenuItem,"ID")
PostMessage, 0x111, 65400,,, ahk_id %WinID%
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
return
ScriptOpen:
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
WinID := ArrayCrossRef(Scripts,"Title",A_ThisMenuItem,"ID")
PostMessage, 0x111, 65300,,, ahk_id %WinID%
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
return
MenuBuild:
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
Menu, MenuMain, UseErrorLevel
Menu, MenuMain, Delete
for index, Script in Scripts
{
Title := Script.Title
script_id := Script.ID
; Force the script to update its Pause/Suspend checkmarks.
SendMessage, 0x211,,,, ahk_id %script_id% ; WM_ENTERMENULOOP
SendMessage, 0x212,,,, ahk_id %script_id% ; WM_EXITMENULOOP
; Get script status from its main menu.
mainMenu := DllCall("GetMenu", "uint", script_id)
fileMenu := DllCall("GetSubMenu", "uint", mainMenu, "int", 0)
isPaused := DllCall("GetMenuState", "uint", fileMenu, "uint", 4, "uint", 0x400) >> 3 & 1
isSuspended := DllCall("GetMenuState", "uint", fileMenu, "uint", 5, "uint", 0x400) >> 3 & 1
DllCall("CloseHandle", "uint", fileMenu)
DllCall("CloseHandle", "uint", mainMenu)
Menu, MenuStop, Add, %Title%, ScriptStop
Menu, MenuPause, Add, %Title%, ScriptPause
if isPaused
Menu, MenuPause, Check, %Title%
else
Menu, MenuPause, UnCheck, %Title%
Menu, MenuSuspend, Add, %Title%, ScriptSuspend
if isSuspended
Menu, MenuSuspend, Check, %Title%
else
Menu, MenuSuspend, UnCheck, %Title%
Menu, MenuEdit, Add, %Title%, ScriptEdit
Menu, MenuReload, Add, %Title%, ScriptReload
Menu, MenuOpen, Add, %Title%, ScriptOpen
}
Menu, MenuMain, Add,% " Stop Script ", :MenuStop
Menu, MenuMain, Add
Menu, MenuMain, Add,% " Pause Script ", :MenuPause
Menu, MenuMain, Add
Menu, MenuMain, Add,% " Suspend Script ", :MenuSuspend
Menu, MenuMain, Add
Menu, MenuMain, Add,% " Edit Script ", :MenuEdit
Menu, MenuMain, Add
Menu, MenuMain, Add,% " Reload Script ", :MenuReload
Menu, MenuMain, Add
Menu, MenuMain, Add,% " Open Script ", :MenuOpen
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
return
; Excluded Gui
ExcludedButtonConfirmEdit:
Gui, Excluded:Submit
Files_Excluded := ""
Hot_Excluded := ""
Loop, Parse, Gui_Excluded, `n, `r
{
if !A_LoopField
continue
if (A_LoopField = String_Wings(" EXCLUDED SCRIPTS AND FILES ",40))
{
Next_Section := false
continue
}
if (A_LoopField = String_Wings(" EXCLUDED HOTKEYS & HOTSTRINGS ",40))
Next_Section := true
else
if !Next_Section
Files_Excluded .= "|" Trim(A_LoopField)
else
Hot_Excluded .= "|" Trim(A_LoopField)
}
Files_Excluded := SubStr(Files_Excluded, 2)
Hot_Excluded := SubStr(Hot_Excluded, 2)
if Set_IniExcluded
{
IniWrite, %Files_Excluded%, Hotkey Help.ini, Excluded, Files_Excluded
IniWrite, %Hot_Excluded%, Hotkey Help.ini, Excluded, Hot_Excluded
}
return
ExcludedGuiSize:
NewWidth := A_GuiWidth - 20
NewHeight := A_GuiHeight - 20
GuiControl, Move, Gui_Excluded, W%NewWidth% H%NewHeight%
return
ExcludedGuiEscape:
Gui, Excluded:Show, Hide
return
; Raw Gui
RawGuiSize:
NewWidth := A_GuiWidth - 20
NewHeight := A_GuiHeight - 20
GuiControl, Move, Gui_Raw_Display, W%NewWidth% H%NewHeight%
return
RawGuiEscape:
Gui, Raw:Show, Hide
return
; Set Gui
SetButtonFinished:
SetGuiEscape:
Gui, Set:Submit
if Set_IniSet
{
IniWrite, %Set_ShowBlank%, Hotkey Help.ini, Settings, Set_ShowBlank
IniWrite, %Set_ShowBlankInclude%, Hotkey Help.ini, Settings, Set_ShowBlankInclude
IniWrite, %Set_ShowExe%, Hotkey Help.ini, Settings, Set_ShowExe
IniWrite, %Set_ShowHotkey%, Hotkey Help.ini, Settings, Set_ShowHotkey
IniWrite, %Set_VarHotkey%, Hotkey Help.ini, Settings, Set_VarHotkey
IniWrite, %Set_FlagHotkey%, Hotkey Help.ini, Settings, Set_FlagHotkey
IniWrite, %Set_ShowString%, Hotkey Help.ini, Settings, Set_ShowString
IniWrite, %Set_AhkExe%, Hotkey Help.ini, Settings, Set_AhkExe
IniWrite, %Set_AhkTxt%, Hotkey Help.ini, Settings, Set_AhkTxt
IniWrite, %Set_AhkTxtOver%, Hotkey Help.ini, Settings, Set_AhkTxtOver
IniWrite, %Set_SortInfo%, Hotkey Help.ini, Settings, Set_SortInfo
IniWrite, %Set_CapHotkey%, Hotkey Help.ini, Settings, Set_CapHotkey
IniWrite, %Set_CapHotkey_Radio%, Hotkey Help.ini, Settings, Set_CapHotkey_Radio
IniWrite, %Set_HideFold%, Hotkey Help.ini, Settings, Set_HideFold
IniWrite, %Set_IniSet%, Hotkey Help.ini, Settings, Set_IniSet
IniWrite, %Set_IniExcluded%, Hotkey Help.ini, Settings, Set_IniExcluded
IniWrite, %Set_Hotkey_Mod_Delimiter%, Hotkey Help.ini, Settings, Set_Hotkey_Mod_Delimiter
}
Set_Hotkey_Mod_Delimiter := Trim(Set_Hotkey_Mod_Delimiter,"""")
return
;}
; FUNCTIONS
;{-----------------------------------------------
;
; Get Value of Variable From Script Dialog
HotkeyVariable(Script,Variable)
{
static
Var := Trim(Variable," %")
If !Script_List
Script_List := {}
if !Script_List[Script]
{
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
SetTitleMatchMode 2
WinMove, %Script%,,A_ScreenWidth, A_ScreenHeight
PostMessage, 0x111, 65407, , , %Script%
ControlGetText, Text, Edit1, %Script%
WinHide, %Script%
Script_List[Script] := Text
}
Pos := RegExMatch(Script_List[Script], Var ".*\:(.*)",Match)
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
if (Pos and Match1)
return Match1
else
return Variable
}
; Get Hotkeys From Script Dialog
ScriptHotkeys(Script)
{
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
SetTitleMatchMode 2
WinMove, %Script%,,A_ScreenWidth, A_ScreenHeight
if (Script = A_ScriptFullPath)
ListHotkeys
else
PostMessage, 0x111, 65408, , , %Script%
ControlGetText, Text, Edit1, %Script%
WinHide, %Script%
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
Result := {}
Loop, Parse, Text, `n
{
Pos := RegExMatch(A_LoopField,"^[(reg|k|m|2|joy)].*\t(.*)$",Match)
if Pos
Result.Insert(Match1)
}
return Result
}
; Expand File Path
Get_Full_Path(path)
{
Loop, %path%, 1
return A_LoopFileLongPath
return path
}
; Add Character Wings to Each Side of String to Create Graphical Break
String_Wings(String,Length:=76,Char:="=",Case:="U")
{
if (Case = "U")
StringUpper, String, String
else if (Case = "T")
StringUpper, String, String, T
else if (Case = "L")
StringLower, String, String
WingX1 := Round(((Length-StrLen(String))/2)/StrLen(Char)-.5)
WingX2 := Round((Length-StrLen(String)-(WingX1*StrLen(Char)))/StrLen(Char)+.5)
loop %WingX1%
Wing_1 .= Char
loop %WingX2%
Wing_2 .= Char
return SubStr(Wing_1 String Wing_2,1,Length)
}
; Format Spaces Between Hot Keys and Help Info to Create Columns
Format_Line(Hot,Info,Pos_Info)
{
Spaces := ""
Length := Pos_Info - StrLen(Hot) - 1
Loop %Length%
Spaces .= " "
return Hot Spaces Info
}
; Reference One Branch of Array and Return Corrisponding Information on Cross Branch
ArrayCrossRef(Array, Haystack, Needle, Cross)
{
for index, element in Array
if (Needle = element[Haystack])
return element[Cross]
}
; Function - AHK Scripts
; Fanatic Guru
; 2013 06 20
;
; Function that will find the path and file name of all AHK scripts running.
;
;---------------------------------------------------------------------------------
;
; Method:
; AHK_Paths(Array)
; Array must be declared as a global variable before function call
;
; Parameters:
; 1) {Array} global array in which to store AHK script path data
;
; Returns:
; String containing the complete path of all AHK scripts running
; One path per line of string, delimiter = `n
;
; Global:
; Populates {Array} passed as parameter with AHK script path data
; {Array}.Path
; {Array}.Name
; {Array}.Dir
; {Array}.Ext
; {Array}.Title
; {Array}.ID
;
; Example Code:
/*
global Script_List
MsgBox % AHK_Scripts("Script_List")
for index, element in Script_List
MsgBox % "#:`t" index "`nPath:`t" element.Path "`nName:`t" element.Name "`nDir:`t" element.Dir "`nExt:`t" element.Ext "`nTitle:`t" element.Title "`nID:`t" element.ID
return
*/
AHK_Scripts(Array)
{
Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
DetectHiddenWindows, On
WinGet, AHK_Windows, List, ahk_class AutoHotkey
%Array% := {}
list := ""
Loop %AHK_Windows%
{
hWin := AHK_Windows%A_Index%
WinGetTitle, Win_Name, ahk_id %hWin%
File_Path := RegExReplace(Win_Name, "(^.*\.\S*) - AutoHotkey .*$", "$1")
SplitPath, File_Path, File_Name, File_Dir, File_Ext, File_Title
%array%[A_Index,"Path"] := File_Path
%array%[A_Index,"Name"] := File_Name
%array%[A_Index,"Dir"] := File_Dir
%array%[A_Index,"Ext"] := File_Ext
%array%[A_Index,"Title"] := File_Title
%array%[A_Index,"ID"] := hWin
list .= File_Path "`n"
}
DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
return Trim(list, " `n")
}
;}