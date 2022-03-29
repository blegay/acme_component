

If (False:C215)
	
	
	  //  //================================================================================
	  //  // name : Sur connexion Web
	  //  // scope : public
	  //  // deprecated : no
	  //  // description : http client connexion handler 
	  //  // parameter[1-IN-url-TEXT] : url
	  //  // parameter[2-IN-request-TEXT] : http request (header + body, 32 kb max size)
	  //  // parameter[3-IN-clientIp-TEXT] : client ip address
	  //  // parameter[4-IN-serverIp-TEXT] : server ip address
	  //  // parameter[5-IN-username-TEXT] : username
	  //  // parameter[6-IN-password-TEXT] : password
	  //  // notes : 
	  //  // example : Sur connexion Web
	  //  // see : 
	  //  // version : 1.00.00
	  //  // author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
	  //  // history : 
	  //  //  CREATION : Bruno LEGAY (BLE) - 01/07/2019, 16:03:41 - 0.90.08
	  //  //================================================================================
	
	  //C_TEXT($1;$vt_url)
	  //C_TEXT($2;$vt_request)
	  //C_TEXT($3;$vt_clientIp)
	  //C_TEXT($4;$vt_serverIp)
	  //C_TEXT($5;$vt_username)
	  //C_TEXT($6;$vt_password)
	
	  //ASSERT(Count parameters>5;"requires 6 parameters")
	
	  //$vt_url:=$1
	  //$vt_request:=$2
	  //$vt_clientIp:=$3
	  //$vt_serverIp:=$4
	  //$vt_username:=$5
	  //$vt_password:=$6
	
	
	  //TRACE
	
	  //Case of 
	  //: (acme_onWebConnection ($vt_url))  // gestion letsencrypt (challenge)
	
	  //Else   // code application spécifique
	
	
	  //End case 
Else 
	
	
	C_TEXT:C284($1;$vt_url)
	C_TEXT:C284($2;$vt_request)
	C_TEXT:C284($3;$vt_clientIp)
	C_TEXT:C284($4;$vt_serverIp)
	C_TEXT:C284($5;$vt_username)
	C_TEXT:C284($6;$vt_password)
	
	ASSERT:C1129(Count parameters:C259>5;"requires 6 parameters")
	
	$vt_url:=$1
	$vt_request:=$2
	$vt_clientIp:=$3
	$vt_serverIp:=$4
	$vt_username:=$5
	$vt_password:=$6
	
	If (Not:C34(Is compiled mode:C492))
		
		Case of 
			: (acme_onWebConnection ($vt_url))
				
			Else 
				
				  //ALERT(WEB Get current session ID)
				
				  //WEB SEND TEXT("hello")
				  //WEB Get current session ID
				
		End case 
		
	End if 
End if 

