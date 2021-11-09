//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_rsakeyPairGenerate
  //@scope : public
  //@deprecated : no
  //@description : This function creates a 2048 bits rsa key pair in a directory
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if OK, FALSE otherwise
  //@parameter[1-IN-dirPath-TEXT] : dir path (HFS on OS X, windows path on Windows). The directory must exist.
  //@notes : the files will be in PEM (text) format and will be named "key.pem" (private key) and "key.pub" (public key)
  //@example : acme_rsakeyPairGenerate
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 09/10/2018, 08:29:48 - 1.0
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_dirPath)

ASSERT:C1129(Count parameters:C259>0;"require 1 parameter")
ASSERT:C1129(Test path name:C476($1)=Is a folder:K24:2;"$1 (orderDir) does not exist")

$vt_dirPath:=$1

If (Length:C16($vt_dirPath)>0)
	If (Substring:C12($vt_dirPath;Length:C16($vt_dirPath);1)#Folder separator:K24:12)
		$vt_dirPath:=$vt_dirPath+Folder separator:K24:12
	End if 
End if 

C_TEXT:C284($vt_privateKeyPath;$vt_publicKeyPath)
$vt_privateKeyPath:=$vt_dirPath+"key.pem"  //$vt_timestamp+"_csrkey.pem"
$vt_publicKeyPath:=$vt_dirPath+"key.pub"  //$vt_timestamp+"_csrkey.pub"

  // generate an RSA keypair to sign the csr
If (True:C214)  //(Tester chemin acces($vt_privateKeyPath)#Est un document)  // | (Tester chemin acces($vt_publicKeyPath)#Est un document))
	C_BLOB:C604($vx_keyPrivBlob;$vx_keyPubBlob)
	SET BLOB SIZE:C606($vx_keyPrivBlob;0)
	SET BLOB SIZE:C606($vx_keyPubBlob;0)
	
	C_LONGINT:C283($vl_size)
	$vl_size:=2048
	
	acme__log (4;Current method name:C684;"creating an rsa "+String:C10($vl_size)+"bits key pair in \""+$vt_dirPath+"\"...")
	
	  //acme__moduleDebugDateTimeLine (4;Nom méthode courante;"generating key pair ("+Chaîne($vl_size)+" bits)...")
	If (acme__keyPairRsaGenerate (->$vx_keyPrivBlob;->$vx_keyPubBlob;$vl_size))
		
		  // if the files already exist, archive them
		C_TEXT:C284($vt_archiveDir)
		$vt_archiveDir:=$vt_dirPath+"archives"+Folder separator:K24:12+acme__timestamp +Folder separator:K24:12
		
		acme__archiveFile ($vt_privateKeyPath;$vt_archiveDir)
		acme__archiveFile ($vt_publicKeyPath;$vt_archiveDir)
		
		  // dump the new files
		BLOB TO DOCUMENT:C526($vt_privateKeyPath;$vx_keyPrivBlob)
		$vb_ok:=(ok=1)
		ASSERT:C1129($vb_ok;"failed writing file \""+$vt_privateKeyPath+"\"")
		
		If ($vb_ok)
			BLOB TO DOCUMENT:C526($vt_publicKeyPath;$vx_keyPubBlob)
			$vb_ok:=(ok=1)
			ASSERT:C1129($vb_ok;"failed writing file \""+$vt_publicKeyPath+"\"")
		End if 
		
		If ($vb_ok)
			  // try to protect the private key (chmod 600 on OS X)
			$vb_ok:=acme__keyFileProtect ($vt_privateKeyPath)
		End if 
		
	End if 
	
	SET BLOB SIZE:C606($vx_keyPrivBlob;0)
	SET BLOB SIZE:C606($vx_keyPubBlob;0)
End if 

$0:=$vb_ok