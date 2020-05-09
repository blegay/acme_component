//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__xdocInit
  //@scope : private
  //@deprecated : no
  //@description : This method itializes the xdoc component 
  //@notes :
  //@example : acme__xdocInit 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : CREATION : Bruno LEGAY (BLE) - 24/06/2018, 09:17:12 - v1.00.00
  //@xdoc-end
  //================================================================================

ARRAY TEXT:C222($tt_components;0)
COMPONENT LIST:C1001($tt_components)

If (Find in array:C230($tt_components;"XDOC_component")>0)
	
	  //XDOC_componentPrefixSet ("S3")
	EXECUTE METHOD:C1007("XDOC_componentPrefixSet";*;"acme")
	
	  //XDOC_authorSet (1;"Bruno LEGAY (BLE)")
	EXECUTE METHOD:C1007("XDOC_authorSet";*;1;"Bruno LEGAY (BLE)")
	
	  //XDOC_authorSet (2;"Bruno LEGAY (BLE) - Copyrights A&C Consulting "+Chaine(Annee de(Date du jour)))
	EXECUTE METHOD:C1007("XDOC_authorSet";*;2;"Bruno LEGAY (BLE) - Copyrights A&C Consulting "+String:C10(Year of:C25(Current date:C33)))
	
	  //XDOC_versionTagSet (AWS_componentVersionGet )
	EXECUTE METHOD:C1007("XDOC_versionTagSet";*;acme_componentVersionGet )
	
End if 

ARRAY TEXT:C222($tt_components;0)