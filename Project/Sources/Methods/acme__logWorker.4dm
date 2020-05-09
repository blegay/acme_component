//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : acme__logWorker
  //@scope : public
  //@deprecated : no
  //@description : This method is a simple/crude worker which writes log messages onto disk
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-moduleCode-TEXT] : module code
  //@parameter[2-IN-level-LONGINT] : log level
  //@parameter[3-IN-methodName-TEXT] : method name
  //@parameter[4-IN-debugMessage-TEXT] : debug message
  //@notes :
  //@example : acme__logWorker 
  //@see : acme__log
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 17/02/2020, 21:45:16 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_moduleCode)
C_LONGINT:C283($2;$vl_level)
C_TEXT:C284($3;$vt_methodName)
C_TEXT:C284($4;$vt_debugMessage)

If (Count parameters:C259>3)
	$vt_moduleCode:=$1
	$vl_level:=$2
	$vt_methodName:=$3
	$vt_debugMessage:=$4
	
	C_TEXT:C284($vt_logDir)
	$vt_logDir:=Get 4D folder:C485(Logs folder:K5:19;*)
	
	If (Test path name:C476($vt_logDir)=Is a folder:K24:2)
		
		C_TEXT:C284($vt_endOfLine)
		$vt_endOfLine:=Choose:C955(Is Windows:C1573;"\r\n";"\n")
		
		$vt_debugMessage:=Replace string:C233($vt_debugMessage;"\r";$vt_endOfLine;*)
		
		C_TEXT:C284($vt_timestamp)
		$vt_timestamp:=Timestamp:C1445  // "2020-02-17T20:43:38.712Z"
		
		C_TEXT:C284($vt_line)
		$vt_line:=$vt_timestamp+" - "+$vt_moduleCode+" - "+String:C10($vl_level;"00")+" - "+$vt_methodName+" ==> "+$vt_debugMessage+$vt_endOfLine
		
		C_TEXT:C284($vt_filepath)
		$vt_filepath:=$vt_logDir+"acme_"+Substring:C12($vt_timestamp;1;10)+".log"
		
		  // install an error handler that will ignore errors
		C_TEXT:C284($vt_onErrorCallPrevious)
		$vt_onErrorCallPrevious:=Method called on error:C704
		ON ERR CALL:C155("acme__logWorkerErrHdlr")
		
		C_TIME:C306($vh_docRef)
		
		If (Test path name:C476($vt_filepath)#Is a document:K24:1)
			
			  // create log file and write message
			$vh_docRef:=Create document:C266($vt_filepath)
			If (ok=1)
				SEND PACKET:C103($vh_docRef;$vt_line)
				CLOSE DOCUMENT:C267($vh_docRef)
			End if 
			
		Else 
			
			  // append message at the end of the log file
			C_TIME:C306($vh_docRef)
			$vh_docRef:=Append document:C265($vt_filepath)
			If (ok=1)
				SEND PACKET:C103($vh_docRef;$vt_line)
				CLOSE DOCUMENT:C267($vh_docRef)
			End if 
			
		End if 
		
		  // restore initial error handler
		ON ERR CALL:C155($vt_onErrorCallPrevious)
		
	End if 
End if 
