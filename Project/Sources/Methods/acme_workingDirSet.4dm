//%attributes = {"shared":true}
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
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
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
		
		If (Not:C34(TXT_isEqualStrict (<>vt_ACME_workingDir;$vt_workingDir)))
			acme__moduleDebugDateTimeLine (4;Current method name:C684;"setting \"workingDir\" : \""+$vt_workingDir+"\"")
			<>vt_ACME_workingDir:=$vt_workingDir
		End if 
	End if 
	
End if 