//%attributes = {"invisible":true,"preemptive":"incapable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__setLocal
  //@scope : private 
  //@deprecated : no
  //@description : This method/ wil set the localization (for "Get localized string" calls)
  //@notes : 
  //@example : acme__setLocal
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 17/01/2022, 21:29:00 - 2.00.04
  //@xdoc-end
  //================================================================================

C_TEXT:C284($vt_lang)
$vt_lang:=Lowercase:C14(Get database localization:C1009(Default localization:K5:21;*))

  // host local language "en-gb", set component local language "en" (default)

If (($vt_lang="fr") | ($vt_lang="en") | ($vt_lang="de"))
	
	  //If (($vt_lang="fr") | ($vt_lang="en") | ($vt_lang="de"))
	
	  //%T-
	SET DATABASE LOCALIZATION:C1104($vt_lang)
	  //%T+
	acme__log (4;Current method name:C684;"set component local language \""+$vt_lang+"\"")
Else 
	  //%T-
	SET DATABASE LOCALIZATION:C1104("en")
	  //%T+
	acme__log (2;Current method name:C684;"host local language \""+$vt_lang+"\", set component local language \"en\" (default)")
End if 