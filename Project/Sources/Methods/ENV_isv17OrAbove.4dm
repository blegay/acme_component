//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : ENV_v17orAbove
  //@scope : public
  //@deprecated : no
  //@description : This function returns TRUE if 4D is v17 or above 
  //@parameter[0-OUT-v17orAbove-TEXT] : returns True if 4D is v17 or above, False otherwise.
  //@notes :
  //@example : ENV_v17orAbove 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 11/02/2020, 13:37:30 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_is4Dv17orAbove)  // is4Dv17orAbove

C_TEXT:C284($vt_appVers)
$vt_appVers:=Application version:C493

  //$vb_is4Dv17orAbove:=(Num(Substring($vt_appVers;1;2))>=17)

  //C_ALPHA(2;$va_appVersMajeur)
C_TEXT:C284($va_appVersMajeur)
$va_appVersMajeur:=Substring:C12($vt_appVers;1;2)
Case of 
	: ($va_appVersMajeur="06")  //4D v6
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="07")  //4D v2003
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="08")  //4D v2004 
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="11")  //4Dv11
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="12")  //4Dv12
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="13")  //4Dv13
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="14")  //4Dv14
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="15")  //4Dv15
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="16")  //4Dv16
		$vb_is4Dv17orAbove:=False:C215
		
	Else 
		
		$vb_is4Dv17orAbove:=True:C214
End case 

$0:=$vb_is4Dv17orAbove