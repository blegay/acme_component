//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpServerRequestVersion
  //@scope : private
  //@deprecated : no
  //@description : This function returns the http version (e.g. "HTTP/1.1") from a http request
  //@parameter[0-OUT-method-TEXT] : version  (e.g. "HTTP/1.1")
  //@parameter[1-IN-httpServerHeaderObject-OBJECT] : http server header object
  //@notes : 
  //@example : acme__httpServerRequestVersion
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:38:38 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_version)
C_OBJECT:C1216($1;$vo_httpServerHeaderObject)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(OB Is defined:C1231($1);"$1 (httpServerHeaderObject) is undefined")

$vt_version:=""
$vo_httpServerHeaderObject:=$1

If (OB Is defined:C1231($vo_httpServerHeaderObject;"version"))
	$vt_version:=OB Get:C1224($vo_httpServerHeaderObject;"version";Is text:K8:3)
End if 

$0:=$vt_version