
#include <GuiConstants.au3>
;
$regBranch = "HKCU\SOFTWARE\xeneworks\VDefGet3"

$cxMain = 600
$cyMain = 400
$cx0 = 0
$cy0 =-100
; GUI
$WinMain  = GuiCreate("VDefGet GUI v3", $cxMain, $cyMain)
GuiSetIcon(@SystemDir & "\zipfldr.dll", 101,$WinMain)

; AVI
$aviCtrl = GuiCtrlCreateAvi(@SystemDir & "\shell32.dll",167, 40, 20, $cxMain, 60)

; BUTTON
$btnKAV_URL1 = GuiCtrlCreateButton("KAV-cumul", 0, $cy0 + 240, 120, 20,$WS_DISABLED)
$strKAV_URL1 = RegRead($regBranch, "KAV_URL1" )
if($strKAV_URL1 == "") Then
	$strKAV_URL1 = "http://downloads1.kaspersky-labs.com/zips/av-i386-cumul.zip"
Endif
$editKAV_URL1 = GuiCtrlCreateEdit($strKAV_URL1,120, $cy0 + 240,$cxMain-120,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL)

$btnKAV_URL2 = GuiCtrlCreateButton("KAV_weekly", 0,  $cy0 + 260, 120, 20,$WS_DISABLED)
$strKAV_URL2 = RegRead($regBranch, "KAV_URL2" )
if($strKAV_URL2 == "") Then
	$strKAV_URL2 = "http://downloads1.kaspersky-labs.com/zips/av-i386-weekly.zip"
Endif
$editKAV_URL2 = GuiCtrlCreateEdit($strKAV_URL2,120, $cy0 + 260,$cxMain-120,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL)

$btnKAV_URL3 = GuiCtrlCreateButton("KAV_daily", 00,  $cy0 + 280, 120, 20,$WS_DISABLED)
$strKAV_URL3 = RegRead($regBranch, "KAV_URL3" )
if($strKAV_URL3 == "") Then
	$strKAV_URL3 = "http://downloads1.kaspersky-labs.com/zips/av-i386-daily.zip"
Endif
$editKAV_URL3 = GuiCtrlCreateEdit($strKAV_URL3,120, $cy0 + 280,$cxMain-120,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL)

$btnSAV_URL = GuiCtrlCreateButton("SAV", 00,  $cy0 + 300, 120, 20,$WS_DISABLED)
$strSAV_URL = RegRead($regBranch, "SAV_URL" )
if($strSAV_URL == "") Then
	$strSAV_URL = "http://definitions.symantec.com/defs/symcdefsi32.exe"
Endif
$editSAV_URL = GuiCtrlCreateEdit($strSAV_URL,120, $cy0 + 300,$cxMain-120,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL)

$btnVDefsLocal = GuiCtrlCreateButton("Local", 00,  $cy0 + 320, 120, 20,$WS_DISABLED)
$strVDefsLocal = RegRead($regBranch, "VDefsLocal" )
if($strVDefsLocal == "") Then
	$strVDefsLocal = "C:\VDefsLocal"
Endif
$editVDefsLocal = GuiCtrlCreateEdit($strVDefsLocal,120, $cy0 + 320,$cxMain-120,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL)

$btnDownload = GuiCtrlCreateButton("下载", 00,  $cy0 + 350, 120, 50)


$strRemindme = RegRead($regBranch, "Remindme" )
if($strRemindme == "") Then
	$strRemindme = $GUI_CHECKED
Endif
$btnRemindme = GUICtrlCreateCheckbox("完成后提示我", 200,  $cy0 + 350, 120, 50)
 GUICtrlSetState ($btnRemindme,$strRemindme)
	

; GUI MESSAGE LOOP
GuiSetState()

$background = 1
$timeout =1

Do
   $Msg = GuiGetMsg()
   If $msg = $btnDownload Then
           ; When you press Encrypt
		; Advanced example - downloading in the background
   		$strKAV_URL1 = GUICtrlRead($editKAV_URL1)		
   		$strKAV_URL2 = GUICtrlRead($editKAV_URL2)
   		$strKAV_URL3 = GUICtrlRead($editKAV_URL3)  		
   		$strSAV_URL = GUICtrlRead($editSAV_URL)   		
   		$strVDefsLocal = GUICtrlRead($editVDefsLocal)
   		
   		GUICtrlSetState($aviCtrl,1)
   		     
   		DirCreate($strVDefsLocal)
   		DirCreate($strVDefsLocal & "\Kaspersky")
   		DirCreate($strVDefsLocal & "\Symantec")
			InetGet($strKAV_URL1, $strVDefsLocal & "\Kaspersky"& "\av-i386-cumul.zip", 0, $background)
				While @InetGetActive
			  TrayTip("Downloading", "Bytes = " & @InetGetBytesRead, $timeout, 16)
			  Sleep(1250)
			Wend
						InetGet($strKAV_URL2, $strVDefsLocal & "\Kaspersky"& "\av-i386-weekly.zip", 0, $background)
				While @InetGetActive
			  TrayTip("Downloading", "Bytes = " & @InetGetBytesRead, $timeout, 16)
			  Sleep(1250)
			Wend
			InetGet($strKAV_URL3, $strVDefsLocal & "\Kaspersky"& "\av-i386-daily.zip", 0, $background)			
				While @InetGetActive
			  TrayTip("Downloading", "Bytes = " & @InetGetBytesRead, $timeout, 16)
			  Sleep(1250)
			Wend
			InetGet($strSAV_URL, $strVDefsLocal & "\Symantec"& "\symcvdefsi32.zip", 0, $background)			
				While @InetGetActive
			  TrayTip("Downloading", "Bytes = " & @InetGetBytesRead, $timeout, 16)
			  Sleep(1250)
			Wend
			GUICtrlSetState($aviCtrl,0)
			 $strRemindme = GUICtrlRead($btnRemindme)
			 if($strRemindme == $GUI_CHECKED) Then
			 	
			MsgBox(4096, $strVDefsLocal,"下载完毕")
			Run(@WindowsDir & "\explorer.exe" &" " & $strVDefsLocal,$strVDefsLocal,@SW_SHOW);
			Endif
   EndIf   

Until $msg = $GUI_EVENT_CLOSE; Continue loop untill window is closed


   		RegWrite($regBranch,"KAV_URL1","REG_SZ",$strKAV_URL1);

   		RegWrite($regBranch,"KAV_URL2","REG_SZ",$strKAV_URL2);

   		RegWrite($regBranch,"KAV_URL3","REG_SZ",$strKAV_URL3);

   		RegWrite($regBranch,"SAV_URL","REG_SZ",$strSAV_URL);   		

   		RegWrite($regBranch,"VDefsLocal","REG_SZ",$strVDefsLocal);   	
   		RegWrite($regBranch,"Remindme","REG_SZ",$strRemindme);  	
Exit


; Advanced example - downloading in the background
InetGet("http://www.nowhere.com/somelargefile.exe", "test.exe", 1, 1)

While @InetGetActive
  TrayTip("Downloading", "Bytes = " & @InetGetBytesRead, 10, 16)
  Sleep(250)
Wend

MsgBox(0, "Bytes read", @InetGetBytesRead)
