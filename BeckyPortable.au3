;
;
;
AutoItSetOption ( "TrayIconHide" ,1 )

;
;'恢复 Becky 的设置
RunWait("regedit /s b2.reg",@WorkingDir,@SW_MINIMIZE)

;修正字体错误
RegWrite("HKEY_CURRENT_USER\Software\RimArts\B2\Settings","FontFace", "REG_SZ","宋体")

;$oldDataDir = RegRead("HKEY_CURRENT_USER\Software\RimArts\B2\Settings","DataDir");
;$Temp = StringSplit(OldDataDir, "\", 1)
;$FullName = ScriptFullName
;$ScriptName = ScriptName
;$BeckyPath = StringLeft($FullName,StringLen($FullName) - StringLen($ScriptName)
$BeckyPath = @WorkingDir
$DataFolderName = "BeckyMail"
$NewDataDir = $BeckyPath & "\" & $DataFolderName & "\"

;Init GPG for Becky
;。如果你不需要，请注解掉。
;InitGPG()
;Init Windows-Private-Tray
;。如果你不需要，请注解掉。
;InitWinPT()

RegWrite("HKEY_CURRENT_USER\Software\RimArts\B2\Settings","DataDir", "REG_SZ", $NewDataDir)
RunWait("B2.exe")


$RegName = @WorkingDir & "\" & "B2.Reg"
;'以下两句是保存 Becky 的设置
RunWait("regedit /E " & $RegName& " HKEY_CURRENT_USER\Software\RimArts")





Func InitGPG()
     $ExecPath = @ScriptDir
	 $Path = @WorkingDir
	 $GpgName = $ExecPath & "\gpg.exe"
	 ;MsgBox(0,"",$GpgName)
	 ;以下五行是自动安装 GPG 文件。如果你不需要，请注解掉。
	 If(FileExists($GpgName)) Then
		 ;
	 Else
		 FileCopy( $ExecPath & "\Gpg\gpg.exe",$Path & "\")
		 
		 MsgBox(0,"Notice","GPG Init OK",1000)
	 EndIf
	 
	 ;以下三行是设置 GPG 的运行环境。如果你不需要，请注解掉。
	 RegWrite("HKCU\Software\GNU\GnuPG", "HomeDir","REG_SZ",$Path & "\Gpg")
	 RegWrite("HKEY_CLASSES_ROOT\mailto\shell\open\command","","REG_SZ", $Path & "\B2 %1")
	 
     Return 1
 EndFunc

Func InitWinPT()
     $ExecPath = @ScriptDir
	 $Path = @WorkingDir
	 
	 ;下一行是制动运行 WinPT。如果你不需要，请注解掉。
	 Run( $ExecPath & "\WinPT\WinPT.exe");
	return 1
EndFunc


