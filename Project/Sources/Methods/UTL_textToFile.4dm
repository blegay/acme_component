//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL_textToFile
  //@scope : private
  //@deprecated : no
  //@description : This function writes a text to a file (without any BOM)
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-filepath-TEXT] : filepath
  //@parameter[2-IN-text-TEXT] : text
  //@parameter[3-IN-encoding-TEXT] : encoding (optional, default value : "UTF-8")
  //@notes : this function will overwrite a file if it exists
  //@example : UTL_textToFile
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 08:42:42 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_filepath)
C_TEXT:C284($2;$vt_text)
C_TEXT:C284($3;$vt_encoding)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")

$vb_ok:=False:C215
$vt_filepath:=$1
$vt_text:=$2
If (Count parameters:C259>2)
	$vt_encoding:=$3
Else 
	$vt_encoding:="UTF-8"
End if 

C_BLOB:C604($vx_blob)
SET BLOB SIZE:C606($vx_blob;0)
CONVERT FROM TEXT:C1011($vt_text;$vt_encoding;$vx_blob)
ASSERT:C1129(ok=1;"convert text to blob failed with encoding \""+$vt_encoding+"\"")
If (ok=1)
	BLOB TO DOCUMENT:C526($vt_filepath;$vx_blob)
	ASSERT:C1129(ok=1;"writing to file \""+$vt_filepath+"\" failed")
	$vb_ok:=(ok=1)
	
	acme__log (Choose:C955($vb_ok;4;2);Current method name:C684;"dump :\r"+$vt_text+"\rinto file : \""+$vt_filepath+"\". "+Choose:C955($vb_ok;"[OK]";"[KO]"))
	
Else 
	acme__log (2;Current method name:C684;"failed to convert text to \""+$vt_encoding+"\" encoding, text :\r"+$vt_text+"\r[KO]")
End if 
SET BLOB SIZE:C606($vx_blob;0)

$0:=$vb_ok