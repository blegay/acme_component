//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certToText
  //@scope : public
  //@deprecated : no
  //@description : This function returns text data about a private key, a csr, or certificate in PEM or DER format
  //@parameter[0-OUT-text-TEXT] : text
  //@parameter[1-IN-sourcePtr-POINTER] : source pointer (private key, csr, or certificate in PEM or DER format) (not modified)
  //@parameter[2-IN-param-TEXT] : "text", "startdate", "enddate" (optional, default "text")
  //@parameter[3-IN-inform-TEXT] : "PEM" or "DER" (optional, default "PEM" if $2 is text, "DER" if $2 is blob)
  //@notes : 
  // "startdate" => "notBefore=Jan 23 19:15:40 2019 GMT\n"
  // "enddate" => "notAfter=Jan 20 19:15:40 2029 GMT\n"
  // "text" => 
  //     Certificate:
  //         Data:
  //             Version: 1 (0x0)
  //             Serial Number:
  //                 9e:df:23:80:9f:8d:b7:0b
  //         Signature Algorithm: sha256WithRSAEncryption
  //             Issuer: C=FR, L=Paris, ST=Paris (75), O=AC Consulting, OU=AC Consulting/emailAddress=john@example.com, CN=www.example.com
  //             Validity
  //                 Not Before: Jan 23 19:15:40 2019 GMT
  //                 Not After : Jan 20 19:15:40 2029 GMT
  //             Subject: C=FR, L=Paris, ST=Paris (75), O=AC Consulting, OU=AC Consulting/emailAddress=john@example.com, CN=www.example.com
  //             Subject Public Key Info:
  //                 Public Key Algorithm: rsaEncryption
  //                     Public-Key: (2048 bit)
  //                     Modulus:
  //                         00:c4:0a:31:62:5f:a3:af:98:d5:61:87:00:50:7e:
  //                         .......
  //                         62:64:89:56:cd:be:4c:a7:ce:d3:7d:6d:3e:8b:0a:
  //                         73:d7
  //                     Exponent: 65537 (0x10001)
  //         Signature Algorithm: sha256WithRSAEncryption
  //              a7:cd:27:50:f8:b9:ea:2f:91:57:7f:97:f2:95:3d:fa:df:d0:
  //              .......
  //              c3:b9:94:e3:d9:fd:b3:dc:25:6d:04:86:3f:87:c8:93:3c:3c:
  //              ea:0e:54:24

  //@example : 

  // If (acme_certCurrentGet (->$vt_key;->$vt_cert))
  //   C_OBJECT($vo_certificateProperties)
  //   OB SET($vo_certificateProperties;"text";acme_certToText (->$vt_cert;"text"))
  //   OB SET($vo_certificateProperties;"dates";acme_certToText (->$vt_cert;"dates"))
  //   OB SET($vo_certificateProperties;"startdate";acme_certToText (->$vt_cert;"startdate"))
  //   OB SET($vo_certificateProperties;"enddate";acme_certToText (->$vt_cert;"enddate"))
  //   OB SET($vo_certificateProperties;"serial";acme_certToText (->$vt_cert;"serial"))
  //   OB SET($vo_certificateProperties;"hash";acme_certToText (->$vt_cert;"hash"))
  //   OB SET($vo_certificateProperties;"subject_hash";acme_certToText (->$vt_cert;"subject_hash"))
  //   OB SET($vo_certificateProperties;"issuer_hash";acme_certToText (->$vt_cert;"issuer_hash"))
  //   OB SET($vo_certificateProperties;"subject";acme_certToText (->$vt_cert;"subject"))
  //   OB SET($vo_certificateProperties;"issuer";acme_certToText (->$vt_cert;"issuer"))
  //   OB SET($vo_certificateProperties;"email";acme_certToText (->$vt_cert;"email"))
  //   OB SET($vo_certificateProperties;"purpose";acme_certToText (->$vt_cert;"purpose"))
  //   OB SET($vo_certificateProperties;"modulus";acme_certToText (->$vt_cert;"modulus"))
  //   OB SET($vo_certificateProperties;"fingerprint";acme_certToText (->$vt_cert;"fingerprint"))
  //   OB SET($vo_certificateProperties;"ocspid";acme_certToText (->$vt_cert;"ocspid"))
  //   OB SET($vo_certificateProperties;"ocsp_uri";acme_certToText (->$vt_cert;"ocsp_uri"))
  //   OB SET($vo_certificateProperties;"pubkey";acme_certToText (->$vt_cert;"pubkey"))
  //   OB SET($vo_certificateProperties;"alias";acme_certToText (->$vt_cert;"alias"))
  // End if
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/01/2019, 22:35:47 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_text)
C_POINTER:C301($1;$vp_inPtr)
C_TEXT:C284($2;$vt_param)
C_TEXT:C284($3;$vt_inform)

$vt_text:=""
$vp_inPtr:=$1

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
  //ASSERT(OB Est défini($1);"Undefined $1 object")
ASSERT:C1129((Type:C295($1->)=Is text:K8:3) | (Type:C295($1->)=Is BLOB:K8:12);"$1 should be a text or blob pointer")

C_BOOLEAN:C305($vb_ok)
$vb_ok:=False:C215
$vp_inPtr:=$1
  // openssl x509 -noout -text -in cert.pem

Case of 
	: (Count parameters:C259>2)
		$vt_param:=$2
		$vt_inform:=$3
		
	: (Count parameters:C259>1)
		$vt_param:=$2
		$vt_inform:=""
		
	Else 
		$vt_param:=""  //"text"
		$vt_inform:=""
End case 

If (($vt_inform="DER") | ($vt_inform="PEM"))
	$vt_inform:=Uppercase:C13($vt_inform)
Else 
	$vt_inform:=Choose:C955(Type:C295($vp_inPtr->)=Is BLOB:K8:12;"DER";"PEM")
End if 

$vt_param:=Lowercase:C14($vt_param)
Case of 
	: ($vt_param="text")
	: ($vt_param="startdate")
	: ($vt_param="enddate")
	: ($vt_param="dates")
	: ($vt_param="serial")
	: ($vt_param="hash")
	: ($vt_param="subject_hash")
	: ($vt_param="subject_hash_old")
	: ($vt_param="issuer_hash")
	: ($vt_param="issuer_hash_old")
	: ($vt_param="subject")
	: ($vt_param="issuer")
	: ($vt_param="email")
	: ($vt_param="purpose")
	: ($vt_param="modulus")
	: ($vt_param="fingerprint")
	: ($vt_param="ocspid")
	: ($vt_param="ocsp_uri")
	: ($vt_param="pubkey")
	: ($vt_param="alias")
	Else 
		
End case 

If (Length:C16($vt_param)=0)
	  //  -serial         - print serial number value
	  //  -subject_hash   - print subject hash value
	  //  -subject_hash_old   - print old-style (MD5) subject hash value
	  //  -issuer_hash    - print issuer hash value
	  //  -issuer_hash_old    - print old-style (MD5) issuer hash value
	  //  -subject        - print subject DN
	  //  -issuer         - print issuer DN
	  //  -email          - print email address(es)
	  //  -purpose        - print out certificate purposes
	  //  -modulus        - print the RSA key modulus
	  //  -fingerprint    - print the certificate fingerprint
	  //  -ocspid         - print OCSP hash values for the subject name and public key
	  //  -ocsp_uri       - print OCSP Responder URL(s)
	  //  -text           - print the certificate in text form
	  //  -C              - print out C code forms
	
	$vt_param:="text"
End if 

C_TEXT:C284($vt_args)
$vt_args:="x509 "+" -noout "+" -"+$vt_param+" "+" -inform "+$vt_inform

If (False:C215)
	C_TEXT:C284($vt_args;$vt_type)
	$vt_type:="x509"
	$vt_args:=$vt_type+" "+" -noout "+" -text "+" -inform "+Choose:C955(Type:C295($vp_inPtr->)=Is BLOB:K8:12;"DER";"PEM")
End if 

acme__opensslConfigDefault 

C_TEXT:C284($vt_err)
$vt_err:=""

If (acme__openSslCmd ($vt_args;$vp_inPtr;->$vt_text;->$vt_err))
	$vb_ok:=True:C214
	acme__log (4;Current method name:C684;"openssl "+$vt_args+" \r"+$vt_text+"\r [OK]")
Else 
	acme__log (2;Current method name:C684;"openssl "+$vt_args+" ("+$vt_err+"). [KO]")
	ASSERT:C1129(False:C215;$vt_err)
End if 

$0:=$vt_text