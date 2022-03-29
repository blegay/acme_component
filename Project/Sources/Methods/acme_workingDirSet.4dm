//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_workingDirSet
  //@scope : public
  //@deprecated : no
  //@description : This method sets the working directory
  //@parameter[1-IN-workingDir-TEXT] : working directory
  //@notes : interprocess scope
  // the folder needs to be writable, default is : Get 4D folder (Database folder)
  //@example : acme_workingDirSet
  //@see : acme_workingDirGet
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 12/02/2019, 19:41:35 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_workingDir)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"\"workingDir\" parameter is empty")
ASSERT:C1129(Test path name:C476($1)=Is a folder:K24:2;"\"workingDir\" (\""+$1+"\" ) parameter is not a directory")

acme__init 

If (Count parameters:C259>0)
	$vt_workingDir:=$1
	
	If (Test path name:C476($vt_workingDir)=Is a folder:K24:2)
		
		If (Substring:C12($vt_workingDir;Length:C16($vt_workingDir);1)#Folder separator:K24:12)
			$vt_workingDir:=$vt_workingDir+Folder separator:K24:12
		End if 
		
		If (ENV_isv17OrAbove )  // use Storage to be "thread-safe" compatible
			
			If (Not:C34(TXT_isEqualStrict (Storage:C1525.acme.config.workingDir;$vt_workingDir)))
				
				acme__log (4;Current method name:C684;"setting \"workingDir\" : \""+$vt_workingDir+"\"")
				
				Use (Storage:C1525.acme)  // locking "Storage.acme" or "Storage.acme.config" is just the same
					Storage:C1525.acme.config.workingDir:=$vt_workingDir
				End use 
				
			End if 
		Else 
			
			  // unfortunately, the thread-safe compiler directive do not work with interprocess variables (v18.0)...
			  //%T-
			  //%T// If (Not(TXT_isEqualStrict (<>vt_ACME_workingDir;$vt_workingDir)))
			  //%T// acme__log (4;Current method name;"setting \"workingDir\" : \""+$vt_workingDir+"\"")
			  //%T// <>vt_ACME_workingDir:=$vt_workingDir
			  //%T// End if 
			  //%T+
		End if 
		
	End if 
	
End if 