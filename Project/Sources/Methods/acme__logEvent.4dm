//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__logEvent
  //@scope : private
  //@deprecated : no
  //@description : This method will log an event
  //@parameter[1-IN-message-TEXT] : message
  //@notes :
  //@example : acme__logEvent 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 12/02/2019, 22:56:09 - v1.00.00
  //@xdoc-end
  //================================================================================
C_TEXT:C284($1;$vt_message)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_message:=$1

C_LONGINT:C283($vl_outputType;$vl_importance)
If (Is Windows:C1573)
	$vl_outputType:=Into Windows log events:K38:4
	$vl_importance:=Information message:K38:1
	
	LOG EVENT:C667($vl_outputType;$vt_message;$vl_importance)
Else 
	
	  //<Modif> Bruno LEGAY (BLE) (14/02/2019)
	$vt_message:="acme-4d : "+$vt_message
	  //<Modif>
	
	$vl_outputType:=Into 4D debug message:K38:5
	
	LOG EVENT:C667($vl_outputType;$vt_message)
End if 