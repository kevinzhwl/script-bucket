;
;
;
AutoItSetOption ( "TrayIconHide" ,1 )

;
;'�ָ� Becky ������
RunWait("regedit /s b2.reg",@WorkingDir,@SW_MINIMIZE)

;�����������
RegWrite("HKEY_CURRENT_USER\Software\RimArts\B2\Settings","FontFace", "REG_SZ","����")

;$oldDataDir = RegRead("HKEY_CURRENT_USER\Software\RimArts\B2\Settings","DataDir");
;$Temp = StringSplit(OldDataDir, "\", 1)
;$FullName = ScriptFullName
;$ScriptName = ScriptName
;$BeckyPath = StringLeft($FullName,StringLen($FullName) - StringLen($ScriptName)
$BeckyPath = @WorkingDir
$DataFolderName = "BeckyMail"
$NewDataDir = $BeckyPath & "\" & $DataFolderName & "\"

;Init GPG for Becky
;������㲻��Ҫ����ע�����
;InitGPG()
;Init Windows-Private-Tray
;������㲻��Ҫ����ע�����
;InitWinPT()

RegWrite("HKEY_CURRENT_USER\Software\RimArts\B2\Settings","DataDir", "REG_SZ", $NewDataDir)
RunWait("B2.exe")


$RegName = @WorkingDir & "\" & "B2.Reg"
;'���������Ǳ��� Becky ������
RunWait("regedit /E " & $RegName& " HKEY_CURRENT_USER\Software\RimArts")





Func InitGPG()
     $ExecPath = @ScriptDir
	 $Path = @WorkingDir
	 $GpgName = $ExecPath & "\gpg.exe"
	 ;MsgBox(0,"",$GpgName)
	 ;�����������Զ���װ GPG �ļ�������㲻��Ҫ����ע�����
	 If(FileExists($GpgName)) Then
		 ;
	 Else
		 FileCopy( $ExecPath & "\Gpg\gpg.exe",$Path & "\")
		 
		 MsgBox(0,"Notice","GPG Init OK",1000)
	 EndIf
	 
	 ;�������������� GPG �����л���������㲻��Ҫ����ע�����
	 RegWrite("HKCU\Software\GNU\GnuPG", "HomeDir","REG_SZ",$Path & "\Gpg")
	 RegWrite("HKEY_CLASSES_ROOT\mailto\shell\open\command","","REG_SZ", $Path & "\B2 %1")
	 
     Return 1
 EndFunc

Func InitWinPT()
     $ExecPath = @ScriptDir
	 $Path = @WorkingDir
	 
	 ;��һ�����ƶ����� WinPT������㲻��Ҫ����ע�����
	 Run( $ExecPath & "\WinPT\WinPT.exe");
	return 1
EndFunc


