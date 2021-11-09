//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslCsrNew
  //@scope : private
  //@deprecated : no
  //@description : This function generates a binary certificat request (csr) signed with a private key
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if OK, FALSE otherwise
  //@parameter[1-IN-csrObj-OBJECT] : csr object (see acme_csrReqConfObjectNew)
  //@parameter[2-IN-privateKeyPath-TEXT] : private rsa key path (do not use the account private key)
  //@parameter[3-OUT-csrPtr-POINTER] : csr text (PEM format) or blob (DER format) pointer (modified)
  //@notes : 
  // do not use the account private key to avoid error "certificate public key must be different than account key"
  //@example : acme__opensslCsrNew
  //@see : acme_csrReqConfObjectNew
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 23:18:01 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_OBJECT:C1216($1;$vo_csrObj)
C_TEXT:C284($2;$vt_privateKeyPath)
C_POINTER:C301($3;$vp_csrPtr)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(OB Is defined:C1231($1);"$1 (csrObj) is undefined")
ASSERT:C1129(Test path name:C476($2)=Is a document:K24:1;"$2 private key file \""+$2+"\" not found")
ASSERT:C1129((Type:C295($3->)=Is text:K8:3) | (Type:C295($3->)=Is BLOB:K8:12);"$3 (csr) should be a text or blob pointer")
  //ASSERT(Longueur($2)>0;"$2 domain")

$vb_ok:=False:C215
SET BLOB SIZE:C606($vx_binaryCsr;0)
$vo_csrObj:=$1
$vt_privateKeyPath:=$2
$vp_csrPtr:=$3

C_TEXT:C284($vt_outForm)
If ((Type:C295($vp_csrPtr->)=Is text:K8:3))  // text format
	$vt_outForm:="PEM"
Else   // binary format
	$vt_outForm:="DER"
End if 
If (False:C215)  // sample config file
	  //" -config san.cnf"
	  // [req]
	  // default_bits = 2048
	  // prompt = no
	  // default_md = sha256
	  // req_extensions = req_ext
	  // distinguished_name = dn
	  // 
	  // [ dn ]
	  // C=US
	  // ST=New York
	  // L=Rochester
	  // O=End Point
	  // OU=Testing Domain
	  // emailAddress=your-administrative-address@your-awesome-existing-domain.com
	  // CN = www.your-new-domain.com
	  // 
	  // [ req_ext ]
	  // subjectAltName = @alt_names
	  // 
	  // [ alt_names ]
	  // DNS.1 = your-new-domain.com
	  // DNS.2 = www.your-new-domain.com
End if 

  // will use a temporary file for the config
C_TEXT:C284($vt_configPath)
$vt_configPath:=Temporary folder:C486+"openssl_config_"+Generate UUID:C1066+".cnf"
If (Test path name:C476($vt_configPath)=Is a document:K24:1)
	DELETE DOCUMENT:C159($vt_configPath)
End if 

C_TEXT:C284($vt_csrConf)
$vt_csrConf:=acme__csrReqConfObjectToText ($vo_csrObj)
UTL_textToFile ($vt_configPath;$vt_csrConf)

  // generate a new csr using a given rsa private key, using sha256 for the signature, output in PEM (text) or DER (binary) format
  // nodes = no DES i.e. the csr is not password encrypted
  // and using the configuration file we have just generated

C_TEXT:C284($vt_args)
$vt_args:="req -new"+" -key "+UTL_pathToPosixConvert ($vt_privateKeyPath)+" -sha256"+" -outform "+$vt_outForm+" -nodes"+" -config "+UTL_pathToPosixConvert ($vt_configPath)

C_TEXT:C284($vt_in;$vt_err)
$vt_in:=""
$vt_err:=""

  //<Modif> Bruno LEGAY (BLE) (22/07/2021)

  // try avoiding the "error/warning" on Windows 
  // 2021-07-22T05:48:02.060Z - acme - 04 - acme__openSslCmd ==> cmd ""C:\Users\bruno\myApp\Components\acme_component.4dbase\Resources\openssl\win64\openssl.exe" req 
  // -new 
  // -key "C:\Users\bruno\myApp\letsencrypt\org.letsencrypt.api.acme-v02\_orders\11332917651\key.pem" 
  // -sha256 
  // -outform DER 
  // -nodes 
  // -config "C:\Users\bruno\AppData\Local\Temp\openssl_config_442FD54E5118264BB9AFE54D814FD882.cnf"", in : "", out : "1225 byte(s)", err : "WARNING: can't open config file: /usr/local/ssl/openssl.cnf
  // ", duration : 0,496s success. [OK]

acme__opensslConfigDefault 
  //<Modif>

If (acme__openSslCmd ($vt_args;->$vt_in;$vp_csrPtr;->$vt_err))
	$vb_ok:=True:C214
	
	acme__log (4;Current method name:C684;"openssl generate "+$vt_outForm+" csr, csrObj :\r"+JSON Stringify:C1217($vo_csrObj;*)+"\r, config :\r"+$vt_csrConf+"\r csr :\r"+acme__opensslCsrToText ($vp_csrPtr))
	
	If (False:C215)  // for debugging
		  //%T-
		SET TEXT TO PASTEBOARD:C523(acme__opensslCsrToText ($vp_csrPtr))
		  //%T+
	End if 
	
Else 
	acme__log (2;Current method name:C684;"openssl failed to generate "+$vt_outForm+" csr, csrObj :\r"+JSON Stringify:C1217($vo_csrObj;*)+"\r, config :\r"+$vt_csrConf+"\r : "+$vt_err)
	ASSERT:C1129(False:C215;$vt_err)
End if 

  // cleanup temporary file
If (Test path name:C476($vt_configPath)=Is a document:K24:1)
	DELETE DOCUMENT:C159($vt_configPath)
End if 

$0:=$vb_ok