//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
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
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 12/02/2019, 19:41:20 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_directoryUrl)

acme__init 

If (ENV_isv17OrAbove )  // use Storage to be "thread-safe" compatible
	$vt_directoryUrl:=Storage:C1525.acme.config.directoryUrl
Else 
	  // unfortunately, the thread-safe compiler directive do not work with interprocess variables (v18.0)...
	  //%T-
	  //%T// $vt_directoryUrl:=<>vt_ACME_directoryUrl
	  //%T+
End if 

$0:=$vt_directoryUrl