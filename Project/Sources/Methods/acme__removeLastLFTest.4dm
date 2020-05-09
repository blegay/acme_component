//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__removeLastLFTest
  //@scope : public
  //@deprecated : no
  //@description : This is a test method
  //@notes : 
  //@example : acme__removeLastLFTest
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 30/06/2018, 08:56:03 - 1.0
  //@xdoc-end
  //================================================================================


ALERT:C41("\""+acme__removeLastWhitespaces ("Bruno \nLegay \n")+"\"")
ALERT:C41("\""+acme__removeLastWhitespaces ("Bruno \rLegay "+(20*"\n"))+"\"")