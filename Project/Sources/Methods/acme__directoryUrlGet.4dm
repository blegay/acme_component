//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__directoryUrlGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the url for a given "service" from a "directory" url
  //@parameter[0-OUT-serviceUrl-TEXT] : service url (
  //@parameter[1-IN-directoryUrl-TEXT] : directory url ("https://acme-v02.api.letsencrypt.org/directory" or "https://acme-staging-v02.api.letsencrypt.org/directory")
  //@parameter[2-IN-serviceKey-TEXT] : service key ("newAccount", "newNonce", "newOrder", "revokeCert")
  //@notes : 
  //
  // curl https://acme-staging-v02.api.letsencrypt.org/directory
  // {
  //   "IKpf1NyBPSU": "https://community.letsencrypt.org/t/adding-random-entries-to-the-directory/1234",
  //   "keyChange": "https://acme-staging-v02.api.letsencrypt.org/acme/key-change",
  //   "meta": {
  //     "caaIdentities": [
  //       "letsencrypt.org"
  //     ],
  //     "termsOfService": "https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf",
  //     "website": "https://letsencrypt.org/docs/staging-environment/"
  //   },
  //   "newAccount": "https://acme-staging-v02.api.letsencrypt.org/acme/new-acct",
  //   "newNonce": "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce",
  //   "newOrder": "https://acme-staging-v02.api.letsencrypt.org/acme/new-order",
  //   "revokeCert": "https://acme-staging-v02.api.letsencrypt.org/acme/revoke-cert"
  // }
  //
  //@example : acme__directoryUrlGet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 07:22:27 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_serviceUrl)
C_TEXT:C284($1;$vt_directoryUrl)
C_TEXT:C284($2;$vt_serviceKey)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")

ASSERT:C1129(Length:C16($1)>0;"directory url \""+$1+"\" should not be empty")
ASSERT:C1129(TXT_isEqualStrict ($2;"newAccount") | \
TXT_isEqualStrict ($2;"newNonce") | \
TXT_isEqualStrict ($2;"newOrder") | \
TXT_isEqualStrict ($2;"revokeCert");"serviceKey \""+$2+"\" should be \"newAccount\", \"newNonce\", \"newOrder\" or \"revokeCert\"")

$vt_serviceUrl:=""
$vt_directoryUrl:=$1
$vt_serviceKey:=$2

  //<Modif> Bruno LEGAY (BLE) (27/01/2020)
Repeat 
	  //<Modif>
	
	ARRAY TEXT:C222($tt_headerKey;0)
	ARRAY TEXT:C222($tt_headerValue;0)
	
	acme__httpRequestHeaderCommon (->$tt_headerKey;->$tt_headerValue)
	
	  // save the request headers into an object
	C_OBJECT:C1216($vo_requestHeaders)
	$vo_requestHeaders:=acme__httpHeadersToObject (->$tt_headerKey;->$tt_headerValue)
	
	acme__httpClientOptionsSet 
	
	C_TEXT:C284($vt_errorHandler)
	$vt_errorHandler:=acme__errorHdlrBefore 
	
	  // timer
	C_LONGINT:C283($vl_ms)
	$vl_ms:=Milliseconds:C459
	
	C_TEXT:C284($vt_responseBody)
	
	C_LONGINT:C283($vl_status)
	$vl_status:=HTTP Get:C1157($vt_directoryUrl;$vt_responseBody;$tt_headerKey;$tt_headerValue)
	
	  // timer
	$vl_ms:=UTL_durationDifference ($vl_ms;Milliseconds:C459)
	
	If ($vl_status=0)  // server did not respond
		
		  // for instance, using an invalid port (server not listening on that port) on a server, acme__errorLastGet will return 30
		C_LONGINT:C283($vl_networkError)
		$vl_networkError:=acme__errorLastGet 
		acme__log (2;Current method name:C684;"method : "+HTTP GET method:K71:1+", url : \""+$vt_directoryUrl+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", networkError : "+String:C10($vl_networkError))
		
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
	OB SET:C1220($vo_httpResponse;"method";HTTP GET method:K71:1)
	OB SET:C1220($vo_httpResponse;"url";$vt_directoryUrl)
	OB SET:C1220($vo_httpResponse;"status";$vl_status)
	OB SET:C1220($vo_httpResponse;"requestHeaders";$vo_requestHeaders)
	  //OB FIXER($vo_httpResponse;"requestBody";$vo_requestBody)
	OB SET:C1220($vo_httpResponse;"responseHeaders";$vo_responseHeaders)
	OB SET:C1220($vo_httpResponse;"responseBody";$vt_responseBody)
	
	CLEAR VARIABLE:C89($vo_requestHeaders)
	CLEAR VARIABLE:C89($vo_responseHeaders)
	
	Case of 
		: ($vl_status=200)
			
			C_TEXT:C284($vt_contentType)
			$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
			If ($vt_contentType="application/json")
				
				C_OBJECT:C1216($vo_responseObject)
				$vo_responseObject:=JSON Parse:C1218($vt_responseBody)
				OB SET:C1220($vo_httpResponse;"responseBody";$vo_responseObject)
				
				If (OB Is defined:C1231($vo_responseObject;$vt_serviceKey))
					$vt_serviceUrl:=OB Get:C1224($vo_responseObject;$vt_serviceKey;Is text:K8:3)
					acme__log (4;Current method name:C684;"directory url : \""+$vt_directoryUrl+"\""+\
						", status : "+String:C10($vl_status)+\
						", service : \""+$vt_serviceKey+"\""+\
						", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
						", serviceUrl : \""+$vt_serviceUrl+"\". [OK]")
				Else 
					acme__log (2;Current method name:C684;"directory url : \""+$vt_directoryUrl+"\""+\
						", status : "+String:C10($vl_status)+\
						", service : \""+$vt_serviceKey+"\""+\
						", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
						" undefined in response : "+$vt_responseBody+". [KO]")
				End if 
				
			Else 
				acme__log (2;Current method name:C684;"directory url : \""+$vt_directoryUrl+"\""+\
					", status : "+String:C10($vl_status)+\
					", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
					", unexpected Content-Type : \""+$vt_contentType+"\". [KO]")
			End if 
		Else 
			acme__log (2;Current method name:C684;"directory url : \""+$vt_directoryUrl+"\""+\
				", request :\r"+JSON Stringify:C1217($vo_httpResponse;*)+"\r"+\
				", status : "+String:C10($vl_status)+". [KO]")
			
	End case 
	
	CLEAR VARIABLE:C89($vo_httpResponse)
	
	  //<Modif> Bruno LEGAY (BLE) (27/01/2020)
	If (Length:C16($vt_serviceUrl)=0)
		acme__notify ("http GET \""+$vt_directoryUrl+"\" failed ...")
		acme__log (4;Current method name:C684;"pausing process "+String:C10(Current process:C322)+" for 120s...")
		DELAY PROCESS:C323(Current process:C322;2*60*60)  // pause 2 minutes
		acme__log (4;Current method name:C684;"wake-up")
	End if 
Until (Length:C16($vt_serviceUrl)>0)
  //<Modif>

$0:=$vt_serviceUrl