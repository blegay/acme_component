//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__challengeReqUrlMatch
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-match-BOOLEAN] : match
  //@parameter[1-IN-url-TEXT] : url
  //@parameter[2-OUT-tokenPtr-POINTER] : token text pointer (optional, modified)
  //@notes : 
  //@example : acme__challengeReqUrlMatch
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 26/08/2019, 15:32:46 - 0.90.09
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_match)
C_TEXT:C284($1;$vt_url)
C_POINTER:C301($2;$vp_tokenPtr)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameters")

$vb_match:=False:C215
$vt_url:=$1

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

Case of 
	: ($vl_nbParam=0)
	: ($vl_nbParam=1)
	Else 
		  //:($vl_nbParam=2)
		$vp_tokenPtr:=$2
		
		ASSERT:C1129(Type:C295($2->)=Is text:K8:3;"$2/out should be a text pointer")
End case 

If ($vl_nbParam>0)
	
	  //  "/.well-known/acme-challenge/-P9Ukqz_ehOWBxaB3H-StJVwWmvHVadfW8HA-H1zJIM"
	  //  "/.well-known/acme-challenge/5nTCyyUMDZ-Wo68784SPas9EWIrNZTbg9ArHimPr4Qk"
	  //  "/.well-known/acme-challenge/AmnMB9UGzwbFEb3S4x_nss1JCNjH7xAoeCo4vBnhFZg"
	  //  "/.well-known/acme-challenge/Hf-SnpM7wzUAe9RR3UcEc89Ob3TEz6nVJHQc4jdDEWg"
	  //  "/.well-known/acme-challenge/ADnBhkmsn1AtQczosTZ_8YsIAelq1d5g6-JvKA3dZsg"
	  //  "/.well-known/acme-challenge/9uu98LtAMIsXu_9sW1k8QinNjX1Af3hYds7BpGQTtx0"
	  //  "/.well-known/acme-challenge/gzhNs4m51R3XyM9hCDjtfj0HVFxGtf5jYNKSCHUwVus"
	  //  "/.well-known/acme-challenge/12Fw4aruX0Y5O2_P-WYeGhcvSc7SX3V6J6v98Ps13tc"
	  //  "/.well-known/acme-challenge/5Gvs0QcIUUQpNWDBJ5jbY0s-qIj-mYCCromNHPq51B4"
	  //  "/.well-known/acme-challenge/wUDZVYkobBj40sabCVGdKuD6JYH9IzWatSeDfb1DUAM"
	  //  "/.well-known/acme-challenge/Qp1ncKwBMKP2RfhyGF4gViD5wJQigIriAKv1vp70i04"
	
	  // if compatibility options is set, 4D may strip the leading "/"
	  //  ".well-known/acme-challenge/-P9Ukqz_ehOWBxaB3H-StJVwWmvHVadfW8HA-H1zJIM"
	  //  ".well-known/acme-challenge/5nTCyyUMDZ-Wo68784SPas9EWIrNZTbg9ArHimPr4Qk"
	  //  ".well-known/acme-challenge/AmnMB9UGzwbFEb3S4x_nss1JCNjH7xAoeCo4vBnhFZg"
	  //  ".well-known/acme-challenge/Hf-SnpM7wzUAe9RR3UcEc89Ob3TEz6nVJHQc4jdDEWg"
	  //  ".well-known/acme-challenge/ADnBhkmsn1AtQczosTZ_8YsIAelq1d5g6-JvKA3dZsg"
	  //  ".well-known/acme-challenge/9uu98LtAMIsXu_9sW1k8QinNjX1Af3hYds7BpGQTtx0"
	  //  ".well-known/acme-challenge/gzhNs4m51R3XyM9hCDjtfj0HVFxGtf5jYNKSCHUwVus"
	  //  ".well-known/acme-challenge/12Fw4aruX0Y5O2_P-WYeGhcvSc7SX3V6J6v98Ps13tc"
	  //  ".well-known/acme-challenge/5Gvs0QcIUUQpNWDBJ5jbY0s-qIj-mYCCromNHPq51B4"
	  //  ".well-known/acme-challenge/wUDZVYkobBj40sabCVGdKuD6JYH9IzWatSeDfb1DUAM"
	  //  ".well-known/acme-challenge/Qp1ncKwBMKP2RfhyGF4gViD5wJQigIriAKv1vp70i04"
	  //  ".well-known/acme-challenge/0RD11_kwxNqSEpSxoaUPAE1gleKxOpySzWLsnTzVVn0"
	  //  ".well-known/acme-challenge/-eqdzwF74M0bbfSMGkYJDClrT1gAxZDBxO-plGVGyTI"
	C_TEXT:C284($vt_regex)
	
	C_LONGINT:C283($vl_length)
	$vl_length:=Length:C16($vt_url)
	If (($vl_length>=27) & ($vl_length<=120))
		  //Si (($vl_length>=27) & ($vl_length<=71))
		
		If (($vt_url=".well-known/acme-challenge/@") | ($vt_url="/.well-known/acme-challenge/@"))
			
			If ($vl_nbParam=1)
				
				$vt_regex:="^/?\\.well-known/acme-challenge/[-_A-Za-z0-9]{43,}$"
				
				$vb_match:=Match regex:C1019($vt_regex;$vt_url;1;*)
				
				If ($vb_match)
					acme__log (6;Current method name:C684;"url \""+$vt_url+"\" did match regex \""+$vt_regex+"\"")
				End if 
				
			Else 
				
				$vt_regex:="^/?\\.well-known/acme-challenge/([-_A-Za-z0-9]{43,})$"
				
				C_TEXT:C284($vt_token)
				$vb_match:=TXT_regexGetMatchingGroup ($vt_regex;$vt_url;1;->$vt_token)
				$vp_tokenPtr->:=$vt_token
				
				If ($vb_match)
					acme__log (6;Current method name:C684;"url \""+$vt_url+"\" did match regex \""+$vt_regex+"\", token : \""+$vt_token+"\"")
				End if 
				
			End if 
			
			If (Not:C34($vb_match))
				acme__log (2;Current method name:C684;"url \""+$vt_url+"\" did not match regex \""+$vt_regex+"\"")
			End if 
			
		End if 
		
	End if 
End if 

$0:=$vb_match
