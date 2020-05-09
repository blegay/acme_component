//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : ENV_isPreemptive
  //@scope : public
  //@deprecated : no
  //@description : This function returns TRUE if the current process is running in pre-emptive mode, FALSE otherwise
  //@parameter[0-OUT-ispre-emptive-BOOLEAN] : TRUE if current process is pre-emptive, FALSE otherwise
  //@notes :
  //
  //  If (False)  // not thread safe
  //    If (Not(ENV_isPreemptive ))
  //      //%T-
  //      SET TEXT TO PASTEBOARD(JSON Stringify($vo_httpServerHeaderObject;*))
  //      //%T+
  //    End if 
  //  End if 
  //
  //@example : ENV_isPreemptive 
  //@see : https://blog.4d.com/coexistence-of-thread-safe-and-non-thread-safe-commands/
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 18/02/2020, 19:59:52 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_isPreemptive)

C_TEXT:C284($vt_processName)
C_LONGINT:C283($vl_processState;$vl_procTimeTicks;$vl_flags)
  //C_LONGINT($vl_uniqueId;$vl_origin)

PROCESS PROPERTIES:C336(Current process:C322;$vt_processName;$vl_processState;$vl_procTimeTicks;$vl_flags)  //;$vl_uniqueId;$vl_origin)

  //C_BOOLEAN($vb_isVisible)
  //$vb_isVisible:=($vl_flags ?? 0)
$vb_isPreemptive:=($vl_flags ?? 1)

$0:=$vb_isPreemptive