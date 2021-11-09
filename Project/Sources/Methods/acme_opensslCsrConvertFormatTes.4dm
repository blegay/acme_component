//%attributes = {"invisible":false,"shared":true,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_opensslCsrConvertFormatTes
  //@scope : public
  //@deprecated : no
  //@description : This is a test method
  //@notes : 
  //@example : acme_opensslCsrConvertFormatTes
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2018, 12:24:00 - 1.0
  //@xdoc-end
  //================================================================================


C_TEXT:C284($vt_csrDerPath;$vt_csrPemPath)
$vt_csrDerPath:=Get 4D folder:C485(Current resources folder:K5:16)+\
"testcases"+Folder separator:K24:12+\
"certificate"+Folder separator:K24:12+\
"csr.der"

$vt_csrPemPath:=Get 4D folder:C485(Current resources folder:K5:16)+\
"testcases"+Folder separator:K24:12+\
"certificate"+Folder separator:K24:12+\
"csr.pem"

C_TEXT:C284($vt_csr;$vt_csrExpected)
C_BLOB:C604($vx_csr)
DOCUMENT TO BLOB:C525($vt_csrDerPath;$vx_csr)

$vt_csrExpected:=Document to text:C1236($vt_csrPemPath;"us-ascii";Document with LF:K24:22)
acme__opensslCsrConvertFormat (->$vx_csr;->$vt_csr)

ASSERT:C1129($vt_csrExpected=$vt_csr)



  //ALERTE($vt_csr)