;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon@hiddensoft.com)
;
; Script Function:
;   Demo of using multiple lines in a message box
;

; Use the @CRLF macro to do a newline in a MsgBox - it is similar to the \n in v2.64
;
;
;changes log
;2009.03.20 增加 压缩包中增加ep*.DLL
;

#include <GuiConstants.au3>
;
$regBranch = "HKEY_LOCAL_MACHINE\SOFTWARE\LzWorks-Ltd\codepack"

$cxMain = 600
$cyMain = 400
; GUI
$WinMain  = GuiCreate("Codepack GUI v0.2", $cxMain, $cyMain)
GuiSetIcon(@SystemDir & "\zipfldr.dll", 101,$WinMain)

;List
$listview = GuiCtrlCreateListView ("log infomation-----------------------------",0,0,$cxMain,150);,$LVS_SORTDESCENDING)
$item1=GuiCtrlCreateListViewItem("item2",$listview)

; AVI
$aviCtrl = GuiCtrlCreateAvi(@SystemDir & "\shell32.dll",167, 40, 150, $cxMain, 60)

; PROGRESS
GuiCtrlCreateLabel("参数:", 0, 220)
GuiCtrlCreateProgress(50, 220, $cxMain - 50, 20)
GuiCtrlSetData(-1, 60)
; BUTTON
$btnWesKassiniSmall = GuiCtrlCreateButton("WesKassiniSmall", 0, 240, 120, 20)
$strWesKassiniSmall = RegRead($regBranch, "WesKassiniSmall" )
if($strWesKassiniSmall == "") Then
	$strWesKassiniSmall = "-xr!test_*.* -xr!debug -xr!release -xr!*.ncb -xr!*.opt -xr!*.plg -xr!ek*.dll"
Endif
$editWesKassiniSmall = GuiCtrlCreateEdit($strWesKassiniSmall,120,240,$cxMain-120,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL)

$btnWesKassiniXXXXXX = GuiCtrlCreateButton("WesKassiniXXXXXX", 0, 260, 120, 20)
$strWesKassiniXXXXXX = RegRead($regBranch, "WesKassiniXXXXXX" )
if($strWesKassiniXXXXXX == "") Then
	$strWesKassiniXXXXXX = "-xr!test_*.* -xr!debug -xr!release"
Endif
$editWesKassiniXXXXXX = GuiCtrlCreateEdit($strWesKassiniXXXXXX,120,260,$cxMain-120,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL)

$btnWesTest_xxxxxx_LZW = GuiCtrlCreateButton("WesTest_xxxxxx_LZW", 00, 280, 120, 20)
$strWesTest_xxxxxx_LZW = RegRead($regBranch, "WesTest_xxxxxx_LZW" )
if($strWesTest_xxxxxx_LZW == "") Then
	$strWesTest_xxxxxx_LZW = "-xr!test_*.* -xr!debug -xr!release -xr!.svn -xr!*.ncb -xr!*.opt -xr!*.plg -xr!ek*.dll"
Endif
$editWesTest_xxxxxx_LZW = GuiCtrlCreateEdit($strWesTest_xxxxxx_LZW,120,280,$cxMain-120,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL)

$btnSFT_LZW_xxxxxx = GuiCtrlCreateButton("SFT_LZW_xxxxxx", 00, 300, 120, 20)
$strSFT_LZW_xxxxxx = RegRead($regBranch, "SFT_LZW_xxxxxx" )
if($strSFT_LZW_xxxxxx == "") Then
	$strSFT_LZW_xxxxxx = "-xr!SFT*.*"
Endif
$editSFT_LZW_xxxxxx = GuiCtrlCreateEdit($strSFT_LZW_xxxxxx,120,300,$cxMain-120,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL)

$zdir = "E:\Software\Other\7-ZipPortable\App\7-Zip"
$srcdir = "D:\Workshop\Codecan\Weskassini"
$packname = StringFormat("WesKassini%02d%02d%02d.7z",@YEAR,@MON,@MDAY)
$packdir = "D:\workshop\Codecan"
$packpath = "D:\Workshop\Codecan\" & $packname
$svn = " -xr!.svn"

; GUI MESSAGE LOOP
GuiSetState()

GuiCtrlCreateListViewItem($zdir,$listview)
GuiCtrlCreateListViewItem($srcdir,$listview)
GuiCtrlCreateListViewItem($packname,$listview)
GuiCtrlCreateListViewItem($packpath,$listview)


Do
   $Msg = GuiGetMsg()
   If $msg = $btnWesKassiniSmall Then
     ; When you press Encrypt
     ;~~
   ;   GuiSetState(@SW_DISABLE,$WinMain)
     ; Stops you from changing anything
     ;~~
      $oldEnv = EnvGet("PATH")
 		 GuiCtrlCreateListViewItem($oldEnv,$listview)    
      $newEnv = $zdir & ";" & $oldEnv
  	 GuiCtrlCreateListViewItem($newEnv,$listview)    
        EnvSet("PATH",$newEnv)
     ; Saves the editbox for later
     ;~~
     $cmd = StringFormat("7z.exe a -mx9 %s %s" & "\\*.* -r " & $strWesKassiniSmall,$packpath,$srcdir)
     	 GuiCtrlCreateListViewItem($cmd,$listview)    
     GUICtrlSetState($aviCtrl,1)
     RunWait($cmd,$packdir,@SW_MINIMIZE);
     ; Friendly message
     ;~~
	     	 GuiCtrlCreateListViewItem("Zip finished",$listview)
	         GUICtrlSetState($aviCtrl,0) 	  	
     ; Calls the encryption. Sets the data of editbox with the encrypted string
     ;~~
      EnvSet("PATH",$oldEnv)
    ;  GuiSetState(@SW_ENABLE,$WinMain)
	     	 GuiCtrlCreateListViewItem($oldEnv,$listview)
     ; This turns the window back on
     ;~~
   EndIf   
   If $msg = $btnWesKassiniXXXXXX Then
     ; When you press Encrypt
     ;~~
   ;   GuiSetState(@SW_DISABLE,$WinMain)
     ; Stops you from changing anything
     ;~~
      $oldEnv = EnvGet("PATH")
 		 GuiCtrlCreateListViewItem($oldEnv,$listview)    
      $newEnv = $zdir & ";" & $oldEnv
  	 GuiCtrlCreateListViewItem($newEnv,$listview)    
        EnvSet("PATH",$newEnv)
     ; Saves the editbox for later
     ;~~
     $cmd = StringFormat("7z.exe a -mx9 %s %s" & "\\*.* -r " & $strWesKassiniXXXXXX,$packpath,$srcdir)
     	 GuiCtrlCreateListViewItem($cmd,$listview)    
     GUICtrlSetState($aviCtrl,1)
     RunWait($cmd,$packdir,@SW_MINIMIZE);
     ; Friendly message
     ;~~
	     	 GuiCtrlCreateListViewItem("Zip finished",$listview)
	         GUICtrlSetState($aviCtrl,0) 	  	
     ; Calls the encryption. Sets the data of editbox with the encrypted string
     ;~~
      EnvSet("PATH",$oldEnv)
    ;  GuiSetState(@SW_ENABLE,$WinMain)
	     	 GuiCtrlCreateListViewItem($oldEnv,$listview)
     ; This turns the window back on
     ;~~
   EndIf
   If $msg = $btnWesTest_xxxxxx_LZW Then
      ; When you press Encrypt
     $packname = StringFormat("WesTest_%02d%02d%02d_LZW.7z",@YEAR -2000,@MON,@MDAY)
			$packpath = "D:\Workshop\Codecan\" & $packname  ;~~
   ;   GuiSetState(@SW_DISABLE,$WinMain)
     ; Stops you from changing anything
     ;~~
      $oldEnv = EnvGet("PATH")
 		 GuiCtrlCreateListViewItem($oldEnv,$listview)    
      $newEnv = $zdir & ";" & $oldEnv
  	 GuiCtrlCreateListViewItem($newEnv,$listview)    
        EnvSet("PATH",$newEnv)
     ; Saves the editbox for later
     ;~~
     $cmd = StringFormat("7z.exe a -mx9 %s %s" & "\\*.* -r " & $strWesTest_xxxxxx_LZW,$packpath,$srcdir,$svn)
     	 GuiCtrlCreateListViewItem($cmd,$listview)    
     GUICtrlSetState($aviCtrl,1)
     RunWait($cmd,$packdir,@SW_MINIMIZE);
     ; Friendly message
     ;~~
	     	 GuiCtrlCreateListViewItem("Zip finished",$listview)
	         GUICtrlSetState($aviCtrl,0) 	  	
     ; Calls the encryption. Sets the data of editbox with the encrypted string
     ;~~
      EnvSet("PATH",$oldEnv)
    ;  GuiSetState(@SW_ENABLE,$WinMain)
	     	 GuiCtrlCreateListViewItem($oldEnv,$listview)
     ; This turns the window back on
     ;~~
   EndIf
   If $msg = $btnSFT_LZW_xxxxxx Then
     ; When you press Encrypt
     $packname = StringFormat("SFT_LZW_%02d%02d%02d.7z",@YEAR - 2000,@MON,@MDAY)
     $packpath = "D:\workshop\upload";
     $packpath = $packpath & "\" & $packname
     $srcdir = "D:\workshop\upload"
     ;~~
   ;   GuiSetState(@SW_DISABLE,$WinMain)
     ; Stops you from changing anything
     ;~~
      $oldEnv = EnvGet("PATH")
 		 GuiCtrlCreateListViewItem($oldEnv,$listview)    
      $newEnv = $zdir & ";" & $oldEnv
  	 GuiCtrlCreateListViewItem($newEnv,$listview)    
        EnvSet("PATH",$newEnv)
     ; Saves the editbox for later
     ;~~
     $cmd = StringFormat("7z.exe a -mx9 %s %s" & "\\*.* -r " &$strSFT_LZW_xxxxxx,$packpath,$srcdir)
     	 GuiCtrlCreateListViewItem($cmd,$listview)    
     GUICtrlSetState($aviCtrl,1)
     RunWait($cmd,$packdir,@SW_MINIMIZE);
     ; Friendly message
     ;~~
	     	 GuiCtrlCreateListViewItem("Zip finished",$listview)
	         GUICtrlSetState($aviCtrl,0) 	  	
     ; Calls the encryption. Sets the data of editbox with the encrypted string
     ;~~
      EnvSet("PATH",$oldEnv)
    ;  GuiSetState(@SW_ENABLE,$WinMain)
	     	 GuiCtrlCreateListViewItem($oldEnv,$listview)
     ; This turns the window back on
     ;~~
   EndIf
Until $msg = $GUI_EVENT_CLOSE; Continue loop untill window is closed

   		$strWesKassiniSmall = GUICtrlRead($editWesKassiniSmall)
   		RegWrite($regBranch,"WesKassiniSmall","REG_SZ",$strWesKassiniSmall);
   		$strWesKassiniXXXXXX = GUICtrlRead($editWesKassiniXXXXXX)
   		RegWrite($regBranch,"WesKassiniXXXXXX","REG_SZ",$strWesKassiniXXXXXX);
   		$strWesTest_xxxxxx_LZW = GUICtrlRead($editWesTest_xxxxxx_LZW)
   		RegWrite($regBranch,"WesTest_xxxxxx_LZW","REG_SZ",$strWesTest_xxxxxx_LZW);
   		$strSFT_LZW_xxxxxx = GUICtrlRead($editSFT_LZW_xxxxxx)
   		RegWrite($regBranch,"SFT_LZW_xxxxxx","REG_SZ",$strSFT_LZW_xxxxxx);   		
Exit