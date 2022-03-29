//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__keyPairRsaGenerate
  //@scope : private
  //@deprecated : no
  //@description : This function generates a pair of rsa private keys
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if OK, FALSE otherwise
  //@parameter[1-OUT-privateKeyPtr-POINTER] : rsa private key (pem format) text or blob pointer (modified)
  //@parameter[2-OUT-publicKeyPtr-POINTER] : rsa public key (pem format) text or blob pointer (modified)
  //@parameter[3-IN-size-LONGINT] : key size (optional, default : 2048)
  //@notes : uses openssl
  //@example : acme__keyPairRsaGenerate 
  //@see :
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 30/06/2018, 08:08:30 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_POINTER:C301($1;$vp_privateKeyPtr)
C_POINTER:C301($2;$vp_publicKeyPtr)
C_LONGINT:C283($3;$vl_size)

$vb_ok:=False:C215
ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129((Type:C295($1->)=Is text:K8:3) | (Type:C295($1->)=Is BLOB:K8:12);"$1 should be a text or blob pointer")
ASSERT:C1129((Type:C295($2->)=Is text:K8:3) | (Type:C295($2->)=Is BLOB:K8:12);"$2 should be a text or blob pointer")
ASSERT:C1129(Type:C295($1->)=Type:C295($2->);"$1 and $2 should be of same type pointer")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	
	$vp_privateKeyPtr:=$1
	$vp_publicKeyPtr:=$2
	If ($vl_nbParam>3)
		$vl_size:=$3
	Else 
		$vl_size:=2048
	End if 
	
	If (Type:C295($vp_privateKeyPtr->)=Is BLOB:K8:12)
		
		If (False:C215)
			GENERATE ENCRYPTION KEYPAIR:C688($vp_privateKeyPtr->;$vp_publicKeyPtr->;$vl_size)
		Else 
			C_TEXT:C284($vt_in;$vt_err)
			
			C_TEXT:C284($vt_args)
			$vt_args:="genrsa "+String:C10($vl_size)
			
			acme__opensslConfigDefault 
			
			If (acme_opensslCmd ($vt_args;->$vt_in;$vp_privateKeyPtr;->$vt_err))
				
				$vt_args:="rsa"+\
					" -pubout"
				
				acme__opensslConfigDefault 
				
				If (acme_opensslCmd ($vt_args;$vp_privateKeyPtr;$vp_publicKeyPtr;->$vt_err))
					$vb_ok:=True:C214
				End if 
			End if 
			
		End if 
		
	Else 
		C_BLOB:C604($vx_keyPrivBlob;$vx_keyPubBlob)
		SET BLOB SIZE:C606($vx_keyPrivBlob;0)
		SET BLOB SIZE:C606($vx_keyPubBlob;0)
		
		$vb_ok:=acme__keyPairRsaGenerate (->$vx_keyPrivBlob;->$vx_keyPubBlob;$vl_size)
		
		$vp_privateKeyPtr->:=Convert to text:C1012($vx_keyPrivBlob;"us-ascii")
		$vp_publicKeyPtr->:=Convert to text:C1012($vx_keyPubBlob;"us-ascii")
		
		SET BLOB SIZE:C606($vx_keyPrivBlob;0)
		SET BLOB SIZE:C606($vx_keyPubBlob;0)
	End if 
	
End if 
$0:=$vb_ok