//%attributes = {"executedOnServer":true,"preemptive":"capable","shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__check4dWebLicenceSrv
  //@scope : private 
  //@deprecated : no
  //@description : This function returns the 4D licence
  //@parameter[0-OUT-licenceObject-OBJECT] : 4D licence
  //@notes : 
  //@example : acme__check4dWebLicenceSrv
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 27/01/2022, 21:14:01 - 2.00.04
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0)

$0:=Get license info:C1489

  //         },
