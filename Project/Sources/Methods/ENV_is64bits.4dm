//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : ENV_is64bits
  //@scope : private
  //@deprecated : no
  //@description : This function returns TRUE if 4D is 64 bits
  //@parameter[0-OUT-is64bits-BOOLEAN] : returns TRUE if 64 bits 4D, FALSE otherwise
  //@notes :
  //@example : ENV_is64bits 
  //@see : 
  //@tag : sct-v15-tag
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : CREATION : Bruno LEGAY (BLE) - 12/01/2012, 17:13:32 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_is64bits)

$vb_is64bits:=(Version type:C495 ?? 64 bit version:K5:25)

$0:=$vb_is64bits
