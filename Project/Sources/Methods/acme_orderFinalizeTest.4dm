//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_testOrderFinalize
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@notes : 
  //@example : acme_testOrderFinalize
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 00:08:04 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($vt_directoryUrl)
$vt_directoryUrl:="https://acme-staging-v02.api.letsencrypt.org/directory"

C_TEXT:C284($vt_workingDir)
$vt_workingDir:=FS_pathToParent (Get 4D folder:C485(Database folder:K5:14;*))

  //C_TEXTE($vt_domain)
  //$vt_domain:="test-ssl.example.com"

C_OBJECT:C1216($vo_dn)
OB SET:C1220($vo_dn;"C";"FR")
OB SET:C1220($vo_dn;"L";"Paris")
OB SET:C1220($vo_dn;"ST";"Paris (75)")
OB SET:C1220($vo_dn;"O";"AC Consulting")
OB SET:C1220($vo_dn;"OU";"AC Consulting")
OB SET:C1220($vo_dn;"emailAddress";"john@example.com")
OB SET:C1220($vo_dn;"CN";"test-ssl.example.com")

C_TEXT:C284($vt_url)
$vt_url:="https://acme-staging-v02.api.letsencrypt.org/acme/finalize/6332152/2370753"

C_BLOB:C604($vx_keyPrivBlob;$vx_keyPubBlob)
SET BLOB SIZE:C606($vx_keyPrivBlob;0)
SET BLOB SIZE:C606($vx_keyPubBlob;0)

C_LONGINT:C283($vl_size)
$vl_size:=2048
  //acme__moduleDebugDateTimeLine (4;Nom méthode courante;"generating key pair ("+Chaîne($vl_size)+" bits)...")
acme__keyPairRsaGenerate (->$vx_keyPrivBlob;->$vx_keyPubBlob;$vl_size)

  // get the account key dir path
C_TEXT:C284($vt_accountKeyDir)
$vt_accountKeyDir:=acme__accountInit   // ($vt_workingDir;$vt_directoryUrl)

C_TEXT:C284($vt_timestamp)
$vt_timestamp:=acme__timestamp 

C_TEXT:C284($vt_privateKeyPath;$vt_publicKeyPath)
$vt_privateKeyPath:=$vt_accountKeyDir+$vt_timestamp+"_csrkey.pem"
$vt_publicKeyPath:=$vt_accountKeyDir+$vt_timestamp+"_csrkey.pub"
BLOB TO DOCUMENT:C526($vt_privateKeyPath;$vx_keyPrivBlob)
BLOB TO DOCUMENT:C526($vt_publicKeyPath;$vx_keyPubBlob)

SET BLOB SIZE:C606($vx_keyPrivBlob;0)
SET BLOB SIZE:C606($vx_keyPubBlob;0)

  // generate the csr in DER (binary) format
C_BLOB:C604($vx_csr)
If (acme__opensslCsrNew (acme_csrReqConfObjectNew ($vo_dn);$vt_privateKeyPath;->$vx_csr))
	
	C_OBJECT:C1216($vo_payload)
	OB SET:C1220($vo_payload;"csr";UTL_base64UrlSafeEncode ($vx_csr))
	
	C_OBJECT:C1216($vb_finalized)
	$vb_finalized:=acme_orderFinalize ($vt_url;$vo_payload)
	If (OB Is defined:C1231($vb_finalized))
		C_TEXT:C284($vt_certificateUrl)
		$vt_certificateUrl:=OB Get:C1224($vb_finalized;"certificate")
		
		  // HTTP/1.1 200 OK
		  // Server: nginx
		  // Content-Type: application/pem-certificate-chain
		  // Content-Length: 3863
		  // Replay-Nonce: xz2cb0XGLUADX-7smj-2tVRDFnLX4XH_MQMThrRe_Ho
		  // X-Frame-Options: DENY
		  // Strict-Transport-Security: max-age=604800
		  // Expires: Sat, 23 Jun 2018 07:04:31 GMT
		  // Cache-Control: max-age=0, no-cache, no-store
		  // Pragma: no-cache
		  // Date: Sat, 23 Jun 2018 07:04:31 GMT
		  // Connection: keep-alive
		
		C_TEXT:C284($vt_certificate)
		acme_certificateGet ($vt_certificateUrl;->$vt_certificate)
		ALERT:C41($vt_certificate)
		
		  //C_BLOB($vx_certificate)
		  //FIXER TAILLE BLOB($vx_certificate;0)
		  //ASSERT(HTTP Get($vt_certificateUrl;$vx_certificate)=200)
		  //ALERTE(Convertir vers texte($vx_certificate;"utf-8"))
		  //FIXER TAILLE BLOB($vx_certificate;0)
		
	End if 
	
Else   // error generation csr
	
End if 