//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
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
	
	If (Storage:C1525.acme=Null:C1517)
		
		C_TEXT:C284($vt_directoryUrl;$vt_workingDir)
		$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
		$vt_workingDir:=Get 4D folder:C485(Database folder:K5:14;*)
		  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v15:acme_component:source:acme_component.4dbase:"
		
		  // set the values for the acme config in a shared object
		C_OBJECT:C1216($vo_acmeConfig)
		$vo_acmeConfig:=New shared object:C1526(\
			"workingDir";$vt_workingDir;\
			"directoryUrl";$vt_directoryUrl;\
			"certificateDir";"";\
			"opensslPath";acme__opensslPathGet ;\
			"execBitForced";Choose:C955(Is macOS:C1572;False:C215;Null:C1517);\
			"progressId";0)
		
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
		  // Storage.acme.config.
		
		C_TEXT:C284($vt_componentInfos)
		If (ENV__isComponent )
			$vt_componentInfos:=", component "+Choose:C955(Is compiled mode:C492;"compiled";"interpreted")+\
				", host "+Choose:C955(Is compiled mode:C492(*);"compiled";"interpreted")
		Else 
			$vt_componentInfos:=", "+Choose:C955(Is compiled mode:C492;"compiled";"interpreted")
		End if 
		
		  // #4D-v19 ... maybe in headless mode, assertions are sent to error log
		
		C_BOOLEAN:C305($vb_isHeadless;$vb_launchedAsService)
		$vb_isHeadless:=acme__isHeadless 
		$vb_launchedAsService:=acme__launchedAsService 
		SET ASSERT ENABLED:C1131(Not:C34($vb_isHeadless | $vb_launchedAsService))
		
		C_TEXT:C284($vt_environmentText)
		$vt_environmentText:=ENV_versionStr +" "+\
			Choose:C955(ENV_is64bits ;"(64 bits)";"(32 bits)")+" "+\
			Choose:C955(Is Windows:C1573;"Windows";"macOS")+\
			$vt_componentInfos+\
			", openssl binary version : \""+acme_opensslVersionGet +"\""+\
			", 4D openssl version : \""+acme__openssl4dVersion +"\""
		
		  // "4D v15.6 Final (Build 222813) (32 bits) macOS, compiled, openssl binary version : "OpenSSL 1.0.2o  27 Mar 2018", 4D openssl version : "OpenSSL 1.0.2j  26 Sep 2016""
		  // "4D v18.0 Final (Build 246707) (64 bits) macOS, compiled, openssl binary version : "OpenSSL 1.0.2o  27 Mar 2018", 4D openssl version : "OpenSSL 1.1.1d  10 Sep 2019""
		  // "4D v18.3 Final (Build 255861) (64 bits) macOS, compiled, openssl binary version : "OpenSSL 1.0.2o  27 Mar 2018", 4D openssl version : "OpenSSL 1.1.1d  10 Sep 2019"
		  // "4D v19.1 Final (Build 273454) (64 bits) macOS, compiled, openssl binary version : "OpenSSL 1.1.1l  24 Aug 2021", 4D openssl version : "OpenSSL 1.1.1l  24 Aug 2021"
		
		  // send some infos in the log file
		acme__log (4;Current method name:C684;"component acme v"+acme_componentVersionGet +" ("+$vt_environmentText+") init")
		acme__log (4;Current method name:C684;"cipher list : \""+acme_sslCipherListGet +"\"")
		acme__log (4;Current method name:C684;"\"workingDir\" default : \""+$vt_workingDir+"\"")
		acme__log (4;Current method name:C684;"\"directoryUrl\" default : \""+$vt_directoryUrl+"\"")
		
		acme__log (4;Current method name:C684;"app type :  "+String:C10(Application type:C494))
		acme__log (4;Current method name:C684;"structure file :  \""+Structure file:C489(*)+"\"")
		
		C_TEXT:C284($vt_certActiveDirGet)
		$vt_certActiveDirGet:=acme__certActiveDirPathDfltGet 
		Use (Storage:C1525)
			Storage:C1525.acme.certificateDir:=$vt_certActiveDirGet
		End use 
		
		acme__log (4;Current method name:C684;"Storage.acme : "+JSON Stringify:C1217($vo_acme))
		acme__log (4;Current method name:C684;"assertions : "+Choose:C955(Get assert enabled:C1130;"enabled";"disabled"))
		
		C_TEXT:C284($vt_webRootFolder)
		$vt_webRootFolder:=Get 4D folder:C485(HTML Root folder:K5:20)
		If (Test path name:C476($vt_webRootFolder)=Is a folder:K24:2)
			acme__log (4;Current method name:C684;"web root folder : \""+$vt_webRootFolder+"\". [OK]")
		Else 
			acme__log (2;Current method name:C684;"web root folder : \""+$vt_webRootFolder+"\" does not exist. [KO]")
		End if 
		
		  // get public ip v4
		C_TEXT:C284($vt_publicIpV4;$vt_url)
		$vt_url:="https://api.ipify.org"  // "?format=jsonp"
		If (HTTP Get:C1157($vt_url;$vt_publicIpV4)=200)
			acme__log (4;Current method name:C684;"public IP v4 : "+$vt_publicIpV4+" (from "+$vt_url+")")
		Else 
			acme__log (2;Current method name:C684;"public IP v4 uknown ("+$vt_url+")")
		End if 
		
		  // get public ip v6
		C_TEXT:C284($vt_publicIpV6)  //;$vt_url
		$vt_url:="https://api64.ipify.org"  // "?format=jsonp"
		If (HTTP Get:C1157($vt_url;$vt_publicIpV6)=200)
			acme__log (4;Current method name:C684;"public IP v6 : "+$vt_publicIpV6+" (from "+$vt_url+")")
		Else 
			acme__log (2;Current method name:C684;"public IP v6 uknown ("+$vt_url+")")
		End if 
		
		  // get system information (architecture, etc...)
		acme__log (4;Current method name:C684;"System infos :\r"+JSON Stringify:C1217(Get system info:C1571;*))
		
		  // #4D-v19-newhttpServer
		If (WEB Is server running:C1313)
			acme__log (4;Current method name:C684;"web server (legacy) is running")
			
			acme_logHttpServerInfos 
			  //  // #4D-v19-newhttpServer
			
			  //C_OBJECT($vo_webServerInfos)
			  //$vo_webServerInfos:=WEB Get server info
			
			  //acme__log (4;Current method name;"4D Web server (legacy) infos :\r"+JSON Stringify($vo_webServerInfos;*))
		Else 
			acme__log (4;Current method name:C684;"web server (legacy) is not running")
		End if 
		
		acme__check4dWebLicence 
		
		C_LONGINT:C283($vl_process)
		$vl_process:=New process:C317("acme__setLocal";0)
		
	End if 
	
Else 
	
	  // unfortunately, the thread-safe compiler directive do not work with interprocess variables (v18.0)...
	  //%T-
	  //%T// UTL_initAuto (-><>vb_ACME_init;"acme__compiler";"acme__initSub")
	  //%T+
	
End if 