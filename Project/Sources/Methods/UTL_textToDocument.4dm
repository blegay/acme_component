//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL_textToDocument
  //@scope : public
  //@deprecated : no
  //@description : This function writes a text to a UTF-8 file without a bom 
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-filepath-TEXT] : filepath
  //@parameter[2-IN-text-TEXT] : text
  //@notes : 
  //@example : UTL_textToDocument
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/04/2019, 15:13:42 - 0.90.05
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_filepath)
C_TEXT:C284($2;$vt_text)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")

$vb_ok:=False:C215
$vt_filepath:=$1
$vt_text:=$2

If (Test path name:C476($vt_filepath)=Is a document:K24:1)
	DELETE DOCUMENT:C159($vt_filepath)
	ASSERT:C1129(ok=1;"error deleting file \""+$vt_filepath+"\"")
End if 

C_BLOB:C604($vx_blob)
SET BLOB SIZE:C606($vx_blob;0)

TEXT TO BLOB:C554($vt_text;$vx_blob;UTF8 text without length:K22:17)

BLOB TO DOCUMENT:C526($vt_filepath;$vx_blob)
$vb_ok:=(ok=1)

ASSERT:C1129($vb_ok;"failed to write to file \""+$vt_filepath+"\"")

SET BLOB SIZE:C606($vx_blob;0)

$0:=$vb_ok
