//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_directoryUrlSet
  //@scope : public
  //@deprecated : no
  //@description : This method sets the ACME "directory url". This function allows to use the acme "staging" environement for tests
  //@parameter[1-IN-directoryUrl-TEXT] : "directory url"
  //@notes : interprocess scope
  //@example : 
  //
  // Production :
  //   https://acme-v02.api.letsencrypt.org/directory
  //
  // Staging :
  //   https://acme-staging-v02.api.letsencrypt.org/directory
  //
  // acme_directoryUrlSet("https://acme-v02.api.letsencrypt.org/directory") // default
  // acme_directoryUrlSet("https://acme-staging-v02.api.letsencrypt.org/directory")
  //
  //@see : acme_directoryUrlGet
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 12/02/2019, 19:52:02 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_directoryUrl)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"\"directoryUrl\" parameter is empty")

acme__init 

If (Count parameters:C259>0)
	$vt_directoryUrl:=$1
	
	If (ENV_isv17OrAbove )  // use Storage to be "thread-safe" compatible
		
		If (Not:C34(TXT_isEqualStrict (Storage:C1525.acme.config.directoryUrl;$vt_directoryUrl)))
			acme__log (4;Current method name:C684;"setting \"workingDir\" : \""+$vt_directoryUrl+"\"")
			
			Use (Storage:C1525.acme)  // locking "Storage.acme" or "Storage.acme.config" is juste the same
				Storage:C1525.acme.config.directoryUrl:=$vt_directoryUrl
			End use 
			
		End if 
	Else 
		  // unfortunately, the thread-safe compiler directive do not work with interprocess variables (v18.0)...
		  //%T-
		If (Not:C34(TXT_isEqualStrict (<>vt_ACME_directoryUrl;$vt_directoryUrl)))
			acme__log (4;Current method name:C684;"setting \"workingDir\" : \""+$vt_directoryUrl+"\"")
			
			<>vt_ACME_directoryUrl:=$vt_directoryUrl
		End if 
		  //%T+
	End if 
	
	
End if 