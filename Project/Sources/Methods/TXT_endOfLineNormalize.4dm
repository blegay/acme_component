//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : TXT_endOfLineNormalize
  //@scope : public
  //@deprecated : no
  //@description : This function will convert the end of line characters
  //@parameter[0-OUT-out-TEXT] : text
  //@parameter[1-IN-in-TEXT] : text
  //@parameter[2-IN-mode-LONGINT] : mode (optional default "Document with native format" i.e. 1)
  //@notes : 
  // mode values are identical to TEXT TO DOCUMENT (same constants)
  // - Document unchanged (0)
  // - Document with native format (1) 
  // - Document with CRLF (2)
  // - Document with CR (3)
  // - Document with LF (4)
  //@example : TXT_endOfLineNormalize
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/04/2019, 15:21:35 - 0.90.05
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_out)
C_TEXT:C284($1;$vt_in)
C_LONGINT:C283($2;$vl_mode)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_out:=""
$vt_in:=$1

If (Count parameters:C259>1)
	$vl_mode:=$2
Else 
	$vl_mode:=Document with native format:K24:19
End if 

If (Length:C16($vt_in)>0)
	Case of 
		: ($vl_mode=Document unchanged:K24:18)  // 0
			$vt_out:=$vt_in
			
		: ($vl_mode=Document with native format:K24:19)  // 1
			
			If (Is Windows:C1573)
				  //$vt_out:=UTL_normalize ($vt_in;Document avec CRLF)
				$vt_out:=Replace string:C233($vt_in;"\r\n";"\r";*)
				$vt_out:=Replace string:C233($vt_out;"\n";"\r";*)
				$vt_out:=Replace string:C233($vt_out;"\r";"\r\n";*)
			Else 
				  //$vt_out:=UTL_normalize ($vt_in;Document avec CR)
				$vt_out:=Replace string:C233($vt_in;"\r\n";"\r";*)
				$vt_out:=Replace string:C233($vt_out;"\n";"\r";*)
			End if 
			
		: ($vl_mode=Document with CRLF:K24:20)  // 2
			$vt_out:=Replace string:C233($vt_in;"\r\n";"\r";*)
			$vt_out:=Replace string:C233($vt_out;"\n";"\r";*)
			$vt_out:=Replace string:C233($vt_out;"\r";"\r\n";*)
			
		: ($vl_mode=Document with CR:K24:21)  // 3
			$vt_out:=Replace string:C233($vt_in;"\r\n";"\r";*)
			$vt_out:=Replace string:C233($vt_out;"\n";"\r";*)
			
		: ($vl_mode=Document with LF:K24:22)  // 4
			$vt_out:=Replace string:C233($vt_in;"\r\n";"\n";*)
			$vt_out:=Replace string:C233($vt_out;"\r";"\n";*)
			
		Else 
			ASSERT:C1129(False:C215;"invalid mode : "+String:C10($vl_mode))
	End case 
	
End if 

$0:=$vt_out