//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_newOrderTest
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@notes :
  //@example : acme_newOrderTest
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 21:28:07 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($vt_directoryUrl)
  //$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
$vt_directoryUrl:="https://acme-staging-v02.api.letsencrypt.org/directory"


C_TEXT:C284($vt_workingDir)
$vt_workingDir:=FS_pathToParent (Get 4D folder:C485(Database folder:K5:14;*))
SHOW ON DISK:C922($vt_workingDir)
  // when called from a host database, will return the path to folder containing the "letsencrypt" directory (where preference data will be stored)
  // Macintosh HD:Users:ble:Documents:Projets:BaseRef_v15:acme_component:source:

ARRAY TEXT:C222($tt_domain;0)
APPEND TO ARRAY:C911($tt_domain;"test-ssl.example.com")
APPEND TO ARRAY:C911($tt_domain;"test1-ssl.example.com")
APPEND TO ARRAY:C911($tt_domain;"test2-ssl.example.com")
APPEND TO ARRAY:C911($tt_domain;"test3-ssl.example.com")

  // create a "newOrder" object
  // this is just initiating the "object" (no communication with letsencrypt at this stage)
C_OBJECT:C1216($vo_newOrderObject)
$vo_newOrderObject:=acme_newOrderObject (->$tt_domain;$vt_workingDir;$vt_directoryUrl)
  //$vo_newOrderObject:=acme_newOrderObject (->$tt_domain)

ARRAY TEXT:C222($tt_domain;0)

If (False:C215)
	
	ARRAY OBJECT:C1221($to_identifiers;0)
	
	  //C_OBJET($vo_identifier)
	  //OB FIXER($vo_identifier;"type";"dns")  // "A" type DNS record
	  //OB FIXER($vo_identifier;"value";"test-ssl.example.com")
	
	  //OB FIXER($vo_identifier;"type";"dns")  // "CNAME" type DNS record
	  //OB FIXER($vo_identifier;"value";"test1-ssl.example.com")
	  //AJOUTER À TABLEAU($to_identifiers;$vo_identifier)
	
	  //OB FIXER($vo_identifier;"type";"dns")  // "CNAME" type DNS record
	  //OB FIXER($vo_identifier;"value";"test2-ssl.example.com")
	  //AJOUTER À TABLEAU($to_identifiers;$vo_identifier)
	
	  //OB FIXER TABLEAU
	  //OB FIXER($vo_identifier;"type";"dns")  // "CNAME" type DNS record
	  //OB FIXER($vo_identifier;"value";"test3-ssl.example.com")
	  //AJOUTER À TABLEAU($to_identifiers;$vo_identifier)
	
	APPEND TO ARRAY:C911($to_identifiers;acme_identifierObjectNew ("dns";"test-ssl.example.com"))
	APPEND TO ARRAY:C911($to_identifiers;acme_identifierObjectNew ("dns";"test1-ssl.example.com"))
	APPEND TO ARRAY:C911($to_identifiers;acme_identifierObjectNew ("dns";"test2-ssl.example.com"))
	APPEND TO ARRAY:C911($to_identifiers;acme_identifierObjectNew ("dns";"test3-ssl.example.com"))
	
	
	OB SET ARRAY:C1227($vo_payload;"identifiers";$to_identifiers)
	  //OB FIXER($vo_payload;"notBefore";acme__dateFormatIso8601 ($vd_today))
	  //OB FIXER($vo_payload;"notAfter";acme__dateFormatIso8601 ($vd_today+10))
	
End if 


  // get the account key dir path
  //C_TEXTE($vt_accountKeyDir)
  //$vt_accountKeyDir:=acme__accountInit ($vt_workingDir;$vt_directoryUrl)
  //$vt_accountKeyDir:=acme__accountInit

C_TEXT:C284($vt_id)
C_OBJECT:C1216($vo_order)
If (acme_newOrder ($vo_newOrderObject;->$vt_id;->$vo_order))
	  //acme__notify ("newOrder success")
	
	  //Si (acme_newOrder ($vt_directoryUrl;$vo_payload;->$vt_id;->$vo_order;$vt_workingDir))
	
	C_OBJECT:C1216($vo_dn)
	OB SET:C1220($vo_dn;"C";"FR")
	OB SET:C1220($vo_dn;"L";"Paris")
	OB SET:C1220($vo_dn;"ST";"Paris (75)")
	OB SET:C1220($vo_dn;"O";"AC Consulting")
	OB SET:C1220($vo_dn;"OU";"AC Consulting")
	OB SET:C1220($vo_dn;"emailAddress";"john@example.com")
	OB SET:C1220($vo_dn;"CN";"test-ssl.example.com")
	
	C_OBJECT:C1216($vo_altNames)
	OB SET:C1220($vo_altNames;"DNS.1";"test1-ssl.example.com")
	OB SET:C1220($vo_altNames;"DNS.2";"test2-ssl.example.com")
	OB SET:C1220($vo_altNames;"DNS.3";"test3-ssl.example.com")
	
	C_OBJECT:C1216($vo_csrReqConfObject)
	$vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_dn;$vo_altNames)
	
	
	
	
	C_TEXT:C284($vt_finalizeUrl)
	$vt_finalizeUrl:=OB Get:C1224($vo_order;"finalize")  //"https://acme-staging-v02.api.letsencrypt.org/acme/finalize/12345/6789"
	
	  //C_TEXTE($vt_orderDir)
	  //$vt_orderDir:=$vt_accountKeyDir+"_orders"+Séparateur dossier+$vt_id+Séparateur dossier\
		
	  //CRÉER DOSSIER($vt_orderDir;*)
	
	C_TEXT:C284($vt_orderDir)
	$vt_orderDir:=acme_orderDirPathGet ($vt_id)  //;$vt_workingDir;$vt_directoryUrl)
	  //$vt_orderDir:=acme_orderDirPathGet($vt_id)
	
	acme_rsakeyPairGenerate ($vt_orderDir)
	
	
	
	  //C_TEXTE($vt_timestamp)
	  //$vt_timestamp:=acme__timestamp 
	
	  //C_TEXTE($vt_privateKeyPath;$vt_publicKeyPath)
	  //$vt_privateKeyPath:=$vt_orderDir+"key.pem"  //$vt_timestamp+"_csrkey.pem"
	  //$vt_publicKeyPath:=$vt_orderDir+"key.pub"  //$vt_timestamp+"_csrkey.pub"
	
	  //  // re-generate a key pair for every csr
	  //C_TEXTE($vt_archiveDir)
	  //$vt_archiveDir:=$vt_orderDir+"archives"+Séparateur dossier
	  //acme__archiveFile ($vt_privateKeyPath;$vt_archiveDir)
	  //acme__archiveFile ($vt_publicKeyPath;$vt_archiveDir)
	
	  //  // generate an RSA keypair to sign the csr
	  //Si (Vrai)  //(Tester chemin acces($vt_privateKeyPath)#Est un document)  // | (Tester chemin acces($vt_publicKeyPath)#Est un document))
	  //C_BLOB($vx_keyPrivBlob;$vx_keyPubBlob)
	  //FIXER TAILLE BLOB($vx_keyPrivBlob;0)
	  //FIXER TAILLE BLOB($vx_keyPubBlob;0)
	
	  //C_ENTIER LONG($vl_size)
	  //$vl_size:=2048
	  //  //acme__moduleDebugDateTimeLine (4;Nom méthode courante;"generating key pair ("+Chaîne($vl_size)+" bits)...")
	  //acme__keyPairRsaGenerate (->$vx_keyPrivBlob;->$vx_keyPubBlob;$vl_size)
	
	  //BLOB VERS DOCUMENT($vt_privateKeyPath;$vx_keyPrivBlob)
	  //BLOB VERS DOCUMENT($vt_publicKeyPath;$vx_keyPubBlob)
	  //acme__keyFileProtect ($vt_privateKeyPath)
	
	  //FIXER TAILLE BLOB($vx_keyPrivBlob;0)
	  //FIXER TAILLE BLOB($vx_keyPubBlob;0)
	  //Fin de si 
	
	  // generate the csr in DER (binary) format and sign it with the private RSA key
	C_BLOB:C604($vx_csr)
	C_TEXT:C284($vt_privateKeyPath)
	If (acme__opensslCsrNew ($vo_csrReqConfObject;$vt_privateKeyPath;->$vx_csr))
		
		  // save the csr in DER (binary) format
		If (True:C214)
			C_TEXT:C284($vt_csrFile;$vt_archiveDir)
			$vt_csrFile:=$vt_orderDir+"csr.der"
			acme__archiveFile ($vt_csrFile;$vt_archiveDir)
			BLOB TO DOCUMENT:C526($vt_csrFile;$vx_csr)
		End if 
		
		  // save the csr in PEM (text) format
		If (True:C214)
			C_TEXT:C284($vt_csrPem)
			acme__opensslCsrConvertFormat (->$vx_csr;->$vt_csrPem)
			
			$vt_csrFile:=$vt_orderDir+"csr.pem"
			acme__archiveFile ($vt_csrFile;$vt_archiveDir)
			UTL_textToFile ($vt_csrFile;$vt_csrPem)
		End if 
		
		  //MONTRER SUR DISQUE($vt_csrFile)
		
		  // encode the csr in DER (binary) format into base64UrlSafe
		C_OBJECT:C1216($vo_payload)
		OB SET:C1220($vo_payload;"csr";UTL_base64UrlSafeEncode ($vx_csr))
		
		  // send the csr and 
		C_OBJECT:C1216($vo_finalized)
		$vo_finalized:=acme_orderFinalize ($vt_finalizeUrl;$vo_payload)
		If (OB Is defined:C1231($vo_finalized))
			C_TEXT:C284($vt_certificateUrl)
			$vt_certificateUrl:=OB Get:C1224($vo_finalized;"certificate")
			
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
			
			acme_certificateGetAndInstall ($vt_certificateUrl;$vt_orderDir)
			
			  //C_TEXTE($vt_certificate)
			  //Si (acme_certificateGet ($vt_certificateUrl;->$vt_certificate))
			
			  //C_TEXTE($vt_certPath)
			  //$vt_certPath:=$vt_orderDir+"cert.pem"
			  //$vt_archiveDir:=$vt_orderDir+"archives"+Séparateur dossier
			  //acme__archiveFile ($vt_certPath;$vt_archiveDir)
			  //UTL_textToFile ($vt_certPath;$vt_certificate)
			
			  //acme_certificateInstall ($vt_privateKeyPath;$vt_certPath)
			
			  //acme__webServerRestart 
			
			  //Fin de si 
			
			  //ALERTE($vt_certificate)
			
			  //C_BLOB($vx_certificate)
			  //FIXER TAILLE BLOB($vx_certificate;0)
			  //ASSERT(HTTP Get($vt_certificateUrl;$vx_certificate)=200)
			  //ALERTE(Convertir vers texte($vx_certificate;"utf-8"))
			  //FIXER TAILLE BLOB($vx_certificate;0)
			
		End if 
		
	Else   // error generating csr
		
	End if 
End if 
