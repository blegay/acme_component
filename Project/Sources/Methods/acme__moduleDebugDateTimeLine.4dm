//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__moduleDebugDateTimeLine
  //@scope : public
  //@deprecated : no
  //@description : This method will send debug to a log file using the optional "log4D_component" 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-level-LONGINT] : level (1-9)
  //@parameter[2-IN-debugMessage-TEXT] : debug message
  //@notes :
  //@example : acme__moduleDebugDateTimeLine 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 28/06/2019, 20:13:32 - v1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($1;$vl_level)
C_TEXT:C284($2;$vt_methodName)
C_TEXT:C284($3;$vt_debugMessage)

If (Count parameters:C259>2)
	$vl_level:=$1
	$vt_methodName:=$2
	$vt_debugMessage:=$3
	
	C_TEXT:C284($vt_moduleCode)
	$vt_moduleCode:="acme"
	
	If (Length:C16(<>vt_ACME_dbgMethodName)>0)
		EXECUTE METHOD:C1007(<>vt_ACME_dbgMethodName;*;$vt_moduleCode;$vl_level;$vt_methodName;$vt_debugMessage)
	End if 
	
	If ($vl_level<=2)
		acme__logEvent ("ERROR : - "+$vt_moduleCode+" - "+String:C10($vl_level;"00")+" - "+$vt_methodName+" ==> "+$vt_debugMessage)
	End if 
	
End if 
