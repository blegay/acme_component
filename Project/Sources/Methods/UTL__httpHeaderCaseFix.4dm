//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL__httpHeaderCaseFix
  //@scope : private 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-headerKeyCaseSensitive-TEXT] : headerKeyCaseSensitive
  //@parameter[1-IN-paramName-OBJECT] : ParamDescription
  //@parameter[2-IN-$vt_headerKey-TEXT] : headers key
  //@notes : 
  //@example : 
  // $vt_locationHeaderKey:=UTL__httpHeaderCaseFix ($vo_responseHeaders;"Location")  // may return "location"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 05/08/2022, 21:11:00 - 2.00.05
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_headerKeyCaseSensitive)
C_OBJECT:C1216($1;$vo_headers)
C_TEXT:C284($2;$vt_headerKey)

$vt_headerKeyCaseSensitive:=""
$vo_headers:=$1
$vt_headerKey:=$2

$vt_headerKeyCaseSensitive:=$vt_headerKey

If ($vo_headers#Null:C1517)
	If ($vo_headers[$vt_headerKeyCaseSensitive]=Null:C1517)  // property does not exist case sensitive
		
		  // try to match "Location" with "location"
		
		C_BOOLEAN:C305($vb_found)
		$vb_found:=False:C215
		C_TEXT:C284($vt_property)
		
		For each ($vt_property;$vo_headers) Until ($vb_found)
			
			If ($vt_property=$vt_headerKey)
				$vb_found:=True:C214
				$vt_headerKeyCaseSensitive:=$vt_property
			End if 
			
		End for each 
		
	End if 
End if 

$0:=$vt_headerKeyCaseSensitive