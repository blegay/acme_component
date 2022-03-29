//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : ENV_isv19OrAbove
  //@scope : private 
  //@deprecated : no
  //@description : This function returns TRUE if 4D is v19 or above 
  //@parameter[0-OUT-v19orAbove-TEXT] : returns True if 4D is v19 or above, False otherwise.
  //@notes : 
  //@example : ENV_isv19OrAbove
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 27/01/2022, 20:25:28 - 2.00.04
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_is4Dv19orAbove)  // is4Dv17orAbove

C_TEXT:C284($vt_appVers)
$vt_appVers:=Application version:C493

  //$vb_is4Dv19orAbove:=(Num(Substring($vt_appVers;1;2))>=17)

  //C_ALPHA(2;$va_appVersMajeur)
C_TEXT:C284($va_appVersMajeur)
$va_appVersMajeur:=Substring:C12($vt_appVers;1;2)
Case of 
	: ($va_appVersMajeur="06")  //4D v6
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="07")  //4D v2003
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="08")  //4D v2004 
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="11")  //4Dv11
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="12")  //4Dv12
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="13")  //4Dv13
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="14")  //4Dv14
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="15")  //4Dv15
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="16")  //4Dv16
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="17")  //4Dv17
		$vb_is4Dv19orAbove:=False:C215
		
	: ($va_appVersMajeur="18")  //4Dv18
		$vb_is4Dv19orAbove:=False:C215
		
	Else 
		
		$vb_is4Dv19orAbove:=True:C214
End case 

$0:=$vb_is4Dv19orAbove