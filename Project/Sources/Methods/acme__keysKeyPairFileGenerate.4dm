//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__keysKeyPairFileGenerate
  //@scope : private
  //@deprecated : no
  //@description : This method methods generates key pair files "key.pub" and "key.pem"
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-$vt_certDir-TEXT] : dir where to store keypairs (e.g. "Macintosh HD:Users:ble:Documents:certs:", or if not used, will use host db home dir)
  //@notes : "key.pub" is the public key. "key.pem" is the private key. The key pair is generated in 2048 bits.
  //@example : acme__keysKeyPairFileGenerate
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 17:24:20 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_certDir)
C_TEXT:C284($2;$vt_filenamebase)

$vb_ok:=False:C215
If (Count parameters:C259>0)
	$vt_certDir:=$1
	
	If (Test path name:C476($vt_certDir)#Is a folder:K24:2)
		CREATE FOLDER:C475($vt_certDir;*)
	End if 
	
Else 
	  // get the host database database folder
	$vt_certDir:=Get 4D folder:C485(Database folder:K5:14;*)
End if 

If (Count parameters:C259>1)
	$vt_filenamebase:=$2
End if 

If (Length:C16($vt_filenamebase)=0)
	$vt_filenamebase:="key"
End if 

C_TEXT:C284($vt_keyPrivPath;$vt_keyPubPath)
$vt_keyPubPath:=$vt_certDir+$vt_filenamebase+".pub"
$vt_keyPrivPath:=$vt_certDir+$vt_filenamebase+".pem"

If ((Test path name:C476($vt_keyPubPath)=Is a document:K24:1) & \
(Test path name:C476($vt_keyPrivPath)=Is a document:K24:1))
	  // done
	
	$vb_ok:=True:C214
	
	acme__moduleDebugDateTimeLine (6;Current method name:C684;"files \""+$vt_keyPrivPath+"\" and \""+$vt_keyPubPath+"\" already exist (left untouched). [OK]")
	
Else 
	
	  // one or both files is missing, regenerate them
	C_BLOB:C604($vx_keyPrivBlob;$vx_keyPubBlob)
	SET BLOB SIZE:C606($vx_keyPrivBlob;0)
	SET BLOB SIZE:C606($vx_keyPubBlob;0)
	
	  // generate rsa key pairs (in pem format)
	C_LONGINT:C283($vl_size)
	$vl_size:=2048
	acme__moduleDebugDateTimeLine (6;Current method name:C684;"generating rsa key pair ("+String:C10($vl_size)+" bits)...")
	acme__keyPairRsaGenerate (->$vx_keyPrivBlob;->$vx_keyPubBlob;$vl_size)
	acme__moduleDebugDateTimeLine (4;Current method name:C684;"rsa key pair ("+String:C10($vl_size)+" bits) generated")
	
	$vb_ok:=True:C214
	
	  // write private key file to disk
	BLOB TO DOCUMENT:C526($vt_keyPrivPath;$vx_keyPrivBlob)
	If (ok=1)
		acme__keyFileProtect ($vt_keyPrivPath)
		acme__moduleDebugDateTimeLine (4;Current method name:C684;"private key written to file \""+$vt_keyPubPath+"\". [OK]")
	Else 
		$vb_ok:=False:C215
		acme__moduleDebugDateTimeLine (2;Current method name:C684;"error writing private key to file \""+$vt_keyPubPath+"\". [KO]")
	End if 
	
	  // write public key file to disk
	BLOB TO DOCUMENT:C526($vt_keyPubPath;$vx_keyPubBlob)
	If (ok=1)
		acme__moduleDebugDateTimeLine (4;Current method name:C684;"public key written to file \""+$vt_keyPubPath+"\". [OK]")
	Else 
		$vb_ok:=False:C215
		acme__moduleDebugDateTimeLine (2;Current method name:C684;"error writing public key to file \""+$vt_keyPubPath+"\". [KO]")
	End if 
	
	SET BLOB SIZE:C606($vx_keyPrivBlob;0)
	SET BLOB SIZE:C606($vx_keyPubBlob;0)
	
	acme__notify ("account key pair generated")
	
End if 
$0:=$vb_ok
