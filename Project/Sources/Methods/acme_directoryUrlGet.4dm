//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_directoryUrlGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns the "directory url"
  //@parameter[0-OUT-directoryUrl-TEXT] : directory url
  //@notes : interprocess scope
  //@example : acme_directoryUrlGet
  //@see : acme_directoryUrlSet
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 12/02/2019, 19:41:20 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_directoryUrl)

acme__init 

$vt_directoryUrl:=<>vt_ACME_directoryUrl

$0:=$vt_directoryUrl