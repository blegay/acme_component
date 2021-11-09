//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certificateGetAndInstall
  //@scope : public
  //@deprecated : no
  //@description : This function retrieves the certificate (from url), installs it and restarts 4D Web server
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-certificateUrl-TEXT] : url
  //@parameter[2-IN-orderDir-TEXT] : order directory
  //@notes : 
  //@example : acme_certificateGetAndInstall
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 09/10/2018, 08:41:27 - 1.0
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_certificateUrl)
C_TEXT:C284($2;$vt_orderDir)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")

ASSERT:C1129(Test path name:C476($2)=Is a folder:K24:2;"$2 (orderDir) does not exist")

$vb_ok:=False:C215
$vt_certificateUrl:=$1
$vt_orderDir:=$2

  // get the certificate in PEM format into $vt_certificate
C_TEXT:C284($vt_certificate)
$vb_ok:=acme_certificateGet ($vt_certificateUrl;->$vt_certificate)
If ($vb_ok)
	
	  // get the active certificate file path
	C_TEXT:C284($vt_certPath)
	$vt_certPath:=$vt_orderDir+"cert.pem"
	
	C_TEXT:C284($vt_archiveDir)
	$vt_archiveDir:=$vt_orderDir+"archives"+Folder separator:K24:12
	
	  // archive previous certificate ("cert.pem" file)
	acme__archiveFile ($vt_certPath;$vt_archiveDir)
	
	  // save new certificate into "cert.pem" file into order order dir
	UTL_textToFile ($vt_certPath;$vt_certificate)
	
	  // 
	C_TEXT:C284($vt_privateKeyPath)
	$vt_privateKeyPath:=$vt_orderDir+"key.pem"
	If (acme_certificateInstall ($vt_privateKeyPath;$vt_certPath))
		
		acme_webServerRestart 
		
	End if 
	
End if 

$0:=$vb_ok