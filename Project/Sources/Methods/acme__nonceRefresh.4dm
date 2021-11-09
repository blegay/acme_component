//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__nonceRefresh
  //@scope : private
  //@deprecated : no
  //@description : This method will update the "nonce" value which can be used on the next request
  //@parameter[1-IN-status-LONGINT] : http status
  //@parameter[3-IN-headerKeyArrayPtr-POINTER] : header key text array pointer (not modified)
  //@parameter[3-IN-headerValArrayPtr-POINTER] : header values text array pointer (not modified)
  //@notes : 
  //@example : acme__nonceRefresh
  //@see : acme__nonceGet
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 13/02/2019, 21:32:48 - 0.90.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($1;$vl_status)
C_POINTER:C301($2;$vp_headerKeyArrayPtr)
C_POINTER:C301($3;$vp_headerValArrayPtr)

ASSERT:C1129(Count parameters:C259=3;"requires 3 parameters")
ASSERT:C1129(Type:C295($2->)=Text array:K8:16;"$2 should be a text array pointer")
ASSERT:C1129(Type:C295($3->)=Text array:K8:16;"$3 should be a text array pointer")
ASSERT:C1129(Size of array:C274($2->)=Size of array:C274($3->);"$3-> and $2-> should be arrays of identical size")

$vl_status:=$1
$vp_headerKeyArrayPtr:=$2
$vp_headerValArrayPtr:=$3

If ($vl_status#0)
	
	C_LONGINT:C283($vl_size)
	$vl_size:=Size of array:C274($vp_headerKeyArrayPtr->)
	If ($vl_size>0)
		
		C_LONGINT:C283($vl_found)
		$vl_found:=Find in array:C230($vp_headerKeyArrayPtr->;"Replay-Nonce")
		If ($vl_found>0)
			acme__initG 
			
			  //C_ENTIER LONG($vl_nonceDurationSecs)
			  //$vl_nonceDurationSecs:=120
			
			  //vl_ACME_nonceTickcount:=Nombre de ticks+(60*$vl_nonceDurationSecs)  // (60*120)  // the nonce will expire in 2 minutes
			vl_ACME_nonceTickcount:=Tickcount:C458
			vt_ACME_nonceLast:=$vp_headerValArrayPtr->{$vl_found}
			
			acme__log (6;Current method name:C684;"http status : "+String:C10($vl_status)+", nonce : \""+vt_ACME_nonceLast+"\" (in process "+String:C10(Current process:C322)+", tickcount "+String:C10(vl_ACME_nonceTickcount)+" ticks)")
		Else 
			acme__log (2;Current method name:C684;"http status : "+String:C10($vl_status)+" no \"Replay-Nonce\" header in response")
		End if 
		
	End if 
	
End if 