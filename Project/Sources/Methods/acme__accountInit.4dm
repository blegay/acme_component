//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__accountInit
  //@scope : private
  //@deprecated : no
  //@description : This function returns the account key dir the a given serivce (based from directory url) and from the working dir
  //@parameter[0-OUT-accountKeyDir-TEXT] : account key dir "<$vt_workingDir>letsencrypt:acme-v02.api.letsencrypt.org:_account:"
  //@parameter[1-IN-delete-BOOLEAN] : if TRUE will delete the "key.pem" and "key.pub" files (optional, default FALSE)
  //@notes : 
  //
  // "letsencrypt"
  //   +--  "acme-v02.api.letsencrypt.org" (or "acme-staging-v02.api.letsencrypt.org")
  //     +--  "_account"
  //       +--  "account.json" (account data returned by the http POST request body to letsencrypt)
  //       +--  "httpRequest.json" (contains the http request /response info of the account creation, including the "Location" reponse header (e.g. "https://acme-v02.api.letsencrypt.org/acme/acct/<accountId>")
  //       +--  "key.pub" (account 2048 bits rsa public key file in PEM / text format, starting with "-----BEGIN RSA PUBLIC KEY-----")
  //       +--  "key.pem" (accounr 2048 bits rsa private key file in PEM / text format, starting with "-----BEGIN RSA PRIVATE KEY-----")
  //     +--  "_orders"
  //       +--  "<orderId>"
  //         +--  "<yyyymmddhhmiss>_httpRequest.json" (contains the http request / response info of the order creation)
  //         +--  "<yyyymmddhhmiss>_httpResponse.json" (same as "<orderId>.json")
  //         +--  "<orderId>.json"  (response to the order http request, including the "Location" reponse header (e.g. "https://acme-staging-v02.api.letsencrypt.org/acme/order/<accountId>/<orderId>")
  //         +--  "cert.pem" (certificate in PEM format, starting with "-----BEGIN CERTIFICATE-----")
  //         +--  "csr.der" (certificate request in DER / binary format)
  //         +--  "csr.pem" (certificate request in PEM / text format, stating with "-----BEGIN CERTIFICATE REQUEST-----")
  //         +--  "key.pem" (certificate 2048 bits rsa private key in PEM / text format, starting with "-----BEGIN RSA PRIVATE KEY-----")
  //         +--  "key.pub" (certificate 2048 bits rsa public key in PEM / text format, starting with "-----BEGIN PUBLIC KEY-----") 
  // 
  //@example : acme__accountInit => "Macintosh HD:Users:ble:Documents:Projets:myApp:letsencrypt:_account:acme-staging-v02.api.letsencrypt.org:"
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 13:18:26 - 1.00.00
  //@xdoc-end
  //================================================================================
  //@parameter[1-IN-workingDir-TEXT] : working directory (optional, default Get 4D folder(Database folder;*))
  //@parameter[2-IN-directoryUrl-TEXT] : directory url (optional, default "https://acme-v02.api.letsencrypt.org/directory")
  //@parameter[3-IN-delete-BOOLEAN] : if TRUE will delete the "key.pem" and "key.pub" files (optional, default FALSE)

C_TEXT:C284($0;$vt_accountKeyDir)
C_BOOLEAN:C305($1;$vb_delete)

  //C_TEXTE($1;$vt_workingDir)
  //C_TEXTE($2;$vt_directoryUrl)
  //C_BOOLÉEN($3;$vb_delete)

  //ASSERT(Nombre de paramètres>0;"require 1 parameter")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

Case of 
	: ($vl_nbParam=0)
		$vb_delete:=False:C215
		
	Else 
		  //:($vl_nbParam=1)
		$vb_delete:=$1
End case 

  //Au cas ou 
  //: ($vl_nbParam=0)
  //$vt_workingDir:=""
  //$vt_directoryUrl:=""
  //$vb_delete:=Faux

  //: ($vl_nbParam=1)
  //$vt_workingDir:=$1
  //$vt_directoryUrl:=""
  //$vb_delete:=Faux

  //: ($vl_nbParam=2)
  //$vt_workingDir:=$1
  //$vt_directoryUrl:=$2
  //$vb_delete:=Faux

  //Sinon 
  //  //:($vl_nbParam=3)
  //$vt_workingDir:=$1
  //$vt_directoryUrl:=$2
  //$vb_delete:=$3
  //Fin de cas 
  //Si (Longueur($vt_directoryUrl)=0)
  //$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
  //Fin de si 

  //Si (Tester chemin acces($vt_workingDir)#Est un dossier)
  //$vt_workingDir:=""
  //Fin de si 
  //Si (Longueur($vt_workingDir)=0)
  //$vt_workingDir:=Dossier 4D(Dossier base;*)
  //Fin de si 

acme__init 

C_TEXT:C284($vt_workingDir;$vt_directoryUrl)
$vt_workingDir:=acme_workingDirGet 
$vt_directoryUrl:=acme_directoryUrlGet 

  // extract "acme-v02.api.letsencrypt.org" from "https://acme-v02.api.letsencrypt.org/directory for instance

  //<Modif> Bruno LEGAY (BLE) (31/07/2019)
C_TEXT:C284($vt_caDomain)
If (acme__domainExtractFromUrl ($vt_directoryUrl;->$vt_caDomain))
	  //C_TEXTE($vt_regex;$vt_caDomain)
	  //$vt_regex:="^https?://(.*?)/.*$"
	  //Si (TXT_regexGetMatchingGroup ($vt_regex;$vt_directoryUrl;1;->$vt_caDomain))
	  //<Modif>
	
	C_TEXT:C284($vt_certificatesDir;$vt_accountKeyDir;$vt_accountKeyPath)
	$vt_certificatesDir:=$vt_workingDir+"letsencrypt"+Folder separator:K24:12
	
	  //<Modif> Bruno LEGAY (BLE) (12/02/2019)
	$vt_accountKeyDir:=$vt_certificatesDir+acme__domainReverse ($vt_caDomain)+Folder separator:K24:12
	$vt_accountKeyDir:=$vt_accountKeyDir+"_account"+Folder separator:K24:12
	  //$vt_accountKeyDir:=$vt_certificatesDir+"_account"+Séparateur dossier
	  //$vt_accountKeyDir:=$vt_accountKeyDir+$vt_caDomain+Séparateur dossier
	  //<Modif>
	
	
	  //$vt_accountKeyPath:=$vt_accountKeyDir+"key.pem"
	
	If (Test path name:C476($vt_accountKeyDir)=Is a folder:K24:2)
		acme__log (4;Current method name:C684;"account directory \""+$vt_accountKeyDir+"\" exists. [OK]")
	Else 
		CREATE FOLDER:C475($vt_accountKeyDir;*)
		ASSERT:C1129(ok=1;"failed creating dir \""+$vt_accountKeyDir+"\"")
		If (ok=1)
			acme__log (4;Current method name:C684;"account directory \""+$vt_accountKeyDir+"\" created. [OK]")
		Else 
			acme__log (2;Current method name:C684;"account directory \""+$vt_accountKeyDir+"\" could not be created. [KO]")
		End if 
	End if 
	
	If ($vb_delete)
		  // delete the "key.pem" and "key.pub" if they exist
		acme__accountKeyDelete ($vt_accountKeyDir)
	End if 
	
	  // create the account key pair ("key.pem" and "key.pub") files if they don't exist
	acme__accountInitSub ($vt_accountKeyDir)
	
Else 
	acme__log (2;Current method name:C684;"domain not found in url \""+$vt_directoryUrl+"\". [KO]")
End if 

$0:=$vt_accountKeyDir