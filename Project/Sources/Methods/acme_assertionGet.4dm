//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_assertionGet
  //@scope : private 
  //@deprecated : no
  //@description : This function returns the current status of the acme component assertions
  //@parameter[0-OUT-assertionsEnabled-BOOLEAN] : TRUE if the assertions are enabled, FALSE otherwise
  //@notes : 
  //@example : acme_assertionGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 21/07/2021, 16:25:40 - 2.00.02
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_assertionsEnabled)

$vb_assertionsEnabled:=Get assert enabled:C1130

acme__log (4;Current method name:C684;"assertions : "+Choose:C955($vb_assertionsEnabled;"enabled";"disabled"))

$0:=$vb_assertionsEnabled