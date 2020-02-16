//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : OB_jsonBlobParse
  //@scope : private
  //@deprecated : no
  //@description : This function converts a json blob ("UTF-8" encoded) into an Object
  //@parameter[0-OUT-object-OBJECT] : object
  //@parameter[1-IN-jsonBlobPtr-POINTER] : json blob pointer (not modified)
  //@notes : 
  //@example : 
  //
  //  C_BLOB(>$vx_responseBody)
  //  ...
  //  C_OBJET($vo_responseBody)
  //  $vo_responseBody:=OB_jsonBlobParse (->$vx_responseBody)
  //
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 10:04:32 - 1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_object)
C_POINTER:C301($1;$vp_blobPtr)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12;"$1 should be a blob pointer")

$vp_blobPtr:=$1

C_TEXT:C284($vt_json)
$vt_json:=Convert to text:C1012($vp_blobPtr->;"UTF-8")

C_BOOLEAN:C305($vb_ok)
$vb_ok:=(ok=1)
ASSERT:C1129($vb_ok;"error converting blob to UTF-8 text")
If ($vb_ok)
	acme__moduleDebugDateTimeLine (6;Current method name:C684;"json :\r"+$vt_json)
Else 
	C_TEXT:C284($vt_blobBase64)
	BASE64 ENCODE:C895($vp_blobPtr->;$vt_blobBase64)  // encode standard Base64
	
	  // replace the "\r" and "/n" we may find...
	$vt_blobBase64:=Replace string:C233($vt_blobBase64;"\r";"";*)
	$vt_blobBase64:=Replace string:C233($vt_blobBase64;"\n";"";*)
	acme__moduleDebugDateTimeLine (4;Current method name:C684;"error converting blob to UTF-8 text. Blob (bas64 encoded) : "+$vt_blobBase64)
End if 

$vo_object:=JSON Parse:C1218($vt_json)

$0:=$vo_object