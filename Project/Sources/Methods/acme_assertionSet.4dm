//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_assertionSet
  //@scope : private 
  //@deprecated : no
  //@description : This method sets the assertion for the acme component
  //@parameter[1-IN-assertionsEnabled-BOOLEAN] : TRUE if the assertions are enabled, FALSE otherwise
  //@notes : 
  //@example : acme_assertionSet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 21/07/2021, 16:25:35 - 2.00.02
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($1;$vb_assertionsEnabled)

If (Count parameters:C259>0)
	$vb_assertionsEnabled:=$1
	
	SET ASSERT ENABLED:C1131($vb_assertionsEnabled)
	
	acme__log (4;Current method name:C684;"assertions : "+Choose:C955($vb_assertionsEnabled;"enabled";"disabled"))
	
End if 