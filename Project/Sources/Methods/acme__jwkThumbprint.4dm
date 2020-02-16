//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__jwkThumbprint
  //@scope : private
  //@deprecated : no
  //@description : This function returns a jwk thumbprint in binary format
  //@parameter[0-OUT-jwkThumbprint-BLOB] : jwkThumbprint binary
  //@parameter[1-IN-privateKeyPath-TEXT] : private key path
  //@notes : 
  //@example : acme__jwkThumbprint
  //@see : https://tools.ietf.org/html/rfc7638
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:50:21 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_jwkThumbprint)
C_TEXT:C284($1;$vt_privateKeyPath)

SET BLOB SIZE:C606($vx_jwkThumbprint;0)
$vt_privateKeyPath:=$1

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Test path name:C476($1)=Is a document:K24:1;"private key path \""+$1+"\" not found")

  // NOTE : do not change the order of the properties !!!
C_OBJECT:C1216($vo_jwk)
OB SET:C1220($vo_jwk;"e";UTL_base64UrlSafeEncode (acme__keyPrivExponentGet ($vt_privateKeyPath)))
OB SET:C1220($vo_jwk;"kty";"RSA")
OB SET:C1220($vo_jwk;"n";UTL_base64UrlSafeEncode (acme__keyPrivModulusGet ($vt_privateKeyPath)))

C_TEXT:C284($vt_json)
$vt_json:=JSON Stringify:C1217($vo_jwk)

C_BLOB:C604($vx_data)
SET BLOB SIZE:C606($vx_data;0)
CONVERT FROM TEXT:C1011($vt_json;"UTF-8";$vx_data)
acme__openSslSha256 (->$vx_data;->$vx_jwkThumbprint)
SET BLOB SIZE:C606($vx_data;0)

$0:=$vx_jwkThumbprint
SET BLOB SIZE:C606($vx_jwkThumbprint;0)