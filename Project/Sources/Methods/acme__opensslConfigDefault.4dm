//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslConfigDefault
  //@scope : private
  //@deprecated : no
  //@description : This function returns a default config path for openss on Windows 
  //@parameter[0-OUT-configArg-TEXT] : config argument " -config \"C:\.....\openssl.cnf\"")
  //@notes : on OS X, default file "/usr/local/ssl/openssl.cnf" will exist ?
  // avoid error " "WARNING: can't open config file: /usr/local/ssl/openssl.cnf"
  //@example : acme__opensslConfigDefault
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 21/02/2019, 19:37:56 - 0.90.01
  //@xdoc-end
  //================================================================================

  //C_TEXTE($0;$vt_configArg)

  //$vt_configArg:=""

If (ENV_onWindows )
	
	If (True:C214)
		C_TEXT:C284($vt_confPath)
		
		  //<Modif> Bruno LEGAY (BLE) (25/04/2019)
		  // meme sur Windows on doit utiliser le fichier de configuration en séparateur LF (pas de CRLF)
		$vt_confPath:=acme__opensslConfigDefaultSub 
		  //$vt_confPath:=Dossier 4D(Dossier Resources courant)+"openssl"+Séparateur dossier+"opensslWin.cnf"
		  //<Modif>
		
		If (Test path name:C476($vt_confPath)=Is a document:K24:1)
			  // set OPENSSL_CONF=C:\OpenSSL-Win32\bin\cnf\openssl.cnf
			C_TEXT:C284($vt_variableName)
			$vt_variableName:="OPENSSL_CONF"
			
			SET ENVIRONMENT VARIABLE:C812($vt_variableName;$vt_confPath)
			
			  //<Modif> Bruno LEGAY (BLE) (25/04/2019)
			  // note : maybe it does not work :  err : "WARNING: can't open config file: /usr/local/ssl/openssl.cnf
			acme__log (4;Current method name:C684;"set environment variable \""+$vt_variableName+"\" : \""+$vt_confPath+"\"")
			  //<Modif>
			
		End if 
		
	Else 
		  // this file makes openssl crash on Windows probably because of this file is LF...
		
		  // this file makes openssl crash on Windows probably because of this file is LF...
		  //$vt_confPath:=Dossier 4D(Dossier Resources courant)+"openssl"+Séparateur dossier+"openssl.cnf"
		
		  //Si (Tester chemin acces($vt_confPath)=Est un document)
		  //$vt_configArg:=" -config "+UTL_pathToPosixConvert ($vt_confPath)
		  //Fin de si 
		
	End if 
	
End if 

  //$0:=$vt_configArg