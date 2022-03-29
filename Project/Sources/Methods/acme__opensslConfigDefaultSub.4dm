//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslConfigDefaultSub
  //@scope : private
  //@deprecated : no
  //@description : This function returns the default openssl configuration path
  //@parameter[0-OUT-opensslConfigPath-TEXT] : openssl configuration path
  //@notes : 
  // Dossier 4D(Dossier Resources courant)+"openssl"+Séparateur dossier+"openssl.cnf"
  //@example : acme__opensslConfigDefaultSub
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/04/2019, 13:25:03 - 0.90.05
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_opensslConfigPath)

$vt_opensslConfigPath:=Get 4D folder:C485(Current resources folder:K5:16)+"openssl"+Folder separator:K24:12+"openssl.cnf"

$0:=$vt_opensslConfigPath