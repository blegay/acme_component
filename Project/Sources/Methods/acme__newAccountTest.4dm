//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_newAccountTest
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@notes : 
  //@example : acme_newAccountTest
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 09:26:15 - 1.00.00
  //@xdoc-end
  //================================================================================

ARRAY TEXT:C222($tt_contacts;0)
APPEND TO ARRAY:C911($tt_contacts;"mailto:john@example.com")

C_OBJECT:C1216($vo_payload)
  //OB FIXER($vo_payload;"termsOfServiceAgreed";Vrai)
  //OB FIXER TABLEAU($vo_payload;"contact";$tt_contacts)

  //C_TEXTE($vt_directoryUrl)
  //$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
  //  //$vt_directoryUrl:="https://acme-staging-v02.api.letsencrypt.org/directory"
  //C_TEXTE($vt_workingDir)
  //$vt_workingDir:=FS_pathToParent (Dossier 4D(Dossier base;*))

  //TABLEAU TEXTE($tt_contacts;0)
  //AJOUTER À TABLEAU($tt_contacts;"mailto:blegay@example.com")

  //$vo_payload:=acme_newAccountObject (->$tt_contacts;Vrai)  //;$vt_directoryUrl;$vt_workingDir)

C_TEXT:C284($vt_contact)
$vt_contact:="mailto:blegay@example.com"
$vo_payload:=acme_newAccountObject (->$tt_contacts;True:C214)

acme_newAccount ($vo_payload)

  //;"Macintosh HD:Users:ble:Documents:Projets:BaseRef_v15:acme_component:source:acme_component.4dbase:Resources:testcases:signature:")

  //MONTRER SUR DISQUE($vt_workingDir)