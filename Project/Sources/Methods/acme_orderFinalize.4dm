//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_orderFinalize
  //@scope : public
  //@deprecated : no
  //@description : This function will finalize an order
  //@parameter[0-OUT-finalized-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-finalizeUrl-TEXT] : finalizeUrl
  //@parameter[2-IN-payload-OBJET] : payload object (not modified)
  //@notes : 
  //@example : acme_orderFinalize
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 00:06:04 - 1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_finalized)
C_TEXT:C284($1;$vt_finalizeUrl)
C_OBJECT:C1216($2;$vo_payload)


  //C_TEXTE($1;$vt_directoryUrl)  // directory url (e.g. "https://acme-v02.api.letsencrypt.org/directory")
  //C_TEXTE($2;$vt_finalizeUrl)
  //C_OBJET($3;$vo_payload)
  //C_TEXTE($4;$vt_workingDir)
ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(Length:C16($1)>0;"$1 finalize url cannot be empty")
ASSERT:C1129(OB Is defined:C1231($2);"$2 payload object is undefined")

  //ASSERT(Nombre de paramètres>1;"requires 2 parameters")
  //ASSERT(Longueur($1)>0;"$1 directory url cannot be empty")
  //ASSERT(Longueur($2)>0;"$2 url cannot be empty")
  //ASSERT(OB Est défini($3);"$3 object is undefined")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vt_finalizeUrl:=$1
	$vo_payload:=$2
	
	acme__init 
	
	C_TEXT:C284($vt_workingDir;$vt_directoryUrl)
	$vt_workingDir:=acme_workingDirGet 
	$vt_directoryUrl:=acme_directoryUrlGet 
	
	  //$vt_directoryUrl:=$1
	  //$vt_finalizeUrl:=$2
	  //$vo_payload:=$3
	
	  //Au cas ou 
	  //: ($vl_nbParam=3)
	  //$vt_workingDir:=""
	
	  //Sinon 
	  //  //: ($vl_nbParam=4)
	
	  //$vt_workingDir:=$4
	  //Fin de cas 
	
	  // init debugger and stuff
	  //acme__init 
	
	  // get the account key dir path
	C_TEXT:C284($vt_accountKeyDir)
	$vt_accountKeyDir:=acme__accountInit   // ($vt_workingDir;$vt_directoryUrl)
	
	  // get the url for the "newAccount" service
	
	C_TEXT:C284($vt_algorithm;$vt_openSslAlgorithm)
	$vt_algorithm:="RS256"  // HMAC SHA 256
	$vt_openSslAlgorithm:="sha256"
	
	  // initialize the "protected" header property for the JWT signature
	C_OBJECT:C1216($vo_protected)
	$vo_protected:=acme__protectedObjGet ($vt_finalizeUrl;$vt_accountKeyDir;$vt_algorithm)
	
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
	
	acme__httpRequestHeaderCommon (->$tt_headerKey;->$tt_headerValue;acme__joseContentType )
	
	  // get the json object into the request body blob
	$vx_requestBody:=acme__objectToBlob ($vo_requestBody)
	
	  // save the request headers into an object
	C_OBJECT:C1216($vo_requestHeaders)
	$vo_requestHeaders:=acme__httpHeadersToObject (->$tt_headerKey;->$tt_headerValue)
	
	acme__httpClientOptionsSet 
	
	acme__log (6;Current method name:C684;"http request, method : "+HTTP POST method:K71:2+", url : \""+$vt_finalizeUrl+"\"...")
	C_TEXT:C284($vt_errorHandler)
	$vt_errorHandler:=acme__errorHdlrBefore 
	
	  // timer
	C_LONGINT:C283($vl_ms)
	$vl_ms:=Milliseconds:C459
	
	C_LONGINT:C283($vl_status)
	$vl_status:=HTTP Request:C1158(HTTP POST method:K71:2;$vt_finalizeUrl;$vx_requestBody;$vx_responseBody;$tt_headerKey;$tt_headerValue)
	
	  // timer
	$vl_ms:=UTL_durationDifference ($vl_ms;Milliseconds:C459)
	
	acme__log (6;Current method name:C684;"http request, method : "+HTTP POST method:K71:2+", url : \""+$vt_finalizeUrl+"\", status : "+String:C10($vl_status))
	
	If ($vl_status=0)  // server did not respond
		
		acme__progressUpdate (100;"serverDidNotRespond")  //"Zertifikat anfordern fehlgeschlagen")
		  //If ($vb_progress)
		  //Progress SET PROGRESS ($vl_progressID;100;"Zertifikat anfordern fehlgeschlagen";True)
		  //End if 
		
		  // for instance, using an invalid port (server not listening on that port) on a server, acme__errorLastGet will return 30
		C_LONGINT:C283($vl_networkError)
		$vl_networkError:=acme__errorLastGet 
		acme__log (2;Current method name:C684;"method : "+HTTP POST method:K71:2+\
			", url : \""+$vt_finalizeUrl+"\""+\
			", status : "+String:C10($vl_status)+\
			", duration : "+UTL_durationMsDebug ($vl_ms)+\
			", networkError : "+String:C10($vl_networkError))
		
	End if 
	acme__errorHdlrAfter ($vt_errorHandler)
	
	  //<Modif> Bruno LEGAY (BLE) (14/02/2019)
	acme__nonceRefresh ($vl_status;->$tt_headerKey;->$tt_headerValue)
	  //<Modif>
	
	  // save the request headers into an object
	C_OBJECT:C1216($vo_responseHeaders)
	$vo_responseHeaders:=acme__httpHeadersToObject (->$tt_headerKey;->$tt_headerValue)
	
	Case of 
		: ($vl_status=200)  // certificate generated
			
			acme__progressUpdate (0;"certificateGenerated")  //"Zertifikat erfolgreich angefordert")
			  //If ($vb_progress)
			  //Progress SET PROGRESS ($vl_progressID;0;"Zertifikat erfolgreich angefordert";True)
			  //End if 
			
			  // {
			  //   "status": "valid",
			  //   "expires": "2018-06-29T22:36:18Z",
			  //   "identifiers": [
			  //       {
			  //           "type": "dns",
			  //           "value": "test-ssl.example.com"
			  //       }
			  //   ],
			  //   "authorizations": [
			  //      "https://acme-staging-v02.api.letsencrypt.org/acme/authz/nPPN9UEJ8tS7Rdv0_BaPCX9CloLi-XpZ3vQHjSHu0Yk"
			  //   ],
			  //   "finalize": "https://acme-staging-v02.api.letsencrypt.org/acme/finalize/6332152/2354791",
			  //   "certificate": "https://acme-staging-v02.api.letsencrypt.org/acme/cert/faeeefaf925b925f092e414d87f736ce23e1"
			  // }
			
			  // Then you can fetch the certificate with a simple GET on the "certificate" url property
			
			C_TEXT:C284($vt_contentType)
			$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
			If ($vt_contentType="application/json")
				  //$vb_ok:=Vrai
				
				C_OBJECT:C1216($vo_responseBody)
				$vo_responseBody:=OB_jsonBlobParse (->$vx_responseBody)
				
				$vo_finalized:=$vo_responseBody
				
				If (True:C214)
					  // dump the status, the request header and body and the response headers and body to an object
					C_OBJECT:C1216($vo_httpResponse)
					OB SET:C1220($vo_httpResponse;"method";HTTP POST method:K71:2)
					OB SET:C1220($vo_httpResponse;"url";$vt_finalizeUrl)
					OB SET:C1220($vo_httpResponse;"status";$vl_status)
					OB SET:C1220($vo_httpResponse;"requestHeaders";$vo_requestHeaders)
					OB SET:C1220($vo_httpResponse;"requestBody";$vo_requestBody)
					OB SET:C1220($vo_httpResponse;"responseHeaders";$vo_responseHeaders)
					OB SET:C1220($vo_httpResponse;"responseBody";$vo_responseBody)
					
					  //TEXTE VERS DOCUMENT($vt_accountKeyDir+"httpRequest.json";JSON Stringify($vo_httpResponse;*))
					If (False:C215)
						  //%T-
						SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_httpResponse;*))
						  //%T+
					End if 
					
					CLEAR VARIABLE:C89($vo_httpResponse)
				End if 
				
				acme__log (4;Current method name:C684;"url : \""+$vt_finalizeUrl+"\""+\
					", status : "+String:C10($vl_status)+\
					", duration : "+UTL_durationMsDebug ($vl_ms)+\
					", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+\
					", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\","+\
					", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\","+\
					", response body : \""+Convert to text:C1012($vx_responseBody;"UTF-8")+"\". [OK]")
			Else 
				acme__log (2;Current method name:C684;"url : \""+$vt_finalizeUrl+"\""+\
					", status : "+String:C10($vl_status)+\
					", duration : "+UTL_durationMsDebug ($vl_ms)+\
					", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+\
					", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\""+\
					", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\""+\
					", unexpected \"Content-Type\": \""+$vt_contentType+"\". [KO]")
			End if 
			
		Else 
			  //: (($vl_status>=400) & ($vl_status<500))
			  // application/problem+json
			
			C_TEXT:C284($vt_contentType;$vt_json)
			$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
			If ($vt_contentType="application/@json")  // "application/problem+json"
				$vt_json:=Convert to text:C1012($vx_responseBody;"UTF-8")
			End if 
			
			acme__log (2;Current method name:C684;"url : \""+$vt_finalizeUrl+"\""+\
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
End if 

$0:=$vo_finalized
