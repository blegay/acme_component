//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslModulus
  //@scope : private
  //@deprecated : no
  //@description : This function calculates a modulus for a private key, csr, or certificate in PEM or DER format
  //@parameter[0-OUT-modulus-BLOB] : modulus
  //@parameter[1-IN-type-TEXT] : source type ("rsa", "req" or "x509")
  //@parameter[2-IN-sourcePtr-POINTER] : source pointer (private key, csr, or certificate in PEM or DER format) (not modified)
  //@notes : 
  //@example : acme__opensslModulus
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2018, 12:37:30 - 1.0
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_modulus)
C_TEXT:C284($1;$vt_type)
C_POINTER:C301($2;$vp_inPtr)

SET BLOB SIZE:C606($vx_modulus;0)
$vt_type:=$1
$vp_inPtr:=$2

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
  //ASSERT(OB Est défini($1);"Undefined $1 object")
ASSERT:C1129(($1="rsa") | ($1="req") | ($1="x509");"$1 should be \"rsa\", \"req\" or \"x509\"")
ASSERT:C1129((Type:C295($2->)=Is text:K8:3) | (Type:C295($2->)=Is BLOB:K8:12);"$2 should be a text or blob pointer")

  //$vb_ok:=Faux
$vt_type:=$1
$vp_inPtr:=$2
  // openssl x509 -noout -modulus -in cert.pem

C_TEXT:C284($vt_args)
$vt_args:=$vt_type+" "+" -noout "+" -modulus "+" -inform "+Choose:C955(Type:C295($vp_inPtr->)=Is BLOB:K8:12;"DER";"PEM")

acme__opensslConfigDefault 

C_TEXT:C284($vt_err)
$vt_err:=""

If (acme__openSslCmd ($vt_args;$vp_inPtr;->$vx_modulus;->$vt_err))
	  //$vb_ok:=Vrai
	acme__log (4;Current method name:C684;"openssl "+$vt_type+" modulus (md5 : "+Generate digest:C1147($vx_modulus;MD5 digest:K66:1)+"). [OK]")
Else 
	acme__log (2;Current method name:C684;"openssl "+$vt_type+" modulus ("+$vt_err+"). [KO]")
	ASSERT:C1129(False:C215;$vt_err)
End if 

$0:=$vx_modulus
SET BLOB SIZE:C606($vx_modulus;0)