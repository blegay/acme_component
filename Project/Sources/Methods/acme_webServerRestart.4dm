//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_webServerRestart
  //@scope : public
  //@deprecated : no
  //@description : This method will restart the web server
  //@notes : if the web server is not running, it will be started
  //@example : 
  //
  // acme_webServerRestart
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 06/09/2018, 19:12:43 - 1.0
  //@xdoc-end
  //================================================================================

acme_webServerStop 
  //If (WEB Is server running)
  //acme__moduleDebugDateTimeLine (4;Current method name;"stopping web server...")
  //acme__notify ("4D http server : stopping...")

  //C_BOOLEAN($vb_stopped)
  //WEB STOP SERVER
  //$vb_stopped:=(ok=1)

  //ASSERT($vb_stopped;"web server failed to stop")
  //acme__moduleDebugDateTimeLine (Choose(ok=1;4;2);Current method name;"web server stopped. "+Choose(ok=1;"[OK]";"[KO]"))
  //End if 

acme_webServerStart 
  //If (Not(WEB Is server running))
  //acme__moduleDebugDateTimeLine (4;Current method name;"starting web server...")
  //acme__notify ("4D http server : starting...")

  //C_BOOLEAN($vb_started)
  //WEB START SERVER
  //$vb_started:=(ok=1)

  //ASSERT($vb_started;"web server failed to start")
  //acme__moduleDebugDateTimeLine (Choose(ok=1;4;2);Current method name;"web server started. "+Choose(ok=1;"[OK]";"[KO]"))

  //If ($vb_started)
  //acme_logHttpServerInfos 
  //End if 

  //End if 
