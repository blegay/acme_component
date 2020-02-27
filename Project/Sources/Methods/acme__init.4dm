//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__init
  //@scope : private
  //@deprecated : no
  //@description : This method will be called once when the component is initialized
  //@notes :
  //@example : acme__init 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 28/06/2019, 20:10:02 - v1.00.00
  //@xdoc-end
  //================================================================================

If (ENV_isv17OrAbove )  // use Storage to be "thread-safe" compatible
	
	If (Not:C34(OB Is defined:C1231(Storage:C1525;"acme")))  // acme needs to be "inited"
		  //If (Storage.acme#Null)  // this does not work
		
		  // default values
		
		C_TEXT:C284($vt_directoryUrl;$vt_workingDir)
		$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
		$vt_workingDir:=Get 4D folder:C485(Database folder:K5:14;*)
		  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v15:acme_component:source:acme_component.4dbase:"
		
		  // execBitForced is only required on OS X, so on Windows let's say it is already forced...
		C_BOOLEAN:C305($vb_execBitForced)
		$vb_execBitForced:=Choose:C955(ENV_onWindows ;False:C215;True:C214)
		
		  // set the values for the acme config in a shared object
		C_OBJECT:C1216($vo_acmeConfig)
		$vo_acmeConfig:=New shared object:C1526(\
			"workingDir";$vt_workingDir;\
			"directoryUrl";$vt_directoryUrl;\
			"execBitForced";$vb_execBitForced)
		
		  // create a new config shared object with the config object properties
		C_OBJECT:C1216($vo_acme)
		$vo_acme:=New shared object:C1526("config";$vo_acmeConfig)
		
		  // "Storage.acme" will be "private" to the component
		Use (Storage:C1525)
			Storage:C1525.acme:=$vo_acme
			  //Storage.com_ac_consulting_acme:=$vo_acmeConfig
		End use 
		
		  // for instance :
		  // Storage.acme.config.workingDir
		  // Storage.acme.config.directoryUrl
		  // Storage.acme.config.execBitForced
		
		C_TEXT:C284($vt_componentInfos)
		If (ENV__isComponent )
			$vt_componentInfos:=", component "+Choose:C955(Is compiled mode:C492;"compiled";"interpreted")+\
				", host "+Choose:C955(Is compiled mode:C492(*);"compiled";"interpreted")
		Else 
			$vt_componentInfos:=", "+Choose:C955(Is compiled mode:C492;"compiled";"interpreted")
		End if 
		
		C_TEXT:C284($vt_environmentText)
		$vt_environmentText:=ENV_versionStr +" "+\
			Choose:C955(ENV_is64bits ;"(64 bits)";"(32 bits)")+" "+\
			Choose:C955(ENV_onWindows ;"Windows";"macOS")+\
			$vt_componentInfos+\
			", openssl binary version : \""+acme__opensslVersionGet +"\""+\
			", 4D openssl version : \""+acme__openssl4dVersion +"\""
		
		  // "4D v15.6 Final (Build 222813) (32 bits) macOS, compiled, openssl binary version : "OpenSSL 1.0.2o  27 Mar 2018", 4D openssl version : "OpenSSL 1.0.2j  26 Sep 2016""
		  // "4D v18.0 Final (Build 246707) (64 bits) macOS, compiled, openssl binary version : "OpenSSL 1.0.2o  27 Mar 2018", 4D openssl version : "OpenSSL 1.1.1d  10 Sep 2019""
		
		  // send some infos in the log file
		acme__log (4;Current method name:C684;"component acme v"+acme_componentVersionGet +" ("+$vt_environmentText+") init")
		acme__log (4;Current method name:C684;"cipher list : \""+acme_sslCipherListGet +"\"")
		acme__log (4;Current method name:C684;"\"workingDir\" default : \""+$vt_workingDir+"\"")
		acme__log (4;Current method name:C684;"\"directoryUrl\" default : \""+$vt_directoryUrl+"\"")
		
	End if 
	
Else 
	
	  // unfortunately, the thread-safe compiler directive do not work with interprocess variables (v18.0)...
	  //%T-
	UTL_initAuto (-><>vb_ACME_init;"acme__compiler";"acme__initSub")
	  //%T+
	
End if 