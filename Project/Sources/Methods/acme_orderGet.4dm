//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : acme_orderGet
  //@scope : public
  //@deprecated : no
  //@description : This function retrieves an order object from Let's Encrypt® 
  //@parameter[0-OUT-status-LONGINT] : 200 if http request is ok
  //@parameter[1-IN-orderUrl-TEXT] : order url
  //@parameter[2-OUT-order-PONTER] : order object pointer (modified)
  //@notes :
  //@example : acme_orderGet 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 02/03/2020, 18:48:07 - v1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$vl_status)
C_TEXT:C284($1;$vt_url)
C_POINTER:C301($2;$vp_orderPtr)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(Type:C295($2->)=Is object:K8:27;"$2 should be an object pointer")

$vt_url:=$1
$vp_orderPtr:=$2

If (OB Is defined:C1231($vp_orderPtr->))
	CLEAR VARIABLE:C89($vp_orderPtr->)
End if 

If (Length:C16($vt_url)>0)
	
	acme__init 
	
	C_TEXT:C284($vt_accountKeyDir)
	$vt_accountKeyDir:=acme__accountInit   // ($vt_workingDir;$vt_directoryUrl)
	
	C_TEXT:C284($vt_algorithm;$vt_openSslAlgorithm)
	$vt_algorithm:="RS256"  // HMAC SHA 256
	$vt_openSslAlgorithm:="sha256"
	
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
		
		C_OBJECT:C1216($vo_requestBody;$vo_payload)
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
	
	Case of 
		: ($vl_status=200)  // certificate generated
			
			C_TEXT:C284($vt_contentType)
			$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
			If ($vt_contentType="application/json")
				  //$vb_ok:=Vrai
				
				C_OBJECT:C1216($vo_order)
				$vo_order:=OB_jsonBlobParse (->$vx_responseBody)
				$vp_orderPtr->:=$vo_order
				  //$2:=OB Copy($vo_order)
				
				If (False:C215)
					  //%T-
					SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_order;*))
					  //%T+
				End if 
				CLEAR VARIABLE:C89($vo_order)
				
				acme__log (4;Current method name:C684;"url : \""+$vt_url+"\""+\
					", status : "+String:C10($vl_status)+\
					", duration : "+UTL_durationMsDebug ($vl_ms)+\
					", protected : \""+JSON Stringify:C1217($vo_protected;*)+"\""+\
					", payload : \""+JSON Stringify:C1217($vo_payload;*)+"\","+\
					", request body : \""+JSON Stringify:C1217($vo_requestBody;*)+"\","+\
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
			
			C_TEXT:C284($vt_contentType;$vt_json)
			$vt_contentType:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Content-Type")
			If ($vt_contentType="application/@json")  // "application/problem+json"
				$vt_json:=Convert to text:C1012($vx_responseBody;"UTF-8")
			End if 
			
		Else 
			
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
End if 

$0:=$vl_status