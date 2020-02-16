//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_orderAuthorisationWait
  //@scope : public
  //@deprecated : no
  //@description : This function waits that all the authorizations have passed the "pending" status...
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-orderObject-OBJECT] : order object (not modified)
  //@parameter[2-IN-nbSecondsMax-LONGINT] : number of seconds to wait for
  //@notes : 
  // orderObject :
  // {
  //     "status": "pending",
  //     "expires": "2018-07-05T16:15:24Z",
  //     "identifiers": [
  //         {
  //             "type": "dns",
  //             "value": "test.example.com"
  //         },
  //         {
  //             "type": "dns",
  //             "value": "test1.example.com"
  //         },
  //         {
  //             "type": "dns",
  //             "value": "test2.example.com"
  //         },
  //         {
  //             "type": "dns",
  //             "value": "test3.example.com"
  //         }
  //     ],
  //     "authorizations": [
  //         "https://acme-staging-v02.api.letsencrypt.org/acme/authz/n...k",
  //         "https://acme-staging-v02.api.letsencrypt.org/acme/authz/x...M",
  //         "https://acme-staging-v02.api.letsencrypt.org/acme/authz/J...U",
  //         "https://acme-staging-v02.api.letsencrypt.org/acme/authz/m...o"
  //     ],
  //     "finalize": "https://acme-staging-v02.api.letsencrypt.org/acme/finalize/12345/6789"
  // }
  //
  //@example : acme_orderAuthorisationWait
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 14/02/2019, 00:59:37 - 0.90.01
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_OBJECT:C1216($1;$vo_orderObject)
C_LONGINT:C283($2;$vl_nbSecondsMax)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(OB Is defined:C1231($1);"$1 order object cannot be undefined")
ASSERT:C1129(OB Is defined:C1231($1;"authorizations");"$1 order property \"authorizations\" is undefined")
ASSERT:C1129($2>=0;"$2 (nbSecondsMax) should be greater or equal to 0")


$vb_ok:=False:C215
$vo_orderObject:=$1
$vl_nbSecondsMax:=$2

ARRAY TEXT:C222($tt_authUrl;0)
OB GET ARRAY:C1229($vo_orderObject;"authorizations";$tt_authUrl)

If (Size of array:C274($tt_authUrl)>0)
	
	C_LONGINT:C283($vl_startTickcount;$vl_diffTicks;$vl_maxDiffTicks)
	$vl_startTickcount:=Tickcount:C458
	$vl_maxDiffTicks:=$vl_nbSecondsMax*60
	
	C_BOOLEAN:C305($vb_exit)
	$vb_exit:=False:C215
	
	C_LONGINT:C283($vl_pendingCount;$vl_validCount;$vl_invalidCount;$vl_deactivatedCount;$vl_expiredCount;$vl_revokedCount)
	$vl_pendingCount:=Size of array:C274($tt_authUrl)
	$vl_validCount:=0
	$vl_invalidCount:=0
	$vl_deactivatedCount:=0
	$vl_expiredCount:=0
	$vl_revokedCount:=0
	
	C_LONGINT:C283($vl_index)
	$vl_index:=1
	Repeat 
		
		C_TEXT:C284($vt_authorizationUrl)
		$vt_authorizationUrl:=$tt_authUrl{$vl_index}
		
		C_OBJECT:C1216($vo_authObj)
		
		If (acme_authorizationGet ($vt_authorizationUrl;->$vo_authObj))
			
			ASSERT:C1129(OB Is defined:C1231($vo_authObj;"identifier"))
			C_OBJECT:C1216($vo_identifier)
			$vo_identifier:=OB Get:C1224($vo_authObj;"identifier";Is object:K8:27)
			
			ASSERT:C1129(OB Is defined:C1231($vo_identifier;"value"))
			C_TEXT:C284($vt_domain)
			$vt_domain:=OB Get:C1224($vo_identifier;"value";Is text:K8:3)
			
			ASSERT:C1129(OB Is defined:C1231($vo_authObj;"status"))
			C_TEXT:C284($vt_authorizationStatus)
			$vt_authorizationStatus:=OB Get:C1224($vo_authObj;"status";Is text:K8:3)
			
			If ($vt_authorizationStatus="pending")
				
				acme__moduleDebugDateTimeLine (6;Current method name:C684;"domain : \""+$vt_domain+"\""+\
					", status : "+$vt_authorizationStatus)
				
				  // look at the next one
				If ($vl_index<Size of array:C274($tt_authUrl))
					$vl_index:=$vl_index+1
				Else 
					$vl_index:=1
				End if 
				
			Else 
				$vl_pendingCount:=$vl_pendingCount-1
				
				Case of 
						  //: ($vt_authorizationStatus="pending")
					: ($vt_authorizationStatus="valid")
						$vl_validCount:=$vl_validCount+1
						
					: ($vt_authorizationStatus="invalid")
						$vl_invalidCount:=$vl_invalidCount+1
						
					: ($vt_authorizationStatus="deactivated")
						$vl_deactivatedCount:=$vl_deactivatedCount+1
						
					: ($vt_authorizationStatus="expired")
						$vl_expiredCount:=$vl_expiredCount+1
						
					: ($vt_authorizationStatus="revoked")
						$vl_revokedCount:=$vl_revokedCount+1
					Else 
						ASSERT:C1129(False:C215;"unexpected status : \""+$vt_authorizationStatus+"\"")
				End case 
				
				DELETE FROM ARRAY:C228($tt_authUrl;$vl_index;1)
				
				If ($vl_index>Size of array:C274($tt_authUrl))
					$vl_index:=1
				End if 
				
				acme__moduleDebugDateTimeLine (4;Current method name:C684;"domain : \""+$vt_domain+"\""+\
					", status : "+$vt_authorizationStatus)
				
			End if 
			
		End if 
		
		$vl_diffTicks:=Tickcount:C458-$vl_startTickcount
		
		Case of 
			: (Size of array:C274($tt_authUrl)=0)
				$vb_exit:=True:C214
				$vb_ok:=(($vl_invalidCount=0) & ($vl_deactivatedCount=0) & ($vl_expiredCount=0) & ($vl_revokedCount=0))
				
			: ($vl_diffTicks>$vl_maxDiffTicks)
				$vb_exit:=True:C214
		End case 
		
	Until ($vb_exit)
	
	acme__moduleDebugDateTimeLine (Choose:C955($vb_ok;4;2);Current method name:C684;"pending : "+String:C10($vl_pendingCount)+\
		", invalid : "+String:C10($vl_validCount)+\
		", invalid : "+String:C10($vl_invalidCount)+\
		", deactivated : "+String:C10($vl_deactivatedCount)+\
		", expired : "+String:C10($vl_expiredCount)+\
		", revokedCount : "+String:C10($vl_revokedCount)+\
		". "+Choose:C955($vb_ok;"[OK]";"[KO]"))
	
End if 

ARRAY TEXT:C222($tt_authUrl;0)

$0:=$vb_ok
