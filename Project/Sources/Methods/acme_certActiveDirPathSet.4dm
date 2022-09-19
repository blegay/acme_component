//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certActiveDirPathSet
  //@scope : private 
  //@deprecated : no
  //@description : This method allow to specify a different dir for the certificate (other than the default one)
  //@parameter[1-IN-activeCertificateDirPath-TEXT] : active certificates dir path
  //@notes : 
  //@example : acme_certActiveDirPathSet
  //@see : acme__certActiveDirPathDfltGet
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 19/09/2022, 14:52:14 - 2.00.06
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_certActiveDir)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_certActiveDir:=$1

If (ENV_isv17OrAbove )
	
	If (Substring:C12($vt_certActiveDir;Length:C16($vt_certActiveDir);1)#Folder separator:K24:12)
		$vt_certActiveDir:=$vt_certActiveDir+Folder separator:K24:12
	End if 
	
	If (Test path name:C476($vt_certActiveDir)=Is a folder:K24:2)
		
		If (Storage:C1525.acme=Null:C1517)
			acme__init 
		End if 
		
		If (Storage:C1525.acme.config.certificateDir#$vt_certActiveDir)
			
			Use (Storage:C1525.acme.config)
				Storage:C1525.acme.config.certificateDir:=$vt_certActiveDir
			End use 
			
			acme__log (4;Current method name:C684;"active certificates dir path : \""+$vt_certActiveDir+"\"")
		End if 
		
	Else 
		acme__log (4;Current method name:C684;"dir path : \""+$vt_certActiveDir+"\" not found")
	End if 
	
End if 