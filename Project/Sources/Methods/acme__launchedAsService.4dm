//%attributes = {"shared":false,"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : acme__launchedAsService
  //@scope : private 
  //@deprecated : no
  //@description : This function returns TRUE if the application was "launched as a service", FALSE otherwise
  //@parameter[0-OUT-isHeadless-BOOLEAN] : TRUE if the application was "launched as a service", FALSE otherwise
  //@notes : 
  //@example : acme__launchedAsService
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 22/07/2021, 08:32:54 - 2.00.02
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_launchedAsService)

C_OBJECT:C1216($vo_appInfo)
$vo_appInfo:=Get application info:C1599

If ($vo_appInfo.launchedAsService#Null:C1517)
	$vb_launchedAsService:=$vo_appInfo.launchedAsService
End if 

acme__log (4;Current method name:C684;"launchedAsService : "+Choose:C955($vb_launchedAsService;"true";"false")+", app infos : "+JSON Stringify:C1217($vo_appInfo))

$0:=$vb_launchedAsService