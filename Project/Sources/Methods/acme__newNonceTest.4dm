//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : newNonceTest
  //@scope : private
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-paramName-TEXT] : ParamDescription
  //@parameter[2-IN-paramName-POINTER] : ParamDescription (not modified)
  //@parameter[3-INOUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[4-OUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[5-IN-paramName-LONGINT] : ParamDescription (optional, default value : 1)
  //@notes : 
  //@example : newNonceTest
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 06:26:03 - 1.00.00
  //@xdoc-end
  //================================================================================

ASSERT:C1129(acme__nonceGet ("https://acme-staging-v02.api.letsencrypt.org/directory")#"")
ASSERT:C1129(acme__nonceGet ("https://acme-v02.api.letsencrypt.org/directory")#"")

