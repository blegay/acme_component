//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_sha256Sign
  //@scope : private 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-signatureBase64-TEXT] : signature base64 encoded
  //@parameter[1-IN-blobPtr-POINTER] : blob pointer (not modified)
  //@parameter[2-IN-privateKeyPem-TEXT] : private key pem format data
  //@notes : 
  //@example : 
  //
  //  C_BLOB($vx_blobToSign)
  //  TEXT TO BLOB("hello world";$vx_blobToSign;UTF8 text without length)
  //
  //  C_TEXT($vt_pem)
  //  $vt_pem:=acme_pkcs12FileToPem ($vt_p12Path;$vt_p12Password)
  //
  //  C_OBJECT($vo_certificates)
  //  $vo_certificates:=acme_pemFormatChainToObject ($vt_pem)
  //
  //  C_TEXT($vt_signatureBase64)
  //  $vt_signatureBase64:=acme_sha256Sign (->$vx_blobToSign;$vo_certificates.pkey)
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2020
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 14/12/2020, 10:18:03 - 1.00.03
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_signatureBase64)
C_POINTER:C301($1;$vx_blobPtr)
C_TEXT:C284($2;$vt_privateKeyPem)

$vt_signatureBase64:=""
$vx_blobPtr:=$1
$vt_privateKeyPem:=$2

C_TEXT:C284($vt_privateKeyPemPath)
$vt_privateKeyPemPath:=Temporary folder:C486+Generate UUID:C1066+"_privateKey.tmp"

TEXT TO DOCUMENT:C1237($vt_privateKeyPemPath;$vt_privateKeyPem;"us-ascii";Document unchanged:K24:18)
  // will write a BOM, not good for signature :-(
  //TEXT TO DOCUMENT($vt_privateKeyPemPath;$vt_privateKeyPem;"UTF-8";Document unchanged)

C_TEXT:C284($vt_args)
If (True:C214)
	$vt_args:="dgst"
	$vt_args:=$vt_args+" -sha256"
	$vt_args:=$vt_args+" -keyform PEM"
	$vt_args:=$vt_args+" -sign "+UTL_pathToPosixConvert ($vt_privateKeyPemPath)
	
Else 
	$vt_args:="sha256"
	$vt_args:=$vt_args+" -sign "+UTL_pathToPosixConvert ($vt_privateKeyPemPath)
End if 

C_TEXT:C284($vt_err)
$vt_err:=""

C_BLOB:C604($vx_signatureBinary)
SET BLOB SIZE:C606($vx_signatureBinary;0)

If (acme__openSslCmd ($vt_args;$vx_blobPtr;->$vx_signatureBinary;->$vt_err))
	BASE64 ENCODE:C895($vx_signatureBinary;$vt_signatureBase64)
End if 

SET BLOB SIZE:C606($vx_signatureBinary;0)

DELETE DOCUMENT:C159($vt_privateKeyPemPath)

$0:=$vt_signatureBase64
