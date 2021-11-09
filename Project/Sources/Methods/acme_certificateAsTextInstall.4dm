//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certificateAsTextInstall
  //@scope : public
  //@deprecated : no
  //@description : This function dumps the certificates in the 4D cert location. It will also restart the 4D http/Web server
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-keyPem-TEXT] : key in pem format (without password protection)
  //@parameter[2-IN-certPem-TEXT] : certificate in pem format
  //@notes : If the Web Server is not runnning, it will be started 
  //@example : acme_certificateAsTextInstall
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/01/2019, 19:24:53 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_keyPem)
C_TEXT:C284($2;$vt_certPem)

ASSERT:C1129(Count parameters:C259>1)
ASSERT:C1129(Length:C16($1)>0;"$1 (key pem) is empty")
ASSERT:C1129(Length:C16($2)>0;"$2 (cert pem) is empty")

$vt_keyPem:=$1
$vt_certPem:=$2

  // dir where to set the certificates
C_TEXT:C284($vt_4dCertDir)
$vt_4dCertDir:=acme_certActiveDirPathGet 
If (Length:C16($vt_4dCertDir)>0)
	
	C_TEXT:C284($vt_keyPath;$vt_certPath)
	$vt_keyPath:=$vt_4dCertDir+"key.pem"
	$vt_certPath:=$vt_4dCertDir+"cert.pem"
	
	$vb_ok:=(UTL_textToFile ($vt_keyPath;$vt_keyPem) & UTL_textToFile ($vt_certPath;$vt_certPem))
	
	If ($vb_ok)  // both files are ok
		
		acme_webServerRestart 
		
	End if 
	
End if 
$0:=$vb_ok