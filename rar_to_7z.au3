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
; Use the @CRLF macro to do a newline in a MsgBox - it is similar to the \n in v2.64
;
;changelog
; add 7z parammeters line
;
#include <GuiConstants.au3>

$regBranch = "HKEY_LOCAL_MACHINE\SOFTWARE\LzWorks-Ltd\rar_to_7z"

$cxMain = 450
$cyMain = 430
; GUI
$WinMain  = GuiCreate("Convert RAR to 7z GUI v0.2", $cxMain, $cyMain)
GuiSetIcon(@SystemDir & "\zipfldr.dll", 101,$WinMain)


; AVI
$aviCtrl = GuiCtrlCreateAvi(@SystemDir & "\shell32.dll",167, 0, 0, $cxMain,60)


$cmbCmplv = GuiCtrlCreateCombo("1",0,70,80,20); create first item
GUICtrlSetData($cmbCmplv,"3|5|7|9","9") ; add other item snd set a new default

$editRarPath = GuiCtrlCreateEdit("",0,110,380,20,$ES_READONLY);
$editRarFile = GuiCtrlCreateEdit("",0,130,380,20,$ES_READONLY);
$btnRarPath = GuiCtrlCreateButton("目录", 380, 110, $cxMain - 380, 20);
$btnRarFile = GuiCtrlCreateButton("文件", 380, 130, $cxMain - 380, 20);

$chkAllFile = GuiCtrlCreateCheckbox("*.rar",0,150,380,20);

$str7zParameters = RegRead($regBranch, "7zParameters" )
if($str7zParameters == "") Then
	$str7zParameters = "-xr!test_*.* -xr!debug -xr!release -xr!*.ncb -xr!*.opt -xr!*.plg -xr!ek*.dll -xr!ep*.dll"
Endif
GuiCtrlCreateLabel("7z参数",0,180,50,20)
$edit7zParameters = GuiCtrlCreateEdit($str7zParameters ,50,180,$cxMain -50,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL);

$strRarParameters = RegRead($regBranch, "RarParameters" )
if($strRarParameters == "") Then
	$strRarParameters = ""
Endif
GuiCtrlCreateLabel("Rar参数",0,200,50,20)
$editRarParameters = GuiCtrlCreateEdit($strRarParameters,50,200,$cxMain -50,20,$ES_WANTRETURN+ $ES_AUTOVSCROLL+ $ES_AUTOHSCROLL);


; BUTTON
$btnConvertFile = GuiCtrlCreateButton("ConvertF", 0, 340, 120, 30)
$btnConvert = GuiCtrlCreateButton("ConvertA", 120, 340, 120, 30)
$btnExit = GuiCtrlCreateButton("Exit", 240, 340, 120, 30)

$strRarPath ="";
$strRarFile ="";
$str7zFile = "";
$str7zPath ="";



$zdir = "E:\Software\Other\7-ZipPortable\App\7-Zip"
$rdir = "C:\Program Files\WinRAR"
$srcdir = "D:\Workshop\Codecan\Weskassini"

; GUI MESSAGE LOOP
GuiSetState()

Do
   $Msg = GuiGetMsg()
   If $msg = $btnRarPath Then
     ; When you press Encrypt
    $strRarPath = FileSelectFolder ( "Select RAR Path", "" ,3 )
		GUICtrlSetData($editRarPath,$strRarPath);
		$str7zPath = $strRarPath;
     ;~~
   EndIf   
   If $msg = $btnRarFile Then
     ; When you press Encrypt
		$strRarFile = FileOpenDialog("Select RAR File", "", "RAR(*.rar)", 1 + 4 )
		GUICtrlSetData($editRarFile,$strRarFile);
		$str7zFile = $strRarFile;
     ;~~
   EndIf
   If $msg = $btnConvertFile Then
   		GetParameters();
   		;MsgBox(4096, "File:",$str7zParam)
     ; When you press Encrypt
      $oldEnv = EnvGet("PATH")
      $newEnv = $zdir & ";" &$rdir & ";" & $oldEnv
      EnvSet("PATH",$newEnv)

      GUICtrlSetState($aviCtrl,1)
       
	  	$strCmplv = GUICtrlRead($cmbCmplv);

			$search = FileFindFirstFile($strRarFile)  
	
			If $search = -1 Then
	  	  MsgBox(0, "Error", "No files/directories matched the search pattern")
	    	;Exit
	    Else

		    $file = FileFindNextFile($search) 
		    $str7zFile = StringLeft($file,StringLen($file)-3);
		    $str7zFile = $str7zFile & "7z";
		    $strRarPath = StringLeft($strRarFile,StringLen($strRarFile)- StringLen($file)-1)
				;MsgBox(4096, "File:",$strRarPath)
		    ConvertRar($str7zFile,$file)
		  Endif
		  
  	  GUICtrlSetState($aviCtrl,0) 	
   		EnvSet("PATH",$oldEnv)
   EndIf
   
   If $msg = $btnConvert Then
   	
   	  GetParameters();
      ; When you press Encrypt
      $oldEnv = EnvGet("PATH")
      $newEnv = $zdir & ";" &$rdir & ";" & $oldEnv
      EnvSet("PATH",$newEnv)
      GUICtrlSetState($aviCtrl,1)
          
			$strCmplv = GUICtrlRead($cmbCmplv);

			$search = FileFindFirstFile($strRarPath & "\\*.rar")  
		
			If $search = -1 Then
	  	  MsgBox(0, "Error", "No files/directories matched the search pattern")
	    	;Exit
	    Else
				While 1
		    $file = FileFindNextFile($search) 
		    If @error Then ExitLoop
		    
		    $str7zFile = StringLeft($file,StringLen($file)-3);
		    $str7zFile = $str7zFile & "7z";
		    ConvertRar($str7zFile,$file)
				WEnd	    	
		EndIf
	  GUICtrlSetState($aviCtrl,0) 	
    EnvSet("PATH",$oldEnv)

  	EndIf
   
		If $msg = $btnExit Then
   		 $msg = $GUI_EVENT_CLOSE
   	EndIf
   	
Until $msg = $GUI_EVENT_CLOSE; Continue loop untill window is closed
;
   		$str7zParameters = GUICtrlRead($edit7zParameters)
   		;MsgBox(4096, "File:",$str7zParam)
   		 RegWrite($regBranch,"7zParameters","REG_SZ",$str7zParameters);
   		$strRarParameters = GUICtrlRead($editRarParameters)
   		;MsgBox(4096, "File:",$str7zParam)
   		 RegWrite($regBranch,"RarParameters","REG_SZ",$strRarParameters);
Exit

Func ConvertRar(ByRef $s7z, ByRef $rar)  ;swap the contents of two variables

  $ra = $strRarPath &"\" & $rar
	$cmd1=StringFormat("RAR.exe x -y "& Chr(34)& "%s" &Chr(34) & " " &Chr(34) & "%s\\Temp\\" &Chr(34),$ra,$strRarPath);
	;MsgBox(4096, "File:",$cmd1)
	$s7 = $strRarPath &"\" & $s7z
	$cmd2=StringFormat("7z.exe a -mx%s "& Chr(34)& "%s"& Chr(34)& " "& Chr(34)& "%s\\Temp\\*.*"& Chr(34)& " -r " & $str7zParameters,$strCmplv,$s7,$strRarPath)
 

  RunWait($cmd1,$strRarPath,@SW_MINIMIZE);
  RunWait($cmd2,$strRarPath,@SW_MINIMIZE);
  ;MsgBox(4096, "File:",Chr(34)& $strRarPath & "\Temp" & Chr(34))
  DirRemove($strRarPath & "\Temp" ,1);
EndFunc

Func GetParameters()
	   $str7zParameters = GUICtrlRead($edit7zParameters)
   	 $strRarParameters = GUICtrlRead($editRarParameters)
EndFunc