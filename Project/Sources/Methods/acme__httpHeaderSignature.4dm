//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpHeaderSignature
  //@scope : private
  //@deprecated : no
  //@description : This function returns the http header signature
  //@parameter[0-OUT-httpHeaderSignature-TEXT] : http header signature (e.g. "acme-4d component v0.90.00/4D v15.6 Final (Build 222813) (32 bits)/macOS")
  //@notes : 
  //@example : acme__httpHeaderSignature
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 20:22:36 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_httpHeaderSignature)

  //<Modif> Bruno LEGAY (BLE) (14/02/2019)
$vt_httpHeaderSignature:="acme-4d component v"+acme_componentVersionGet +\
"/"+ENV_versionStr +Choose:C955(ENV_is64bits ;" (64 bits)";" (32 bits)")+\
"/"+Choose:C955(ENV_onWindows ;"Windows";"macOS")

  //$vt_httpHeaderSignature:="acme-4d component v"+acme_componentVersionGet +"/"+ENV_versionStr +Choisir(ENV_is64bits ;" (32 bits)";" (64 bits)")
  //<Modif>

$0:=$vt_httpHeaderSignature
