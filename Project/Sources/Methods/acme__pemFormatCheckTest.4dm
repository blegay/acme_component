//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__pemFormatCheckTest
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-paramName-STRING 32] : ParamDescription
  //@parameter[2-IN-paramName-POINTER] : ParamDescription (not modified)
  //@parameter[3-INOUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[4-OUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[5-IN-paramName-LONGINT] : ParamDescription (optional, default value : 1)
  //@notes : 
  //@example : acme__pemFormatCheckTest
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 01/07/2019, 09:29:48 - 0.90.08
  //@xdoc-end
  //================================================================================


C_TEXT:C284($vt_testDirPath)
$vt_testDirPath:=Get 4D folder:C485(Current resources folder:K5:16)+"testcases"+Folder separator:K24:12+"certificate"+Folder separator:K24:12

C_TEXT:C284($vt_certPath;$vt_keyPath)
$vt_certPath:=$vt_testDirPath+"cert.pem"
$vt_keyPath:=$vt_testDirPath+"key.pem"

C_BLOB:C604($vx_pem)
SET BLOB SIZE:C606($vx_pem;0)

  //FIXER ACTIVATION ASSERTIONS(Vrai)


C_TEXT:C284($vt_regex;$vt_pemData)
$vt_regex:="[^-A-Za-z0-9+/=]|=[^=]|={3,}$"
$vt_pemData:="MIIGpzCCBYGT6-----END CERTIFICATE----------BEGIN CERTIFICATE-----M"

ASSERT:C1129((Match regex:C1019($vt_regex;$vt_pemData;1)))

$vt_pemData:="MIIGpzCCBYGT6"
ASSERT:C1129(Not:C34(Match regex:C1019($vt_regex;$vt_pemData;1)))

$vt_pemData:="MIIGpzCCBYGT6="
ASSERT:C1129(Not:C34(Match regex:C1019($vt_regex;$vt_pemData;1)))

$vt_pemData:="MIIGpzCCBYGT6=="
ASSERT:C1129(Not:C34(Match regex:C1019($vt_regex;$vt_pemData;1)))

$vt_pemData:="MIIGpzCCBYGT6==="
ASSERT:C1129(Match regex:C1019($vt_regex;$vt_pemData;1))


DOCUMENT TO BLOB:C525($vt_certPath;$vx_pem)
ASSERT:C1129(acme__pemFormatCheck (->$vx_pem;"CERTIFICATE";True:C214))

SET BLOB SIZE:C606($vx_pem;0)
DOCUMENT TO BLOB:C525($vt_keyPath;$vx_pem)
ASSERT:C1129(acme__pemFormatCheck (->$vx_pem;"RSA PRIVATE KEY"))

SET BLOB SIZE:C606($vx_pem;0)