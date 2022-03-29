//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_csrSubjectAutoFromDomains
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function returns a csr subject object from a list of domains
  //@parameter[0-OUT-csrSubjectObject-OBJECT] : csr subject object
  //@parameter[1-IN-domainListPtr-POINTER] : domain list text or text array pointer (not modified)
  //@notes : the first item in the list of domains will be used a "CN" (common name)
  //@example : acme_csrSubjectAutoFromDomains
  //
  // // subject for "distinguished_name" 
  // 
  // C_OBJECT($vo_subject)
  // OB SET($vo_subject;"CN";$tt_domains{1})
  //
  // // equivalent to
  //
  // C_OBJECT($vo_subject)
  // $vo_subject:=acme_csrSubjectAutoFromDomains(->$tt_domains)
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 05/03/2020, 16:07:08 - 0.90.15
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vb_subjectObject)
C_POINTER:C301($1;$vp_domainListPtr)

ASSERT:C1129(Count parameters:C259>0;"Requires 1 parameter")
ASSERT:C1129((Type:C295($1->)=Is text:K8:3) | (Type:C295($1->)=Text array:K8:16);"$1 should be a text or text array pointer")

  //C_LONGINT($vl_nbParam)
  //$vl_nbParam:=Count parameters

  //If ($vl_nbParam>0)
$vp_domainListPtr:=$1

C_TEXT:C284($vt_commonName)
Case of 
	: (Type:C295($vp_domainListPtr->)=Is text:K8:3)
		$vt_commonName:=$vp_domainListPtr->
		
	: (Type:C295($vp_domainListPtr->)=Text array:K8:16)
		If (Size of array:C274($vp_domainListPtr->)>0)
			$vt_commonName:=$vp_domainListPtr->{1}
		End if 
End case 

OB SET:C1220($vb_subjectObject;"CN";$vt_commonName)

  //End if 

$0:=$vb_subjectObject
