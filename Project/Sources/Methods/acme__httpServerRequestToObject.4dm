//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpServerRequestToObject
  //@scope : private
  //@deprecated : no
  //@description : This function returns a web connexion http headers and connexion information into an object
  //@parameter[0-OUT-httpServerHeaderObject-OBJECT] : http server header object
  //@notes : 
  //@example : acme__httpServerRequestToObject
  // {
  //   "method": "GET",
  //   "url": "/index.html",
  //   "version": "HTTP/1.1",
  //   "ssl": false,
  //   "requestHeaders": {
  //     "Accept": "*/*",
  //     "Host": "www.example.com",
  //     "User-Agent": "curl/7.55.1"
  //   }
  // }
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:00:18 - 1.0
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_httpServerHeaderObject)

C_OBJECT:C1216($vo_headers)

ARRAY TEXT:C222($tt_key;0)
ARRAY TEXT:C222($tt_value;0)

WEB GET HTTP HEADER:C697($tt_key;$tt_value)

C_LONGINT:C283($vl_headerIndex)
For ($vl_headerIndex;1;Size of array:C274($tt_key))
	Case of 
		: ($tt_key{$vl_headerIndex}="X-METHOD")
			OB SET:C1220($vo_httpServerHeaderObject;"method";$tt_value{$vl_headerIndex})
			
		: ($tt_key{$vl_headerIndex}="X-URL")
			OB SET:C1220($vo_httpServerHeaderObject;"url";$tt_value{$vl_headerIndex})
			
		: ($tt_key{$vl_headerIndex}="X-VERSION")
			OB SET:C1220($vo_httpServerHeaderObject;"version";$tt_value{$vl_headerIndex})
			
		Else 
			OB SET:C1220($vo_headers;$tt_key{$vl_headerIndex};$tt_value{$vl_headerIndex})
	End case 
	
End for 

OB SET:C1220($vo_httpServerHeaderObject;"ssl";WEB Is secured connection:C698)

OB SET:C1220($vo_httpServerHeaderObject;"requestHeaders";$vo_headers)
CLEAR VARIABLE:C89($vo_headers)

If (False:C215)
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_httpServerHeaderObject;*))
End if 

$0:=$vo_httpServerHeaderObject

CLEAR VARIABLE:C89($vo_httpServerHeaderObject)