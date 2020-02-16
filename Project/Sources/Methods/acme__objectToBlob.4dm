//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__objectToBlob
  //@scope : private
  //@deprecated : no
  //@description : This method converts an object to a blob
  //@parameter[0-OUT-requestBodyPtr-POINTER] : request body blob pointer (modified)
  //@parameter[1-IN-object-OBJECT] : object
  //@notes : the JWS MUST is in the "Flattened JSON Serialization" [RFC7515]
  //@example : acme__objectToBlob
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 06:00:29 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_blob)
C_OBJECT:C1216($1;$vo_object)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
  //ASSERT(OB Est défini($1);"Undefined $1 object")
  //ASSERT(Type($2->)=Est un BLOB;"$2 should be a blob pointer")

SET BLOB SIZE:C606($vx_blob;0)
$vo_object:=$1

If (OB Is defined:C1231($vo_object))
	C_TEXT:C284($vt_json)
	$vt_json:=JSON Stringify:C1217($vo_object)  // The JWS MUST be in the Flattened JSON Serialization [RFC7515]
	
	CONVERT FROM TEXT:C1011($vt_json;"UTF-8";$vx_blob)
End if 

$0:=$vx_blob

SET BLOB SIZE:C606($vx_blob;0)