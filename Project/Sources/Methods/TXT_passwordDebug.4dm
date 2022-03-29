//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : TXT_passwordDebug
  //@scope : private
  //@deprecated : no
  //@description : This function returns a scrambled password for debug/log purposes
  //@parameter[0-OUT-scrambledPassword-TEXT] : scrambled password (e.g. "ab*****de"
  //@parameter[1-IN-password-TEXT] : password
  //@notes :
  //@example : TXT_passwordDebug 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2018
  //@history : CREATION : Bruno LEGAY (BLE) - 17/04/2016, 09:23:15 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_passwordOut)
C_TEXT:C284($1;$vt_passwordIn)

$vt_passwordOut:=""
If (Count parameters:C259>0)
	$vt_passwordIn:=$1
	
	C_LONGINT:C283($vl_length)
	$vl_length:=Length:C16($vt_passwordIn)
	
	$vt_passwordOut:="*"*$vl_length
	
	C_LONGINT:C283($i)
	For ($i;1;$vl_length)
		
		C_BOOLEAN:C305($vb_show)
		Case of 
			: ($vl_length>6)
				$vb_show:=(($i<=2) | ($i>=($vl_length-1)))
				
			: ($vl_length>4)
				$vb_show:=($i=1) | ($i=$vl_length)
				
			: ($vl_length>1)
				$vb_show:=($i=1)
				
			Else 
				$vb_show:=False:C215
		End case 
		
		If ($vb_show)
			$vt_passwordOut[[$i]]:=$vt_passwordIn[[$i]]
		End if 
	End for 
	
End if 
$0:=$vt_passwordOut
