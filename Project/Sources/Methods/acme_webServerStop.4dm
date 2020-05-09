//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_webServerStop
  //@scope : public
  //@deprecated : no
  //@description : This method will stop the web server
  //@notes : if the web server is running, it will be stopped
  //@example : 
  //
  // acme_webServerStop
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 06/09/2018, 19:12:43 - 1.0
  //@xdoc-end
  //================================================================================

If (WEB Is server running:C1313)
	acme__log (4;Current method name:C684;"stopping web server...")
	acme__notify ("4D http server : stopping...")
	
	C_BOOLEAN:C305($vb_stopped)
	WEB STOP SERVER:C618
	$vb_stopped:=(ok=1)
	
	ASSERT:C1129($vb_stopped;"web server failed to stop")
	acme__log (Choose:C955($vb_stopped;4;2);Current method name:C684;"web server stopped. "+Choose:C955(ok=1;"[OK]";"[KO]"))
End if 
