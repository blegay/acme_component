//%attributes = {"shared":true}
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

$vt_workingDir:=<>vt_ACME_workingDir

$0:=$vt_workingDir