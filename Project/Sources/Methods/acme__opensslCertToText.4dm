//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslCertToText
  //@scope : private
  //@deprecated : no
  //@description : This function checks a csr output
  //@parameter[0-OUT-certText-TEXT] : certificate output
  //@parameter[2-IN-certPointer-POINTER] : certiticate pointer (if blob assumed in DER format, else PEM format) (not modified)
  //@notes : 
  //@example : acme__opensslCertToText
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2018, 11:44:55 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_out)
C_POINTER:C301($1;$vp_csrPtr)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129((Type:C295($1->)=Is text:K8:3) | (Type:C295($1->)=Is BLOB:K8:12);"$1 should be a text or blob pointer")

$vt_out:=""
$vp_csrPtr:=$1

C_TEXT:C284($vt_args)
$vt_args:="x509"+\
" -noout"+\
" -text"+\
" -inform "+Choose:C955(Type:C295($vp_csrPtr->)=Is BLOB:K8:12;"DER";"PEM")

acme__opensslConfigDefault 

C_TEXT:C284($vt_err)
If (acme__openSslCmd ($vt_args;$vp_csrPtr;->$vt_out;->$vt_err))
	
Else 
	ASSERT:C1129(False:C215;$vt_err)
End if 

If (False:C215)
	  //%T-
	SET TEXT TO PASTEBOARD:C523($vt_out)
	  //%T+
End if 

$0:=$vt_out