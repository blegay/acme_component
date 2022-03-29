//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_csrGenerateAndSign
  //@scope : public
  //@deprecated : no
  //@description : This function creates the csr, calls the letsEncrypt "finalize" and retrieved the certificares and installs them
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if OK, FALSE otherwise
  //@parameter[1-IN-orderObject-OBJECT] : order object (see acme_newOrder $3)
  //@parameter[2-IN-csrReqConfObject-OBJECT] : csr object (see acme_csrReqConfObjectNew)
  //@parameter[3-IN-orderDir-TEXT] : order dir
  //@notes : 
  //@example : acme_csrGenerateAndSign
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 12/02/2019, 23:07:47 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_OBJECT:C1216($1;$vo_orderObject)
C_OBJECT:C1216($2;$vo_csrReqConfObject)
C_TEXT:C284($3;$vt_orderDir)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(OB Is defined:C1231($1);"$1 (order) is undefined")
ASSERT:C1129(OB Is defined:C1231($2);"$2 (csrObj) is undefined")
ASSERT:C1129(Test path name:C476($3)=Is a folder:K24:2;"$3 (order dir : \""+$3+"\") is not a directory")

$vb_ok:=False:C215
$vo_orderObject:=$1
$vo_csrReqConfObject:=$2
$vt_orderDir:=$3

C_BLOB:C604($vx_csr)
SET BLOB SIZE:C606($vx_csr;0)

C_TEXT:C284($vt_privateKeyPath)
$vt_privateKeyPath:=$vt_orderDir+"key.pem"
ASSERT:C1129(Test path name:C476($vt_privateKeyPath)=Is a document:K24:1;"private key path: \""+$vt_privateKeyPath+"\" : file not found")

acme__progressUpdate (20;"csrReqConfObjectNew")  //"Zertifikat Anforderung (CSR) erstellen")

  // create the csr (certificate request in a DER/binary form)
If (acme__opensslCsrNew ($vo_csrReqConfObject;$vt_privateKeyPath;->$vx_csr))
	
	acme__init 
	
	C_TEXT:C284($vt_workingDir;$vt_directoryUrl)
	$vt_workingDir:=acme_workingDirGet 
	$vt_directoryUrl:=acme_directoryUrlGet 
	
	
	C_TEXT:C284($vt_archiveDir)
	$vt_archiveDir:=$vt_orderDir+"archives"+Folder separator:K24:12
	
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
	
	acme__progressUpdate (52;"csrGenerateAndSign")  //"Zertifikat Anforderung abschließen")
	  //If ($vb_progress)
	  //Progress SET PROGRESS ($vl_progressID;50;"Zertifikat Anforderung abschließen";True)
	  //End if 
	
	  // base64 encode the csr in DER (binary) format into base64UrlSafe
	  // and add to to a payload object with property named "csr"
	C_OBJECT:C1216($vo_payload)
	OB SET:C1220($vo_payload;"csr";UTL_base64UrlSafeEncode ($vx_csr))
	
	  // get the finalizeUrl from the orderObject which was set acme_newOrder ($3)
	ASSERT:C1129(OB Is defined:C1231($vo_orderObject;"finalize");"\"finalize\" property not found in order object")
	
	C_TEXT:C284($vt_finalizeUrl)
	$vt_finalizeUrl:=OB Get:C1224($vo_orderObject;"finalize")
	
	  // send the csr and 
	C_OBJECT:C1216($vo_finalized)
	$vo_finalized:=acme_orderFinalize ($vt_finalizeUrl;$vo_payload)
	If (OB Is defined:C1231($vo_finalized))
		
		C_TEXT:C284($vt_certificateUrl)
		$vt_certificateUrl:=OB Get:C1224($vo_finalized;"certificate")
		
		$vb_ok:=acme_certificateGetAndInstall ($vt_certificateUrl;$vt_orderDir)
		
	End if 
	
End if 

SET BLOB SIZE:C606($vx_csr;0)
$0:=$vb_ok