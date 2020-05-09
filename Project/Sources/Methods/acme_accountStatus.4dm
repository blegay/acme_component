//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_accountStatus
  //@scope : public
  //@deprecated : no
  //@description : This method creates a new account
  //@parameter[1-IN-directoryUrl-TEXT] : directory url (e.g. "https://acme-v02.api.letsencrypt.org/directory")
  //@parameter[2-IN-url-OBJECT] : account url (location) (e.g. "https://acme-staging-v02.api.letsencrypt.org/acme/acct/12345678")
  //@parameter[3-OUT-accountObjPrt-POINTER] : account object pointer
  //@parameter[4-IN-certDir-TEXT] : certbase dir path
  //@notes : 
  //@example : acme_accountStatus
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 16:57:55 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_directoryUrl)  // directory url (e.g. "https://acme-v02.api.letsencrypt.org/directory")
C_TEXT:C284($2;$vt_url)
C_POINTER:C301($3;$vp_accountObjPtr)
C_TEXT:C284($4;$vt_workingDir)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameter")
ASSERT:C1129(Length:C16($1)>0;"$1 directory url cannot be empty")
ASSERT:C1129(Length:C16($2)>0;"$2 url cannot be empty")
ASSERT:C1129(Type:C295($3->)=Is object:K8:27;"$3 should be an object pointer")
$vb_ok:=False:C215

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>2)
	$vt_directoryUrl:=$1
	$vt_url:=$2
	$vp_accountObjPtr:=$3
	
	Case of 
		: ($vl_nbParam=3)
			$vt_workingDir:=""
			
		Else 
			  //: ($vl_nbParam=4)
			$vt_workingDir:=$4
	End case 
	
	CLEAR VARIABLE:C89($vp_accountObjPtr->)
	
	  // make an empty payload to get the account infos
	C_OBJECT:C1216($vo_payload)
	$vo_payload:=OB_newObject 
	
	  // init debugger and stuff
	acme__init 
	
	  // get the account key dir path
	C_TEXT:C284($vt_accountKeyDir)
	$vt_accountKeyDir:=acme__accountInit   //($vt_workingDir;$vt_directoryUrl)
	
	C_TEXT:C284($vt_algorithm;$vt_openSslAlgorithm)
	$vt_algorithm:="RS256"  // HMAC SHA 256
	$vt_openSslAlgorithm:="sha256"
	
	  // initialize the "protected" header property for the JWT signature
	C_OBJECT:C1216($vo_protected)
	$vo_protected:=acme__protectedObjGet ($vt_url;$vt_accountKeyDir;$vt_algorithm)
	
	  // initialize JWT signature (request body)
	If (True:C214)
		C_OBJECT:C1216($vo_requestBody)
		
		  // get private key path
		C_TEXT:C284($vt_privateKeyPath)
		$vt_privateKeyPath:=acme__keysKeyPairFilepathGet ("private";$vt_accountKeyDir)
		
		  //C_OBJET($vo_signaturePrep;$vo_requestBody)
		  //OB FIXER($vo_signaturePrep;"protected";$vo_protected)
		  //OB FIXER($vo_signaturePrep;"payload";$vo_payload)
		
		C_OBJECT:C1216($vo_requestBody)
		$vo_requestBody:=acme__jwsObjectSign ($vo_protected;$vo_payload;$vt_privateKeyPath;$vt_openSslAlgorithm)
	End if 
	
	C_BLOB:C604($vx_requestBody;$vx_responseBody)
	SET BLOB SIZE:C606($vx_requestBody;0)
	SET BLOB SIZE:C606($vx_responseBody;0)
	
	ARRAY TEXT:C222($tt_headerKey;0)
	ARRAY TEXT:C222($tt_headerValue;0)
	
	acme__httpRequestHeaderCommon (->$tt_headerKey;->$tt_headerValue;acme__jsonContentType )
	
	  // get the json object into the request body blob
	$vx_requestBody:=acme__objectToBlob ($vo_requestBody)
	
	  // save the request headers into an object
	C_OBJECT:C1216($vo_requestHeaders)
	$vo_requestHeaders:=acme__httpHeadersToObject (->$tt_headerKey;->$tt_headerValue)
	
	acme__httpClientOptionsSet 
	
	C_TEXT:C284($vt_errorHandler)
	$vt_errorHandler:=acme__errorHdlrBefore 
	
	  // timer
	C_LONGINT:C283($vl_ms)
	$vl_ms:=Milliseconds:C459
	
	C_LONGINT:C283($vl_status)
	$vl_status:=HTTP Request:C1158(HTTP POST method:K71:2;$vt_url;$vx_requestBody;$vx_responseBody;$tt_headerKey;$tt_headerValue)
	
	  // timer
	$vl_ms:=UTL_durationDifference ($vl_ms;Milliseconds:C459)
	
	If ($vl_status=0)  // server did not respond
		
		  // for instance, using an invalid port (server not listening on that port) on a server, acme__errorLastGet will return 30
		C_LONGINT:C283($vl_networkError)
		$vl_networkError:=acme__errorLastGet 
		acme__log (2;Current method name:C684;"method : "+HTTP POST method:K71:2+", url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", networkError : "+String:C10($vl_networkError))
		
	End if 
	acme__errorHdlrAfter ($vt_errorHandler)
	
	  //<Modif> Bruno LEGAY (BLE) (14/02/2019)
	acme__nonceRefresh ($vl_status;->$tt_headerKey;->$tt_headerValue)
	  //<Modif>
	
	  // save the request headers into an object
	C_OBJECT:C1216($vo_responseHeaders)
	$vo_responseHeaders:=acme__httpHeadersToObject (->$tt_headerKey;->$tt_headerValue)
	
	Case of 
		: ($vl_status=200)  // account already created, account update ?
			
			C_TEXT:C284($vt_contentType)
			$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
			If ($vt_contentType="application/json")
				$vb_ok:=True:C214
				
				C_OBJECT:C1216($vo_responseBody)
				$vo_responseBody:=OB_jsonBlobParse (->$vx_responseBody)
				
				$vp_accountObjPtr->:=$vo_responseBody
				
				If (True:C214)
					  // dump the status, the request header and body and the response headers and body to a json file
					  // in the repsonse header, we have the "Location"
					  // "Location": "https://acme-staging-v02.api.letsencrypt.org/acme/acct/1234567",
					C_OBJECT:C1216($vo_httpResponse)
					OB SET:C1220($vo_httpResponse;"method";HTTP POST method:K71:2)
					OB SET:C1220($vo_httpResponse;"url";$vt_url)
					OB SET:C1220($vo_httpResponse;"status";$vl_status)
					OB SET:C1220($vo_httpResponse;"requestHeaders";$vo_requestHeaders)
					OB SET:C1220($vo_httpResponse;"requestBody";$vo_requestBody)
					OB SET:C1220($vo_httpResponse;"responseHeaders";$vo_responseHeaders)
					OB SET:C1220($vo_httpResponse;"responseBody";$vo_responseBody)
					
					If (False:C215)
						SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_httpResponse;*))
					End if 
					
					  //TEXTE VERS DOCUMENT($vt_accountKeyDir+"httpRequest.json";JSON Stringify($vo_httpResponse;*))
					CLEAR VARIABLE:C89($vo_httpResponse)
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
				  //     "mailto:blegay@mac.com"
				  //   ],
				  //   "initialIp": "78.247.97.8",
				  //   "createdAt": "2018-06-21T11:42:45.431961959Z",
				  //   "status": "valid"
				  // }
				
				acme__log (4;Current method name:C684;"url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\","+", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\","+", response body : \""+Convert to text:C1012($vx_responseBody;"UTF-8")+"\". [OK]")
			Else 
				acme__log (2;Current method name:C684;"url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+", unexpected \"Content-Type\": \""+$vt_contentType+"\". [KO]")
			End if 
			
			
		Else 
			  //: (($vl_status>=400) & ($vl_status<500))
			  // application/problem+json
			
			C_TEXT:C284($vt_contentType;$vt_json)
			$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
			If ($vt_contentType="application/@json")  // "application/problem+json"
				$vt_json:=Convert to text:C1012($vx_responseBody;"UTF-8")
			End if 
			
			acme__log (2;Current method name:C684;"url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+", response body : \""+$vt_json+"\". [KO]")
			
	End case 
	
	ARRAY TEXT:C222($tt_headerKey;0)
	ARRAY TEXT:C222($tt_headerValue;0)
	
	SET BLOB SIZE:C606($vx_requestBody;0)
	SET BLOB SIZE:C606($vx_responseBody;0)
End if 

$0:=$vb_ok
