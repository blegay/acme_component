//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__initSub
  //@scope : private
  //@deprecated : no
  //@description : This method will initialize the interprocess variables
  //@notes :
  //@example : acme__initSub 
  //@see : acme__init
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 28/06/2019, 20:16:04 - v1.00.00
  //@xdoc-end
  //================================================================================

  //DBG__dbgInitAuto (-><>vt_ACME_dbgMethodName)

  //  //<Modif> Bruno LEGAY (BLE) (06/12/2019)
  //C_TEXT($vt_environmentText)
  //$vt_environmentText:=ENV_versionStr +" "+Choose(ENV_is64bits ;"(64 bits)";"(32 bits)")+" "+Choose(Is windows ;"Windows";"macOS")+", openssl binary version : \""+acme__opensslVersionGet +"\""+", 4D openssl version : \""+acme__openssl4dVersion +"\""

  //  // "4D v15.6 Final (Build 222813) (32 bits) macOS, openssl binary version : "OpenSSL 1.0.2o  27 Mar 2018", 4D openssl version : "OpenSSL 1.0.2j  26 Sep 2016""

  //acme__log (4;Current method name;"component acme v"+acme_componentVersionGet +"("+$vt_environmentText+") init")

  //acme__log (4;Current method name;"cipher list : \""+acme_sslCipherListGet +"\"")

  //  //  //<Modif> Bruno LEGAY (BLE) (13/03/2019)
  //  //C_TEXTE($vt_openSsl4DlibVers)
  //  //C_RÉEL($vr_result)
  //  //C_ENTIER LONG($vl_param)
  //  //$vl_param:=94  // SSL version string
  //  //$vr_result:=Lire paramètre base($vl_param;$vt_openSsl4DlibVers)  // e.g. "OpenSSL 1.0.2j  26 Sep 2016" (4D v15.6)
  //  //acme__moduleDebugDateTimeLine (4;Nom méthode courante;ENV_versionStr +", 4D openssl library version "+$vt_openSsl4DlibVers)
  //  //  //<Modif>
  //  //<Modif>

  //If (Length(<>vt_ACME_workingDir)=0)
  //C_TEXT($vt_baseDir)
  //$vt_baseDir:=Get 4D folder(Database folder;*)

  //  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v15:acme_component:source:acme_component.4dbase:"
  //<>vt_ACME_workingDir:=$vt_baseDir

  //  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v15:acme_component:source:acme_component.4dbase:"
  //  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v15:acme_component:source:"
  //  //<>vt_ACME_workingDir:=FS_pathToParent ($vt_baseDir)

  //acme__log (4;Current method name;"\"workingDir\" default : \""+<>vt_ACME_workingDir+"\"")
  //End if 

  //If (Length(<>vt_ACME_directoryUrl)=0)
  //<>vt_ACME_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
  //acme__log (4;Current method name;"\"directoryUrl\" default : \""+<>vt_ACME_directoryUrl+"\"")
  //End if 

  //acme__log (4;Current method name;"assertions : "+Choose(Get assert enabled;"enabled";"disabled"))
