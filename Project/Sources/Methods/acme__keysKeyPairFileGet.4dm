//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__keysKeyPairFileGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the content of keyfile as blob (pem format)
  //@parameter[0-OUT-keyBlob-BLOB] : content of keyfile as blob (pem format)
  //@parameter[1-IN-keyType-TEXT] : key type "private" or "public"
  //@parameter[2-IN-keyDir-TEXT] : keypair dir (optional, default value : host db home dir)
  //@notes : 
  //@example : acme__keysKeyPairFileGet
  //
  // $privateKeyBlob := acme__keysKeyPairFileGet("private";{"/path/to/certs"})
  // $publicKeyBlob := acme__keysKeyPairFileGet("public";{"/path/to/certs"})
  //
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:20:30 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_key)
C_TEXT:C284($1;$vt_keyType)
C_TEXT:C284($2;$vt_keyDir)

SET BLOB SIZE:C606($vx_key;0)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameter")
ASSERT:C1129(($1="private") | ($1="public");"$1 should be \"private\" or \"public\"")

$vt_keyType:=$1
$vt_keyDir:=$2

C_TEXT:C284($vt_keyPath)
$vt_keyPath:=acme__keysKeyPairFilepathGet ($vt_keyType;$vt_keyDir)

If (Length:C16($vt_keyPath)>0)
	
	If (Test path name:C476($vt_keyPath)=Is a document:K24:1)
		
		DOCUMENT TO BLOB:C525($vt_keyPath;$vx_key)
		If (ok=1)
			acme__moduleDebugDateTimeLine (4;Current method name:C684;"key file \""+$vt_keyPath+"\" loaded. [OK]")
		Else 
			acme__moduleDebugDateTimeLine (2;Current method name:C684;"key file \""+$vt_keyPath+"\" could not be loaded. [KO]")
		End if 
		
	Else 
		acme__moduleDebugDateTimeLine (2;Current method name:C684;"key file \""+$vt_keyPath+"\" does not exist, key type : \""+$vt_keyType+"\", key dir : \""+$vt_keyDir+"\". [KO]")
	End if 
	
Else 
	acme__moduleDebugDateTimeLine (2;Current method name:C684;"empty key path for key type : \""+$vt_keyType+"\", key dir : \""+$vt_keyDir+"\". [KO]")
End if 

$0:=$vx_key
SET BLOB SIZE:C606($vx_key;0)