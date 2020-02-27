//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_orderDirPathGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns the order dir path
  //@parameter[0-OUT-ordersDirPath-TEXT] : order dir path
  //@parameter[1-IN-id-TEXT] : order id
  //@notes : 
  // "letsencrypt"
  //   +--  "acme-v02.api.letsencrypt.org" (or "acme-staging-v02.api.letsencrypt.org")
  //     +--  "_account"
  //       +--  "key.pub" (rsa public key file in pem format "-----BEGIN RSA PUBLIC KEY-----")
  //       +--  "key.pem" (rsa private key file in pem format starting with "-----BEGIN RSA PRIVATE KEY-----")
  //     +--  "_orders"
  //@example : acme_orderDirPathGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 13/02/2019, 00:35:14 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_ordersDirPath)
C_TEXT:C284($1;$vt_orderId)
$vt_ordersDirPath:=""

If (Count parameters:C259>0)
	$vt_orderId:=$1
End if 

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
	
	$vt_ordersDirPath:=$vt_workingDir+"letsencrypt"+Folder separator:K24:12+acme__domainReverse ($vt_caDomain)+Folder separator:K24:12+"_orders"+Folder separator:K24:12
	
	If (Length:C16($vt_orderId)>0)
		$vt_ordersDirPath:=$vt_ordersDirPath+$vt_orderId+Folder separator:K24:12
	End if 
	
	If (Test path name:C476($vt_ordersDirPath)=Is a folder:K24:2)
		acme__log (4;Current method name:C684;"order directory \""+$vt_ordersDirPath+"\" exists. [OK]")
	Else 
		CREATE FOLDER:C475($vt_ordersDirPath;*)
		ASSERT:C1129(ok=1;"failed creating dir \""+$vt_ordersDirPath+"\"")
		If (ok=1)
			acme__log (4;Current method name:C684;"order directory \""+$vt_ordersDirPath+"\" created. [OK]")
		Else 
			acme__log (2;Current method name:C684;"order directory \""+$vt_ordersDirPath+"\" could not be created. [KO]")
		End if 
	End if 
	
Else 
	acme__log (2;Current method name:C684;"domain not found in url \""+$vt_directoryUrl+"\". [KO]")
End if 

$0:=$vt_ordersDirPath
