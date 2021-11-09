//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__csrReqConfObjectToTextSub
  //@scope : private
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : csr request conf text
  //@parameter[1-IN-csrReqConfObject-OBJECT] : csr request conf object
  //@parameter[2-IN-endLine-TEXT] : end of line character ("\r\n" or "\n")
  //@notes : 
  //@example : acme__csrReqConfObjectToTextSub
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 07:43:18 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_buffer)
C_OBJECT:C1216($1;$vo_object)
C_TEXT:C284($2;$vt_endLine)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(OB Is defined:C1231($1);"$1 should be defined")
ASSERT:C1129(Length:C16($2)>0;"$2 endLine is empty")

$vt_buffer:=""
$vo_object:=$1
$vt_endLine:=$2

If (OB Is defined:C1231($vo_object))
	
	ARRAY TEXT:C222($tt_propertyNames;0)
	ARRAY LONGINT:C221($tl_propertyTypes;0)
	
	OB GET PROPERTY NAMES:C1232($vo_object;$tt_propertyNames;$tl_propertyTypes)
	C_LONGINT:C283($vl_properyIndex)
	For ($vl_properyIndex;1;Size of array:C274($tl_propertyTypes))
		C_LONGINT:C283($vl_propertyType)
		$vl_propertyType:=$tl_propertyTypes{$vl_properyIndex}
		
		C_TEXT:C284($vt_propertyName)
		$vt_propertyName:=$tt_propertyNames{$vl_properyIndex}
		
		Case of 
			: ($vl_propertyType=Is boolean:K8:9)
				$vt_buffer:=$vt_buffer+$vt_propertyName+" = "+Choose:C955(OB Get:C1224($vo_object;$vt_propertyName;$vl_propertyType);"yes";"no")+$vt_endLine
				
			: ($vl_propertyType=Is real:K8:4)
				$vt_buffer:=$vt_buffer+$vt_propertyName+" = "+String:C10(OB Get:C1224($vo_object;$vt_propertyName;$vl_propertyType))+$vt_endLine
				
			: ($vl_propertyType=Is text:K8:3)
				$vt_buffer:=$vt_buffer+$vt_propertyName+" = "+OB Get:C1224($vo_object;$vt_propertyName;$vl_propertyType)+$vt_endLine
				
			: ($vl_propertyType=Is object:K8:27)
				$vt_buffer:=$vt_buffer+"["+$vt_propertyName+"]"+$vt_endLine
				$vt_buffer:=$vt_buffer+acme__csrReqConfObjectToTextSub (OB Get:C1224($vo_object;$vt_propertyName;$vl_propertyType);$vt_endLine)
				$vt_buffer:=$vt_buffer+$vt_endLine
		End case 
		
	End for 
	
	ARRAY TEXT:C222($tt_propertyNames;0)
	ARRAY LONGINT:C221($tl_propertyTypes;0)
	
End if 

$0:=$vt_buffer