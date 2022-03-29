//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__progressDeinit
  //@scope : private 
  //@deprecated : no
  //@description : This method deinits the progress (closes the progress window)
  //@notes : 
  //@example : acme__progressDeinit
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 17/01/2022, 14:30:00 - 2.00.03
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($vl_progressId)
$vl_progressId:=Storage:C1525.acme.progressId

If ($vl_progressId#0)
	
	Use (Storage:C1525.acme)
		Storage:C1525.acme.progressId:=0
	End use 
	
	acme__log (4;Current method name:C684;"progress close, progressId : "+String:C10($vl_progressId))
	
	  //%T-
	EXECUTE METHOD:C1007("Progress QUIT";*;$vl_progressId)
	  //Progress QUIT($vl_progressId)
	  //%T+
End if 
