//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpServerRequestToObject
  //@scope : private
  //@deprecated : no
  //@description : This function returns a web connexion http headers and connexion information into an object
  //@parameter[0-OUT-httpServerHeaderObject-OBJECT] : http server header object
  //@notes : improvement/todo/limitation : http header key does not have to be unique. This is not supported in this method.
  //@example : acme__httpServerRequestToObject
  // {
  //   "method": "GET",
  //   "url": "/index.html",
  //   "version": "HTTP/1.1",
  //   "ssl": false,
  //   "thread-safe": true,
  //   "timestamp": "2020-02-17T20:43:38.712Z",
  //   "requestHeaders": {
  //     "Accept": "*/*",
  //     "Host": "www.example.com",
  //     "User-Agent": "curl/7.55.1"
  //   }
  // }
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:00:18 - 1.0
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_httpServerHeaderObject)

C_OBJECT:C1216($vo_headers)

ARRAY TEXT:C222($tt_headersKey;0)
ARRAY TEXT:C222($tt_headersValue;0)

C_TEXT:C284($vt_timestamp)
$vt_timestamp:=Timestamp:C1445  // "2020-02-17T20:43:38.712Z"

  // read the http headers from current http request
WEB GET HTTP HEADER:C697($tt_headersKey;$tt_headersValue)

C_LONGINT:C283($vl_headerIndex)
For ($vl_headerIndex;1;Size of array:C274($tt_headersKey))
	Case of 
		: ($tt_headersKey{$vl_headerIndex}="X-METHOD")
			OB SET:C1220($vo_httpServerHeaderObject;"method";$tt_headersValue{$vl_headerIndex})
			
		: ($tt_headersKey{$vl_headerIndex}="X-URL")
			OB SET:C1220($vo_httpServerHeaderObject;"url";$tt_headersValue{$vl_headerIndex})
			
		: ($tt_headersKey{$vl_headerIndex}="X-VERSION")
			OB SET:C1220($vo_httpServerHeaderObject;"version";$tt_headersValue{$vl_headerIndex})
			
		Else 
			OB SET:C1220($vo_headers;$tt_headersKey{$vl_headerIndex};$tt_headersValue{$vl_headerIndex})
	End case 
	
End for 

OB SET:C1220($vo_httpServerHeaderObject;"ssl";WEB Is secured connection:C698)
OB SET:C1220($vo_httpServerHeaderObject;"preemptive";ENV_isPreemptive )
OB SET:C1220($vo_httpServerHeaderObject;"timestamp";$vt_timestamp)  // "2020-02-17T20:43:38.712Z"

OB SET:C1220($vo_httpServerHeaderObject;"requestHeaders";$vo_headers)
CLEAR VARIABLE:C89($vo_headers)

If (False:C215)  // not thread safe, useful when debugging to trace into
	If (Not:C34(ENV_isPreemptive ))
		  //%T-
		SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_httpServerHeaderObject;*))
		  //%T+
	End if 
End if 

$0:=$vo_httpServerHeaderObject

CLEAR VARIABLE:C89($vo_httpServerHeaderObject)