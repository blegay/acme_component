//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_rsaCertSelfSignedCreate
  //@scope : public
  //@deprecated : no
  //@description : This function generates a self signed certificate
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if OK, FALSE otherwise
  //@parameter[1-OUT-keyPtr-POINTER] : key (PEM format) text or blob pointer (modified)
  //@parameter[2-OUT-certPtr-POINTER] : cert (PEM format) text or blob pointer (modified)
  //@parameter[3-IN-csrObj-OBJECT] : csr object (see acme_csrReqConfObjectNew)
  //@parameter[4-IN-validity-LONGINT] : validity (number of days), optional default 365
  //@parameter[5-IN-keySize-LONGINT] : key size (optional, default 2048)
  //@notes : 
  //@example : 
  //
  // C_OBJET($vo_csrObj)
  // OB FIXER($vo_csrObj;"CN";"www.example.com")
  //
  // C_OBJET($vo_csrReqConfObject)
  // $vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_csrObj)
  //
  // C_TEXTE($vt_key;$vt_cert)
  // Si (acme_rsaCertSelfSignedCreate (->$vt_key;->$vt_cert;$vo_csrReqConfObject;3650))
  //   acme_certificateAsTextInstall ($vt_key;$vt_cert)
  // Fin de si
  //
  //     csr conf object ==>  
  //
  //     {
  //       "req": {
  //         "default_bits": 2048,
  //         "prompt": false,
  //         "default_md": "sha256",
  //         "distinguished_name": "dn"
  //       },
  //       "dn": {
  //         "CN": "www.example.com"
  //       }
  //     }
  //     
  //     openssl csr conf file ==>  
  //   
  //     [req]
  //     default_bits = 2048
  //     prompt = no
  //     default_md = sha256
  //     distinguished_name = dn
  //     
  //     [dn]
  //     CN = www.example.com
  //
  //
  // a more complex certificates (with alternative names)
  //
  // C_TEXTE($vt_key;$vt_cert)
  //
  // C_OBJET($vo_csrObj)
  // OB FIXER($vo_csrObj;"C";"FR")
  // OB FIXER($vo_csrObj;"L";"Paris")
  // OB FIXER($vo_csrObj;"ST";"Paris (75)")
  // OB FIXER($vo_csrObj;"O";"AC Consulting")
  // OB FIXER($vo_csrObj;"OU";"AC Consulting")
  // OB FIXER($vo_csrObj;"emailAddress";"john@example.com")
  // OB FIXER($vo_csrObj;"CN";"www.example.com")
  //
  // // C_OBJET($vo_altNames)
  // // OB FIXER($vo_altNames;"DNS.1";"api.example.com")
  // // OB FIXER($vo_altNames;"DNS.2";"status.example.com")
  //
  // TABLEAU TEXTE($tt_altNames;0)
  // AJOUTER À TABLEAU($tt_altNames;"api.example.com")
  // AJOUTER À TABLEAU($tt_altNames;"status.example.com")
  // $vo_altNames:=acme_csrAltnamesNew (->$tt_altNames)
  // TABLEAU TEXTE($tt_altNames;0)
  //
  // C_OBJET($vo_csrReqConfObject)
  // $vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_csrObj;$vo_altNames)
  //
  // C_TEXTE($vt_key;$vt_cert)
  // Si (acme_rsaCertSelfSignedCreate (->$vt_key;->$vt_cert;$vo_csrReqConfObject;3650))
  //   acme_certificateAsTextInstall ($vt_key;$vt_cert)
  // Fin de si
  // 
  //
  //     csr conf object ==>  
  //
  //     {
  //       "req": {
  //         "default_bits": 2048,
  //         "prompt": false,
  //         "default_md": "sha256",
  //         "req_extensions": "req_ext",
  //         "distinguished_name": "dn"
  //       },
  //       "dn": {
  //         "C": "FR",
  //         "L": "Paris",
  //         "ST": "Paris (75)",
  //         "O": "AC Consulting",
  //         "OU": "AC Consulting",
  //         "emailAddress": "john@example.com",
  //         "CN": "www.example.com"
  //       },
  //       "req_ext": {
  //         "subjectAltName": "@alt_names"
  //       },
  //       "alt_names": {
  //         "DNS.1": "api.example.com",
  //         "DNS.2": "status.example.com"
  //       }
  //     }
  //
  //     openssl csr conf file ==>  
  //
  //     [req]
  //     default_bits = 2048
  //     prompt = no
  //     default_md = sha256
  //     req_extensions = req_ext
  //     distinguished_name = dn
  //     
  //     [dn]
  //     C = FR
  //     L = Paris
  //     ST = Paris (75)
  //     O = AC Consulting
  //     OU = AC Consulting
  //     emailAddress = john@example.com
  //     CN = www.example.com
  //     
  //     [req_ext]
  //     subjectAltName = @alt_names
  //     
  //     [alt_names]
  //     DNS.1 = api.example.com
  //     DNS.2 = status.example.com
  //     
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/01/2019, 07:39:18 - 1.00.00
  //@xdoc-end
  //================================================================================

  // creates a self signed certificate and key
  // the private key is rsa 2048 bits
  // the certificate uses sha256
  // and will be valid for 365 days

  //$vt_subject:="/C=FR/L=Paris/O=A&C Consulting/CN=www.demo-ssl.com"
C_BOOLEAN:C305($0;$vb_ok)
C_POINTER:C301($1;$vp_keyPtr)
C_POINTER:C301($2;$vp_certPtr)
C_OBJECT:C1216($3;$vo_csrObj)
C_LONGINT:C283($4;$vl_validity)  // optional default is 365
C_LONGINT:C283($5;$vl_keySize)  // optional default is 2048
  //C_TEXTE($6;$vt_signature)

ASSERT:C1129(Count parameters:C259>1;"expecting 2 parameters")
ASSERT:C1129(Not:C34(Is nil pointer:C315($1));"$1 should not be nil")
ASSERT:C1129(Not:C34(Is nil pointer:C315($2));"$2 should not be nil")
ASSERT:C1129(Type:C295($1->)=Type:C295($2->);"$1 and $2 should be of same type")
ASSERT:C1129((Type:C295($1->)=Is BLOB:K8:12) | (Type:C295($1->)=Is text:K8:3);"$1 should be a text or blob pointer")

$vb_ok:=False:C215

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>2)
	$vp_keyPtr:=$1
	$vp_certPtr:=$2
	$vo_csrObj:=$3
	
	Case of 
		: ($vl_nbParam=3)
			$vl_validity:=365
			$vl_keySize:=2048
			
		: ($vl_nbParam=4)
			$vl_validity:=$4
			$vl_keySize:=2048
			
		Else 
			  //: ($vl_nbParam=5)
			$vl_validity:=$4
			$vl_keySize:=$5
			
	End case 
	
	If (False:C215)
		  // req [options] <infile >outfile
		  // where options  are
		  //  -inform arg    input format - DER or PEM
		  //  -outform arg   output format - DER or PEM
		  //  -in arg        input file
		  //  -out arg       output file
		  //  -text          text form of request
		  //  -pubkey        output public key
		  //  -noout         do not output REQ
		  //  -verify        verify signature on REQ
		  //  -modulus       RSA modulus
		  //  -nodes         don't encrypt the output key
		  //  -engine e      use engine e, possibly a hardware device
		  //  -subject       output the request's subject
		  //  -passin        private key password source
		  //  -key file      use the private key contained in file
		  //  -keyform arg   key file format
		  //  -keyout arg    file to send the key to
		  //  -rand file:file:...
		  //                 load the file (or the files in the directory) into
		  //                 the random number generator
		  //  -newkey rsa:bits generate a new RSA key of 'bits' in size
		  //  -newkey dsa:file generate a new DSA key, parameters taken from CA in 'file'
		  //  -newkey ec:file generate a new EC key, parameters taken from CA in 'file'
		  //  -[digest]      Digest to sign with (md5, sha1, md2, mdc2, md4)
		  //  -config file   request template file.
		  //  -subj arg      set or modify request subject
		  //  -multivalue-rdn enable support for multivalued RDNs
		  //  -new           new request.
		  //  -batch         do not ask anything during request generation
		  //  -x509          output a x509 structure instead of a cert. req.
		  //  -days          number of days a certificate generated by -x509 is valid for.
		  //  -set_serial    serial number to use for a certificate generated by -x509.
		  //  -newhdr        output "NEW" in the header lines
		  //  -asn1-kludge   Output the 'request' in a format that is wrong but some CA's
		  //                 have been reported as requiring
		  //  -extensions .. specify certificate extension section (override value in config file)
		  //  -reqexts ..    specify request extension section (override value in config file)
		  //  -utf8          input characters are UTF8 (default ASCII)
		  //  -nameopt arg    - various certificate name options
		  //  -reqopt arg    - various request text options
	End if 
	
	acme__init 
	
	
	ASSERT:C1129(Type:C295($vp_keyPtr->)=Type:C295($vp_certPtr->))
	
	Case of 
		: (Type:C295($vp_keyPtr->)=Is BLOB:K8:12)
			
			  //OB FIXER($vo_csrObj;"default_bits";$vl_keySize)
			  //OB FIXER($vo_csrObj;"default_md";$vt_signature)
			  //C_OBJET($vo_req)
			  //$vo_req:=OB Lire($vo_csrObj;"req")
			  //$vl_keySize:=OB Lire($vo_req;"default_bits";Est un entier long)
			  //$vt_signature:=OB Lire($vo_req;"default_md";Est un texte)
			  //EFFACER VARIABLE($vo_req)
			
			C_TEXT:C284($vt_structureDir)
			$vt_structureDir:=Temporary folder:C486  //cert__dirPath 
			
			C_TEXT:C284($vt_uuid)
			$vt_uuid:=Generate UUID:C1066
			
			C_TEXT:C284($vt_keyPath;$vt_certPath;$vt_confPath)
			$vt_keyPath:=$vt_structureDir+$vt_uuid+"-key-rsa.pem"
			$vt_certPath:=$vt_structureDir+$vt_uuid+"-cert-rsa.pem"
			$vt_confPath:=$vt_structureDir+$vt_uuid+"-cert.conf"
			
			C_TEXT:C284($vt_keyPathPosix;$vt_certPathPosix;$vt_confPathPosix)
			$vt_keyPathPosix:=UTL_pathToPosixConvert ($vt_keyPath)
			$vt_certPathPosix:=UTL_pathToPosixConvert ($vt_certPath)
			$vt_confPathPosix:=UTL_pathToPosixConvert ($vt_confPath)
			
			
			C_TEXT:C284($vt_csrConf)
			$vt_csrConf:=acme__csrReqConfObjectToText ($vo_csrObj)
			UTL_textToFile ($vt_confPath;$vt_csrConf)
			
			If (BLOB size:C605($vp_keyPtr->)=0)
				
				C_TEXT:C284($vt_cmd;$vt_in;$vt_out;$vt_err)
				If (True:C214)
					$vt_cmd:="req "+\
						" -new "+\
						" -days "+String:C10($vl_validity)+" "+\
						" -x509 "+\
						" -newkey rsa:"+String:C10($vl_keySize)+" "+\
						" -nodes "+\
						" -config "+$vt_confPathPosix+\
						" -keyout "+$vt_keyPathPosix+" "+\
						" -out "+$vt_certPathPosix
				Else 
					C_TEXT:C284($vt_signature;$vt_subject)
					$vt_cmd:="req "+\
						" -new "+\
						" -x509 "+\
						" -days "+String:C10($vl_validity)+" "+\
						" -"+$vt_signature+" "+\
						" -newkey rsa:"+String:C10($vl_keySize)+" "+\
						" -nodes "+\
						" -keyout "+$vt_keyPathPosix+" "+\
						" -subj '"+$vt_subject+"' "+\
						" -out "+$vt_certPathPosix
				End if 
				
				$vb_ok:=acme__openSslCmd ($vt_cmd;->$vt_in;->$vt_out;->$vt_err)
				ASSERT:C1129($vb_ok;"error "+$vt_err)
				
				If (Test path name:C476($vt_keyPath)=Is a document:K24:1)
					DOCUMENT TO BLOB:C525($vt_keyPath;$vp_keyPtr->)
				Else 
					SET BLOB SIZE:C606($vp_keyPtr->;0)
				End if 
				
				If (Test path name:C476($vt_keyPath)=Is a document:K24:1)
					DOCUMENT TO BLOB:C525($vt_certPath;$vp_certPtr->)
				Else 
					SET BLOB SIZE:C606($vp_certPtr->;0)
				End if 
				
			Else 
				BLOB TO DOCUMENT:C526($vt_keyPath;$vp_keyPtr->)
				
				C_TEXT:C284($vt_cmd;$vt_in;$vt_out;$vt_err)
				If (True:C214)
					$vt_cmd:="req "+\
						" -new "+\
						" -key "+$vt_keyPathPosix+" "+\
						" -x509 "+\
						" -days "+String:C10($vl_validity)+" "+\
						" -config "+$vt_confPathPosix+\
						" -out "+$vt_certPathPosix
					
				Else 
					C_TEXT:C284($vt_signature;$vt_subject)
					$vt_cmd:="req "+\
						" -new "+\
						" -key "+$vt_keyPathPosix+" "+\
						" -"+$vt_signature+" "+\
						" -x509 "+\
						" -days "+String:C10($vl_validity)+" "+\
						" -subj '"+$vt_subject+"' "+\
						" -out "+$vt_certPathPosix
				End if 
				
				$vb_ok:=acme__openSslCmd ($vt_cmd;->$vt_in;->$vt_out;->$vt_err)
				ASSERT:C1129($vb_ok;"error "+$vt_err)
				
				DOCUMENT TO BLOB:C525($vt_certPath;$vp_certPtr->)
				
			End if 
			DELETE DOCUMENT:C159($vt_keyPath)
			DELETE DOCUMENT:C159($vt_certPath)
			DELETE DOCUMENT:C159($vt_confPath)
			
		: (Type:C295($vp_keyPtr->)=Is text:K8:3)
			
			C_BLOB:C604($vx_key;$vx_cert)
			SET BLOB SIZE:C606($vx_key;0)
			SET BLOB SIZE:C606($vx_cert;0)
			
			C_BOOLEAN:C305($vb_newKey)
			$vb_newKey:=(Length:C16($vp_keyPtr->)=0)
			If (Not:C34($vb_newKey))
				CONVERT FROM TEXT:C1011($vp_keyPtr->;"us-ascii";$vx_key)
			End if 
			
			$vb_ok:=acme_rsaCertSelfSignedCreate (->$vx_key;->$vx_cert;$vo_csrObj;$vl_validity;$vl_keySize)
			
			If ($vb_newKey)
				$vp_keyPtr->:=Convert to text:C1012($vx_key;"us-ascii")
			End if 
			$vp_certPtr->:=Convert to text:C1012($vx_cert;"us-ascii")
			
			SET BLOB SIZE:C606($vx_key;0)
			SET BLOB SIZE:C606($vx_cert;0)
	End case 
	
End if 
$0:=$vb_ok
