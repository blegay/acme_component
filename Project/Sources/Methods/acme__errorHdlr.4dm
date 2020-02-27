//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__errorHdlr
  //@scope : private
  //@deprecated : no
  //@description : This method is the error handler to trap http request errors (like no network)
  //@notes : 
  //@example : acme__errorHdlr
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 11:40:58 - 1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283(vl_ACME_error)

C_LONGINT:C283(error;Error line)
C_TEXT:C284(Error method;Error formula)

  //(Error method;Error formula)  // note "Error formula" is in 4D v15 R4

C_LONGINT:C283($vl_error;$vl_errorLine)
C_TEXT:C284($vt_errorMethod;$vt_errorFormula)

$vl_error:=error
$vl_errorLine:=Error line
$vt_errorMethod:=Error method
$vt_errorFormula:=Error formula  // 4D v15 R4+

vl_ACME_error:=$vl_error

If ($vl_error#0)
	acme__log (2;Current method name:C684;"error : "+String:C10($vl_error)+\
		", method : \""+$vt_errorMethod+"\""+\
		", error line : "+String:C10($vl_errorLine)+\
		", error formula : \""+$vt_errorFormula+"\"")
End if 

ARRAY LONGINT:C221($tl_errorCodes;0)
ARRAY TEXT:C222($tt_intCompArray;0)
ARRAY TEXT:C222($tt_errorText;0)

GET LAST ERROR STACK:C1015($tl_errorCodes;$tt_intCompArray;$tt_errorText)

C_LONGINT:C283($vl_errIndex;$vl_errCount)
$vl_errCount:=Size of array:C274($tl_errorCodes)
For ($vl_errIndex;1;$vl_errCount)
	acme__log (2;Current method name:C684;String:C10($vl_errIndex)+" / "+String:C10($vl_errCount)+\
		", error : "+String:C10($tl_errorCodes{$vl_errIndex})+\
		", internal componnent : "+String:C10($vl_errorLine)+\
		", error text : \""+$tt_errorText{$vl_errIndex}+"\"")
End for 

ARRAY LONGINT:C221($tl_errorCodes;0)
ARRAY TEXT:C222($tt_intCompArray;0)
ARRAY TEXT:C222($tt_errorText;0)