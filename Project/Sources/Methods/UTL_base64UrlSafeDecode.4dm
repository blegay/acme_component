//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL_base64UrlSafeDecode
  //@scope : private
  //@deprecated : no
  //@description : This function decodes a base64 url safe format into a blob
  //@parameter[0-OUT-blob-BLOB] : blob
  //@parameter[1-IN-base64UrlSafeEncoded-TEXT] : base64 url safe encoded
  //@notes : 
  //@example : UTL_base64UrlSafeDecode
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 19:32:17 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_blob)
C_TEXT:C284($1;$vt_base64Encoded)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

SET BLOB SIZE:C606($vx_blob;0)
$vt_base64Encoded:=$1

  // replace the "\r" and "/n" we may find...
$vt_base64Encoded:=Replace string:C233($vt_base64Encoded;"\r";"";*)
$vt_base64Encoded:=Replace string:C233($vt_base64Encoded;"\n";"";*)

$vt_base64Encoded:=Replace string:C233($vt_base64Encoded;"_";"/";*)  // convert "_" to "/"
$vt_base64Encoded:=Replace string:C233($vt_base64Encoded;"-";"+";*)  // convert "-" to "+"

  // if the base64 encoded does not contain the padding characters ("="), lets add them
  // base64 encoded data should have a length multiple of 4
C_LONGINT:C283($vl_padModulo)
$vl_padModulo:=Mod:C98(Length:C16($vt_base64Encoded);4)
If ($vl_padModulo>0)
	$vt_base64Encoded:=$vt_base64Encoded+((4-$vl_padModulo)*"=")
End if 

BASE64 DECODE:C896($vt_base64Encoded;$vx_blob)  // decode to plain text

$0:=$vx_blob
SET BLOB SIZE:C606($vx_blob;0)
