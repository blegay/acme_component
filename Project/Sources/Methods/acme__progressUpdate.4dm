//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__progressUpdate
  //@scope : private 
  //@deprecated : no
  //@description : This method update the progress windows message and position
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-progress-LOGINT] : value
  //@parameter[2-IN-message-TEXT] : message
  //@notes : 
  //@example : acme__progressUpdate
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 17/01/2022, 12:10:42 - 2.00.03
  //@xdoc-end
  //================================================================================

C_REAL:C285($1;$vr_progress)
C_TEXT:C284($2;$vt_resName)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")

$vr_progress:=$1
$vt_resName:=$2

C_TEXT:C284($vt_message)
$vt_message:=Get localized string:C991($vt_resName)

C_LONGINT:C283($vl_progressId)
$vl_progressId:=Storage:C1525.acme.progressId
If ($vl_progressId#0)
	
	
	  //%T-
	  //Progress SET PROGRESS($vl_progressId;$vr_progress;$vt_message)
	EXECUTE METHOD:C1007("Progress SET PROGRESS";*;$vl_progressId;$vr_progress;$vt_message)
	  //%T+
	
	acme__log (4;Current method name:C684;"progressId : "+String:C10($vl_progressId)+\
		", progress : "+String:C10($vr_progress)+\
		", resName : \""+$vt_resName+"\""+\
		", message : \""+$vt_message+"\"")
Else 
	
	acme__log (2;Current method name:C684;"no progressId"+\
		", progress : "+String:C10($vr_progress)+\
		", resName : \""+$vt_resName+"\""+\
		", message : \""+$vt_message+"\"")
End if 

