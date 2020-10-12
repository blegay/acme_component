//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__jswKeyInfosSet
  //@scope : private
  //@deprecated : no
  //@description : This method will read the infos about the private key, or load it from a file 
  //@parameter[1-INOUT-object-OBJET] : object
  //@parameter[2-IN-accountKeyDir-TEXT] : accountKeyDir (e.g. "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v15:acme_component:source:acme_component.4dbase:letsencrypt:org.letsencrypt.api.acme-staging-v02:_account:")
  //@notes : 
  // if the account has already been created, 
  //   the function will set "kid" property with a url value "https://acme-v02.api.letsencrypt.org/acme/acct/12345678" (found in the account creation "Location" header response)
  // if the account has not been created (when creating an account for instance)
  //   the function will set a "jwk" object with "kty"="RSA", "n" = private key modulus (base 64 encoded) and "e" = private key exponent (base 64 encoded)
  //@example : acme__jswKeyInfosSet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 12:06:52 - 1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($1;$vo_object)
C_TEXT:C284($2;$vt_accountKeyDir)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(OB Is defined:C1231($1);"$1 is a null/undefined object")
ASSERT:C1129(Length:C16($2)>0;"$2 (accountKeyDir) is empty")

$vo_object:=$1
$vt_accountKeyDir:=$2

ASSERT:C1129(Test path name:C476($vt_accountKeyDir)=Is a folder:K24:2;"account dir \""+$vt_accountKeyDir+"\" does not exist.")

C_TEXT:C284($vt_httpRequestFilePath)
$vt_httpRequestFilePath:=$vt_accountKeyDir+"httpRequest.json"

C_TEXT:C284($vt_accountFilePath)
$vt_accountFilePath:=$vt_accountKeyDir+"account.json"
If ((Test path name:C476($vt_accountFilePath)=Is a document:K24:1) & (Test path name:C476($vt_httpRequestFilePath)=Is a document:K24:1))
	
	  // Key ID, for all requests signed using an existing account
	  // For all other requests, the request is signed using an existing
	  //    account and there MUST be a "kid" field.  This field MUST contain the
	  //    account URL received by POSTing to the newAccount resource.
	
	C_TEXT:C284($vt_keyId)
	If (True:C214)  // $vt_keyId => "https://acme-staging-v02.api.letsencrypt.org/acme/acct/12345678"
		  // this works with letsencrypt.org - Bruno LEGAY (BLE) (22/06/2018)
		
		  // the url is in the account creation response "Location" header
		
		  // read the "httpRequest.json" which was created when the account was created
		C_TEXT:C284($vt_json)
		$vt_json:=Document to text:C1236($vt_httpRequestFilePath)
		
		C_OBJECT:C1216($vo_httpRequestObj)
		$vo_httpRequestObj:=JSON Parse:C1218($vt_json)
		ASSERT:C1129(OB Is defined:C1231($vo_httpRequestObj);"file \""+$vt_httpRequestFilePath+"\" is not a valid json")
		
		  // 
		C_OBJECT:C1216($vo_responseHeaders)
		$vo_responseHeaders:=OB Get:C1224($vo_httpRequestObj;"responseHeaders";Is object:K8:27)
		ASSERT:C1129(OB Is defined:C1231($vo_responseHeaders);"file \""+$vt_httpRequestFilePath+"\" does not have a responseHeaders property")
		ASSERT:C1129(OB Is defined:C1231($vo_responseHeaders;"Location");"file \""+$vt_httpRequestFilePath+"\" does not have a responseHeaders.Location property")
		
		C_TEXT:C284($vt_location)
		$vt_location:=OB Get:C1224($vo_responseHeaders;"Location";Is text:K8:3)  // "https://acme-v02.api.letsencrypt.org/acme/acct/12345678"
		
		  //<Modif> Bruno LEGAY (BLE) (11/02/2020)
		If (True:C214)
			  // the value to set for "kid" is not the account number 
			  // but the "Location" url "https://acme-v02.api.letsencrypt.org/acme/acct/12345678"
			$vt_keyId:=$vt_location
		Else 
			C_TEXT:C284($vt_regex)
			$vt_regex:="^.*/([0-9]+)$"
			
			C_BOOLEAN:C305($vb_match)
			C_TEXT:C284($vt_accountId)
			$vb_match:=TXT_regexGetMatchingGroup ($vt_regex;$vt_location;1;->$vt_accountId)
			ASSERT:C1129($vb_match;"Account id not found in \"Location\" header \""+$vt_location+"\" with regex \""+$vt_regex+"\"")
			
			$vt_keyId:=$vt_accountId
		End if 
		  //<Modif>
		
		CLEAR VARIABLE:C89($vo_responseHeaders)
		CLEAR VARIABLE:C89($vo_httpRequestObj)
	Else   // $vt_keyId => "12345678"
		  // this does not work with letsencrypt.org - Bruno LEGAY (BLE) (22/06/2018)
		
		C_TEXT:C284($vt_json)
		$vt_json:=Document to text:C1236($vt_accountFilePath)
		
		C_OBJECT:C1216($vo_accountObj)
		$vo_accountObj:=JSON Parse:C1218($vt_json)
		
		  // {
		  //   "id": "12345678",
		  //   "key": {
		  //     "kty": "RSA",
		  //     "n": "u-M...a8w",
		  //     "e": "AQAB"
		  //   },
		  //   "contact": [
		  //     "mailto:blegay@mac.com"
		  //   ],
		  //   "initialIp": "78.247.97.8",
		  //   "createdAt": "2018-06-21T11:42:45.431961959Z",
		  //   "status": "valid"
		  // }
		
		$vt_keyId:=OB Get:C1224($vo_accountObj;"id";Is text:K8:3)
		
		CLEAR VARIABLE:C89($vo_accountObj)
	End if 
	
	OB SET:C1220($vo_object;"kid";$vt_keyId)
	acme__log (4;Current method name:C684;"account already exists, found \"kid\" value : \""+$vt_keyId+"\" in file \""+$vt_httpRequestFilePath+"\"")
	
Else 
	
	  // JSON Web Key, for all requests not signed using an existing account, e.g. newAccount
	  // For newAccount requests, and for revokeCert requests authenticated by
	  //   certificate key, there MUST be a "jwk" field.  This field MUST
	  //   contain the public key corresponding to the private key used to sign
	  //   the JWS.
	C_TEXT:C284($vt_privateKeyPath)
	$vt_privateKeyPath:=acme__keysKeyPairFilepathGet ("private";$vt_accountKeyDir)
	ASSERT:C1129(Test path name:C476($vt_privateKeyPath)=Is a document:K24:1;"private key file \""+$vt_privateKeyPath+"\" not found")
	
	acme__log (4;Current method name:C684;"account does not exist, files \""+$vt_accountFilePath+"\" and \""+$vt_httpRequestFilePath+"\" not found. Calculating modulus and exponent from private key file \""+$vt_privateKeyPath+"\" and setting \"jwk\" property")
	
	  // create a jwk object with private key modulus and exponent
	C_OBJECT:C1216($vo_jwk)
	OB SET:C1220($vo_jwk;"kty";"RSA")
	OB SET:C1220($vo_jwk;"n";UTL_base64UrlSafeEncode (acme__keyPrivModulusGet ($vt_privateKeyPath)))
	OB SET:C1220($vo_jwk;"e";UTL_base64UrlSafeEncode (acme__keyPrivExponentGet ($vt_privateKeyPath)))
	
	OB SET:C1220($vo_object;"jwk";$vo_jwk)
End if 