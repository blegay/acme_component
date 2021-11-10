//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
//================================================================================
//@xdoc-start : en
//@name : acme_certificateInstall
//@scope : public
//@deprecated : no
//@description : This function will install the private key and certificate files in the active directory
//@parameter[0-OUT-ok-BOOLEAN] : TRUE if OK, FALSE otherwise
//@parameter[1-IN-privateKeyPath-TEXT] : private key path
//@parameter[2-IN-certPath-TEXT] : certificate path
//@parameter[3-IN-certDir-TEXT] : 4D cert dir (optional, default acme_certActiveDirPathGet)
//@notes : 
//@example : acme_certificateInstall
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 03/07/2018, 09:03:04 - 1.0
//@xdoc-end
//================================================================================

C_BOOLEAN:C305($0; $vb_ok)
C_TEXT:C284($1; $vt_privateKeyPath)
C_TEXT:C284($2; $vt_certPath)
C_TEXT:C284($3; $vt_4dCertDir)

ASSERT:C1129(Count parameters:C259>1; "requires 2 parameters")
//ASSERT(Tester chemin acces($1)=Est un document;"$1 (\""+$1+"\") private key file not found")
//ASSERT(Tester chemin acces($2)=Est un document;"$2 (\""+$2+"\") certificate file not found")

$vb_ok:=False:C215
$vt_privateKeyPath:=$1
$vt_certPath:=$2

If (Count parameters:C259>2)
	$vt_4dCertDir:=$3
Else 
	// dir where to set the certificates
	$vt_4dCertDir:=acme_certActiveDirPathGet
End if 

C_BOOLEAN:C305($vt_privateKeyFileOk; $vb_certFileOk)
$vt_privateKeyFileOk:=(Test path name:C476($vt_privateKeyPath)=Is a document:K24:1)
$vb_certFileOk:=(Test path name:C476($vt_certPath)=Is a document:K24:1)

ASSERT:C1129($vt_privateKeyFileOk; "private key file ($1) \""+$vt_privateKeyPath+"\" not found !")
ASSERT:C1129($vb_certFileOk; "certificate file ($2) \""+$vt_certPath+"\" not found !")

If ($vb_certFileOk & $vt_privateKeyFileOk)
	
	C_TEXT:C284($vt_archiveDir)
	$vt_archiveDir:=$vt_4dCertDir+"archives"+Folder separator:K24:12
	
	C_TEXT:C284($vt_certDest)
	$vt_certDest:=$vt_4dCertDir+"cert.pem"
	acme__archiveFile($vt_certDest; $vt_archiveDir)
	COPY DOCUMENT:C541($vt_certPath; $vt_certDest)
	$vb_ok:=(ok=1)
	ASSERT:C1129($vb_ok; "error copying file \""+$vt_certPath+"\" to \""+$vt_certDest+"\"")
	
	If ($vb_ok)
		
		C_TEXT:C284($vt_privKeyDest)
		$vt_privKeyDest:=$vt_4dCertDir+"key.pem"
		acme__archiveFile($vt_privKeyDest; $vt_archiveDir)
		COPY DOCUMENT:C541($vt_privateKeyPath; $vt_privKeyDest)
		$vb_ok:=(ok=1)
		ASSERT:C1129($vb_ok; "error copying file \""+$vt_privateKeyPath+"\" to \""+$vt_privKeyDest+"\"")
		
		If ($vb_ok)
			acme__log(4; Current method name:C684; "new certificates installed. [OK]")
			acme__notify("4D http server : new certificates installed !")
		End if 
		
	End if 
	
Else 
	
	If (Not:C34($vb_certFileOk))
		acme__log(2; Current method name:C684; "certificate file \""+$vt_certPath+"\" not found. [KO]")
	End if 
	If (Not:C34($vt_privateKeyFileOk))
		acme__log(2; Current method name:C684; "private key file \""+$vt_privateKeyPath+"\" not found. [KO]")
	End if 
	
End if 

$0:=$vb_ok

