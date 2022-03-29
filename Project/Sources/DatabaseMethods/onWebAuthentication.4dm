If (False:C215)
	
	  //  //================================================================================
	  //  // name : Sur authentification web
	  //  // scope : public
	  //  // deprecated : no
	  //  // description : http client authentication handler 
	  //  // parameter[0-OUT-allowed-BOOLEAN] : TRUE if authenticated, FALSE otherwise
	  //  // parameter[1-IN-url-TEXT] : url
	  //  // parameter[2-IN-request-TEXT] : http request (header + body, 32 kb max size)
	  //  // parameter[3-IN-clientIp-TEXT] : client ip address
	  //  // parameter[4-IN-serverIp-TEXT] : server ip address
	  //  // parameter[5-IN-username-TEXT] : username
	  //  // parameter[6-IN-password-TEXT] : password
	  //  // notes : 
	  //  // example : Sur uthentification web
	  //  // see : 
	  //  // version : 1.00.00
	  //  // author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
	  //  // history : 
	  //  //  CREATION : Bruno LEGAY (BLE) - 01/07/2019, 16:03:41 - 0.90.08
	  //  //================================================================================
	
	  //C_BOOLEAN($0;$vb_allowed)
	  //C_TEXT($1;$vt_url)
	  //C_TEXT($2;$vt_request)
	  //C_TEXT($3;$vt_clientIp)
	  //C_TEXT($4;$vt_serverIp)
	  //C_TEXT($5;$vt_username)
	  //C_TEXT($6;$vt_password)
	
	  //ASSERT(Count parameters>5;"requires 6 parameters")
	
	  //$vb_allowed:=False
	  //$vt_url:=$1
	  //$vt_request:=$2
	  //$vt_clientIp:=$3
	  //$vt_serverIp:=$4
	  //$vt_username:=$5
	  //$vt_password:=$6
	
	  //Case of 
	  //: (acme_onWebAuthentication ($vt_url;->$vb_allowed))  // gestion letsencrypt (challenge)
	
	
	  //Else   // code application spécifique
	
	  //$vb_allowed:=True
	
	  //End case 
	
	  //$0:=$vb_allowed
	
Else 
	
	C_BOOLEAN:C305($0;$vb_allowed)
	C_TEXT:C284($1;$vt_url)
	C_TEXT:C284($2;$vt_request)
	C_TEXT:C284($3;$vt_clientIp)
	C_TEXT:C284($4;$vt_serverIp)
	C_TEXT:C284($5;$vt_username)
	C_TEXT:C284($6;$vt_password)
	
	ASSERT:C1129(Count parameters:C259>5;"requires 6 parameters")
	
	$vb_allowed:=False:C215
	$vt_url:=$1
	$vt_request:=$2
	$vt_clientIp:=$3
	$vt_serverIp:=$4
	$vt_username:=$5
	$vt_password:=$6
	
	If (Not:C34(Is compiled mode:C492))
		
		Case of 
			: (acme_onWebAuthentication ($vt_url;->$vb_allowed))
				
			Else 
				$vb_allowed:=True:C214
		End case 
		
	End if 
	
	$0:=$vb_allowed
	
End if 

