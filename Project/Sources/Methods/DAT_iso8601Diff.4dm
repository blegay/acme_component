//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : DAT_iso8601Diff
  //@scope : private
  //@deprecated : no
  //@description : This function returns a difference in seconds between to iso8601 GMT timestamps
  //@parameter[0-OUT-diff-LONGINT] : number of seconds between two iso8601 GMT timestamps (iso8601_a - iso8601_b)
  //@parameter[1-IN-iso8601_a-TEXT] : iso8601_a
  //@parameter[2-IN-iso8601_b-TEXT] : iso8601_b (optional : current date and time)
  //@notes : iso8601 format is "20150323T135657Z"
  //@example : DAT_iso8601Diff
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 08/02/2019, 18:52:37 - 1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$vl_diff)
C_TEXT:C284($1;$vt_iso8601_a)
C_TEXT:C284($2;$vt_iso8601_b)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
$vt_iso8601_a:=$1

If (Count parameters:C259>0)
	
	If (Count parameters:C259=1)
		$vt_iso8601_b:=String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178)
		$vt_iso8601_b:=Replace string:C233($vt_iso8601_b;"-";"";*)
		$vt_iso8601_b:=Replace string:C233($vt_iso8601_b;":";"";*)
	Else 
		$vt_iso8601_b:=$2
	End if 
	
	
	C_DATE:C307($vd_aGmt;$vd_bGmt)
	C_TIME:C306($vh_aGmt;$vh_bGmt)
	DAT_iso8601DateTimeGmt ($vt_iso8601_a;->$vd_aGmt;->$vh_aGmt)
	
	DAT_iso8601DateTimeGmt ($vt_iso8601_b;->$vd_bGmt;->$vh_bGmt)
	  // "2019-02-08T17:36:33Z"
	C_LONGINT:C283($vl_bGmt;$vl_aGmt)
	$vl_aGmt:=DAT_tsNew ($vd_aGmt;$vh_aGmt)
	$vl_bGmt:=DAT_tsNew ($vd_bGmt;$vh_bGmt)
	
	C_LONGINT:C283($vl_diff)  //;$vl_days;$vl_hours)
	$vl_diff:=$vl_aGmt-$vl_bGmt
	
End if 
$0:=$vl_diff