//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpServerRequestMethod
  //@scope : private
  //@deprecated : no
  //@description : This function returns the method (e.g. "GET") from a http request
  //@parameter[0-OUT-method-TEXT] : method (e.g. "GET")
  //@parameter[1-IN-httpServerHeaderObject-OBJECT] : http server header object
  //@notes : 
  //@example : acme__httpServerRequestMethod
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:38:38 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_method)
C_OBJECT:C1216($1;$vo_httpServerHeaderObject)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(OB Is defined:C1231($1);"$1 (httpServerHeaderObject) is undefined")

$vt_method:=""
$vo_httpServerHeaderObject:=$1

If (OB Is defined:C1231($vo_httpServerHeaderObject;"method"))
	$vt_method:=OB Get:C1224($vo_httpServerHeaderObject;"method";Is text:K8:3)
End if 

$0:=$vt_method