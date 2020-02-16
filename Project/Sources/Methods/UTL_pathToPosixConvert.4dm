//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL_pathToPosixConvert
  //@scope : private
  //@deprecated : no
  //@description : This function converts a local file path to posix
  //@parameter[0-OUT-posix-TEXT] : filepath posix
  //@parameter[1-IN-path-TEXT] : path
  //@parameter[2-IN-enclose-BOOLEAN] : add enclose quotes
  //@notes : 
  //@example : UTL_pathToPosixConvert
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 22:07:34 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_posix)
C_TEXT:C284($1;$vt_path)
C_BOOLEAN:C305($2;$vb_enclose)
ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_posix:=""
$vt_path:=$1

If (Count parameters:C259>1)
	$vb_enclose:=$2
Else 
	$vb_enclose:=True:C214
End if 

If (ENV_onWindows )
	
	$vt_posix:=$vt_path
	If ($vb_enclose)
		$vt_posix:="\""+$vt_posix+"\""
	End if 
	
Else 
	
	$vt_posix:=Convert path system to POSIX:C1106($vt_path)
	If ($vb_enclose)
		$vt_posix:="'"+$vt_posix+"'"
	End if 
	
End if 

$0:=$vt_posix