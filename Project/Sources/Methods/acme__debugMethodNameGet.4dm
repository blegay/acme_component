//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__debugMethodNameGet
  //@scope : private 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : debug method call
  //@notes : 
  //@example : acme__debugMethodNameGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 04/05/2021, 12:52:37 - 1.00.04
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_methodName)

If (Storage:C1525.acme#Null:C1517)
	$vt_methodName:=Storage:C1525.acme.debug.methodName
Else 
	
	If (False:C215)
		
		  //ARRAY TEXT($tt_hostComponent;0)
		  //COMPONENT LIST($tt_hostComponent)  // not thread safe in v18.4
		
		  //Case of 
		  //: (Find in array($tt_hostComponent;"dbg_component")>0)  //à partir de v3, 4D v17
		  //$vt_methodName:="DBG_module_Debug_DateTimeLine"
		
		  //: (Find in array($tt_hostComponent;"log4D_component")>0)  //jusqu'à v2, 4D v15
		  //$vt_methodName:="DBG_module_Debug_DateTimeLine"
		  //Else 
		  //$vt_methodName:=""
		  //End case 
		
	Else 
		  //VIEILLE METHODE (datant d'avant LISTE COMPOSANTS)
		
		C_TEXT:C284($vt_errHdlr)
		$vt_errHdlr:=Method called on error:C704
		
		ON ERR CALL:C155("acme__errHdlrToDevNull")
		
		C_TEXT:C284($vt_dbg_version)
		EXECUTE METHOD:C1007("DBG_componentVersionGet";$vt_dbg_version)
		If (ok=1)
			$vt_methodName:="DBG_module_Debug_DateTimeLine"
		End if 
		
		ON ERR CALL:C155($vt_errHdlr)
		
	End if 
	
	
End if 


$0:=$vt_methodName

