//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_webServerStart
  //@scope : public
  //@deprecated : no
  //@description : This method will restart the web server
  //@notes : if the web server is not running, it will be started
  //@example : 
  //
  // acme_webServerStart
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 06/09/2018, 19:12:43 - 1.0
  //@xdoc-end
  //================================================================================

If (Not:C34(WEB Is server running:C1313))
	
	  // do we have a certificate ?
	C_TEXT:C284($vt_cert)
	If (acme_certCurrentGet (->$vt_cert))  // we have a certificate
		acme__log (4;Current method name:C684;"certficate found")
		
		  // 4D v16 R6
		  //   - RC4 disabled
		  //   - PFS : Perfect Forward Secrecy (
		  //   - https://blog.4d.com/higher-security-ranking-for-4d-web-sites/
		
		  // 4D v17
		  //   - HSTS
		  // do the following to get A+ rating in 
		  //   - https://www.ssllabs.com/ssltest/
		  //   - https://blog.4d.com/a-security-ranking-for-4d-web-sites/
		
		If (ENV_isv17OrAbove )
			  // The time that the browser should remember that the site is only to be accessed using HTTPS.
			WEB SET OPTION:C1210(Web HSTS max age:K73:27;31536000)  // 87 - 31 536 000 = 365 * 86400 s = 365 days
			
			  // Enable HSTS on the 4D Web server
			WEB SET OPTION:C1210(Web HSTS enabled:K73:26;1)  // 86
			
			  // Enable HTTP on your 4D Web server
			WEB SET OPTION:C1210(Web HTTP enabled:K73:28;1)  // 88
			
			  // Enable HTTPS on your 4D Web server
			WEB SET OPTION:C1210(Web HTTPS enabled:K73:29;1)  // 89
		End if 
		
	Else   // no certificate => no https
		acme__log (2;Current method name:C684;"no certficate found")
		
		If (ENV_isv17OrAbove )
			  // Enable HTTP on your 4D Web server (no certificates)
			WEB SET OPTION:C1210(Web HTTP enabled:K73:28;1)  // 88
			
			  // Disable HTTPS on your 4D Web server
			WEB SET OPTION:C1210(Web HTTPS enabled:K73:29;0)  // 89
		End if 
		
	End if 
	
	acme__log (4;Current method name:C684;"starting web server...")
	acme__notify ("4D http server : starting...")
	
	C_BOOLEAN:C305($vb_started)
	WEB START SERVER:C617
	$vb_started:=(ok=1)
	
	ASSERT:C1129($vb_started;"web server failed to start")
	acme__log (Choose:C955($vb_started;4;2);Current method name:C684;"web server started. "+Choose:C955(ok=1;"[OK]";"[KO]"))
	
	If ($vb_started)  // log some infos on the server start...
		acme_logHttpServerInfos 
	End if 
End if 
