//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_newOrder
  //@scope : public
  //@deprecated : no
  //@description : This function sends the order to letsencrypt
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if OK, FALSE otherwise
  //@parameter[1-IN-newOrderObject-OBJECT] : new order object (see acme_newOrderObject)
  //@parameter[2-OUT-orderId-POINTER] : orderId (modified)
  //@parameter[3-OUT-orderObjectPtr-POINTER] : order object, this object will be created (modified)
  //@notes : 
  //@example : 
  // TABLEAU OBJET($to_identifiers;0)
  // AJOUTER À TABLEAU($to_identifiers;acme_identifierObjectNew ("dns";"test.example.com"))
  // AJOUTER À TABLEAU($to_identifiers;acme_identifierObjectNew ("dns";"test1.example.com"))
  // AJOUTER À TABLEAU($to_identifiers;acme_identifierObjectNew ("dns";"test2.example.com"))
  // AJOUTER À TABLEAU($to_identifiers;acme_identifierObjectNew ("dns";"test3.example.com"))
  //
  //C_TEXT($vt_directoryUrl)
  //  //$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
  //$vt_directoryUrl:="https://acme-staging-v02.api.letsencrypt.org/directory"
  //
  //C_TEXT($vt_workingDir)
  //$vt_workingDir:=FS_pathToParent (Get 4D Folder(Database folder))
  //
  //TABLEAU TEXTE($tt_domain;0)
  //AJOUTER À TABLEAU($tt_domain;"test.example.com")
  //AJOUTER À TABLEAU($tt_domain;"test1.example.com")
  //AJOUTER À TABLEAU($tt_domain;"test2.example.com")
  //AJOUTER À TABLEAU($tt_domain;"test3.example.com")
  //
  //C_OBJECT($vo_newOrderObject)
  //$vo_newOrderObject:=acme_newOrderObject (->$tt_domain;$vt_workingDir;$vt_directoryUrl)
  //
  //C_TEXT($vt_id)
  //C_OBJECT($vo_order)
  //If(acme_newOrder ($vo_newOrderObject;->$vt_id;->$vo_order))
  //
  //End if
  //
  // {
  //     "status": "pending",
  //     "expires": "2018-07-05T16:15:24Z",
  //     "identifiers": [
  //         {
  //             "type": "dns",
  //             "value": "test.example.com"
  //         },
  //         {
  //             "type": "dns",
  //             "value": "test1.example.com"
  //         },
  //         {
  //             "type": "dns",
  //             "value": "test2.example.com"
  //         },
  //         {
  //             "type": "dns",
  //             "value": "test3.example.com"
  //         }
  //     ],
  //     "authorizations": [
  //         "https://acme-staging-v02.api.letsencrypt.org/acme/authz/n...k",
  //         "https://acme-staging-v02.api.letsencrypt.org/acme/authz/x...M",
  //         "https://acme-staging-v02.api.letsencrypt.org/acme/authz/J...U",
  //         "https://acme-staging-v02.api.letsencrypt.org/acme/authz/m...o"
  //     ],
  //     "finalize": "https://acme-staging-v02.api.letsencrypt.org/acme/finalize/12345/6789"
  // }
  //
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 21:22:28 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_OBJECT:C1216($1;$vo_newOrderObject)
C_POINTER:C301($2;$vp_orderIdPtr)
C_POINTER:C301($3;$vp_orderObjectPtr)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(OB Is defined:C1231($1);"$1 object is undefined")
ASSERT:C1129(OB Is defined:C1231($1;"workingDir");"$1.workingDir object is undefined")
ASSERT:C1129(OB Is defined:C1231($1;"directoryUrl");"$1.directoryUrl object is undefined")
ASSERT:C1129(OB Is defined:C1231($1;"identifiers");"$1.identifiers object is undefined")

ASSERT:C1129(Type:C295($2->)=Is text:K8:3;"$2 orderIdPtr should be a text pointer")
ASSERT:C1129(Type:C295($3->)=Is object:K8:27;"$3 orderObjectPtr should be an object pointer")

$vb_ok:=False:C215

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vo_newOrderObject:=$1
	$vp_orderIdPtr:=$2
	$vp_orderObjectPtr:=$3
	
	C_TEXT:C284($vt_workingDir;$vt_directoryUrl)
	$vt_directoryUrl:=OB Get:C1224($vo_newOrderObject;"directoryUrl")
	$vt_workingDir:=OB Get:C1224($vo_newOrderObject;"workingDir")
	
	  // copy the "identifiers" property
	C_OBJECT:C1216($vo_payload)
	ARRAY OBJECT:C1221($to_identifiers;0)
	OB GET ARRAY:C1229($vo_newOrderObject;"identifiers";$to_identifiers)
	OB SET ARRAY:C1227($vo_payload;"identifiers";$to_identifiers)
	ARRAY OBJECT:C1221($to_identifiers;0)
	
	CLEAR VARIABLE:C89($vp_orderIdPtr->)
	CLEAR VARIABLE:C89($vp_orderObjectPtr->)
	
	  // init debugger and stuff
	acme__init 
	
	  // get the account key dir path
	  // create the rsa key pair "key.pem" (private key) and "key.pub" (public key)
	  // in "<$vt_workingDir>letsencrypt:_account:acme-v02.api.letsencrypt.org:"
	C_TEXT:C284($vt_accountKeyDir)
	$vt_accountKeyDir:=acme__accountInit   // ($vt_workingDir;$vt_directoryUrl)
	
	  // get the url for the "newAccount" service
	C_TEXT:C284($vt_url)
	$vt_url:=acme__directoryUrlGet ($vt_directoryUrl;"newOrder")
	
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
	
	acme__nonceRefresh ($vl_status;->$tt_headerKey;->$tt_headerValue)
	
	  // save the request headers into an object
	C_OBJECT:C1216($vo_responseHeaders)
	$vo_responseHeaders:=acme__httpHeadersToObject (->$tt_headerKey;->$tt_headerValue)
	
	Case of 
		: ($vl_status=200)  //account already created, account update ?
			
			acme__log (2;Current method name:C684;"url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+", duration : "+UTL_durationMsDebug ($vl_ms)+", account already created ?. [KO]")
			
		: ($vl_status=201)  // certificate issuance request created
			
			  //"Location": "https://acme-staging-v02.api.letsencrypt.org/acme/order/12345/6789
			
			C_TEXT:C284($vt_locationUrl)
			$vt_locationUrl:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Location")
			
			
			C_TEXT:C284($vt_orderStatus)
			$vt_orderStatus:=acme__orderStatusGet ($vt_locationUrl)
			If (($vt_orderStatus="pending") | ($vt_orderStatus="ready") | ($vt_orderStatus="valid"))
				
				C_TEXT:C284($vt_id)
				$vt_id:=acme__urlLocationIdGet ($vt_locationUrl)
				$vp_orderIdPtr->:=$vt_id
				
				C_TEXT:C284($vt_contentType)
				$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
				If ($vt_contentType="application/json")
					  //$vb_ok:=Vrai
					
					C_OBJECT:C1216($vo_responseBody)
					$vo_responseBody:=OB_jsonBlobParse (->$vx_responseBody)
					
					$vp_orderObjectPtr->:=$vo_responseBody
					
					C_TEXT:C284($vt_orderDir)
					$vt_orderDir:=acme_orderDirPathGet ($vt_id)
					  //$vt_orderDir:=$vt_workingDir+"_orders"+Séparateur dossier+$vt_id+Séparateur dossier
					  //$vt_orderDir:=$vt_accountKeyDir+"_orders"+Séparateur dossier+$vt_id+Séparateur dossier
					  // create the order directory
					CREATE FOLDER:C475($vt_orderDir;*)
					C_BOOLEAN:C305($vb_direCreated)
					$vb_direCreated:=(ok=1)
					ASSERT:C1129($vb_direCreated;"failed to create \""+$vt_orderDir+"\" directory")
					acme__log (Choose:C955($vb_direCreated;4;2);Current method name:C684;"order dir : \""+$vt_orderDir+". "+Choose:C955($vb_direCreated;"[OK]";"[KO]"))
					
					  // generate an rsa key pair in the order dir
					acme_rsakeyPairGenerate ($vt_orderDir)
					
					UTL_textToFile ($vt_orderDir+$vt_id+".json";JSON Stringify:C1217($vo_responseBody;*))
					
					  // before getting the authorization
					  // we need to make sure we have stop HSTS (redirection "http://" to "https://")
					  // otherwise we may not receive the challenge from Let's Encrypt®
					  // this means the site should have a traditional "http:" => "https://" redirect in the meantime
					acme__webHstsStop 
					
					  // order has been accepted, we need to proceed to the autorization
					  // using the challenges
					$vb_ok:=(acme_orderAuthorisationProcess ($vo_responseBody))
					
					C_TEXT:C284($vt_timestamp)
					$vt_timestamp:=acme__timestamp 
					BLOB TO DOCUMENT:C526($vt_orderDir+$vt_timestamp+"_httpResponse.json";$vx_responseBody)
					
					If (True:C214)
						  // dump the status, the request header and body and the response headers and body to an object
						C_OBJECT:C1216($vo_httpResponse)
						OB SET:C1220($vo_httpResponse;"method";HTTP POST method:K71:2)
						OB SET:C1220($vo_httpResponse;"url";$vt_url)
						OB SET:C1220($vo_httpResponse;"status";$vl_status)
						OB SET:C1220($vo_httpResponse;"requestHeaders";$vo_requestHeaders)
						OB SET:C1220($vo_httpResponse;"requestBody";$vo_requestBody)
						OB SET:C1220($vo_httpResponse;"responseHeaders";$vo_responseHeaders)
						OB SET:C1220($vo_httpResponse;"responseBody";$vo_responseBody)
						
						UTL_textToFile ($vt_orderDir+$vt_timestamp+"_httpRequest.json";JSON Stringify:C1217($vo_httpResponse;*))
						If (False:C215)
							SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_httpResponse;*))
						End if 
						
						CLEAR VARIABLE:C89($vo_httpResponse)
					End if 
					
					C_LONGINT:C283($vl_nbSecondsMax)
					$vl_nbSecondsMax:=120  // wait two minutes 
					acme_orderAuthorisationWait ($vo_responseBody;$vl_nbSecondsMax)
					
					acme__log (4;Current method name:C684;"url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+\
						", duration : "+UTL_durationMsDebug ($vl_ms)+\
						", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+\
						", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+\
						", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+\
						", response body : \""+Convert to text:C1012($vx_responseBody;"UTF-8")+"\". [OK]")
				Else 
					acme__log (2;Current method name:C684;"url : \""+$vt_url+"\""+\
						", status : "+String:C10($vl_status)+\
						", duration : "+UTL_durationMsDebug ($vl_ms)+\
						", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+\
						", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+\
						", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+\
						", unexpected \"Content-Type\": \""+$vt_contentType+"\". [KO]")
				End if 
				
			Else 
				acme__log (2;Current method name:C684;"order url : \""+$vt_locationUrl+"\", unexpected status : \""+$vt_orderStatus+"\". [KO]")
			End if 
			
		Else 
			  //: (($vl_status>=400) & ($vl_status<500))
			  // application/problem+json
			
			C_TEXT:C284($vt_contentType;$vt_json)
			$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
			If ($vt_contentType="application/@json")  // "application/problem+json"
				$vt_json:=Convert to text:C1012($vx_responseBody;"UTF-8")
			End if 
			
			acme__log (2;Current method name:C684;"url : \""+$vt_url+"\""+\
				", status : "+String:C10($vl_status)+\
				", duration : "+UTL_durationMsDebug ($vl_ms)+\
				", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+\
				", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+\
				", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+\
				", response body : \""+$vt_json+"\". [KO]")
			
	End case 
	
	SET BLOB SIZE:C606($vx_requestBody;0)
	SET BLOB SIZE:C606($vx_responseBody;0)
	
	ARRAY TEXT:C222($tt_headerKey;0)
	ARRAY TEXT:C222($tt_headerValue;0)
	
	acme__notify ("newOrder "+Choose:C955($vb_ok;"success";"failed"))
End if 

$0:=$vb_ok
