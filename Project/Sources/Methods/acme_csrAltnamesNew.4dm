//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_csrAltnamesNew
  //@scope : public
  //@deprecated : no
  //@description : This function converts a text array of "alt names" into an alt names object
  //@parameter[0-OUT-altNamesObj-OBJECT] : object
  //@parameter[1-IN-domainArrayPtr-POINTER] : domain text array pointer (not modified)
  //@parameter[2-IN-startFrom-LONGINT] : start from position (optional, default value : 1)
  //@notes : 
  //@example : acme_csrAltnamesNew
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/01/2019, 20:00:38 - 1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_altNames)
C_POINTER:C301($1;$vp_domainArrayPtr)
C_LONGINT:C283($2;$vl_startFrom)

ASSERT:C1129(Count parameters:C259>0)
ASSERT:C1129(Not:C34(Is nil pointer:C315($1));"$1 is nil")
ASSERT:C1129(Type:C295($1->)=Text array:K8:16;"$1 should be a text array")

$vp_domainArrayPtr:=$1

C_LONGINT:C283($i;$vl_size)
$vl_size:=Size of array:C274($vp_domainArrayPtr->)
If ($vl_size>0)
	
	If (Count parameters:C259>1)
		ASSERT:C1129($2>0;"$2 start from ("+String:C10($2)+" should be greated than 0")
		$vl_startFrom:=$2
	Else 
		$vl_startFrom:=1
	End if 
	
	If ($vl_startFrom<=$vl_size)
		C_LONGINT:C283($vl_dnsIndex)
		$vl_dnsIndex:=0
		
		For ($i;$vl_startFrom;$vl_size)
			$vl_dnsIndex:=$vl_dnsIndex+1
			OB SET:C1220($vo_altNames;"DNS."+String:C10($vl_dnsIndex);$vp_domainArrayPtr->{$i})
		End for 
		
	End if 
End if 

$0:=$vo_altNames