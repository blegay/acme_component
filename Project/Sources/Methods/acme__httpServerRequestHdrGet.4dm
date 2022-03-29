//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpServerRequestHdrGet
  //@scope : private
  //@deprecated : no
  //@description : This function return the header value from a httpServerHeader for a given key  
  //@parameter[0-OUT-headerValue-TEXT] : header value
  //@parameter[1-IN-httpServerHeaderObject-OBJECT] : http server header object
  //@parameter[2-IN-headerKey-TEXT] : header key (will match case insensitive)
  //@notes : 
  //@example : acme__httpServerRequestHdrGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:21:05 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_headerValue)
C_OBJECT:C1216($1;$vo_httpServerRequestObject)
C_TEXT:C284($2;$vt_key)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(OB Is defined:C1231($1);"$1 (httpServerHeaderObject) is undefined")
ASSERT:C1129(Length:C16($2)>0;"header key is empty")

$vt_headerValue:=""
$vo_httpServerRequestObject:=$1
$vt_key:=$2

If (OB Is defined:C1231($vo_httpServerRequestObject;"requestHeaders"))
	
	C_OBJECT:C1216($vo_headers)
	$vo_headers:=OB Get:C1224($vo_httpServerRequestObject;"requestHeaders")
	If (OB Is defined:C1231($vo_headers;$vt_key))  // search case sensitive
		$vt_headerValue:=OB Get:C1224($vo_headers;$vt_key;Is text:K8:3)
	Else   // search case insensitive
		
		ARRAY TEXT:C222($tt_keys;0)
		OB GET PROPERTY NAMES:C1232($vo_headers;$tt_keys)
		
		C_LONGINT:C283($vl_keyFound)
		$vl_keyFound:=Find in array:C230($tt_keys;$vt_key)
		If ($vl_keyFound>0)
			$vt_headerValue:=OB Get:C1224($vo_headers;$tt_keys{$vl_keyFound};Is text:K8:3)
		End if 
		
		ARRAY TEXT:C222($tt_keys;0)
		
	End if 
	CLEAR VARIABLE:C89($vo_headers)
	
End if 
$0:=$vt_headerValue