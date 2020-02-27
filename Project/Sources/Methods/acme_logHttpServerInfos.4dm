//%attributes = {}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_logHttpServerInfos
  //@scope : public
  //@deprecated : no
  //@description : This method writes server infos to log file
  //@notes :
  //@example : acme_logHttpServerInfos 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 13/02/2020, 13:33:17 - v1.00.00
  //@xdoc-end
  //================================================================================

  // 4D v16R6+
If (ENV_isv17OrAbove )
	C_BOOLEAN:C305($vb_withCache)
	$vb_withCache:=True:C214
	
	C_OBJECT:C1216($vo_object)
	$vo_object:=WEB Get server info:C1531($vb_withCache)
	
	C_TEXT:C284($vt_serverInfosJson)
	$vt_serverInfosJson:=JSON Stringify:C1217($vo_object;*)
	acme__log (4;Current method name:C684;"http server infos :\r"+$vt_serverInfosJson)
End if 

C_TEXT:C284($vt_cert)
If (acme_certCurrentGet (->$vt_cert))
	
	C_TEXT:C284($vt_certText)
	$vt_certText:=acme_certChainToText ($vt_cert)
	  //$vt_certText:=acme_certToText (->$vt_cert)
	
	$vt_certText:=Replace string:C233($vt_certText;"\r\n";"\r";*)
	$vt_certText:=Replace string:C233($vt_certText;"\n";"\r";*)
	
	acme__log (4;Current method name:C684;"certificate chain :\r"+$vt_certText)
End if 
