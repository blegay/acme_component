//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__notify
  //@scope : private
  //@deprecated : no
  //@description : This method will display a message and log to the console/event log
  //@parameter[1-IN-message-TEXT] : message
  //@notes : 
  //@example : acme__notify
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 03/07/2018, 18:36:36 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_message)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_message:=$1

acme__log (4;Current method name:C684;$vt_message)

acme__logEvent ($vt_message)

C_BOOLEAN:C305($vb_isHeadless;$vb_launchedAsService)
$vb_isHeadless:=acme__isHeadless 
$vb_launchedAsService:=acme__launchedAsService 
If (Not:C34($vb_isHeadless | $vb_launchedAsService))
	
	C_TEXT:C284($vt_title)
	$vt_title:="acme"
	
	C_LONGINT:C283($vl_delaySecs)
	$vl_delaySecs:=20
	
	  // in 4D v19.1 DISPLAY NOTIFICATION is not "thread-safe" ...
	If (Not:C34(ENV_isPreemptive ))
		  //%T-
		DISPLAY NOTIFICATION:C910($vt_title;$vt_message;$vl_delaySecs)  // not "thread-safe" compatible (in v18.0) #thread-safe : todo
		  //%T+
	End if 
	
End if 
