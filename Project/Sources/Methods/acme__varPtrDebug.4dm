//%attributes = {"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : acme__varPtrDebug
  //@scope : private
  //@deprecated : no
  //@description : This function returns a debug for a text or blob pointer
  //@parameter[0-OUT-varDebug-TEXT] : var debug
  //@parameter[1-IN-varPtr-POINTER] : blob or text var pointer (not modified)
  //@notes :
  //@example : acme__varPtrDebug 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 09/10/2020, 18:58:34 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_debug)
C_POINTER:C301($1;$vp_pointer)

$vp_pointer:=$1

C_LONGINT:C283($vl_type)
$vl_type:=Type:C295($vp_pointer->)

Case of 
	: ($vl_type=Is text:K8:3)
		$vt_debug:=$vp_pointer->
		
	: ($vl_type=Is BLOB:K8:12)
		$vt_debug:=String:C10(BLOB size:C605($vp_pointer->))+" byte(s)"
		
	Else 
		$vt_debug:=""
End case 

$0:=$vt_debug
