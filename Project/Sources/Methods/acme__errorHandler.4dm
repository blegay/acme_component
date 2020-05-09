//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__errorHandler
  //@scope : private
  //@deprecated : no
  //@description : This methode est un gestionnaire d'erreur par défaut (qui affichera un message d'erreur)
  //@notes : 
  //@example : acme__errorHandler
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 11:49:46 - 1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($vl_error;$vl_errorLine)
C_TEXT:C284($vt_errorMethod)

$vl_error:=Error
$vt_errorMethod:=Error method
$vl_errorLine:=Error line

CONFIRM:C162("Error : "+String:C10($vl_error)+"\rMethod : \""+$vt_errorMethod+"\"\rLine : "+String:C10($vl_errorLine);"Stop";"Continue")
If (ok=1)
	ABORT:C156
End if 

If (False:C215)
	ARRAY LONGINT:C221($tl_errorCodes;0)
	ARRAY TEXT:C222($tt_intCompArray;0)
	ARRAY TEXT:C222($tt_errorText;0)
	
	GET LAST ERROR STACK:C1015($tl_errorCodes;$tt_intCompArray;$tt_errorText)
	
	ARRAY LONGINT:C221($tl_errorCodes;0)
	ARRAY TEXT:C222($tt_intCompArray;0)
	ARRAY TEXT:C222($tt_errorText;0)
End if 