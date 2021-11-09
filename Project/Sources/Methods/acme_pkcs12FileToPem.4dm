//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_pkcs12FileToPem
  //@scope : private 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-paramName-OBJECT] : ParamDescription
  //@parameter[2-IN-paramName-POINTER] : ParamDescription (not modified)
  //@parameter[3-INOUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[4-OUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[5-IN-paramName-LONGINT] : ParamDescription (optional, default value : 1)
  //@notes : 
  //@example : acme_pkcs12FileToPem
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2020
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 14/12/2020, 10:10:23 - 1.00.03
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_pem)
C_TEXT:C284($1;$vt_pkcs12FilePath)
C_TEXT:C284($2;$vt_pkcs12Password)

$vt_pem:=""
$vt_pkcs12FilePath:=$1
$vt_pkcs12Password:=$2

C_TEXT:C284($vt_args)
$vt_args:="pkcs12"
$vt_args:=$vt_args+" -in "+UTL_pathToPosixConvert ($vt_pkcs12FilePath)
If (Length:C16($vt_pkcs12Password)>0)
	$vt_args:=$vt_args+" -passin pass:"+$vt_pkcs12Password
End if 
$vt_args:=$vt_args+" -nodes"

C_TEXT:C284($vt_in;$vt_pem;$vt_err)
$vt_in:=""
$vt_pem:=""
$vt_err:=""

If (acme__openSslCmd ($vt_args;->$vt_in;->$vt_pem;->$vt_err))
	
End if 
$0:=$vt_pem