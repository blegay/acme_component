//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__domainReverse
  //@scope : private
  //@deprecated : no
  //@description : This function returns a domain in a reversed form
  //@parameter[0-OUT-domainReversed-TEXT] : acme-v02.api.letsencrypt.org
  //@parameter[1-IN-domain-TEXT] : domain (e.g. "acme-v02.api.letsencrypt.org"
  //@notes : 
  //@example : 
  // ASSERT(acme__domainReverse ("acme-v02.api.letsencrypt.org")="org.letsencrypt.api.acme-v02")
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 12/02/2019, 20:24:03 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_domainReversed)
C_TEXT:C284($1;$vt_domain)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"$1 is empty/\"\"")

$vt_domainReversed:=""
$vt_domain:=$1
If (Length:C16($vt_domain)>0)
	
	ARRAY TEXT:C222($tt_domainParts;0)
	TXT_explodeFast ($vt_domain;->$tt_domainParts;".")
	
	C_LONGINT:C283($i)
	For ($i;1;Size of array:C274($tt_domainParts))
		$vt_domainReversed:=$tt_domainParts{$i}+Choose:C955($i=1;"";".")+$vt_domainReversed
	End for 
	
	ARRAY TEXT:C222($tt_domainParts;0)
	
End if 

$0:=$vt_domainReversed