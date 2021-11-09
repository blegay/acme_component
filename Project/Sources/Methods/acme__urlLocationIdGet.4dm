//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__urlLocationIdGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the last part of a "Location" http response header url
  //@parameter[0-OUT-id-TEXT] : id
  //@parameter[1-IN-url-TEXT] : location url
  //@notes : 
  //@example : 
  // acme__urlLocationIdGet ("https://acme-staging-v02.api.letsencrypt.org/acme/order/12345") => "12345"
  // acme__urlLocationIdGet ("https://acme-staging-v02.api.letsencrypt.org/acme/order/12345/6789") => "6789"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 28/06/2018, 18:24:05 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_id)
C_TEXT:C284($1;$vt_url)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"$1 (url) should not be empty")

$vt_id:=""
$vt_url:=$1

C_TEXT:C284($vt_regex)
$vt_regex:="^.*/(.+)$"
TXT_regexGetMatchingGroup ($vt_regex;$vt_url;1;->$vt_id)

$0:=$vt_id