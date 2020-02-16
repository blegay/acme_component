//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_httpChallengePrepareTest
  //@scope : public
  //@deprecated : no
  //@description : This is a test method
  //@notes : 
  //@example : acme_httpChallengePrepareTest
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 14:17:58 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($vt_authorizationUrl)
$vt_authorizationUrl:="https://acme-staging-v02.api.letsencrypt.org/acme/authz/nPPN9UEJ8tS7Rdv0_BaPCX9CloLi-XpZ3vQHjSHu0Yk"

ASSERT:C1129(acme_httpChallengePrepare ($vt_authorizationUrl))

  //C_TEXTE($vt_workingDir)
  //$vt_workingDir:=FS_pathToParent (Dossier 4D(Dossier base;*))

  //C_TEXTE($vt_directoryUrl)
  //$vt_directoryUrl:="https://acme-staging-v02.api.letsencrypt.org/directory"

  //ASSERT(acme_httpChallengePrepare ($vt_directoryUrl;$vt_workingDir;$vt_authorizationUrl))

