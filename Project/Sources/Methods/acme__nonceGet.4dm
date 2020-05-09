//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__nonceGet
  //@scope : private
  //@deprecated : no
  //@description : This function will return a "nonce" value by doing a HEAD http request to the "newNonce" url (e.g. "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce")
  //@parameter[0-OUT-nonce-TEXT] : nonce (e.g. "A-oIXIMunC6AL2VJqn-g0EobW_PidYijJ-KhZbGz3k4")
  //@notes : 
  // the "nonce" value is contained in the repsonse "Replay-Nonce" header
  // https://tools.ietf.org/html/draft-ietf-acme-acme-12#section-7.1.6
  //@example : acme__nonceGet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 06:15:49 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_nonce)  // nonce (e.g. "A-oIXIMunC6AL2VJqn-g0EobW_PidYijJ-KhZbGz3k4")

$vt_nonce:=""

acme__initG 

If ((Length:C16(vt_ACME_nonceLast)>0) & (vl_ACME_nonceTickcount#0))
	
	C_LONGINT:C283($vl_nonceDurationMaxSecs;$vl_nonceDurationMaxTicks)
	$vl_nonceDurationMaxSecs:=120
	$vl_nonceDurationMaxTicks:=$vl_nonceDurationMaxSecs*60
	
	C_LONGINT:C283($vl_nowTicks;$vl_diffTicks)
	$vl_nowTicks:=Tickcount:C458
	$vl_diffTicks:=$vl_nowTicks-vl_ACME_nonceTickcount
	
	If (($vl_diffTicks>=0) & ($vl_diffTicks<$vl_nonceDurationMaxTicks))
		$vt_nonce:=vt_ACME_nonceLast
		
		acme__log (6;Current method name:C684;"nonce \""+vt_ACME_nonceLast+"\" reused"+\
			", nonce tick count : "+String:C10(vl_ACME_nonceTickcount)+\
			", now tick count : "+String:C10($vl_nowTicks)+\
			", diff : "+String:C10($vl_diffTicks)+" ticks"+\
			", diff : "+String:C10(Round:C94($vl_diffTicks/60;3))+" seconds"+\
			", diff max : "+String:C10($vl_nonceDurationMaxSecs)+" seconds")
	Else 
		
		acme__log (6;Current method name:C684;"nonce \""+vt_ACME_nonceLast+"\" too old"+\
			", nonce tick count : "+String:C10(vl_ACME_nonceTickcount)+\
			", now tick count : "+String:C10($vl_nowTicks)+\
			", diff : "+String:C10($vl_diffTicks)+" ticks"+\
			", diff : "+String:C10(Round:C94($vl_diffTicks/60;3))+" seconds"+\
			", diff max : "+String:C10($vl_nonceDurationMaxSecs)+" seconds")
	End if 
	
	vl_ACME_nonceTickcount:=0
	vt_ACME_nonceLast:=""
End if 

If (Length:C16($vt_nonce)=0)
	C_TEXT:C284($vt_directoryUrl)
	$vt_directoryUrl:=acme_directoryUrlGet 
	
	C_TEXT:C284($vt_url)
	$vt_url:=acme__directoryUrlGet ($vt_directoryUrl;"newNonce")
	  // "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce"
	
	Repeat 
		
		ARRAY TEXT:C222($tt_headerKey;0)
		ARRAY TEXT:C222($tt_headerValue;0)
		
		acme__httpRequestHeaderCommon (->$tt_headerKey;->$tt_headerValue)
		
		C_BLOB:C604($vx_requestBody;$vx_responseBody)
		SET BLOB SIZE:C606($vx_requestBody;0)
		SET BLOB SIZE:C606($vx_responseBody;0)
		
		acme__httpClientOptionsSet 
		
		C_TEXT:C284($vt_errorHandler)
		$vt_errorHandler:=acme__errorHdlrBefore 
		
		  // timer
		C_LONGINT:C283($vl_ms)
		$vl_ms:=Milliseconds:C459
		
		C_LONGINT:C283($vl_status)
		$vl_status:=HTTP Request:C1158(HTTP HEAD method:K71:3;$vt_url;$vx_requestBody;$vx_responseBody;$tt_headerKey;$tt_headerValue)
		
		  // timer
		$vl_ms:=UTL_durationDifference ($vl_ms;Milliseconds:C459)
		
		If ($vl_status=0)  // server did not respond
			
			  // for instance, using an invalid port (server not listening on that port) on a server, acme__errorLastGet will return 30
			C_LONGINT:C283($vl_networkError)
			$vl_networkError:=acme__errorLastGet 
			acme__log (2;Current method name:C684;"method : "+HTTP HEAD method:K71:3+", url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", networkError : "+String:C10($vl_networkError))
			
		End if 
		
		acme__errorHdlrAfter ($vt_errorHandler)
		
		If (($vl_status>=200) & ($vl_status<300))
			  // HEAD on https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce will return 204 (No content)
			$vt_nonce:=acme__httpHeaderGetValForKey (->$tt_headerKey;->$tt_headerValue;"Replay-Nonce")
			
			acme__log (6;Current method name:C684;"method : "+HTTP HEAD method:K71:3+", url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+", nonce : \""+$vt_nonce+"\". [OK]")
		Else 
			acme__log (2;Current method name:C684;"method : "+HTTP HEAD method:K71:3+", url : \""+$vt_url+"\""+", status : "+String:C10($vl_status)+", duration : "+UTL_durationMsDebug ($vl_ms)+". [KO]")
		End if 
		
		
		SET BLOB SIZE:C606($vx_requestBody;0)
		SET BLOB SIZE:C606($vx_responseBody;0)
		
		If (Length:C16($vt_nonce)=0)
			acme__notify ("http HEAD \""+$vt_url+"\" failed...")
			acme__log (4;Current method name:C684;"pausing process "+String:C10(Current process:C322)+" for 120s...")
			DELAY PROCESS:C323(Current process:C322;2*60*60)  // pause 2 minutes
			acme__log (4;Current method name:C684;"wake-up")
		End if 
	Until (Length:C16($vt_nonce)>0)
	
End if 

$0:=$vt_nonce
