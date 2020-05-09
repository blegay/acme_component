//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : DBG__dbgInitAuto
  //@scope : private
  //@deprecated : no
  //@description : This method sets a variable with the "DBG_module_Debug_DateTimeLine" method name if log4D_component is installed
  //@parameter[1-OUT-dbgMethodNamePtr-POINTER] : "DBG_module_Debug_DateTimeLine" method name will be set in the text variable pointer (or "" if log4D_component is not installed)
  //@notes : 
  //@example : DBG__dbgInitAuto
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2019, 07:27:27 - 0.90.07
  //@xdoc-end
  //================================================================================

C_POINTER:C301($1;$vp_dbgMethodNamePtr)  //interprocess variable containing the name of méthod to execute (◊vt_acme_dbgMethodName)

C_TEXT:C284($vt_devNullErrHdlr)  //error handler (to /dev/null)

If (Count parameters:C259>0)
	$vp_dbgMethodNamePtr:=$1
	
	  //The standard DBG component module debug with DateTimeLine...
	C_TEXT:C284($vt_methodName)
	$vt_methodName:="DBG_module_Debug_DateTimeLine"
	
	ARRAY TEXT:C222($tt_componentsList;0)
	COMPONENT LIST:C1001($tt_componentsList)
	
	C_BOOLEAN:C305($vb_logComponentIsInstalled)
	Case of 
		: (Find in array:C230($tt_componentsList;"log4D_component")>0)
			$vb_logComponentIsInstalled:=True:C214
			
		: (Find in array:C230($tt_componentsList;"dbg_component")>0)
			$vb_logComponentIsInstalled:=True:C214
			
		Else 
			$vb_logComponentIsInstalled:=False:C215
	End case 
	ARRAY TEXT:C222($tt_componentsList;0)
	
	If ($vb_logComponentIsInstalled)
		  //If the component is installed, we set the name of the DBG component method to execute into an interprcess variable
		  //The calls to acme__moduleDebugDateTimeLine will be passed on to DBG_module_Debug_DateTimeLine from DBG component.
		  //◊vt_acme_dbgMethodName:=$vt_methodName
		$vp_dbgMethodNamePtr->:=$vt_methodName
		
		EXECUTE METHOD:C1007("DBG_init")
		
	Else 
		  //If the component is not installed, we leave the interprcess variable empty. 
		  //The calls to acme__moduleDebugDateTimeLine will not be passed to the DBG component.
		  //◊vt_acme_dbgMethodName:=""
		$vp_dbgMethodNamePtr->:=""
	End if 
	
End if 
