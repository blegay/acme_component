//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : TXT_isEqualStrict
  //@scope : private
  //@deprecated : no
  //@description : This function returns  TRUE if both text are stricly equal, FALSE otherwise
  //@parameter[0-OUT-isEqualStrict-BOOLEAN] : TRUE if both text are stricly equal, FALSE otherwise
  //@parameter[1-IN-text2-TEXT] : text
  //@parameter[2-IN-text2-TEXT] : text to compare
  //@notes : two empty strings are considered equal
  //@example : TXT_isEqualStrict
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:48:56 - 1.0
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_isEqualStrict)
C_TEXT:C284($1;$vt_text1)
C_TEXT:C284($2;$vt_text2)

$vb_isEqualStrict:=False:C215
If (Count parameters:C259>1)
	$vt_text1:=$1
	$vt_text2:=$2
	
	C_LONGINT:C283($vl_length)
	$vl_length:=Length:C16($vt_text1)
	
	Case of 
		: ($vl_length#Length:C16($vt_text2))
			  //If the two string are not of the same length
			  //no need to look further
			
		: ($vl_length=0)
			  //two empty strings are equal
			$vb_isEqualStrict:=True:C214
			
		Else 
			  //we use v11 new diacritic-sensitive option for Position
			  //if the result = 1 (and we know the strings are of same length)
			  //then the strings are strictly equal
			$vb_isEqualStrict:=(Position:C15($vt_text1;$vt_text2;1;*)=1)
	End case 
	
End if 
$0:=$vb_isEqualStrict
