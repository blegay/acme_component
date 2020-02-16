//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__errorHdlrBefore
  //@scope : private
  //@deprecated : no
  //@description : This function installs a custom error handler et returns the current/previous error handler
  //@parameter[0-OUT-previousErrorHandler-TEXT] : previous error handler
  //@notes : 
  //@example : acme__errorHdlrBefore
  //@see : "acme__errorHdlr"
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 11:39:40 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_previousErrorHandler)

acme__errorReset 

$vt_previousErrorHandler:=Method called on error:C704

ON ERR CALL:C155("acme__errorHdlr")

$0:=$vt_previousErrorHandler