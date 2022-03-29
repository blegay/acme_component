//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__progressInit
  //@scope : private 
  //@deprecated : no
  //@description : This method inits the progress (opens a progress window)
  //@parameter[1-IN-titleResname-TEXT] : titleResname
  //@notes : 
  //@example : acme__progressInit
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 17/01/2022, 14:29:56 - 2.00.03
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_titleResname)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_titleResname:=$1

C_BOOLEAN:C305($vb_isHeadless;$vb_launchedAsService;$vb_isPreemptive)
$vb_isHeadless:=acme__isHeadless 
$vb_launchedAsService:=acme__launchedAsService 
$vb_isPreemptive:=ENV_isPreemptive 

C_BOOLEAN:C305($vb_progress)
$vb_progress:=Not:C34($vb_isHeadless | $vb_launchedAsService | $vb_isPreemptive)

If ($vb_progress)
	C_LONGINT:C283($vl_progressId)
	
	C_TEXT:C284($vt_title)
	$vt_title:=Get localized string:C991($vt_titleResname)
	
	  //%T-
	  //$vl_progressId:=Progress New
	  //Progress SET TITLE($vl_progressId;$vt_title)
	EXECUTE METHOD:C1007("Progress New";$vl_progressId)
	EXECUTE METHOD:C1007("Progress SET TITLE";*;$vl_progressId;$vt_title)
	  //%T+
	
	Use (Storage:C1525.acme)
		Storage:C1525.acme.progressId:=$vl_progressId
	End use 
	
	acme__log (4;Current method name:C684;"new progress, progressId : "+String:C10($vl_progressId)+\
		", title : \""+$vt_title+"\""+\
		", headless : "+Choose:C955($vb_isHeadless;"true";"false")+\
		", launchedAsService : "+Choose:C955($vb_launchedAsService;"true";"false")+\
		", preemptive : "+Choose:C955($vb_isPreemptive;"true";"false"))
Else 
	
	acme__log (4;Current method name:C684;"no progress"+\
		", headless : "+Choose:C955($vb_isHeadless;"true";"false")+\
		", launchedAsService : "+Choose:C955($vb_launchedAsService;"true";"false")+\
		", preemptive : "+Choose:C955($vb_isPreemptive;"true";"false"))
End if 