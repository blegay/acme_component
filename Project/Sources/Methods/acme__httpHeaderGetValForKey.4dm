//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpHeaderGetValForKey
  //@scope : private
  //@deprecated : no
  //@description : This function returns a value for a key given a pair of http header key/value text arrays
  //@parameter[0-OUT-value-TEXT] : header value
  //@parameter[1-IN-headerArrayKeyPtr-POINTER] : header text array key pointer (not modified)
  //@parameter[2-IN-headerArrayValuePtr-POINTER] : header text array value pointer (not modified)
  //@parameter[2-IN-contentType-TEXT] : header key
  //@notes : 
  //@example : acme__httpHeaderGetValForKey
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 07:40:16 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_value)
C_POINTER:C301($1;$vp_headerArrayKeyPtr)
C_POINTER:C301($2;$vp_headerArrayValuePtr)
C_TEXT:C284($3;$vt_key)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(Type:C295($1->)=Text array:K8:16;"$1 should be a text array pointer")
ASSERT:C1129(Type:C295($2->)=Text array:K8:16;"$2 should be a text array pointer")
ASSERT:C1129(Size of array:C274($1->)=Size of array:C274($2->);"array should have identical size")

$vp_headerArrayKeyPtr:=$1
$vp_headerArrayValuePtr:=$2
$vt_key:=$3

C_LONGINT:C283($vl_found)
$vl_found:=Find in array:C230($vp_headerArrayKeyPtr->;$vt_key)
If ($vl_found>0)
	$vt_value:=$vp_headerArrayValuePtr->{$vl_found}
End if 
$0:=$vt_value