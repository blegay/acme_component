//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__execbitForce
  //@scope : private
  //@deprecated : no
  //@description : This method sets the permissions (execute bit) on a os x binary (chmod 755)
  //@parameter[1-IN-cmdPath-TEXT] : executable path (posix, can be within '' on os x)
  //@notes : 
  // with 4D, on a client, the resources are copied from server and are sometimes losing the unix permissions (and the execute permission)
  // does nothing on Windows
  //@example : acme__execbitForce 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 30/06/2018, 09:06:47 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_cmdPath)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"$1 cmd path cannot be empty")

  //Si (Nombre de paramètres>0)
$vt_cmdPath:=$1

C_BOOLEAN:C305(<>vb_ACME_execBitForced)
If (Not:C34(<>vb_ACME_execBitForced))
	<>vb_ACME_execBitForced:=True:C214
	
	If (ENV_onWindows )  // windows
		
	Else   // os x
		
		C_BOOLEAN:C305($vb_ok)
		C_TEXT:C284($vt_cmd;$vt_in;$vt_out;$vt_err)
		
		$vt_cmd:="/bin/ls -l "+$vt_cmdPath
		$vt_in:=""
		$vt_out:=""
		$vt_err:=""
		
		If (False:C215)
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")  // windows only
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"true")  // BLOCKING mode by default
		End if 
		
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";Get 4D folder:C485(Database folder:K5:14;*))
		
		LAUNCH EXTERNAL PROCESS:C811($vt_cmd;$vt_in;$vt_out;$vt_err)
		$vb_ok:=(ok=1)
		
		$vt_out:=acme__removeLastWhitespaces ($vt_out)
		$vt_err:=acme__removeLastWhitespaces ($vt_err)
		
		acme__moduleDebugDateTimeLine (4;Current method name:C684;"command : \""+$vt_cmd+"\", in : \""+$vt_in+"\", out : \""+$vt_out+"\", err : \""+$vt_err+"\". "+Choose:C955($vb_ok;"[OK]";"[KO]"))
		
		If (Substring:C12($vt_out;1;10)#"-rwxr-xr-x")
			
			  //$vt_cmd:="/bin/chmod ugo+rx,go-w "+$vt_cmdPath
			$vt_cmd:="/bin/chmod 755 "+$vt_cmdPath
			$vt_in:=""
			$vt_out:=""
			$vt_err:=""
			
			LAUNCH EXTERNAL PROCESS:C811($vt_cmd;$vt_in;$vt_out;$vt_err)
			$vb_ok:=(ok=1)
			
			$vt_out:=acme__removeLastWhitespaces ($vt_out)
			$vt_err:=acme__removeLastWhitespaces ($vt_err)
			
			acme__moduleDebugDateTimeLine (4;Current method name:C684;"command : \""+$vt_cmd+"\", in : \""+$vt_in+"\", out : \""+$vt_out+"\", err : \""+$vt_err+"\". "+Choose:C955($vb_ok;"[OK]";"[KO]"))
		End if 
	End if 
	
End if 

  //Fin de si 
