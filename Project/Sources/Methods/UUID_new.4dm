//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : uuid_new
  //@scope : public
  //@deprecated : no
  //@description : This function returns a uuid (32 hex chars, e.g. "ab00070ed7824bc682f9d2803ee98f4b")
  //@parameter[0-OUT-uuid-TEXT] : uuid v4 compliant
  //@notes :
  // https://en.wikipedia.org/wiki/Universally_unique_identifier#Encoding
  // note : on Windows, the UUID is "mixed-endian"
  // we want a standard rfc compliant uuid in "big-endian"
  // so we need to byteswap few bytes
  // e.g. "33221100554477668899aabbccddeeff" => "00112233445566778899aabbccddeeff"
  //
  //@example : uuid_new 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 09/07/2018, 14:00:37 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_uuid)

$vt_uuid:=Generate UUID:C1066

$vt_uuid:=Lowercase:C14($vt_uuid)

  // AB00070ED7824BC682F9D2803EE98F4B
  //$vt_uuid:="33221100554477668899aabbccddeeff"

If (ENV_onWindows )
	$vt_uuid:=$vt_uuid[[7]]+$vt_uuid[[8]]+$vt_uuid[[5]]+$vt_uuid[[6]]+$vt_uuid[[3]]+$vt_uuid[[4]]+$vt_uuid[[1]]+$vt_uuid[[2]]+$vt_uuid[[11]]+$vt_uuid[[12]]+$vt_uuid[[9]]+$vt_uuid[[10]]+$vt_uuid[[15]]+$vt_uuid[[16]]+$vt_uuid[[13]]+$vt_uuid[[14]]+Substring:C12($vt_uuid;17)
End if 

  // v14r5, v15r5, v16r5, v17 : assert is always true. 
ASSERT:C1129($vt_uuid[[13]]="4";"generate uuid problem : "+$vt_uuid)

  //ASSERT($vt_uuid="00112233445566778899aabbccddeeff")

$0:=$vt_uuid