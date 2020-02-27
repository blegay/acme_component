//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__keyFileProtect
  //@scope : private
  //@deprecated : no
  //@description : This function disables read permissions to "group" and "others"
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-privateKeyPath-TEXT] : private key path
  //@notes : 
  // it is important to secure and restrict the access to the private key
  // OS X only, 
  //@example : acme__keyFileProtect ("file") <=> chmod 600 'file'
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 03/07/2018, 08:49:59 - 1.0
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_privateKeyPath)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"$1 is empty")
ASSERT:C1129(Test path name:C476($1)=Is a document:K24:1;"$1 (\""+$1+"\") file not found")

$vb_ok:=False:C215
$vt_privateKeyPath:=$1

If (ENV_onWindows )
	$vb_ok:=True:C214
	
	If (False:C215)  // #todo : how do we protect files on windows ? chmod 600 equivalent
		
		C_TEXT:C284($vt_cmd;$vt_in;$vt_out;$vt_err)
		
		$vt_cmd:=""
		$vt_in:=""
		$vt_out:=""
		$vt_err:=""
		
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")  // windows only
		If (False:C215)
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"true")  // BLOCKING_EXTERNAL_PROCESS is "true" by default
		End if 
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";Get 4D folder:C485(Database folder:K5:14;*))
		
		LAUNCH EXTERNAL PROCESS:C811($vt_cmd;$vt_in;$vt_out;$vt_err)
		$vb_ok:=(ok=1)
		
		
		  // attrib -R filename ?
	End if 
	
	acme__log (2;Current method name:C684;"protecting file \""+$vt_privateKeyPath+"\" on windows ?")
	
Else 
	
	C_TEXT:C284($vt_cmd;$vt_in;$vt_out;$vt_err)
	
	$vt_cmd:="/bin/chmod 600 "+UTL_pathToPosixConvert ($vt_privateKeyPath)
	$vt_in:=""
	$vt_out:=""
	$vt_err:=""
	
	If (False:C215)
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")  // windows only
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"true")  // BLOCKING_EXTERNAL_PROCESS is "true" by default
	End if 
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";Get 4D folder:C485(Database folder:K5:14;*))
	
	LAUNCH EXTERNAL PROCESS:C811($vt_cmd;$vt_in;$vt_out;$vt_err)
	$vb_ok:=(ok=1)
	
	acme__log (4;Current method name:C684;"command : \""+$vt_cmd+"\", in : \""+$vt_in+"\", out : \""+$vt_out+"\", err : \""+$vt_err+"\". "+Choose:C955($vb_ok;"[OK]";"[KO]"))
	
End if 
$0:=$vb_ok