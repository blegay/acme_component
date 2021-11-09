//%attributes = {"invisible":false,"shared":true,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_challengeStartTest
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@notes : 
  //@example : acme_challengeStartTest
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 17:48:57 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($vt_authorization)
$vt_authorization:="https://acme-staging-v02.api.letsencrypt.org/acme/authz/UOO_ci1UceWAs7yIsqkjKaZCgRwbmY3EfkcqemjwsLI"

C_OBJECT:C1216($vo_authorizationObj)
ASSERT:C1129(acme_authorizationGet ($vt_authorization;->$vo_authorizationObj))

