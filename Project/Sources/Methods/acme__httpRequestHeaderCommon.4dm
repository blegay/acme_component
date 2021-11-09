//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpRequestHeaderCommon
  //@scope : private
  //@deprecated : no
  //@description : This method sets the default http request headers when communicating with acme server
  //@parameter[1-IN-headerArrayKeyPtr-POINTER] : header text array key pointer (modified)
  //@parameter[2-IN-headerArrayValuePtr-POINTER] : header text array value pointer (modified)
  //@parameter[2-IN-contentType-TEXT] : "Content-Type" value (optional, e.g. "application/json")
  //@notes : 
  //@example : acme__headerCommon
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 06:18:14 - 1.00.00
  //@xdoc-end
  //================================================================================

C_POINTER:C301($1;$vp_headerArrayKeyPtr)
C_POINTER:C301($2;$vp_headerArrayValuePtr)
C_TEXT:C284($3;$vt_contentType)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(Type:C295($1->)=Text array:K8:16;"$1 should be a text array pointer")
ASSERT:C1129(Type:C295($2->)=Text array:K8:16;"$2 should be a text array pointer")
ASSERT:C1129(Size of array:C274($1->)=Size of array:C274($2->);"arrays should have identical size")

$vp_headerArrayKeyPtr:=$1
$vp_headerArrayValuePtr:=$2

APPEND TO ARRAY:C911($vp_headerArrayKeyPtr->;"User-Agent")
APPEND TO ARRAY:C911($vp_headerArrayValuePtr->;acme__httpHeaderSignature )

If (Count parameters:C259>2)
	$vt_contentType:=$3  //"application/jose+json"
	APPEND TO ARRAY:C911($vp_headerArrayKeyPtr->;"Content-Type")
	APPEND TO ARRAY:C911($vp_headerArrayValuePtr->;$vt_contentType)  //"application/jose+json")
End if 