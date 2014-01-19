SetBatchLines, -1  ; Make the operation run at maximum speed.

folders_deleted = 0
FileSelectFolder, WhichFolder  ; Ask the user to pick a folder.
Loop, %WhichFolder%\*, 2 ;,1
	{
	currentfolder:=A_LoopFileFullPath
	FolderSizeKB = 0
	Loop, %CurrentFolder%\*.*, , 1
		{
		FolderSizeKB += %A_LoopFileSizeKB%
		}
	;msgbox %CurrentFolder%`n%FolderSizeKB%
	if FolderSizeKB < 100
		{
		;msgbox
		fileremovedir,%CurrentFolder%,1
		folders_deleted+=1
		}
	}
msgbox Deleted %folders_deleted% folders.
return
