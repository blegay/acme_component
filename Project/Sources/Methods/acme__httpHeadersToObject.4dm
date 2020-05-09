//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpHeadersToObject
  //@scope : private
  //@deprecated : no
  //@description : This function converts http header array into an object
  //@parameter[0-OUT-object-OBJECT] : http header object
  //@parameter[1-IN-headerKeyArrayPtr-POINTER] : http header key text array pointer (not modified)
  //@parameter[2-IN-headerValueArrayPtr-POINTER] : http header value text array pointer (not modified)
  //@notes :
  //@example : acme__httpHeadersToObject 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : CREATION : Bruno LEGAY (BLE) - 23/06/2018, 06:34:32 - v1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_httpHeaderObject)
C_POINTER:C301($1;$vp_headerArrayKeyPtr)
C_POINTER:C301($2;$vp_headerArrayValuePtr)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(Type:C295($1->)=Text array:K8:16;"$1 should be a text array pointer")
ASSERT:C1129(Type:C295($2->)=Text array:K8:16;"$2 should be a text array pointer")
ASSERT:C1129(Size of array:C274($1->)=Size of array:C274($2->);"array should have identical size")

$vp_headerArrayKeyPtr:=$1
$vp_headerArrayValuePtr:=$2

C_LONGINT:C283($i)
For ($i;1;Size of array:C274($vp_headerArrayKeyPtr->))
	OB SET:C1220($vo_httpHeaderObject;$vp_headerArrayKeyPtr->{$i};$vp_headerArrayValuePtr->{$i})
End for 

$0:=$vo_httpHeaderObject