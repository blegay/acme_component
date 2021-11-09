//%attributes = {"shared":false,"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : CRC_digestBase64
  //@scope : private 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-digestBase64-TEXT] : digest in base64
  //@parameter[1-IN-dataPtr-POINTER] : dataPtr (not modified)
  //@parameter[2-IN-digest-longint] : digest
  //@notes : 
  //@example : CRC_digestBase64
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2020
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 14/12/2020, 20:43:03 - 1.00.03
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_digestBase64)
C_POINTER:C301($1;$vp_dataPtr)
C_LONGINT:C283($2;$vl_digestAlg)

$vt_digestBase64:=""
$vp_dataPtr:=$1
$vl_digestAlg:=$2

C_TEXT:C284($vt_digestHex)
$vt_digestHex:=Generate digest:C1147($vp_dataPtr->;SHA256 digest:K66:4)

C_BLOB:C604($vx_digestBlob)
SET BLOB SIZE:C606($vx_digestBlob;0)
HEX_hexTextToBlob ($vt_digestHex;->$vx_digestBlob)

BASE64 ENCODE:C895($vx_digestBlob;$vt_digestBase64)
SET BLOB SIZE:C606($vx_digestBlob;0)

$0:=$vt_digestBase64