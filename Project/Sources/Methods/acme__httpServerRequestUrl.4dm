//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpServerRequestUrl
  //@scope : private
  //@deprecated : no
  //@description : This function returns the url (e.g. "/index.html") from a http request
  //@parameter[0-OUT-url-TEXT] : url (e.g. "/index.html")
  //@parameter[1-IN-httpServerHeaderObject-OBJECT] : http server header object
  //@notes : 
  //@example : acme__httpServerRequestUrl
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:38:38 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_url)
C_OBJECT:C1216($1;$vo_httpServerHeaderObject)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(OB Is defined:C1231($1);"$1 (httpServerHeaderObject) is undefined")

$vt_url:=""
$vo_httpServerHeaderObject:=$1

If (OB Is defined:C1231($vo_httpServerHeaderObject;"url"))
	$vt_url:=OB Get:C1224($vo_httpServerHeaderObject;"url";Is text:K8:3)
End if 

$0:=$vt_url