//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_accountStatusTest
  //@scope : public
  //@deprecated : no
  //@description : This method is a test method
  //@notes : 
  //@example : acme_accountStatusTest
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2019, 07:25:02 - 0.90.07
  //@xdoc-end
  //================================================================================

C_TEXT:C284($vt_directoryUrl)
$vt_directoryUrl:="https://acme-staging-v02.api.letsencrypt.org/directory"

C_TEXT:C284($vt_url)
$vt_url:="https://acme-staging-v02.api.letsencrypt.org/acme/acct/6332152"
  //$vt_url:="https://acme-staging-v02.api.letsencrypt.org/acme/acct/6332152"

C_TEXT:C284($vt_workingDir)
$vt_workingDir:=FS_pathToParent (Get 4D folder:C485(Database folder:K5:14;*))

C_OBJECT:C1216($vo_accountObject)

acme_accountStatus ($vt_directoryUrl;$vt_url;->$vo_accountObject;$vt_workingDir)
