//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : TXT_rtrim
  //@scope : private
  //@deprecated : no
  //@description : This function returns a text with a character trimmed at the end
  //@parameter[0-OUT-textOut-TEXT] : text out
  //@parameter[1-IN-textIn-TEXT] : text in
  //@parameter[2-IN-char-TEXT] : character to trim
  //@notes : 
  //@example : TXT_rtrim
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 19:21:13 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_out)  //processed text
C_TEXT:C284($1;$vt_in)  //text to process
C_TEXT:C284($2;$vt_char)  //optionnal character code to remove at the end of the string

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(Length:C16($2)=1;"$2 should be one charracter long")

$vt_out:=""
$vt_in:=$1
$vt_char:=$2

C_LONGINT:C283($vl_length)
$vl_length:=Length:C16($vt_in)

If ($vl_length>0)
	
	C_LONGINT:C283($vl_charCode)
	$vl_charCode:=Character code:C91($vt_char[[1]])
	
	C_LONGINT:C283($i)
	For ($i;$vl_length;1;-1)  //loop from the end of the string
		If (Character code:C91($vt_in[[$i]])#$vl_charCode)  //the caracter is different from the character that we want to remove
			$vt_out:=Substring:C12($vt_in;1;$i)  //return the text up to the current caracter
			$i:=0  //Get out of the loop
		End if 
	End for 
	
End if 

$0:=$vt_out