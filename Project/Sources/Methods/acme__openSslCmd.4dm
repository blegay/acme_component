//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__openSslCmd
  //@scope : private
  //@deprecated : no
  //@description : This function runs some openssl command
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-args-TEXT] : openssl args
  //@parameter[2-IN-inPtr-POINTER] : input stream text of blob pointer (not modified)
  //@parameter[3-OUT-outPtr-POINTER] : output stream text of blob pointer (modified)
  //@parameter[4-OUT-errPtr-POINTER] : error stream text of blob pointer (modified)
  //@notes : 
  //@example : acme__openSslCmd
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:36:29 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_args)
C_POINTER:C301($2;$vp_inPtr)
C_POINTER:C301($3;$vp_outPtr)
C_POINTER:C301($4;$vp_errPtr)
  //C_BOOLÉEN($5;$vb_checkErrorLevelOnWindows)

ASSERT:C1129(Count parameters:C259>3;"requires 4 parameters")
ASSERT:C1129(Length:C16($1)>0;"$1 openssl args cannot be empty")
ASSERT:C1129((Type:C295($2->)=Is text:K8:3) | (Type:C295($2->)=Is BLOB:K8:12);"$2 should be a text or blob pointer")
ASSERT:C1129((Type:C295($3->)=Is text:K8:3) | (Type:C295($3->)=Is BLOB:K8:12);"$3 should be a text or blob pointer")
ASSERT:C1129((Type:C295($4->)=Is text:K8:3) | (Type:C295($4->)=Is BLOB:K8:12);"$4 should be a text or blob pointer")

$vb_ok:=False:C215
$vt_args:=$1
$vp_inPtr:=$2
$vp_outPtr:=$3
$vp_errPtr:=$4

C_TEXT:C284($vt_openSslPath)
$vt_openSslPath:=acme__opensslPathGet 

acme__execbitForce ($vt_openSslPath)

C_TEXT:C284($vt_openSslCmd)
$vt_openSslCmd:=$vt_openSslPath+" "+$vt_args

If (ENV_onWindows )
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")  // windows only
End if 
If (False:C215)
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"true")  // BLOCKING_EXTERNAL_PROCESS is "true" by default
End if 
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";Get 4D folder:C485(Database folder:K5:14;*))

  // timer
C_LONGINT:C283($vl_ms)
$vl_ms:=Milliseconds:C459

LAUNCH EXTERNAL PROCESS:C811($vt_openSslCmd;$vp_inPtr->;$vp_outPtr->;$vp_errPtr->)
$vb_ok:=(ok=1)

  // timer
$vl_ms:=UTL_durationDifference ($vl_ms;Milliseconds:C459)

C_TEXT:C284($vt_inDebug;$vt_outDebug;$vt_errDebug)
If ((Type:C295($vp_inPtr->)=Is text:K8:3))
	$vt_inDebug:=$vp_inPtr->
End if 

If ((Type:C295($vp_outPtr->)=Is text:K8:3))
	$vt_outDebug:=$vp_outPtr->
End if 

If ((Type:C295($vp_errPtr->)=Is text:K8:3))
	$vt_errDebug:=$vp_errPtr->
End if 

If ($vb_ok)
	acme__log (4;Current method name:C684;"cmd \""+$vt_openSslCmd+"\""+", in : \""+$vt_inDebug+"\""+", out : \""+$vt_outDebug+"\""+", err : \""+$vt_errDebug+"\""+", duration : "+UTL_durationMsDebug ($vl_ms)+" success. [OK]")
Else 
	acme__log (2;Current method name:C684;"cmd \""+$vt_openSslCmd+"\""+", in : \""+$vt_inDebug+"\""+", out : \""+$vt_outDebug+"\""+", err : \""+$vt_errDebug+"\""+", duration : "+UTL_durationMsDebug ($vl_ms)+" failed. [KO]")
End if 

$0:=$vb_ok