//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__domainExtractFromUrl
  //@scope : public
  //@deprecated : no
  //@description : This function extracts the domain from a url
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-directoryUrl-TEXT] : directory url
  //@parameter[2-OUT-domainPtr-POINTER] : domain pointer (modified)
  //@notes : 
  //@example : acme__domainExtractFromUrl
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 31/07/2019, 18:08:06 - 0.90.08
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_directoryUrl)
C_POINTER:C301($2;$vp_domainPtr)

$vb_ok:=False:C215
$vt_directoryUrl:=$1
$vp_domainPtr:=$2

C_TEXT:C284($vt_regex;$vt_caDomain)
$vt_regex:="^https?://(.*?)/.*$"

$vb_ok:=TXT_regexGetMatchingGroup ($vt_regex;$vt_directoryUrl;1;$vp_domainPtr)
If (Not:C34($vb_ok))
	acme__log (2;Current method name:C684;"domain not found in url \""+$vt_directoryUrl+"\" with regex \""+$vt_regex+"\". [KO]")
End if 

$0:=$vb_ok