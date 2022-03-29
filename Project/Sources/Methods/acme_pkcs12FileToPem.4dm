//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_pkcs12FileToPem
  //@scope : private
  //@deprecated : no
  //@description : This function read a pkcs12 store and returns a certificate in PEM format
  //@parameter[0-OUT-pem-TEXT] : certificate in PEM format
  //@parameter[1-IN-filepath-TEXT] : pkcs12 filepath
  //@parameter[2-IN-password-TEXT] : pkcs12 password
  //@notes :
  //@example : acme_pkcs12FileToPem
  //@see :
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history :
  //  CREATION : Bruno LEGAY (BLE) - 14/12/2020, 10:10:23 - 1.00.03
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_pem)
C_TEXT:C284($1;$vt_pkcs12Filepath)
C_TEXT:C284($2;$vt_pkcs12Password)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")

$vt_pem:=""
$vt_pkcs12Filepath:=$1
$vt_pkcs12Password:=$2

C_TEXT:C284($vt_args)
$vt_args:="pkcs12"
$vt_args:=$vt_args+" -in "+UTL_pathToPosixConvert ($vt_pkcs12Filepath)
If (Length:C16($vt_pkcs12Password)>0)
	$vt_args:=$vt_args+" -passin pass:"+$vt_pkcs12Password
End if 
$vt_args:=$vt_args+" -nodes"

C_TEXT:C284($vt_in;$vt_pem;$vt_err)
$vt_in:=""
$vt_pem:=""
$vt_err:=""

If (acme_opensslCmd ($vt_args;->$vt_in;->$vt_pem;->$vt_err))
	
End if 

$0:=$vt_pem