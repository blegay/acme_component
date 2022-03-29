//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslToText
  //@scope : private
  //@deprecated : no
  //@description : This function returns text data about a private key, a csr, or certificate in PEM or DER format
  //@parameter[0-OUT-text-TEXT] : text
  //@parameter[1-IN-type-TEXT] : source type ("rsa", "req" or "x509")
  //@parameter[2-IN-sourcePtr-POINTER] : source pointer (private key, csr, or certificate in PEM or DER format) (not modified)
  //@parameter[3-IN-param-TEXT] : "text", "startdate", "enddate" (optional, default "text")
  //@parameter[4-IN-inform-TEXT] : "PEM" or "DER" (optional, default "PEM" if $2 is text, "DER" if $2 is blob)
  //@notes :
  //@example : acme__opensslToText
  //@see :
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history :
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2018, 13:08:27 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_text)
C_TEXT:C284($1;$vt_type)
C_POINTER:C301($2;$vp_inPtr)
C_TEXT:C284($3;$vt_param)
C_TEXT:C284($4;$vt_inform)

$vt_text:=""
$vt_type:=$1
$vp_inPtr:=$2

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
  //ASSERT(OB Est défini($1);"Undefined $1 object")
ASSERT:C1129(($1="rsa") | ($1="req") | ($1="x509");"$1 should be \"rsa\", \"req\" or \"x509\"")
ASSERT:C1129((Type:C295($2->)=Is text:K8:3) | (Type:C295($2->)=Is BLOB:K8:12);"$2 should be a text or blob pointer")

  //$vb_ok:=Faux
$vt_type:=$1
$vp_inPtr:=$2
  // openssl x509 -noout -text -in cert.pem

Case of 
	: (Count parameters:C259>3)
		$vt_param:=$3
		$vt_inform:=$4
		
	: (Count parameters:C259>2)
		$vt_param:=$3
		$vt_inform:=""
		
	Else 
		$vt_param:="text"
		$vt_inform:=""
End case 

If (($vt_inform="DER") | ($vt_inform="PEM"))
	$vt_inform:=Uppercase:C13($vt_inform)
Else 
	$vt_inform:=Choose:C955(Type:C295($vp_inPtr->)=Is BLOB:K8:12;"DER";"PEM")
End if 

C_TEXT:C284($vt_args)
$vt_args:=$vt_type+" "+" -noout "+" -"+$vt_param+" "+" -inform "+$vt_inform

acme__opensslConfigDefault 

If (False:C215)
	C_TEXT:C284($vt_args)
	$vt_args:=$vt_type+" "+" -noout "+" -text "+" -inform "+Choose:C955(Type:C295($vp_inPtr->)=Is BLOB:K8:12;"DER";"PEM")
End if 

C_TEXT:C284($vt_err)
$vt_err:=""

If (acme_opensslCmd ($vt_args;$vp_inPtr;->$vt_text;->$vt_err))
	  //$vb_ok:=Vrai
	acme__log (4;Current method name:C684;"openssl "+$vt_type+" text \r"+$vt_text+"\r [OK]")
Else 
	acme__log (2;Current method name:C684;"openssl "+$vt_type+" text ("+$vt_err+"). [KO]")
	ASSERT:C1129(False:C215;$vt_err)
End if 

$0:=$vt_text