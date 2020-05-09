//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_workingDirGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns the curent working dir for the acme component
  //@parameter[0-OUT-workingDir-TEXT] : working directory
  //@notes : interprocess scope
  //@example : acme_workingDirGet
  //@see : acme_workingDirSet
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 12/02/2019, 19:41:20 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_workingDir)

acme__init 

If (ENV_isv17OrAbove )  // use Storage to be "thread-safe" compatible
	
	$vt_workingDir:=Storage:C1525.acme.config.workingDir
	
Else 
	  // unfortunately, the thread-safe compiler directive do not work with interprocess variables (v18.0)...
	  //%T-
	$vt_workingDir:=<>vt_ACME_workingDir
	  //%T+
End if 

$0:=$vt_workingDir