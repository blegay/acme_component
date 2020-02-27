//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : ENV__isComponent
  //@scope : private
  //@deprecated : no
  //@description : This function returns TRUE if it is called within a component 
  //@parameter[0-OUT-isComponent-BOOLEAN] : TRUE if it is called within a component, FALSE otherwise
  //@notes : this method cannot (by definition) be used as a component...
  //@example : ENV__isComponent 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2015
  //@history : CREATION : Bruno LEGAY (BLE) - 12/10/2010, 11:27:34 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_isComponent)

C_TEXT:C284($vt_structureFile)
$vt_structureFile:=Structure file:C489

C_TEXT:C284($vt_hostStructureFile)
$vt_hostStructureFile:=Structure file:C489(*)

$vb_isComponent:=($vt_structureFile#$vt_hostStructureFile)

$0:=$vb_isComponent