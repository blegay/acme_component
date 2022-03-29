//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__keyPrivModulusGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the modulus of the private key in binary form
  //@parameter[0-OUT-modulus-BLOB] : private key modulus in binary form
  //@parameter[1-IN-privateKeyPath-TEXT] : private key file path (in PEM format)
  //@notes :
  //@example : acme__keyPrivModulusGet
  //@see :
  //@version : 1.00.00
  //@author :
  //@history :
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:33:37 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_modulusBlob)
C_TEXT:C284($1;$vt_privateKeyPath)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Test path name:C476($1)=Is a document:K24:1;"private key path \""+$1+"\" not found")

SET BLOB SIZE:C606($vx_modulusBlob;0)
$vt_privateKeyPath:=$1

  // get the private (key in pem format)
C_BLOB:C604($vx_private)
SET BLOB SIZE:C606($vx_private;0)
DOCUMENT TO BLOB:C525($vt_privateKeyPath;$vx_private)
ASSERT:C1129(ok=1;"File \""+$vt_privateKeyPath+"\" not loaded")
acme__log (4;Current method name:C684;"file \""+$vt_privateKeyPath+"\" loaded size : "+String:C10(BLOB size:C605($vx_private)))

C_TEXT:C284($vt_args)
$vt_args:="rsa"+\
" -noout"+\
" -modulus"

acme__opensslConfigDefault 

C_TEXT:C284($vt_out;$vt_err)
If (acme_opensslCmd ($vt_args;->$vx_private;->$vt_out;->$vt_err))
	
	C_TEXT:C284($vt_modulus;$vt_regex)
	$vt_regex:="Modulus=(.+)"
	If (TXT_regexGetMatchingGroup ($vt_regex;$vt_out;1;->$vt_modulus))
		
		HEX_hexTextToBlob ($vt_modulus;->$vx_modulusBlob)
		
		acme__log (6;Current method name:C684;"private key \""+$vt_privateKeyPath+"\" found modulus value (\""+$vt_regex+"\") : "+$vt_modulus+" success. [OK]")
	Else 
		acme__log (2;Current method name:C684;"private key \""+$vt_privateKeyPath+"\" modulus value (\""+$vt_regex+"\") not founf in "+$vt_out+". [KO]")
	End if 
	
Else 
	acme__log (2;Current method name:C684;"private key \""+$vt_privateKeyPath+"\" modulus reading failed")
End if 

SET BLOB SIZE:C606($vx_private;0)

$0:=$vx_modulusBlob
SET BLOB SIZE:C606($vx_modulusBlob;0)