//%attributes = {"preemptive":"capable","shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__check4dWebLicence
  //@scope : private 
  //@deprecated : no
  //@description : This method function checks the 4D licence... 
  //@notes : Let's Encrypt® may work with a limited 4D web licence (when 4D http server is limited to local ip address) 
  // Unable to connect to the Web server.
  // Your 4D license number doesn't allow you to connect to the Web server from an IP address different from the server.
  //@example : acme__check4dWebLicence
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 27/01/2022, 20:56:02 - 2.00.04
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($vo_licence)
$vo_licence:=Get license info:C1489

If ($vo_licence=Null:C1517)  // This can happen on 4D Remote
	$vo_licence:=acme__check4dWebLicenceSrv 
End if 

C_LONGINT:C283($vl_appType)
C_TEXT:C284($vt_appTypeTxtDebug)
$vl_appType:=Application type:C494
Case of 
	: ($vl_appType=4D Local mode:K5:1)  // 0
		$vt_appTypeTxtDebug:="Local"
		
	: ($vl_appType=4D Volume desktop:K5:2)  // 1
		$vt_appTypeTxtDebug:="Volume desktop"
		
	: ($vl_appType=4D Desktop:K5:4)  // 3
		$vt_appTypeTxtDebug:="Desktop"
		
	: ($vl_appType=4D Remote mode:K5:5)  // 4 
		$vt_appTypeTxtDebug:="Remote"
		
	: ($vl_appType=4D Server:K5:6)  // 5 
		$vt_appTypeTxtDebug:="Server"
		
	Else 
		$vt_appTypeTxtDebug:="Unknown ("+String:C10($vl_appType)+")"
End case 

If ($vo_licence#Null:C1517)
	
	C_COLLECTION:C1488($c_products)
	$c_products:=$vo_licence.products
	
	C_LONGINT:C283($vl_licenceCount)
	$vl_licenceCount:=0
	
	C_OBJECT:C1216($o_product)
	For each ($o_product;$c_products)
		If ($o_product.name="4D Web Server@")
			$vl_licenceCount:=$vl_licenceCount+$o_product.allowedCount
		End if 
	End for each 
	
	C_COLLECTION:C1488($c_products)
	$c_products:=$vo_licence.products
	
	C_LONGINT:C283($vl_licenceCount)
	$vl_licenceCount:=0
	For each ($o_product;$c_products)
		If ($o_product.name="4D Web Server@")
			$vl_licenceCount:=$vl_licenceCount+$o_product.allowedCount
		End if 
	End for each 
	
	If ($vl_licenceCount>1)
		acme__log (4;Current method name:C684;"Total number of \"4D Web Server\" licences : "+String:C10($vl_licenceCount))
	Else 
		acme__log (2;Current method name:C684;"Total number of \"4D Web Server\" licences : "+String:C10($vl_licenceCount)+", \"Let's Encrypt®\" may work with this licence (check if 4D http server is responding correctly from a different ip address) !!! [KO]")
		
		  //         {
		  //             "id": 123456789,
		  //             "name": "4D Web Server",
		  //             "allowedCount": 999,
		  //             "rights": [
		  //                 {
		  //                     "count": 999,
		  //                     "expirationDate": {
		  //                         "year": 2022,
		  //                         "month": 3,
		  //                         "day": 31
		  //                     }
		  //                 }
		  //             ]
		
		
		  //         {
		  //             "id": 123456789,
		  //             "name": "4D Web Server - 1 Connection",
		  //             "allowedCount": 1,
		  //             "rights": [
		  //                 {
		  //                     "count": 1,
		  //                     "expirationDate": {
		  //                         "year": 2022,
		  //                         "month": 2,
		  //                         "day": 1
		  //                     }
		  //                 }
		  //             ]
		  //         },
		
		  // When connecting to the server from another IP address, the server will return :
		  // Unable to connect to the Web server.
		  // Your 4D license number doesn't allow you to connect to the Web server from an IP address different from the server.
	End if 
	
	acme__log (4;Current method name:C684;"4D "+$vt_appTypeTxtDebug+", licence :\r"+JSON Stringify:C1217($vo_licence;*))
	
Else 
	acme__log (2;Current method name:C684;"4D "+$vt_appTypeTxtDebug+", no licence infos. [KO]")
End if 