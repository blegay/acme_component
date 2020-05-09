//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_newAccount
  //@scope : public
  //@deprecated : no
  //@description : This method creates a new account
  //@parameter[1-IN-payload-OBJECT] : payload
  //@notes : 
  //@example : acme_newAccount
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 08:45:46 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_OBJECT:C1216($1;$vo_payload)
  //C_TEXTE($1;$vt_directoryUrl)  // directory url (e.g. "https://acme-v02.api.letsencrypt.org/directory")
  //C_TEXTE($3;$vt_workingDir)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(OB Is defined:C1231($1);"$1 is null object")
  //ASSERT(Longueur($1)>0;"$1 directory url cannot be empty")

$vb_ok:=False:C215

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	$vo_payload:=$1
	If (OB Is defined:C1231($vo_payload))
		
		acme__init 
		
		C_TEXT:C284($vt_workingDir;$vt_directoryUrl)
		$vt_workingDir:=acme_workingDirGet 
		$vt_directoryUrl:=acme_directoryUrlGet 
		
		  //$vt_directoryUrl:=$1
		
		  //Au cas ou 
		  //: ($vl_nbParam=1)
		  //$vt_workingDir:=""
		
		  //: ($vl_nbParam=2)
		  //$vo_payload:=$2
		  //$vt_workingDir:=""
		
		  //Sinon 
		  //  //: ($vl_nbParam=3)
		
		  //$vo_payload:=$2
		  //$vt_workingDir:=$3
		  //Fin de cas 
		
		  //Si (Non(OB Est défini($vo_payload)))
		  //  // if $vo_payload is a null object, make it an empty object
		  //$vo_payload:=OB_newObject
		  //Fin de si 
		
		  //  // init debugger and stuff
		  //acme__init 
		
		  // get the account key dir path
		C_TEXT:C284($vt_accountKeyDir)
		$vt_accountKeyDir:=acme__accountInit   //($vt_workingDir;$vt_directoryUrl)
		
		  // get the url for the "newAccount" service
		C_TEXT:C284($vt_newAccountUrl)
		$vt_newAccountUrl:=acme__directoryUrlGet ($vt_directoryUrl;"newAccount")
		  // "https://acme-staging-v02.api.letsencrypt.org/acme/new-acct"
		
		C_TEXT:C284($vt_algorithm;$vt_openSslAlgorithm)
		$vt_algorithm:="RS256"  // HMAC SHA 256
		$vt_openSslAlgorithm:="sha256"
		
		  // initialize the "protected" header property for the JWT signature
		C_OBJECT:C1216($vo_protected)
		$vo_protected:=acme__protectedObjGet ($vt_newAccountUrl;$vt_accountKeyDir;$vt_algorithm)
		
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
		$vl_status:=HTTP Request:C1158(HTTP POST method:K71:2;$vt_newAccountUrl;$vx_requestBody;$vx_responseBody;$tt_headerKey;$tt_headerValue)
		
		  // timer
		$vl_ms:=UTL_durationDifference ($vl_ms;Milliseconds:C459)
		
		If ($vl_status=0)  // server did not respond
			
			  // for instance, using an invalid port (server not listening on that port) on a server, acme__errorLastGet will return 30
			C_LONGINT:C283($vl_networkError)
			$vl_networkError:=acme__errorLastGet 
			acme__log (2;Current method name:C684;"method : "+HTTP POST method:K71:2+", url : \""+$vt_newAccountUrl+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", networkError : "+String:C10($vl_networkError))
			
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
				
				acme__log (2;Current method name:C684;"url : \""+$vt_newAccountUrl+"\""+", status : "+String:C10($vl_status)+", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+", duration : "+UTL_durationMsDebug ($vl_ms)+", account already created ?. [KO]")
				
			: ($vl_status=201)  // account created
				
				C_TEXT:C284($vt_contentType)
				$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
				If ($vt_contentType="application/json")
					$vb_ok:=True:C214
					
					acme__notify ("new account generated")
					
					C_OBJECT:C1216($vo_responseBody)
					$vo_responseBody:=OB_jsonBlobParse (->$vx_responseBody)
					
					If (True:C214)
						  // dump the status, the request header and body and the response headers and body to a json file
						  // in the repsonse header, we have the "Location"
						  // "Location": "https://acme-staging-v02.api.letsencrypt.org/acme/acct/1234567",
						C_OBJECT:C1216($vo_httpResponse)
						OB SET:C1220($vo_httpResponse;"method";HTTP POST method:K71:2)
						OB SET:C1220($vo_httpResponse;"url";$vt_newAccountUrl)
						OB SET:C1220($vo_httpResponse;"status";$vl_status)
						OB SET:C1220($vo_httpResponse;"requestHeaders";$vo_requestHeaders)
						OB SET:C1220($vo_httpResponse;"requestBody";$vo_requestBody)
						OB SET:C1220($vo_httpResponse;"responseHeaders";$vo_responseHeaders)
						OB SET:C1220($vo_httpResponse;"responseBody";$vo_responseBody)
						
						If (False:C215)
							SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_httpResponse;*))
						End if 
						
						UTL_textToFile ($vt_accountKeyDir+"httpRequest.json";JSON Stringify:C1217($vo_httpResponse;*))
						CLEAR VARIABLE:C89($vo_httpResponse)
					End if 
					
					  //<Modif> Bruno LEGAY (BLE) (06/09/2019) - v0.90.10
					  // https://community.letsencrypt.org/t/acme-v2-scheduled-removal-of-id-from-account-objects/94744/2
					  // https://acme-staging-v02.api.letsencrypt.org/acme/new-acct
					If (Not:C34(OB Is defined:C1231($vo_responseBody;"id")))  // get account id from location url in the response headers
						
						  // After 01/08/2019 : 
						  //
						  // {
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
						
						  // "Boulder-Requester": "1234567",
						  // "Cache-Control": "max-age=0, no-cache, no-store",
						  // "Connection": "close",
						  // "Content-Length": "563",
						  // "Content-Type": "application/json",
						  // "Date": "Fri, 06 Sep 2019 08:34:01 GMT",
						  // "Expires": "Fri, 06 Sep 2019 08:34:01 GMT",
						  // "Link": "<https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf>;rel=\"terms-of-service\"",
						  // "Location": "https://acme-v02.api.letsencrypt.org/acme/acct/1234567",
						  // "Pragma": "no-cache",
						  // "Replay-Nonce": "0002bVQxYkrjwyvepNRuMFMp3iiaaTQ2At-Bf6rL6bvVuvg",
						  // "Server": "nginx",
						  // "Strict-Transport-Security": "max-age=604800",
						  // "X-Frame-Options": "DENY"
						
						C_OBJECT:C1216($vo_account)
						$vo_account:=$vo_responseBody
						CLEAR VARIABLE:C89($vo_responseBody)
						
						C_TEXT:C284($vt_location)
						ASSERT:C1129(OB Is defined:C1231($vo_responseHeaders;"Location");"\"Location\" header not in response of HTTP POST on url \""+$vt_newAccountUrl+"\"")
						$vt_location:=OB Get:C1224($vo_responseHeaders;"Location")
						
						  //C_ENTIER LONG($vl_accountId)
						C_TEXT:C284($vt_accountId)  // treat the account id as string (in case the numbers get really big)
						
						C_TEXT:C284($vt_regex)
						$vt_regex:="^.*/([0-9]+)$"
						
						C_BOOLEAN:C305($vb_match)
						$vb_match:=TXT_regexGetMatchingGroup ($vt_regex;$vt_location;1;->$vt_accountId)
						ASSERT:C1129($vb_match;"Account id not found in \"Location\" header \""+$vt_location+"\" with regex \""+$vt_regex+"\"")
						
						OB SET:C1220($vo_account;"id";$vt_accountId)
						
						UTL_textToFile ($vt_accountKeyDir+"account.json";JSON Stringify:C1217($vo_account;*))
						CLEAR VARIABLE:C89($vo_account)
						
					Else 
						
						  // Before 01/08/2019 : 
						  //
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
						
						UTL_textToFile ($vt_accountKeyDir+"account.json";JSON Stringify:C1217($vo_responseBody;*))
						CLEAR VARIABLE:C89($vo_responseBody)
					End if 
					  //<Modif>
					
					acme__log (4;Current method name:C684;"url : \""+$vt_newAccountUrl+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\","+", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\","+", response body : \""+Convert to text:C1012($vx_responseBody;"UTF-8")+"\". [OK]")
				Else 
					acme__log (2;Current method name:C684;"url : \""+$vt_newAccountUrl+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+", unexpected \"Content-Type\": \""+$vt_contentType+"\". [KO]")
				End if 
				
			Else 
				  //: (($vl_status>=400) & ($vl_status<500))
				  // application/problem+json
				
				C_TEXT:C284($vt_contentType;$vt_json)
				$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
				If ($vt_contentType="application/@json")  // "application/problem+json"
					$vt_json:=Convert to text:C1012($vx_responseBody;"UTF-8")
				End if 
				
				acme__log (2;Current method name:C684;"url : \""+$vt_newAccountUrl+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+", response body : \""+$vt_json+"\". [KO]")
				
		End case 
		
		ARRAY TEXT:C222($tt_headerKey;0)
		ARRAY TEXT:C222($tt_headerValue;0)
		
		SET BLOB SIZE:C606($vx_requestBody;0)
		SET BLOB SIZE:C606($vx_responseBody;0)
	End if 
End if 

$0:=$vb_ok

