//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : acme_pemFormatChainToArray
  //@scope : public
  //@deprecated : no
  //@description : This method parse a pem data (a certificate chain for instance) into a pem array
  //@parameter[1-IN-pem-TEXT] : pem data
  //@parameter[2-OUT-pemDataArrPtr-POINTER] : pem type array pointer (modified)
  //@parameter[3-OUT-pemTypeArrPtr-POINTER] : pem type array pointer (modified)
  //@notes :
  //   # define PEM_STRING_X509_OLD     "X509 CERTIFICATE"
  //   # define PEM_STRING_X509         "CERTIFICATE"
  //   # define PEM_STRING_X509_TRUSTED "TRUSTED CERTIFICATE"
  //   # define PEM_STRING_X509_REQ_OLD "NEW CERTIFICATE REQUEST"
  //   # define PEM_STRING_X509_REQ     "CERTIFICATE REQUEST"
  //   # define PEM_STRING_X509_CRL     "X509 CRL"
  //   # define PEM_STRING_EVP_PKEY     "ANY PRIVATE KEY"
  //   # define PEM_STRING_PUBLIC       "PUBLIC KEY"
  //   # define PEM_STRING_RSA          "RSA PRIVATE KEY"
  //   # define PEM_STRING_RSA_PUBLIC   "RSA PUBLIC KEY"
  //   # define PEM_STRING_DSA          "DSA PRIVATE KEY"
  //   # define PEM_STRING_DSA_PUBLIC   "DSA PUBLIC KEY"
  //   # define PEM_STRING_PKCS7        "PKCS7"
  //   # define PEM_STRING_PKCS7_SIGNED "PKCS #7 SIGNED DATA"
  //   # define PEM_STRING_PKCS8        "ENCRYPTED PRIVATE KEY"
  //   # define PEM_STRING_PKCS8INF     "PRIVATE KEY"
  //   # define PEM_STRING_DHPARAMS     "DH PARAMETERS"
  //   # define PEM_STRING_DHXPARAMS    "X9.42 DH PARAMETERS"
  //   # define PEM_STRING_SSL_SESSION  "SSL SESSION PARAMETERS"
  //   # define PEM_STRING_DSAPARAMS    "DSA PARAMETERS"
  //   # define PEM_STRING_ECDSA_PUBLIC "ECDSA PUBLIC KEY"
  //   # define PEM_STRING_ECPARAMETERS "EC PARAMETERS"
  //   # define PEM_STRING_ECPRIVATEKEY "EC PRIVATE KEY"
  //   # define PEM_STRING_PARAMETERS   "PARAMETERS"
  //   # define PEM_STRING_CMS          "CMS"
  //@example : acme_pemFormatChainToArray 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 13/02/2020, 18:37:10 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_pem)
C_POINTER:C301($2;$vp_pemDataArrPtr)
C_POINTER:C301($3;$vp_pemTypeArrPtr)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(Type:C295($2->)=Text array:K8:16;"$2 should be a text array")
ASSERT:C1129(Type:C295($3->)=Text array:K8:16;"$3 should be a text array")

$vt_pem:=$1
$vp_pemDataArrPtr:=$2
$vp_pemTypeArrPtr:=$3

  // make everything "\n"
C_TEXT:C284($vt_lineSepOriginal)
$vt_lineSepOriginal:=TXT_lineSepGet ($vt_pem)
If ($vt_lineSepOriginal#"\n")
	$vt_pem:=Replace string:C233($vt_pem;$vt_lineSepOriginal;"\n";*)
End if 

C_TEXT:C284($vt_pemTypeKey)
$vt_pemTypeKey:=\
"X509 CERTIFICATE|"+\
"CERTIFICATE|"+\
"TRUSTED CERTIFICATE|"+\
"NEW CERTIFICATE REQUEST|"+\
"CERTIFICATE REQUEST|"+\
"X509 CRL|"+\
"ANY PRIVATE KEY|"+\
"PUBLIC KEY|"+\
"RSA PRIVATE KEY|"+\
"RSA PUBLIC KEY|"+\
"DSA PRIVATE KEY|"+\
"DSA PUBLIC KEY|"+\
"PKCS7|"+\
"PKCS #7 SIGNED DATA|"+\
"ENCRYPTED PRIVATE KEY|"+\
"PRIVATE KEY|"+\
"DH PARAMETERS|"+\
"X9\\.42 DH PARAMETERS|"+\
"SSL SESSION PARAMETERS|"+\
"DSA PARAMETERS|"+\
"ECDSA PUBLIC KEY|"+\
"EC PARAMETERS|"+\
"EC PRIVATE KEY|"+\
"PARAMETERS|"+\
"CMS"

ARRAY TEXT:C222($tt_pemData;0)
ARRAY TEXT:C222($tt_pemType;0)

If (Length:C16($vt_pem)>0)
	C_TEXT:C284($vt_regexStart)
	$vt_regexStart:="(?m)-----BEGIN ("+$vt_pemTypeKey+")-----\n"  //"(.*)+\n-----END ("+$vt_pemTypeKey+")-----"
	
	C_LONGINT:C283($vl_start)
	$vl_start:=1
	
	ARRAY LONGINT:C221($tl_pos;0)
	ARRAY LONGINT:C221($tl_len;0)
	
	  // find the next start tag
	While (Match regex:C1019($vt_regexStart;$vt_pem;$vl_start;$tl_pos;$tl_len))
		
		C_TEXT:C284($vt_tag)
		$vt_tag:=Substring:C12($vt_pem;$tl_pos{1};$tl_len{1})
		
		  // find the corresponding end tag
		C_TEXT:C284($vt_regexEnd)
		$vt_regexEnd:="\n-----END "+$vt_tag+"-----\n"
		
		$vl_start:=$tl_pos{0}+$tl_len{0}
		C_LONGINT:C283($vl_pos;$vl_len)
		If (Match regex:C1019($vt_regexEnd;$vt_pem;$vl_start;$vl_pos;$vl_len))
			
			  // get the text including the start and end tags
			C_TEXT:C284($vt_pemData;$vt_pemDataPure)
			$vt_pemData:=Substring:C12($vt_pem;$tl_pos{0};$vl_pos+$vl_len-$tl_pos{0})
			  // get the text without the tags (to check it is "clean")
			$vt_pemDataPure:=Substring:C12($vt_pem;$tl_pos{0}+$tl_len{0};$vl_pos-$tl_pos{0}-$tl_len{0})
			
			  // -----BEGIN RSA PRIVATE KEY-----
			  // Proc-Type: 4,ENCRYPTED
			  // DEK-Info: AES-256-CBC,D60C7F6
			  // 
			  // kDVqIxEbnN/jQp6429HeILy3vYqOWYUuKDlclHxC753JKitPn3Dfhg4g918osVqR
			  // ...
			  // 1Zxh2TRysMLLsiDmqxjMqLBU1RtZWrLJXAsGPtznTpPIEVsjSZbG8fe6/Q2pi1yW
			  // -----END RSA PRIVATE KEY-----
			
			
			If (Length:C16($vt_pemDataPure)>0)  // make sure the pem data is "clean"
				C_TEXT:C284($vt_regexCheck)
				$vt_regexCheck:="(?m)^(?:[-A-Za-z0-9+/ :,\n]+\n\n)?[-A-Za-z0-9+/\n]+$"
				  //$vt_regexCheck:="(?m)^[-A-Za-z0-9+/\n]+$"
				
				If (Match regex:C1019($vt_regexCheck;$vt_pemDataPure;1;*))
					
					If ($vt_lineSepOriginal#"\n")
						$vt_pemData:=Replace string:C233($vt_pemData;"\n";$vt_lineSepOriginal;*)
					End if 
					
					APPEND TO ARRAY:C911($tt_pemData;$vt_pemData)
					APPEND TO ARRAY:C911($tt_pemType;$vt_tag)
				End if 
			End if 
			
			$vl_start:=$vl_pos+$vl_len
		End if 
		
	End while 
	
	ARRAY LONGINT:C221($tl_pos;0)
	ARRAY LONGINT:C221($tl_len;0)
	
End if 

  //%W-518.1
COPY ARRAY:C226($tt_pemData;$vp_pemDataArrPtr->)
COPY ARRAY:C226($tt_pemType;$vp_pemTypeArrPtr->)
  //%W+518.1

ARRAY TEXT:C222($tt_pemData;0)
ARRAY TEXT:C222($tt_pemType;0)
