//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : OB_newObject
  //@scope : public
  //@deprecated : no
  //@description : This function returns a new empty object
  //@parameter[0-OUT-newObject-OBJECT] : new empty object
  //@notes : 
  //@example : OB_new
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 01/07/2019, 07:08:15 - 0.90.08
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_object)

$vo_object:=New object:C1471  // 4D v16 R3
  //$vo_object:=JSON Parse("{}")

$0:=$vo_object