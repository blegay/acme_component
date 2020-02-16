//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpServerRequestIsSsl
  //@scope : private
  //@deprecated : no
  //@description : This function returns TRUE if connection is Ssl, FALSE otherwise
  //@parameter[0-OUT-ssl-BOOLEAN] : TRUE if connection is Ssl, FALSE otherwise
  //@parameter[1-IN-httpServerHeaderObject-OBJECT] : http server header object
  //@notes : 
  //@example : acme__httpServerRequestIsSsl
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:35:34 - 1.0
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_isSsl)
C_OBJECT:C1216($1;$vo_httpServerHeaderObject)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(OB Is defined:C1231($1);"$1 (httpServerHeaderObject) is undefined")

$vb_isSsl:=False:C215
$vo_httpServerHeaderObject:=$1

If (OB Is defined:C1231($vo_httpServerHeaderObject;"ssl"))
	$vb_isSsl:=OB Get:C1224($vo_httpServerHeaderObject;"ssl";Is boolean:K8:9)
End if 

$0:=$vb_isSsl