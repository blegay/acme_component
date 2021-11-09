//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

C_TEXT:C284($0;$vt_url)
C_TEXT:C284($1;$vt_serviceKey)
C_TEXT:C284($2;$vt_directoryUrl)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

$vt_serviceKey:=$1

If ($vl_nbParam>1)
	$vt_directoryUrl:=$2
Else 
	$vt_directoryUrl:=acme_directoryUrlGet 
End if 

$vt_url:=acme__directoryUrlGet ($vt_directoryUrl;$vt_serviceKey)