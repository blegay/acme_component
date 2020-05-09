//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__keysKeyPairFilepathGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the path to the keyfile
  //@parameter[0-OUT-keyPath-TEXT] : key file path
  //@parameter[1-IN-keyType-TEXT] : key type "private" or "public"
  //@parameter[2-IN-certDir-LONGINT] : keypair dir (optional, default value : host db home dir)
  //@notes : 
  //@example : acme__keysKeyPairFilepathGet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 21:58:46 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_path)
C_TEXT:C284($1;$vt_keyType)
C_TEXT:C284($2;$vt_certDir)

$vt_path:=""

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(($1="private") | ($1="public");"$1 should be \"private\" or \"public\"")

C_TEXT:C284($vt_certDir)
If (Count parameters:C259>0)
	$vt_keyType:=$1
	
	If (Count parameters:C259>1)
		$vt_certDir:=$2
	End if 
	
	If (Length:C16($vt_certDir)=0)
		$vt_certDir:=Get 4D folder:C485(Database folder:K5:14;*)
	End if 
	
	Case of 
		: ($vt_keyType="private")
			$vt_path:=$vt_certDir+"key.pem"
			
		: ($vt_keyType="public")
			$vt_path:=$vt_certDir+"key.pub"
			
	End case 
	
End if 
$0:=$vt_path