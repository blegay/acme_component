//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certificateGet
  //@scope : public
  //@deprecated : no
  //@description : This function retrives a certificate from a certificate url
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-url-TEXT] : certificate url
  //@parameter[2-OUT-certificatePtr-POINTER] : PEM formatted certificate blob or text pointer (modified)
  //@notes : 
  //@example : acme_certificateGet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 24/06/2018, 08:55:53 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_url)
C_POINTER:C301($2;$vp_certificatePtr)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(Length:C16($1)>0;"$1 (url) cannot be empty")
ASSERT:C1129((Type:C295($2->)=Is text:K8:3) | (Type:C295($2->)=Is BLOB:K8:12);"$2 should be a text or blob pointer")

$vb_ok:=False:C215
$vt_url:=$1
$vp_certificatePtr:=$2

ARRAY TEXT:C222($tt_headerKey;0)
ARRAY TEXT:C222($tt_headerValue;0)

  //<Modif> Bruno LEGAY (BLE) (11/02/2020)
acme__httpRequestHeaderCommon (->$tt_headerKey;->$tt_headerValue;acme__jsonContentType )
  //acme__httpRequestHeaderCommon (->$tt_headerKey;->$tt_headerValue)
  //<Modif>

  // save the request headers into an object
C_OBJECT:C1216($vo_requestHeaders)
$vo_requestHeaders:=acme__httpHeadersToObject (->$tt_headerKey;->$tt_headerValue)

acme__httpClientOptionsSet 


  //<Modif> Bruno LEGAY (BLE) (11/02/2020)
  // do a POST as GET to send a jws
  // https://community.letsencrypt.org/t/acme-v2-scheduled-deprecation-of-unauthenticated-resource-gets/74380
  // https://tools.ietf.org/html/rfc8555#section-6.3
C_TEXT:C284($vt_accountKeyDir)
$vt_accountKeyDir:=acme__accountInit   // ($vt_workingDir;$vt_directoryUrl)

C_TEXT:C284($vt_algorithm;$vt_openSslAlgorithm)
$vt_algorithm:="RS256"  // HMAC SHA 256
$vt_openSslAlgorithm:="sha256"

  // initialize the "protected" header property for the JWT signature
C_OBJECT:C1216($vo_protected)
$vo_protected:=acme__protectedObjGet ($vt_url;$vt_accountKeyDir;$vt_algorithm)


  // get private key path
C_TEXT:C284($vt_privateKeyPath)
$vt_privateKeyPath:=acme__keysKeyPairFilepathGet ("private";$vt_accountKeyDir)

  //C_OBJET($vo_signaturePrep;$vo_requestBody)
  //OB FIXER($vo_signaturePrep;"protected";$vo_protected)
  //OB FIXER($vo_signaturePrep;"payload";$vo_payload)

C_OBJECT:C1216($vo_payload)  // pass a null "payload" object to do get a POST as GET jws 

C_OBJECT:C1216($vo_requestBody)
$vo_requestBody:=acme__jwsObjectSign ($vo_protected;$vo_payload;$vt_privateKeyPath;$vt_openSslAlgorithm)

  // get the json object into the request body blob
C_BLOB:C604($vx_requestBody)
SET BLOB SIZE:C606($vx_requestBody;0)
$vx_requestBody:=acme__objectToBlob ($vo_requestBody)
  //<Modif>


C_TEXT:C284($vt_errorHandler)
$vt_errorHandler:=acme__errorHdlrBefore 

  // timer
C_LONGINT:C283($vl_ms)
$vl_ms:=Milliseconds:C459

C_LONGINT:C283($vl_status)
C_BLOB:C604($vx_responseBody)

SET BLOB SIZE:C606($vx_responseBody;0)

  //<Modif> Bruno LEGAY (BLE) (11/02/2020)
  // https://community.letsencrypt.org/t/acme-v2-scheduled-deprecation-of-unauthenticated-resource-gets/74380
  // https://tools.ietf.org/html/rfc8555#section-6.3
C_TEXT:C284($vt_httpMethod)
If (True:C214)
	$vt_httpMethod:=HTTP POST method:K71:2
	$vl_status:=HTTP Request:C1158($vt_httpMethod;$vt_url;$vx_requestBody;$vx_responseBody;$tt_headerKey;$tt_headerValue)
Else 
	$vt_httpMethod:=HTTP GET method:K71:1
	$vl_status:=HTTP Get:C1157($vt_url;$vx_responseBody;$tt_headerKey;$tt_headerValue)
End if 
SET BLOB SIZE:C606($vx_requestBody;0)
  //<Modif>

  // NOTE : the certificates are returned with "LF" as separator
  // I did nottice some 4D version (4D v15.6 on Mac OS) did not like PEM files with LF (or with CR) ¯\_(ツ)_/¯

  // timer
$vl_ms:=UTL_durationDifference ($vl_ms;Milliseconds:C459)

If ($vl_status=0)  // server did not respond
	
	  // for instance, using an invalid port (server not listening on that port) on a server, acme__errorLastGet will return 30
	C_LONGINT:C283($vl_networkError)
	$vl_networkError:=acme__errorLastGet 
	acme__log (2;Current method name:C684;"method : "+HTTP GET method:K71:1+", url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", networkError : "+String:C10($vl_networkError))
	
End if 
acme__errorHdlrAfter ($vt_errorHandler)

  //<Modif> Bruno LEGAY (BLE) (14/02/2019)
  // no "Replay-Nonce" in reponse header for this url
  // acme__nonceRefresh ($vl_status;->$tt_headerKey;->$tt_headerValue)
  //<Modif>

  // save the request headers into an object
C_OBJECT:C1216($vo_responseHeaders)
$vo_responseHeaders:=acme__httpHeadersToObject (->$tt_headerKey;->$tt_headerValue)

C_OBJECT:C1216($vo_httpResponse)
OB SET:C1220($vo_httpResponse;"method";$vt_httpMethod)  //HTTP méthode GET)
OB SET:C1220($vo_httpResponse;"url";$vt_url)
OB SET:C1220($vo_httpResponse;"status";$vl_status)
OB SET:C1220($vo_httpResponse;"requestHeaders";$vo_requestHeaders)
  //OB FIXER($vo_httpResponse;"requestBody";$vo_requestBody)
OB SET:C1220($vo_httpResponse;"responseHeaders";$vo_responseHeaders)
  //OB FIXER($vo_httpResponse;"responseBody";$vo_responseBody)

CLEAR VARIABLE:C89($vo_requestHeaders)
CLEAR VARIABLE:C89($vo_responseHeaders)

Case of 
	: ($vl_status=200)
		  // HTTP/1.1 200 OK
		  // Server: nginx
		  // Content-Type: application/pem-certificate-chain
		  // Content-Length: 3863
		  // Replay-Nonce: xz2cb0XGLUADX-7smj-2tVRDFnLX4XH_MQMThrRe_Ho
		  // X-Frame-Options: DENY
		  // Strict-Transport-Security: max-age=604800
		  // Expires: Sat, 23 Jun 2018 07:04:31 GMT
		  // Cache-Control: max-age=0, no-cache, no-store
		  // Pragma: no-cache
		  // Date: Sat, 23 Jun 2018 07:04:31 GMT
		  // Connection: keep-alive
		
		C_TEXT:C284($vt_contentType)
		$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
		If ($vt_contentType="application/pem-certificate-chain")
			$vb_ok:=True:C214
			
			C_TEXT:C284($vt_certficate)
			$vt_certficate:=Convert to text:C1012($vx_responseBody;"utf-8")
			
			OB SET:C1220($vo_httpResponse;"responseBody";$vt_certficate)
			
			Case of 
				: (Type:C295($vp_certificatePtr->)=Is text:K8:3)
					$vp_certificatePtr->:=$vt_certficate
					
				: (Type:C295($vp_certificatePtr->)=Is BLOB:K8:12)
					$vp_certificatePtr->:=$vx_responseBody
			End case 
			
			acme__log (4;Current method name:C684;$vt_httpMethod+" url : \""+$vt_url+"\""+\
				", status : "+String:C10($vl_status)+\
				", duration : "+UTL_durationMsDebug ($vl_ms)+\
				", content type : \""+$vt_contentType+"\""+\
				", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
				", certificate :\r"+$vt_certficate+". [OK]")
		Else 
			acme__log (4;Current method name:C684;$vt_httpMethod+" url : \""+$vt_url+"\""+\
				", status : "+String:C10($vl_status)+\
				", duration : "+UTL_durationMsDebug ($vl_ms)+\
				", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
				", unexpected content type : "+$vt_contentType+". [KO]")
		End if 
		
	Else 
		acme__log (4;Current method name:C684;$vt_httpMethod+" url : \""+$vt_url+"\""+\
			", status : "+String:C10($vl_status)+\
			", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
			", duration : "+UTL_durationMsDebug ($vl_ms)+". [OK]")
End case 

CLEAR VARIABLE:C89($vo_httpResponse)

SET BLOB SIZE:C606($vx_responseBody;0)

ARRAY TEXT:C222($tt_headerKey;0)
ARRAY TEXT:C222($tt_headerValue;0)

$0:=$vb_ok