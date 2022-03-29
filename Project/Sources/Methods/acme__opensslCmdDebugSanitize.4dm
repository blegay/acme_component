//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslCmdDebugSanitize
  //@scope : private 
  //@deprecated : no
  //@description : This function returns an openssl cmd with password hidden for logs
  //@parameter[0-OUT-opensslCmd-TEXT] : openssl commande sanitized
  //@parameter[1-IN-opensslCmd-TEXT] : openssl command
  //@notes : 
  // acme__opensslCmdDebugSanitize ("... -passin pass:password -passout pass:password -nodes .. ") =>  "... -passin pass:pa****rd -passout pass:pa****rd -nodes .. "
  // acme__opensslCmdDebugSanitize ("... -passin pass:password -passout pass:password") => "... -passin pass:pa****rd -passout pass:pa****rd"
  //
  // ASSERT(acme__opensslCmdDebugSanitize ("... -passin pass:password -passout pass:password -nodes .. ")="... -passin pass:pa****rd -passout pass:pa****rd -nodes .. ")
  // ASSERT(acme__opensslCmdDebugSanitize ("... -passin pass:password -passout pass:password")="... -passin pass:pa****rd -passout pass:pa****rd")
  //@example : Méthode 298
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 26/01/2022, 14:23:42 - 2.00.04
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_cmd)
C_TEXT:C284($1)  // $vt_cmd   

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_cmd:=$1

If (Length:C16($vt_cmd)>0)
	
	  // seach for text (one character or more, non greedy) after whitespace followed by "pass:" and stop when reaching fisrt whitespace or end of text
	C_TEXT:C284($vt_regex)
	$vt_regex:="(?i)\\spass:(.+?)(?:\\s|$)"
	
	C_LONGINT:C283($vl_start)
	$vl_start:=1
	
	ARRAY LONGINT:C221($tl_pos;0)
	ARRAY LONGINT:C221($tl_len;0)
	
	  // find the next start tag
	C_LONGINT:C283($vl_pos;$vl_len)
	While (Match regex:C1019($vt_regex;$vt_cmd;$vl_start;$tl_pos;$tl_len))
		C_LONGINT:C283($vl_pos;$vl_len)
		$vl_pos:=$tl_pos{1}
		$vl_len:=$tl_len{1}
		
		C_TEXT:C284($vt_passwordDebug)
		$vt_passwordDebug:=TXT_passwordDebug (Substring:C12($vt_cmd;$vl_pos;$vl_len))
		
		$vt_cmd:=Change string:C234($vt_cmd;$vt_passwordDebug;$vl_pos)
		
		$vl_start:=$vl_pos+Length:C16($vt_passwordDebug)
	End while 
	
End if 

$0:=$vt_cmd