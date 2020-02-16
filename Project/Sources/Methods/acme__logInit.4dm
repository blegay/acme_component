//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_logInit
  //@scope : private
  //@deprecated : no
  //@description : This method itializes the log/dbg component 
  //@notes : 
  //@example : acme_logInit
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 24/06/2018, 09:19:01 - 1.0
  //@xdoc-end
  //================================================================================

ARRAY TEXT:C222($tt_componentList;0)
COMPONENT LIST:C1001($tt_componentList)
  // if the component "log4D_component" is installed
If (Find in array:C230($tt_componentList;"log4D_component")>0)
	
	  // DBG_init 
	EXECUTE METHOD:C1007("DBG_init")
	
	  // set debug level for "acme" debug to 6 i.e. detailed (default level is 4)
	  // DBG_module_Threshold_Set ("acme";6)
	EXECUTE METHOD:C1007("DBG_module_Threshold_Set";*;"acme";6)
	
	  // DBG_logFileShow 
	EXECUTE METHOD:C1007("DBG_logFileShow")
	
End if 
ARRAY TEXT:C222($tt_componentList;0)
