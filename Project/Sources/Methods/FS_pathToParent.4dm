//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : FS_pathToParent
  //@scope : private
  //@deprecated : no
  //@description : This function returns the path of the parent directory 
  //@parameter[0-OUT-parentDirPath-TEXT] : parent dir path
  //@parameter[1-IN-path-TEXT] : path
  //@notes : 
  //@example : FS_pathToParent
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 10:26:50 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_pathToParentDir)  //path to parent dir
C_TEXT:C284($1;$vt_path)  //path

$vt_pathToParentDir:=""
If (Count parameters:C259>0)
	$vt_path:=$1
	
	C_TEXT:C284($va_sep)
	  //C_ALPHA(1;$va_sep)
	$va_sep:=Folder separator:K24:12  //FS_pathSeparator not needed since v12 :-)
	
	C_LONGINT:C283($vl_pathLength)
	$vl_pathLength:=Length:C16($vt_path)
	
	If ($vl_pathLength>1)
		  //If we receive  "…:Dossier Grand Parent:Dossier Parent:" we want to get 
		  //                  "…:Dossier Grand Parent:"
		  //so we should start at $vl_pathLength-1
		
		C_LONGINT:C283($vl_pos)
		$vl_pos:=0
		
		C_LONGINT:C283($i)
		For ($i;$vl_pathLength-1;1;-1)
			
			If ($vt_path[[$i]]=$va_sep)
				$vl_pos:=$i
				$i:=0
			End if 
			
		End for 
		
		If ($vl_pos>0)
			$vt_pathToParentDir:=Substring:C12($vt_path;1;$vl_pos)
		Else 
			$vt_pathToParentDir:=""  //$1
		End if 
	End if 
	
End if 
$0:=$vt_pathToParentDir