//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__removeLastWhitespaces
  //@scope : public
  //@deprecated : no
  //@description : This function returns a text without the trailing whitespaces
  //@parameter[0-OUT-textIn-TEXT] : text out
  //@parameter[1-IN-textOut-TEXT] : text in
  //@notes : 
  //@example : acme__removeLastWhitespaces
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 30/06/2018, 08:52:37 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_out)
C_TEXT:C284($1;$vt_in)

$vt_out:=""
$vt_in:=$1

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

C_TEXT:C284($vt_regex)
$vt_regex:="^(?s)(.*?)\\s*$"
If (TXT_regexGetMatchingGroup ($vt_regex;$vt_in;1;->$vt_out))
	
End if 

$0:=$vt_out