//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__openSslSignKeyPath
  //@scope : private
  //@deprecated : no
  //@description : This function returns a signature for a payload with a private key
  //@parameter[0-OUT-isgnature-BOOLEAN] : signature (binary format)
  //@parameter[1-IN-payload-TEXT] : payload to sign
  //@parameter[2-IN-keyPath-TEXT] : private key path
  //@parameter[3-IN-algo-TEXT] : algorithm ("SHA256")
  //@notes :
  //@example : acme__openSslSignKeyPath
  //@see :
  //@version : 1.00.00
  //@author :
  //@history :
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 21:56:40 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_signature)
C_POINTER:C301($1;$vp_payloadPtr)
C_TEXT:C284($2;$vt_keyPath)
C_TEXT:C284($3;$vt_algo)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(Test path name:C476($2)=Is a document:K24:1;"private key file \""+$2+"\" not found.")

SET BLOB SIZE:C606($vx_signature;0)
$vp_payloadPtr:=$1
$vt_keyPath:=$2
$vt_algo:=$3

C_TEXT:C284($vt_keyPathPosix)
$vt_keyPathPosix:=UTL_pathToPosixConvert ($vt_keyPath)

C_TEXT:C284($vt_args)
$vt_args:=" dgst"+\
" -"+$vt_algo+\
" -binary"+\
" -sign "+$vt_keyPathPosix

acme__opensslConfigDefault 

C_TEXT:C284($vt_err)
If (acme_opensslCmd ($vt_args;$vp_payloadPtr;->$vx_signature;->$vt_err))
	
Else 
	ASSERT:C1129(False:C215;"signature failure openssl args : "+$vt_args+"\r error : "+$vt_err)
End if 

$0:=$vx_signature
SET BLOB SIZE:C606($vx_signature;0)