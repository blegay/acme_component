//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__errorHdlrAfter
  //@scope : private
  //@deprecated : no
  //@description : This method restores the previous error handler
  //@parameter[1-IN-previousErrorHandler-TEXT] : previous error handler
  //@notes : 
  //@example : acme__errorHdlrAfter
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 11:46:25 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_previousErrorHandler)

acme__errorReset 

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_previousErrorHandler:=$1

ON ERR CALL:C155($vt_previousErrorHandler)
