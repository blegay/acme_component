//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : acme_certChainToText
  //@scope : public
  //@deprecated : no
  //@description : This function returns certificates as text from a pem certificate chain file
  //@parameter[0-OUT-certificateInfos-TEXT] : certificate infos in text format
  //@parameter[1-IN-pem-TEXT] : pem data
  //@notes :
  //@example : acme_certChainToText 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 13/02/2020, 19:09:04 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_text)
C_TEXT:C284($1;$vt_pem)

ASSERT:C1129(Count parameters:C259>0;"require 1 parameter")

$vt_text:=""
$vt_pem:=$1

ARRAY TEXT:C222($tt_pemData;0)
ARRAY TEXT:C222($tt_type;0)

  // parse the pem file into an array of individual pem with their types
acme_pemFormatChainToArray ($vt_pem;->$tt_pemData;->$tt_type)

C_LONGINT:C283($vl_certificateTotalCount;$vl_certificateIndex)
$vl_certificateTotalCount:=Count in array:C907($tt_type;"X509 CERTIFICATE")+Count in array:C907($tt_type;"CERTIFICATE")
$vl_certificateIndex:=0

C_TEXT:C284($vt_lineSep)
$vt_lineSep:=TXT_lineSepGet ($vt_pem)

C_LONGINT:C283($i)
For ($i;1;Size of array:C274($tt_type))
	
	C_TEXT:C284($vt_type;$vt_pemData)
	$vt_type:=$tt_type{$i}
	$vt_pemData:=$tt_pemData{$i}
	
	  // make everything "\n"
	C_TEXT:C284($vt_lineSepOriginal)
	$vt_lineSepOriginal:=TXT_lineSepGet ($vt_pemData)
	If ($vt_lineSepOriginal#"\n")
		$vt_pemData:=Replace string:C233($vt_pemData;$vt_lineSepOriginal;"\n";*)
	End if 
	
	Case of 
		: (($vt_type="X509 CERTIFICATE") | ($vt_type="CERTIFICATE"))
			$vl_certificateIndex:=$vl_certificateIndex+1
			
			C_TEXT:C284($vt_certInfos)
			$vt_certInfos:=acme_certToText (->$vt_pemData)
			If ($vt_lineSepOriginal#"\n")
				$vt_certInfos:=Replace string:C233($vt_certInfos;"\n";$vt_lineSepOriginal;*)
			End if 
			
			$vt_text:=$vt_text+"Certificate "+String:C10($vl_certificateIndex)+" / "+String:C10($vl_certificateTotalCount)+$vt_lineSep
			$vt_text:=$vt_text+$vt_certInfos
			
			  //C_TEXT($vt_subjectHash;$vt_issuerHash)
			  //$vt_subjectHash:=acme_certToText (->$vt_pemData;"subject_hash")  // "f19a1d82\n"
			  //$vt_issuerHash:=acme_certToText (->$vt_pemData;"issuer_hash")  // "4f06f81d\n"
			
	End case 
	
End for 

ARRAY TEXT:C222($tt_pemData;0)
ARRAY TEXT:C222($tt_type;0)

$0:=$vt_text