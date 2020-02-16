//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__nonceHeaderGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the value for "Replay-Nonce"
  //@parameter[0-OUT-nonce-TEXT] : value for response header "Replay-Nonce" (e.g. "qPieoRf2bSbHkg_2_iKLDhL-6XeL09ySyNupClpeXPM")
  //@parameter[1-IN-status-LONGINT] : http status
  //@parameter[2-IN-paramName-POINTER] : http response header key text array pointer (not modified)
  //@parameter[3-IN-paramName-POINTER] : http response header value text array pointer (not modified)
  //@notes : 
  //@example : acme__nonceHeaderGet 
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 06:32:08 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_nonce)
C_LONGINT:C283($1;$vl_status)
C_POINTER:C301($2;$vp_headerArrayKeyPtr)
C_POINTER:C301($3;$vp_headerArrayValuePtr)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(Type:C295($2->)=Text array:K8:16;"$2 should be a text array pointer")
ASSERT:C1129(Type:C295($3->)=Text array:K8:16;"$3 should be a text array pointer")

$vt_nonce:=""
$vl_status:=$1
$vp_headerArrayKeyPtr:=$2
$vp_headerArrayValuePtr:=$3

If (($vl_status>=200) & ($vl_status<300))
	  // will return 204 (No content)
	$vt_nonce:=acme__httpHeaderGetValForKey ($vp_headerArrayKeyPtr;$vp_headerArrayValuePtr;"Replay-Nonce")
End if 
$0:=$vt_nonce