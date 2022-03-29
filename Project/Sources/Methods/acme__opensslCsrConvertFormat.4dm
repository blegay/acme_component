//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslCsrConvertFormat
  //@scope : private
  //@deprecated : no
  //@description : This function will convert a csr from a PEM format to DER or from DER to PEM
  //@parameter[0-IN-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-inPtr-POINTER] : csr source (not modified)
  //@parameter[2-OUT-outPtr-POINTER] : csr converted (modified)
  //@notes : 
  //@example : acme__opensslCsrConvertFormat
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2018, 12:15:08 - 1.0
  //@xdoc-end
  //================================================================================

  // openssl req -in csr.der -inform DER -out csr.pem -outform PEM
C_BOOLEAN:C305($0;$vb_ok)
C_POINTER:C301($1;$vp_inPtr)
C_POINTER:C301($2;$vp_outPtr)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
  //ASSERT(OB Est défini($1);"Undefined $1 object")
ASSERT:C1129((Type:C295($1->)=Is text:K8:3) | (Type:C295($1->)=Is BLOB:K8:12);"$1 should be a text or blob pointer")
ASSERT:C1129((Type:C295($2->)=Is text:K8:3) | (Type:C295($2->)=Is BLOB:K8:12);"$2 should be a text or blob pointer")
ASSERT:C1129(Type:C295($1->)#Type:C295($2->);"$1 and $2 should be of different type pointer")

$vb_ok:=False:C215
$vp_inPtr:=$1
$vp_outPtr:=$2

C_TEXT:C284($vt_args)
$vt_args:="req "+" -inform "+Choose:C955(Type:C295($vp_inPtr->)=Is BLOB:K8:12;"DER";"PEM")+" -outform "+Choose:C955(Type:C295($vp_outPtr->)=Is BLOB:K8:12;"DER";"PEM")

acme__opensslConfigDefault 

C_TEXT:C284($vt_err)
$vt_err:=""

If (acme_opensslCmd ($vt_args;$vp_inPtr;$vp_outPtr;->$vt_err))
	$vb_ok:=True:C214
	
	acme__log (4;Current method name:C684;"openssl csr convert format. [OK]")
Else 
	acme__log (2;Current method name:C684;"openssl csr convert format ("+$vt_err+"). [KO]")
	ASSERT:C1129(False:C215;$vt_err)
End if 

$0:=$vb_ok
