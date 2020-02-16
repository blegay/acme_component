//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__openSslSha256
  //@scope : private
  //@deprecated : no
  //@description : This function performs a sha256 digest
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-dataPtr-POINTER] : blob data pointer (modified)
  //@parameter[2-IN-digestBinary-POINTER] : digest blob pointer (modified)
  //@notes : 
  //@example : acme__openSslSha256
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:59:33 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_POINTER:C301($1;$vp_dataPtr)
C_POINTER:C301($2;$vp_digestBinaryPtr)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12;"$1 should be a blob pointer")
ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12;"$2 should be a blob pointer")

$vb_ok:=False:C215
$vp_dataPtr:=$1
$vp_digestBinaryPtr:=$2

C_TEXT:C284($vt_args)
$vt_args:="dgst"+\
" -binary"+\
" -sha256"

acme__opensslConfigDefault 

C_TEXT:C284($vt_err)
If (acme__openSslCmd ($vt_args;$vp_dataPtr;$vp_digestBinaryPtr;->$vt_err))
	$vb_ok:=True:C214
Else 
	ASSERT:C1129(False:C215;"sha256 digest failure, openssl args : "+$vt_args)
End if 

$0:=$vb_ok
