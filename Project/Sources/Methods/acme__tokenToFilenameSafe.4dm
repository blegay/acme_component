//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__tokenToFilenameSafe
  //@scope : public
  //@deprecated : no
  //@description : This function returns a file name for a token
  //@parameter[0-OUT-filename-TEXT] : filename
  //@parameter[1-IN-token-TEXT] : token
  //@notes : 
  // in Linux, the filenames are case sensitive
  // on OS X and windows, files "abc.txt" = "ABC.txt"
  // so there is a slight risk that "IFYoEgcXKmHJOKpEG1S3kwfZPOksIKQbs4ZHU0yEeSQ" overides/collides with "iFYoEgcXKmHJOKpEG1S3kwfZPOksIKQbs4ZHU0yEeSQ"
  // we could UTL_base64UrlSafeDecode the token and calculate a md5 on this to reduce collision risks
  //@example : 
  //  acme__tokenToFilenameSafe ("IFYoEgcXKmHJOKpEG1S3kwfZPOksIKQbs4ZHU0yEeSQ") => "IFYoEgcXKmHJOKpEG1S3kwfZPOksIKQbs4ZHU0yEeSQ-11bd9a9e7b8b400feac82575eca67ce2.txt"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 21:12:10 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_filename)
C_TEXT:C284($1;$vt_token)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"$1 is empty")

$vt_filename:=""
$vt_token:=$1

If (True:C214)
	C_BLOB:C604($vx_tokenBinary)
	SET BLOB SIZE:C606($vx_tokenBinary;0)
	$vx_tokenBinary:=UTL_base64UrlSafeDecode ($vt_token)
	
	C_TEXT:C284($vt_tokenMd5)
	$vt_tokenMd5:=Generate digest:C1147($vx_tokenBinary;MD5 digest:K66:1)
	SET BLOB SIZE:C606($vx_tokenBinary;0)
	
	$vt_filename:=$vt_token+"-"+$vt_tokenMd5+".txt"
	
	acme__log (4;Current method name:C684;"token : \""+$vt_token+"\", token md5 : \""+$vt_tokenMd5+"\", file name : \""+$vt_filename+"\"")
Else 
	$vt_filename:=$vt_token+".txt"
End if 

$0:=$vt_filename