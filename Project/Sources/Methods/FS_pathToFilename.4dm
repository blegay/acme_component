//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : FS_pathToFilename
  //@scope : private
  //@deprecated : no
  //@description : This function returns the filename for a given path
  //@parameter[0-OUT-filename-TEXT] : filename
  //@parameter[1-IN-path-TEXT] : path
  //@parameter[2-IN-sep-ALPHA] : separator (optional, default : current plateform separator)
  //@notes : 
  //@example : 

  //FS_pathToFileName ("Disque Dur:Dossier Grand Parent:Dossier Parent:Fichier") => 
  //   —————————————————————————————>    "Fichier"
  //
  //FS_pathToFileName ("Disque Dur:Dossier Grand Parent:Dossier Parent:a") => 
  //   —————————————————————————————>   "a"
  //
  //FS_pathToFileName ("Disque Dur:Dossier Grand Parent:Dossier Parent:") => 
  //   —————————————————————————————>   ""
  //
  //FS_pathToFileName ("Disque Dur:Dossier Grand Parent:Dossier Parent") => 
  //   --------------------------->  "Dossier Parent"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2018, 11:04:53 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_filename)  //file name
C_TEXT:C284($1;$vt_path)  //path
C_TEXT:C284($2;$va_sep)  //plateform separator
  //C_ALPHA(1;$2;$va_sep)  //plateform separator

$vt_filename:=""
C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	$vt_path:=$1
	
	Case of 
		: ($vl_nbParam=1)
			$va_sep:=""
		Else 
			  //: ($vl_nbParam=2)
			$va_sep:=$2
	End case 
	
	If (Length:C16($va_sep)#1)
		$va_sep:=Folder separator:K24:12  //FS_pathSeparator 
	End if 
	
	C_LONGINT:C283($vl_pathLength)
	$vl_pathLength:=Length:C16($vt_path)
	
	If ($vl_pathLength>0)
		
		C_LONGINT:C283($vl_pos)
		$vl_pos:=0
		
		C_LONGINT:C283($i)
		For ($i;$vl_pathLength;1;-1)
			
			If ($vt_path[[$i]]=$va_sep)
				$vl_pos:=$i
				$i:=0
			End if 
			
		End for 
		
		If ($vl_pos>0)
			$vt_filename:=Substring:C12($vt_path;$vl_pos+1)
		Else 
			$vt_filename:=$vt_path
		End if 
		
	End if 
	
End if 
$0:=$vt_filename
