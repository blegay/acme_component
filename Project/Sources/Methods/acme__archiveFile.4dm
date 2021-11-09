//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__archiveFile
  //@scope : private
  //@deprecated : no
  //@description : This method will archive a file
  //@parameter[0-IN-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-filepath-TEXT] : filepath
  //@parameter[2-IN-archiveDir-TEXT] : archiveDir
  //@notes : 
  //@example : acme__archiveFile
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2018, 10:57:09 - 1.0
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_filepath)
C_TEXT:C284($2;$vt_archiveDir)

$vb_ok:=False:C215
$vt_filepath:=$1
$vt_archiveDir:=$2

If (Test path name:C476($vt_filepath)=Is a document:K24:1)
	If (Test path name:C476($vt_archiveDir)#Is a folder:K24:2)
		CREATE FOLDER:C475($vt_archiveDir;*)
	End if 
	
	C_BOOLEAN:C305($vb_locked;$vb_invisible)
	C_DATE:C307($vd_createdOn;$vd_modifiedOn)
	C_TIME:C306($vh_createdOn;$vh_modifiedOn)
	GET DOCUMENT PROPERTIES:C477($vt_filepath;$vb_locked;$vb_invisible;$vd_createdOn;$vh_createdOn;$vd_modifiedOn;$vh_modifiedOn)
	
	C_TEXT:C284($vt_filename)
	$vt_filename:=FS_pathToFilename ($vt_filepath)
	
	C_TEXT:C284($vt_filepathNew)
	$vt_filepathNew:=$vt_archiveDir+acme__timestamp ($vd_createdOn;$vh_createdOn)+"_"+$vt_filename
	
	If (Test path name:C476($vt_filepathNew)=Is a document:K24:1)
		DELETE DOCUMENT:C159($vt_filepathNew)
		ASSERT:C1129(ok=1;"failed to delete file \""+$vt_filepathNew+"\"")
	End if 
	
	MOVE DOCUMENT:C540($vt_filepath;$vt_filepathNew)
	$vb_ok:=(ok=1)
	
	If ($vb_ok)
		acme__log (4;Current method name:C684;"file \""+$vt_filepath+"\" archived to \""+$vt_filepathNew+"\". [OK]")
	Else 
		acme__log (2;Current method name:C684;"failed to move file \""+$vt_filepath+"\" to \""+$vt_filepathNew+"\". [KO]")
	End if 
	ASSERT:C1129($vb_ok;"failed to move file \""+$vt_filepath+"\" to \""+$vt_filepathNew+"\"")
	
End if 

$0:=$vb_ok