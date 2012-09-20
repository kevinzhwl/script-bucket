;Update Kapsersky VirusDef

;Update Kaspersky Virus Defination 


Dim $strVirusDefName1
Dim $strVirusDefName2
Dim $strVirusDefName3
Dim $strVirusDefName[4]
Dim $nVirusDefName[4]

$strVirusDefName[1]= "\av-i386-cumul.zip"
$strVirusDefName[2]= "\av-i386-weekly.zip"
$strVirusDefName[3]= "\av-i386-daily.zip"
$nVirusDefName[1]=0
$nVirusDefName[2]=0
$nVirusDefName[3]=0

Dim $strVirusDefPathOnServer
Dim $strVirusDefPathOnLocal
Dim $strVirusDefDate


$strVirusDefDate = "dat" & @YEAR & @MON 

Dim $strVirusDefDay 
Dim $intDay
If (@WDAY < 2) Then
	$intDay = @MDAY - (@WDAY +1)
	if (int($intDay)<10) Then 
		$strVirusDefDay &="0"
		EndIf
	$strVirusDefDay &= String($intDay) ;-7
Else
	If (@WDAY < 6) Then
		$intDay = @MDAY - (@WDAY + 1)
		if ($intDay<10) Then 
			$strVirusDefDay &="0"
			EndIf
	$strVirusDefDay &= String($intDay)
Else
	$intDay = @MDAY ;- (@WDAY -6) ;-7
	if ($intDay<10) then
		$strVirusDefDay &="0" 
		EndIf
	$strVirusDefDay &= String($intDay)
	EndIf

EndIf

$strVirusDefDate &= $strVirusDefDay


$strVirusDefPathOnServer = "\\Ema\share\Software\WinApp\Virus\"
If ((@WDAY == 7)) Then ;(@WDAY == 1) OR 
	$strVirusDefPathOnServer = "\\Ema\tmp\"
EndIf

If (FileExists($strVirusDefPathOnServer & $strVirusDefDate)) Then
	$strVirusDefPathOnServer &= $strVirusDefDate
Else 
	If (FileExists("\\Ema\share\Software\WinApp\Virus\"&$strVirusDefDate)) Then
	$strVirusDefPathOnServer = "\\Ema\share\Software\WinApp\Virus\"
	$strVirusDefPathOnServer &= $strVirusDefDate
Else 
	If (FileExists("\\Ema\tmp\"&$strVirusDefDate)) Then
	$strVirusDefPathOnServer = "\\Ema\tmp\"
	$strVirusDefPathOnServer &= $strVirusDefDate
Else
	If (FileExists("\\Ema\share\Software\WinApp\Virus\test")) Then
	$strVirusDefPathOnServer = "\\Ema\share\Software\WinApp\Virus\test"
Else
		MsgBox(0,"病毒库位置","无法找到病毒库"&$strVirusDefDate,5)
		Exit
		EndIf
		EndIf
	EndIf
EndIf

;$strVirusDefPathOnServer &= $strVirusDefDate

$strVirusDefPathOnServer &= "\Kaspersky"

$strVirusDefPathOnLocal = "E:\Software\Kaspersky"


MsgBox(0,"病毒库位置",$strVirusDefPathOnServer,2); & @CRLF & $strVirusDefPathOnLocal


Dim $strVirusDefSrc
Dim $strVirusDefDest

Dim $i
For $i=1 To 3 Step 1
	$strVirusDefSrc = $strVirusDefPathOnServer & $strVirusDefName[$i]
	$strVirusDefDest = $strVirusDefPathOnLocal & $strVirusDefName[$i]
	$nVirusDefName[$i]= FileCopy ($strVirusDefSrc,$strVirusDefDest,1)
Next

;run and wait AVP start up
For $i=1 To 3 Step 1
	If($nVirusDefName[$i]) Then
	$strVirusDefSrc = $strVirusDefPathOnLocal & $strVirusDefName[$i]
	$strVirusDefDest = "E:\Software\Kaspersky\av-i386-one.zip"
	FileCopy ($strVirusDefSrc,$strVirusDefDest,1)
	RunWait("C:\Program Files\Kaspersky Lab\Kaspersky Anti-Virus 6.0\avp.com UPDATE")
	EndIf
Next

MsgBox(0,"卡巴病毒库更新完毕","病毒库来源是" & $strVirusDefPathOnServer ,3)
Run("C:\Program Files\Kaspersky Lab\Kaspersky Anti-Virus 6.0\avp.exe")


