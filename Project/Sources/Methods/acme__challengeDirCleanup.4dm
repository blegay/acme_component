//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__challengeDirCleanup
  //@scope : private
  //@deprecated : no
  //@description : This method cleans up old files the the challenge dir path
  //@parameter[1-IN-challengeDirPath-TEXT] : challenge dir path
  //@notes : deletes files which are more than 90 days old (based on file creation dates)
  //@example : acme__challengeDirCleanup
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 13/02/2019, 23:56:55 - 0.90.01
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_challengeDirPath)

ASSERT:C1129(Count parameters:C259>0;"require 1 parameter")
ASSERT:C1129(Test path name:C476($1)=Is a folder:K24:2;"$1 (challengeDirPath) is not a directory")

$vt_challengeDirPath:=$1

ARRAY TEXT:C222($tt_challengeFilename;0)
DOCUMENT LIST:C474($vt_challengeDirPath;$tt_challengeFilename;Ignore invisible:K24:16)

C_DATE:C307($vd_dateOldMax)
$vd_dateOldMax:=Current date:C33-90

C_LONGINT:C283($vl_fileIndex;$vl_fileCount)
$vl_fileCount:=Size of array:C274($tt_challengeFilename)
ARRAY TEXT:C222($tt_timestamp;$vl_fileCount)
ARRAY BOOLEAN:C223($tb_delete;$vl_fileCount)
ARRAY REAL:C219($tr_size;$vl_fileCount)

For ($vl_fileIndex;$vl_fileCount;1;-1)
	C_TEXT:C284($vt_filename)
	$vt_filename:=$tt_challengeFilename{$vl_fileIndex}
	
	  // "0DVEXA0EBxu5c79gJi0iLXDDM6NOIZt--h3jIbgwqKA-8d55f3a6523d5c3b015117864a91af82.txt"
	  // "0a0DPbb_qPYQHZT5jMAae_O7drlKw0FS0D60Zr0RMis-68f531c3194a1a89dd266a8f10b43488.txt"
	C_TEXT:C284($vt_regex)
	$vt_regex:="(?i)^[0-9a-zA-Z_-]{43}-[0-9a-f]{32}\\.txt$"
	  //$vt_regex:="^.{43}-[0-9a-f]{32}\\.txt$"
	  //$vt_regex:="^.{43}-.{32}\\.txt$"
	If (Match regex:C1019($vt_regex;$vt_filename;1;*))
		
		C_TEXT:C284($vt_filepath)
		$vt_filepath:=$vt_challengeDirPath+$vt_filename
		
		C_REAL:C285($vr_size)
		$vr_size:=Get document size:C479($vt_filepath)
		If ($vr_size<256)
			
			C_BOOLEAN:C305($vb_locked;$vb_invisible)
			C_DATE:C307($vd_createdOn;$vd_modifiedOn)
			C_TIME:C306($vh_createdOn;$vh_modifiedOn)
			GET DOCUMENT PROPERTIES:C477($vt_filepath;$vb_locked;$vb_invisible;$vd_createdOn;$vh_createdOn;$vd_modifiedOn;$vh_modifiedOn)
			
			$tt_timestamp{$vl_fileIndex}:=String:C10(Year of:C25($vd_createdOn);"0000")+"-"+String:C10(Month of:C24($vd_createdOn);"00")+"-"+String:C10(Day of:C23($vd_createdOn);"00")+"T"+Time string:C180($vh_createdOn)
			
			$tb_delete{$vl_fileIndex}:=($vd_createdOn<$vd_dateOldMax)
			
			$tr_size{$vl_fileIndex}:=$vr_size
			
		Else 
			DELETE FROM ARRAY:C228($tt_challengeFilename;$vl_fileIndex;1)
			DELETE FROM ARRAY:C228($tt_timestamp;$vl_fileIndex;1)
			DELETE FROM ARRAY:C228($tb_delete;$vl_fileIndex;1)
			DELETE FROM ARRAY:C228($tr_size;$vl_fileIndex;1)
			
			acme__log (4;Current method name:C684;"file \""+$vt_filename+"\" size "+String:C10($vr_size)+" bytes is greater or aqual to 256 bytes, file ignored.")
		End if 
		
		
	Else 
		DELETE FROM ARRAY:C228($tt_challengeFilename;$vl_fileIndex;1)
		DELETE FROM ARRAY:C228($tt_timestamp;$vl_fileIndex;1)
		DELETE FROM ARRAY:C228($tb_delete;$vl_fileIndex;1)
		DELETE FROM ARRAY:C228($tr_size;$vl_fileIndex;1)
		
		acme__log (4;Current method name:C684;"file name \""+$vt_filename+"\" does not match regex \""+$vt_regex+"\", file ignored.")
	End if 
End for 

SORT ARRAY:C229($tt_timestamp;$tt_challengeFilename;$tb_delete;$tr_size;>)

$vl_fileCount:=Size of array:C274($tt_challengeFilename)
For ($vl_fileIndex;1;$vl_fileCount)
	
	C_TEXT:C284($vt_filename)
	$vt_filename:=$tt_challengeFilename{$vl_fileIndex}
	
	C_TEXT:C284($vt_filepath)
	$vt_filepath:=$vt_challengeDirPath+$vt_filename
	
	If ($tb_delete{$vl_fileIndex})
		DELETE DOCUMENT:C159($vt_filepath)
		C_BOOLEAN:C305($vb_challengeFileDeleteOk)
		$vb_challengeFileDeleteOk:=(ok=1)
		ASSERT:C1129($vb_challengeFileDeleteOk;"error deleting file \""+$vt_filepath+"\"")
		
		acme__log (Choose:C955($vb_challengeFileDeleteOk;4;2);Current method name:C684;"deleting file \""+$vt_filepath+"\", (size "+String:C10($tr_size{$vl_fileIndex})+" bytes, created on "+$tt_timestamp{$vl_fileIndex}+", older than "+String:C10($vd_dateOldMax)+"). "+Choose:C955($vb_challengeFileDeleteOk;"[OK]";"[KO]"))
	Else 
		acme__log (6;Current method name:C684;"file \""+$vt_filepath+"\" (size "+String:C10($tr_size{$vl_fileIndex})+" bytes, created on "+$tt_timestamp{$vl_fileIndex}+")")
	End if 
	
End for 

ARRAY REAL:C219($tr_size;0)
ARRAY TEXT:C222($tt_challengeFilename;0)
ARRAY TEXT:C222($tt_timestamp;0)
ARRAY BOOLEAN:C223($tb_delete;0)
