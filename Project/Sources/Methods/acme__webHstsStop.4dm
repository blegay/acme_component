//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : acme__webHstsStop
  //@scope : private
  //@deprecated : no
  //@description : This method disables HSTS
  //@notes : this does not require restarting web server
  //@example : acme__webHstsStop 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 14/02/2020, 17:31:06 - v1.00.00
  //@xdoc-end
  //================================================================================

If (ENV_isv17OrAbove )
	
	  // #4D-v19-newhttpServer
	
	C_LONGINT:C283($vl_hstsMode)
	WEB GET OPTION:C1209(Web HSTS enabled:K73:26;$vl_hstsMode)
	If ($vl_hstsMode=1)
		acme__log (4;Current method name:C684;"HSTS mode was activated, disable")
		WEB SET OPTION:C1210(Web HSTS enabled:K73:26;0)
	Else 
		acme__log (2;Current method name:C684;"HSTS mode not activated")
	End if 
	
End if 