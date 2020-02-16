//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL_base64UrlSafeEncode
  //@scope : private
  //@deprecated : no
  //@description : This function encodes a blob into a base64 url safe format
  //@parameter[0-OUT-base64UrlSafeEncoded-TEXT] : base64 url safe encoded
  //@parameter[1-IN-blob-BLOB] : blob
  //@notes : this function removes all characters 
  //
  // "abcdefghijklmnopqrstuvwxyz"
  // "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  // "0123456789"
  // "_-"
  //@example : UTL_base64UrlSafeEncode
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 19:18:35 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_base64Encoded)
C_BLOB:C604($1;$vx_blob)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_base64Encoded:=""
$vx_blob:=$1

BASE64 ENCODE:C895($vx_blob;$vt_base64Encoded)  // encode standard Base64

  // replace the "\r" and "/n" we may find...
$vt_base64Encoded:=Replace string:C233($vt_base64Encoded;"\r";"";*)
$vt_base64Encoded:=Replace string:C233($vt_base64Encoded;"\n";"";*)

$vt_base64Encoded:=Replace string:C233($vt_base64Encoded;"/";"_";*)  // convert "/" to "_"
$vt_base64Encoded:=Replace string:C233($vt_base64Encoded;"+";"-";*)  // convert "+" to "-"

$vt_base64Encoded:=TXT_rtrim ($vt_base64Encoded;"=")  // remove trailing "=" (base64 padding)

$0:=$vt_base64Encoded


