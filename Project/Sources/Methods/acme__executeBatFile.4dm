//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__executeBatFile
  //@scope : private
  //@deprecated : no
  //@description : This function executes a batch file
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if
  //@parameter[1-IN-batfile-TEXT] : bat file path
  //@parameter[2-OUT-outPtr-POINTER] : out text pointer (modified)
  //@parameter[3-OUT-errPtr-POINTER] : err text pointer (modified)
  //@notes : 
  //@example : acme__executeBatFile
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/04/2019, 13:33:13 - 0.90.05
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_batfile)
C_POINTER:C301($2;$vp_outPtr)
C_POINTER:C301($3;$vp_errPtr)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(Type:C295($2->)=Is text:K8:3;"$2/out should be a text pointer")
ASSERT:C1129(Type:C295($3->)=Is text:K8:3;"$3/err should be a text pointer")

ASSERT:C1129(Test path name:C476($1)=Is a document:K24:1;"file \""+$1+"\" not found")

$vb_ok:=False:C215
$vt_batfile:=$1
$vp_outPtr:=$2
$vp_errPtr:=$3

If (ENV_onWindows )
	
	C_TEXT:C284($vt_batfilePosix)
	$vt_batfilePosix:=UTL_pathToPosixConvert ($vt_batfile)
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";Get 4D folder:C485(Database folder:K5:14;*))
	
	C_TEXT:C284($vt_in;$vt_out;$vt_err)
	$vt_in:=""
	$vt_out:=""
	$vt_err:=""
	
	  // timer start
	C_LONGINT:C283($vl_ms)
	$vl_ms:=Milliseconds:C459
	
	LAUNCH EXTERNAL PROCESS:C811($vt_batfilePosix;$vt_in;$vt_out;$vt_err)
	$vb_ok:=(ok=1)
	
	  // timer stop
	$vl_ms:=UTL_durationDifference ($vl_ms;Milliseconds:C459)
	
	$vp_outPtr->:=$vt_out
	$vp_errPtr->:=$vt_err
	
	If ($vb_ok)
		acme__moduleDebugDateTimeLine (4;Current method name:C684;"bat file \""+$vt_batfilePosix+"\""+", in : \""+$vt_in+"\""+", out : \""+$vt_out+"\""+", err : \""+$vt_err+"\""+", duration : "+UTL_durationMsDebug ($vl_ms)+" success. [OK]")
	Else 
		acme__moduleDebugDateTimeLine (2;Current method name:C684;"bat file \""+$vt_batfilePosix+"\""+", in : \""+$vt_in+"\""+", out : \""+$vt_out+"\""+", err : \""+$vt_err+"\""+", duration : "+UTL_durationMsDebug ($vl_ms)+" failed. [KO]")
	End if 
	
End if 

$0:=$vb_ok