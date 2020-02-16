//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_jwsObjectSign
  //@scope : private
  //@deprecated : no
  //@description : This method will sign a object with two properties "protected" and "payload" using a private key
  //@parameter[0-OUT-objectPtr-OBJECT] : jwt object
  //@parameter[1-IN-protected-OBJECT] : protected object
  //@parameter[2-IN-payload-OBJECT] : payload object (can be a null object)
  //@parameter[3-IN-privateKeyPath-TEXT] : private key path
  //@parameter[4-IN-openSslAlgorithm-TEXT] : openssl algorithm (optional, default "sha256")
  //@notes : 
  //@example : acme_jwsObjectSign
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 07:07:32 - 1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_jwt)
C_OBJECT:C1216($1;$vo_protected)
C_OBJECT:C1216($2;$vo_payload)
C_TEXT:C284($3;$vt_privateKeyPath)
C_TEXT:C284($4;$vt_openSslAlgorithm)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(OB Is defined:C1231($1);"$1 (\"protected\") object null")
  //ASSERT(OB Est défini($2);"$2 (\"payload\") property is not defined")
ASSERT:C1129(Test path name:C476($3)=Is a document:K24:1;"private key file \""+$3+"\" not found")

$vo_protected:=$1
$vo_payload:=$2
$vt_privateKeyPath:=$3
If (Count parameters:C259>3)
	$vt_openSslAlgorithm:=$4
Else 
	$vt_openSslAlgorithm:="sha256"
End if 


  //<Modif> Bruno LEGAY (BLE) (11/02/2020)
  // https://community.letsencrypt.org/t/acme-v2-scheduled-deprecation-of-unauthenticated-resource-gets/74380
  // https://tools.ietf.org/html/rfc8555#section-6.3
If (True:C214)
	
	C_TEXT:C284($vt_protected;$vt_payload)
	$vt_protected:=UTL_base64UrlSafeEncode (acme__objectToBlob ($vo_protected))
	
	C_TEXT:C284($vt_payloadJsonDebug)
	If (OB Is defined:C1231($vo_payload))
		$vt_payload:=UTL_base64UrlSafeEncode (acme__objectToBlob ($vo_payload))
		$vt_payloadJsonDebug:=JSON Stringify:C1217($vo_payload;*)
	Else 
		$vt_payload:=""
		$vt_payloadJsonDebug:=""
		acme__moduleDebugDateTimeLine (4;Current method name:C684;"empty payload. POST as GET jws?")
	End if 
	
Else 
	  // if $vo_payload is a null object, make it an empty object
	If (Not:C34(OB Is defined:C1231($vo_payload)))
		$vo_payload:=OB_newObject 
	End if 
	
	  // get jws protected header and payload in baseUrlEncoded format
	C_TEXT:C284($vt_protected;$vt_payload)
	$vt_protected:=UTL_base64UrlSafeEncode (acme__objectToBlob ($vo_protected))
	$vt_payload:=UTL_base64UrlSafeEncode (acme__objectToBlob ($vo_payload))
	
	
End if 
  //<Modif>



  // concatenate into a string (to be signed)
C_TEXT:C284($vt_stringToSign)
$vt_stringToSign:=$vt_protected+"."+$vt_payload

  // sign with private key
C_BLOB:C604($vx_signatureBinary)
SET BLOB SIZE:C606($vx_signatureBinary;0)
$vx_signatureBinary:=acme__openSslSignKeyPath (->$vt_stringToSign;$vt_privateKeyPath;$vt_openSslAlgorithm)

  // get signature in baseUrlEncoded format
C_TEXT:C284($vt_signature)
$vt_signature:=UTL_base64UrlSafeEncode ($vx_signatureBinary)
SET BLOB SIZE:C606($vx_signatureBinary;0)

If (False:C215)  // for debugging
	  // https://jwt.io/#encoded-jwt
	SET TEXT TO PASTEBOARD:C523($vt_stringToSign+"."+$vt_signature)
End if 


OB SET:C1220($vo_jwt;"protected";$vt_protected)
OB SET:C1220($vo_jwt;"payload";$vt_payload)
OB SET:C1220($vo_jwt;"signature";$vt_signature)

  //<Modif> Bruno LEGAY (BLE) (11/02/2020)
  // https://community.letsencrypt.org/t/acme-v2-scheduled-deprecation-of-unauthenticated-resource-gets/74380
  // https://tools.ietf.org/html/rfc8555#section-6.3
acme__moduleDebugDateTimeLine (4;Current method name:C684;"protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+\
", payload : \""+$vt_payloadJsonDebug+"\""+\
", with private key : \""+$vt_privateKeyPath+"\""+\
", signature : \""+$vt_signature+"\""+\
", jwt : \""+JSON Stringify:C1217($vo_jwt;*)+"\".")
  //acme__moduleDebugDateTimeLine (4;Nom méthode courante;"protected : \""+JSON Stringify($vo_protected;*)+"\""+", payload : \""+JSON Stringify($vo_payload;*)+"\""+", with private key : \""+$vt_privateKeyPath+"\""+", signature : \""+$vt_signature+"\".") \
 //<Modif>

$0:=$vo_jwt