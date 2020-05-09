//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_identifierObjectNew
  //@scope : public
  //@deprecated : no
  //@description : This function returns an identifier object
  //@parameter[0-OUT-identifierObj-OBJECT] : identifier object
  //@parameter[1-IN-type-TEXT] : type (e.g. "dns")
  //@parameter[2-IN-domain-text] : domain
  //@notes : 
  //@example : acme_identifierObjectNew
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 28/06/2018, 18:34:09 - 1.0
  //@xdoc-end
  //================================================================================
C_OBJECT:C1216($0;$vo_identifier)
C_TEXT:C284($1;$vt_type)
C_TEXT:C284($2;$vt_domain)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameter")
ASSERT:C1129(Length:C16($1)>0;"$1 (type) should not be empty")
ASSERT:C1129(Length:C16($2)>0;"$2 (domain) should not be empty")

$vt_type:=$1
$vt_domain:=$2

OB SET:C1220($vo_identifier;"type";$vt_type)
OB SET:C1220($vo_identifier;"value";$vt_domain)

$0:=$vo_identifier
CLEAR VARIABLE:C89($vo_identifier)