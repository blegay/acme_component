//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certCurrentGet
  //@scope : public
  //@deprecated : no
  //@description : This function loads the current certificate and rsa private key (optional)
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-OUT-certPtr-POINTER] : certificate pem text or blob pointer (modified)
  //@parameter[2-OUT-keyPtr-POINTER] : key pem text or blob pointer (optional modified)
  //@notes : 
  // on standalone or server, certificates and rsa private key files are in the same folder as the structure file
  // on 4D Client, certificates and rsa private key files are next to the 4D executable file
  //@example :
  //
  //C_BOOLEAN($vb_renew)
  //$vb_renew:=False
  //
  //  // Load current certificates (and private key)
  // C_TEXT($vt_cert)
  // If(acme_certCurrentGet (->$vt_cert))
  //
  //   C_LONGINT($vl_nbDays;$vl_secs)
  //   $vl_nbDays:=30
  //   $vl_secs:=$vl_nbDays*86400  // 86400 = 24 x 60 x 60
  //
  //    // check if the certificate will expire
  //   $vb_renew:=acme_certCheckEnd ($vt_cert;$vl_secs)
  //   If($vb_renew)  // do some logs here...
  //
  //   End if
  //
  // Else  // no certificates
  //   $vb_renew:=True
  // End if
  //
  // If($vb_renew)
  //   cert_renew
  // End if 
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/01/2019, 22:09:21 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_POINTER:C301($1;$vp_certPtr)
C_POINTER:C301($2;$vp_keyPtr)

ASSERT:C1129(Count parameters:C259>0;"expecting 1 or more parameters")
ASSERT:C1129(Not:C34(Is nil pointer:C315($1));"$1 should not be nil")

ASSERT:C1129((Type:C295($1->)=Is BLOB:K8:12) | (Type:C295($1->)=Is text:K8:3);"$1 should be a text or blob pointer")

If (Count parameters:C259>1)
	ASSERT:C1129(Not:C34(Is nil pointer:C315($2));"$2 should not be nil")
	ASSERT:C1129(Type:C295($1->)=Type:C295($2->);"$1 and $2 should be of same type")
End if 

$vb_ok:=False:C215

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	$vp_certPtr:=$1
	
	If ($vl_nbParam>1)
		$vp_keyPtr:=$2
	End if 
	
	Case of 
		: ((Type:C295($vp_certPtr->)=Is BLOB:K8:12))
			
			  //<Modif> Bruno LEGAY (BLE) (30/09/2019)
			C_BOOLEAN:C305($vb_loadKey)
			$vb_loadKey:=($vl_nbParam>1)
			  //<Modif>
			
			SET BLOB SIZE:C606($vp_certPtr->;0)
			If ($vl_nbParam>1)
				SET BLOB SIZE:C606($vp_keyPtr->;0)
			End if 
			
			C_TEXT:C284($vt_4dCertDir)
			$vt_4dCertDir:=acme_certActiveDirPathGet 
			
			C_TEXT:C284($vt_keyPath;$vt_certPath)
			$vt_keyPath:=$vt_4dCertDir+"key.pem"
			$vt_certPath:=$vt_4dCertDir+"cert.pem"
			
			If (Test path name:C476($vt_certPath)=Is a document:K24:1)
				DOCUMENT TO BLOB:C525($vt_certPath;$vp_certPtr->)
				ASSERT:C1129(ok=1;"error loading file \""+$vt_certPath+"\"")
				acme__moduleDebugDateTimeLine (Choose:C955(ok=1;4;2);Current method name:C684;"loading file \""+$vt_certPath+"\". "+Choose:C955(ok=1;"[OK]";"[KO]"))
				
				  //-----BEGIN CERTIFICATE-----
				  // <base64 data>
				  //-----END CERTIFICATE-----
				  //-----BEGIN CERTIFICATE-----
				  // <base64 data>
				  //-----END CERTIFICATE-----
				
				C_BOOLEAN:C305($vb_valid)
				$vb_valid:=acme__pemFormatCheck ($vp_certPtr;"CERTIFICATE";True:C214)
				ASSERT:C1129($vb_valid;"invalid certificate PEM file")
				If (Not:C34($vb_valid))
					acme__moduleDebugDateTimeLine (Choose:C955($vb_valid;4;2);Current method name:C684;"file \""+$vt_certPath+"\" : pem is "+Choose:C955($vb_valid;"valid. [OK]";"invalid. [KO]"))
				End if 
				
				$vb_ok:=True:C214
			Else 
				acme__moduleDebugDateTimeLine (2;Current method name:C684;"certificate file \""+$vt_certPath+"\" : file not found. [KO]")
			End if 
			
			  //<Modif> Bruno LEGAY (BLE) (30/09/2019)
			If ($vb_loadKey)
				If (Test path name:C476($vt_keyPath)=Is a document:K24:1)
					  //Si ((Tester chemin acces($vt_keyPath)=Est un document) & ($vl_nbParam>1))
					  //<Modif>
					
					DOCUMENT TO BLOB:C525($vt_keyPath;$vp_keyPtr->)
					ASSERT:C1129(ok=1;"error loading file \""+$vt_keyPath+"\"")
					acme__moduleDebugDateTimeLine (Choose:C955(ok=1;4;2);Current method name:C684;"loading file \""+$vt_keyPath+"\". "+Choose:C955(ok=1;"[OK]";"[KO]"))
					
					  //-----BEGIN RSA PRIVATE KEY-----
					  // <base64 data>
					  //-----END RSA PRIVATE KEY-----
					
					C_BOOLEAN:C305($vb_valid)
					$vb_valid:=acme__pemFormatCheck ($vp_keyPtr;"RSA PRIVATE KEY";True:C214)
					ASSERT:C1129($vb_valid;"invalid RSA private key PEM file")
					If (Not:C34($vb_valid))
						acme__moduleDebugDateTimeLine (Choose:C955($vb_valid;4;2);Current method name:C684;"file \""+$vt_keyPath+"\" : pem is "+Choose:C955($vb_valid;"valid. [OK]";"invalid. [KO]"))
					End if 
					
				Else 
					acme__moduleDebugDateTimeLine (2;Current method name:C684;"rsa private key file \""+$vt_keyPath+"\" : file not found. [KO]")
					$vb_ok:=False:C215
				End if 
				
				  //<Modif> Bruno LEGAY (BLE) (30/09/2019)
			End if 
			  //<Modif>
			
			
		: ((Type:C295($vp_certPtr->)=Is text:K8:3))
			
			C_BLOB:C604($vx_cert;$vx_key)
			SET BLOB SIZE:C606($vx_cert;0)
			SET BLOB SIZE:C606($vx_key;0)
			
			If ($vl_nbParam=1)
				$vb_ok:=acme_certCurrentGet (->$vx_cert)
			Else 
				$vb_ok:=acme_certCurrentGet (->$vx_cert;->$vx_key)
				
				  //<Modif> Bruno LEGAY (BLE) (06/09/2019) - v0.90.10
				If (BLOB size:C605($vx_key)=0)
					$vp_keyPtr->:=""
				Else 
					  //<Modif>
					
					$vp_keyPtr->:=Convert to text:C1012($vx_key;"UTF-8")
					ASSERT:C1129(ok=1;"error convertir utf8 blob to text (rsa private key in pem format)")
					
					  //<Modif> Bruno LEGAY (BLE) (06/09/2019) - v0.90.10
				End if 
				  //<Modif>
			End if 
			
			  //<Modif> Bruno LEGAY (BLE) (06/09/2019) - v0.90.10
			If (BLOB size:C605($vx_cert)=0)
				$vp_certPtr->:=""
			Else 
				  //<Modif>
				
				$vp_certPtr->:=Convert to text:C1012($vx_cert;"UTF-8")
				ASSERT:C1129(ok=1;"error convertir utf8 blob to text (certificate in pem format)")
				
				  //<Modif> Bruno LEGAY (BLE) (06/09/2019) - v0.90.10
			End if 
			  //<Modif>
			
			SET BLOB SIZE:C606($vx_cert;0)
			SET BLOB SIZE:C606($vx_key;0)
			
	End case 
	
End if 

$0:=$vb_ok

