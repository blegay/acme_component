//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslConfigDefault
  //@scope : private
  //@deprecated : no
  //@description : This function returns a default config path for openss on Windows 
  //@parameter[0-OUT-configArg-TEXT] : config argument " -config \"C:\.....\openssl.cnf\"")
  //@notes : even on windows the "openssl.cnf" file provided in the component SHOULD have line endings as LF (same file used on Windows and OS X)
  //@example : acme__opensslConfigDefault
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 21/02/2019, 19:37:56 - 0.90.01
  //@xdoc-end
  //================================================================================

Case of 
	: (Is Windows:C1573)
		
		C_TEXT:C284($vt_confPath)
		$vt_confPath:=acme__opensslConfigDefaultSub 
		
		If (Test path name:C476($vt_confPath)=Is a document:K24:1)
			  // set OPENSSL_CONF=C:\OpenSSL-Win32\bin\cnf\openssl.cnf
			C_TEXT:C284($vt_variableName)
			$vt_variableName:="OPENSSL_CONF"
			
			SET ENVIRONMENT VARIABLE:C812($vt_variableName;$vt_confPath)
			
			acme__log (4;Current method name:C684;"set environment variable \""+$vt_variableName+"\" : \""+$vt_confPath+"\"")
		End if 
		
		  //<Modif> Bruno LEGAY (BLE) (27/01/2022) - 2.00.04
	: (Is macOS:C1572)  // on Mac OS
		
		  //TRACE
		  //If (False)
		
		C_TEXT:C284($vt_confPath)
		$vt_confPath:=acme__opensslConfigDefaultSub 
		
		If (Test path name:C476($vt_confPath)=Is a document:K24:1)
			  // set OPENSSL_CONF='/Users/Bruno/Documents/Projets/acme_component/source/acme_component.4dbase/acme_component/Resources/openssl/openssl.cnf'
			
			C_TEXT:C284($vt_confPathPosix)
			$vt_confPathPosix:=UTL_pathToPosixConvert ($vt_confPath;False:C215)
			
			C_TEXT:C284($vt_variableName)
			$vt_variableName:="OPENSSL_CONF"
			
			SET ENVIRONMENT VARIABLE:C812($vt_variableName;$vt_confPathPosix)
			
			acme__log (4;Current method name:C684;"set environment variable \""+$vt_variableName+"\" : \""+$vt_confPathPosix+"\"")
		End if 
		  //end if
		  //<Modif>
		
	Else   // Is Linux ?
		
End case 