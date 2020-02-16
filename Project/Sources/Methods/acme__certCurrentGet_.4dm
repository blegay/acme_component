//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certCurrentGet
  //@scope : public
  //@deprecated : no
  //@description : This function loads the current key and certificate
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-OUT-keyPtr-POINTER] : key pem text or blob pointer (modified)
  //@parameter[2-OUT-certPtr-POINTER] : certificate pem text or blob pointer (modified)
  //@notes : 
  //@example : Méthode 158
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/01/2019, 22:09:21 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_POINTER:C301($1;$vp_keyPtr)
C_POINTER:C301($2;$vp_certPtr)

ASSERT:C1129(Count parameters:C259>1;"expecting 2 parameters")
ASSERT:C1129(Not:C34(Is nil pointer:C315($1));"$1 should not be nil")
ASSERT:C1129(Not:C34(Is nil pointer:C315($2));"$2 should not be nil")
ASSERT:C1129(Type:C295($1->)=Type:C295($2->);"$1 and $2 should be of same type")
ASSERT:C1129((Type:C295($1->)=Is BLOB:K8:12) | (Type:C295($1->)=Is text:K8:3);"$1 should be a text or blob pointer")

$vb_ok:=False:C215

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vp_keyPtr:=$1
	$vp_certPtr:=$2
	
	Case of 
		: ((Type:C295($vp_keyPtr->)=Is BLOB:K8:12))
			
			SET BLOB SIZE:C606($vp_keyPtr->;0)
			SET BLOB SIZE:C606($vp_certPtr->;0)
			
			C_TEXT:C284($vt_4dCertDir)
			$vt_4dCertDir:=acme_certActiveDirPathGet 
			
			C_TEXT:C284($vt_keyPath;$vt_certPath)
			$vt_keyPath:=$vt_4dCertDir+"key.pem"
			$vt_certPath:=$vt_4dCertDir+"cert.pem"
			
			If (Test path name:C476($vt_keyPath)=Is a document:K24:1)
				DOCUMENT TO BLOB:C525($vt_keyPath;$vp_keyPtr->)
				
				  //-----BEGIN RSA PRIVATE KEY-----
				  // <base64 data>
				  //-----END RSA PRIVATE KEY-----
				
				  // "^[^-A-Za-z0-9+/=]|=[^=]|={3,}$"
				
				$vb_ok:=True:C214
			End if 
			
			If (Test path name:C476($vt_certPath)=Is a document:K24:1)
				DOCUMENT TO BLOB:C525($vt_certPath;$vp_certPtr->)
				
				  //-----BEGIN CERTIFICATE-----
				  // <base64 data>
				  //-----END CERTIFICATE-----
				  //-----BEGIN CERTIFICATE-----
				  // <base64 data>
				  //-----END CERTIFICATE-----
				
			Else 
				$vb_ok:=False:C215
			End if 
			
		: ((Type:C295($vp_keyPtr->)=Is text:K8:3))
			C_BLOB:C604($vx_key;$vx_cert)
			SET BLOB SIZE:C606($vx_key;0)
			SET BLOB SIZE:C606($vx_cert;0)
			
			$vb_ok:=acme_certCurrentGet (->$vx_key;->$vx_cert)
			
			$vp_keyPtr->:=Convert to text:C1012($vx_key;"UTF-8")
			$vp_certPtr->:=Convert to text:C1012($vx_cert;"UTF-8")
			
			SET BLOB SIZE:C606($vx_key;0)
			SET BLOB SIZE:C606($vx_cert;0)
			
	End case 
	
End if 

$0:=$vb_ok

