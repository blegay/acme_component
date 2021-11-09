//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_accountObjectGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns the account object (from file stored locally)
  //@parameter[0-OUT-accountObject-OBJECT] : account object
  //@notes :
  //@example : 

  //  // optional custom pref files storage location
  // C_TEXT($vt_baseDir)
  // $vt_baseDir:=Get 4D folder(Database folder)
  // $vt_baseDirParent:=FS_pathToParent ($vt_baseDir)
  // 
  // acme_workingDirSet ($vt_baseDirParent)
  // 

  //  // try to read the account data from the local json file (if it exists)
  // C_OBJECT($vo_account)
  // $vo_account:=acme_accountObjectGet  
  // 
  // If (OB Is defined($vo_account))  // the account exists (at least a local file exists)
  //
  //   C_TEXT($vt_accountId)
  //   $vt_accountId:=OB Get($vo_account;"id")
  //
  // Else // the local file does not exists, lets create the account
  //   cert_accountCreate
  //
  //    // C_TEXT($vt_contact)
  //    // $vt_contact:="mailto:me@example.com"
  //
  //    // C_BOOLEAN($vt_termsOfserviceAgreed)
  //    // $vt_termsOfserviceAgreed:=True
  //
  //    // C_OBJECT($vo_payload)
  //    // $vo_payload:=acme_newAccountObject (->$vt_contact;$vt_termsOfserviceAgreed)
  //
  //    // acme_newAccount ($vo_payload)
  //  End if

  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 31/07/2019, 16:48:26 - v1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_accountObject)

acme__init 

C_TEXT:C284($vt_workingDir;$vt_directoryUrl)
$vt_workingDir:=acme_workingDirGet 
$vt_directoryUrl:=acme_directoryUrlGet 

  //<Modif> Bruno LEGAY (BLE) (31/07/2019)
C_TEXT:C284($vt_caDomain)
If (acme__domainExtractFromUrl ($vt_directoryUrl;->$vt_caDomain))
	  //C_TEXTE($vt_regex;$vt_caDomain)
	  //$vt_regex:="^https?://(.*?)/.*$"
	  //Si (TXT_regexGetMatchingGroup ($vt_regex;$vt_directoryUrl;1;->$vt_caDomain))
	  //<Modif>
	
	C_TEXT:C284($vt_accountJsonFilePath)
	$vt_accountJsonFilePath:=$vt_workingDir+"letsencrypt"+Folder separator:K24:12+acme__domainReverse ($vt_caDomain)+Folder separator:K24:12+"_account"+Folder separator:K24:12+"account.json"
	
	If (Test path name:C476($vt_accountJsonFilePath)=Is a document:K24:1)
		
		C_TEXT:C284($vt_json)
		$vt_json:=Document to text:C1236($vt_accountJsonFilePath)
		$vo_accountObject:=JSON Parse:C1218($vt_json)
		
	Else 
		acme__log (2;Current method name:C684;"file \""+$vt_accountJsonFilePath+"\" not found. [KO]")
	End if 
	
Else 
	acme__log (2;Current method name:C684;"domain not found in url \""+$vt_directoryUrl+"\". [KO]")
End if 
$0:=$vo_accountObject