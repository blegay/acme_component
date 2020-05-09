//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_authorizationGet
  //@scope : public
  //@deprecated : no
  //@description : This function retrieves the authorization object
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-url-TEXT] : authorization url (e.g. "https://acme-staging-v02.api.letsencrypt.org/acme/authz/UOO_ci...sLI")
  //@parameter[2-IN-authorizationObjPtr-POINTER] : authorization object pointer (modified)
  //@notes : 
  //
  //  curl https://acme-staging-v02.api.letsencrypt.org/acme/authz/UOO_ci1...sLI
  // {
  //   "identifier": {
  //     "type": "dns",
  //     "value": "www.example.com"
  //   },
  //   "status": "pending",
  //   "expires": "2018-06-29T15:36:28Z",
  //   "challenges": [
  //     {
  //       "type": "dns-01",
  //       "status": "pending",
  //       "url": "https://acme-staging-v02.api.letsencrypt.org/acme/challenge/UOO_ci1...sLI/1234567",
  //       "token": "R2VX-K...m7Y"
  //     },
  //     {
  //       "type": "http-01",
  //       "status": "pending",
  //       "url": "https://acme-staging-v02.api.letsencrypt.org/acme/challenge/UOO_ci1...sLI/1234568",
  //       "token": "IFYoEg...SQ"
  //     },
  //     {
  //       "type": "tls-alpn-01",
  //       "status": "pending",
  //       "url": "https://acme-staging-v02.api.letsencrypt.org/acme/challenge/UOO_ci1...sLI/1234569",
  //       "token": "fx-t44...SA"
  //     }
  //   ]
  // 
  // 
  //
  //@example : amce_authorizationGet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 17:46:00 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_url)
C_POINTER:C301($2;$vp_authorizationObjPtr)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameter")
ASSERT:C1129(Length:C16($1)>0;"$1 url cannot be empty")
ASSERT:C1129(Type:C295($2->)=Is object:K8:27;"$2 should be an object pointer")

$vt_url:=$1
$vp_authorizationObjPtr:=$2

CLEAR VARIABLE:C89($vp_authorizationObjPtr->)

C_BLOB:C604($vx_responseBody)  //$vx_requestBody;
  //FIXER TAILLE BLOB($vx_requestBody;0)
SET BLOB SIZE:C606($vx_responseBody;0)

ARRAY TEXT:C222($tt_headerKey;0)
ARRAY TEXT:C222($tt_headerValue;0)

acme__httpRequestHeaderCommon (->$tt_headerKey;->$tt_headerValue;acme__jsonContentType )

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
		
		C_TEXT:C284($vt_contentType)
		$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
		If ($vt_contentType="application/json")
			$vb_ok:=True:C214
			
			C_OBJECT:C1216($vo_responseBody)
			$vo_responseBody:=OB_jsonBlobParse (->$vx_responseBody)
			
			OB SET:C1220($vo_httpResponse;"responseBody";$vo_responseBody)
			
			$vp_authorizationObjPtr->:=$vo_responseBody
			
			If (True:C214)
				  // dump the status, the request header and body and the response headers and body to a json file
				  // in the repsonse header, we have the "Location"
				  // "Location": "https://acme-staging-v02.api.letsencrypt.org/acme/acct/1234567",
				  //C_OBJET($vo_httpResponse)
				  //OB FIXER($vo_httpResponse;"method";HTTP méthode POST)
				  //OB FIXER($vo_httpResponse;"url";$vt_url)
				  //OB FIXER($vo_httpResponse;"status";$vl_status)
				  //OB FIXER($vo_httpResponse;"requestHeaders";$vo_requestHeaders)
				  //OB FIXER($vo_httpResponse;"responseHeaders";$vo_responseHeaders)
				  //OB FIXER($vo_httpResponse;"responseBody";$vo_responseBody)
				
				If (False:C215)
					SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_httpResponse;*))
				End if 
				
				  //TEXTE VERS DOCUMENT($vt_accountKeyDir+"httpRequest.json";JSON Stringify($vo_httpResponse;*))
				  //EFFACER VARIABLE($vo_httpResponse)
			End if 
			
			  //TEXTE VERS DOCUMENT($vt_accountKeyDir+"account.json";JSON Stringify($vo_responseBody;*))
			CLEAR VARIABLE:C89($vo_responseBody)
			
			  // {
			  //   "id": 1234567,
			  //   "key": {
			  //     "kty": "RSA",
			  //     "n": "u-M...a8w",
			  //     "e": "AQAB"
			  //   },
			  //   "contact": [
			  //     "mailto:me@example.com"
			  //   ],
			  //   "initialIp": "78.247.97.8",
			  //   "createdAt": "2018-06-21T11:42:45.431961959Z",
			  //   "status": "valid"
			  // }
			
			acme__log (4;Current method name:C684;$vt_httpMethod+" url : \""+$vt_url+"\""+\
				", status : "+String:C10($vl_status)+\
				", duration : "+UTL_durationMsDebug ($vl_ms)+\
				", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
				", response body : \""+Convert to text:C1012($vx_responseBody;"UTF-8")+"\". [OK]")
		Else 
			acme__log (2;Current method name:C684;$vt_httpMethod+" url : \""+$vt_url+"\""+\
				", status : "+String:C10($vl_status)+\
				", duration : "+UTL_durationMsDebug ($vl_ms)+\
				", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
				", unexpected \"Content-Type\": \""+$vt_contentType+"\". [KO]")
		End if 
		
		
	Else 
		  //: (($vl_status>=400) & ($vl_status<500))
		  // application/problem+json
		
		C_TEXT:C284($vt_contentType;$vt_json)
		$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
		If ($vt_contentType="application/@json")  // "application/problem+json"
			$vt_json:=Convert to text:C1012($vx_responseBody;"UTF-8")
			OB SET:C1220($vo_httpResponse;"responseBody";$vt_json)
		End if 
		
		acme__log (2;Current method name:C684;$vt_httpMethod+" url : \""+$vt_url+"\""+\
			", status : "+String:C10($vl_status)+\
			", duration : "+UTL_durationMsDebug ($vl_ms)+\
			", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
			", response body : \""+$vt_json+"\". [KO]")
		
End case 

CLEAR VARIABLE:C89($vo_httpResponse)

ARRAY TEXT:C222($tt_headerKey;0)
ARRAY TEXT:C222($tt_headerValue;0)

  //FIXER TAILLE BLOB($vx_requestBody;0)
SET BLOB SIZE:C606($vx_responseBody;0)

$0:=$vb_ok
