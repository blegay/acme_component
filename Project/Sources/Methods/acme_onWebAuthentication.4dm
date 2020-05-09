//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_onWebAuthentication
  //@scope : public
  //@deprecated : no
  //@description : This function returns manages the authentication for the LetsEncrypt service
  //@parameter[0-OUT-match-BOOLEAN] : true if the url looks like "/.well-known/acme-challenge/@"
  //@parameter[1-IN-url-TEXT] : url
  //@parameter[2-OUT-allowedPtr-POINTER] : allowed boolean pointer (modified)
  //@notes : the expected connexion is on plain http connexion (not https)
  //@example : On Web authentification : 
  //
  //  C_BOOLEEN($0;$vb_allowed)
  //  C_TEXT($1;$vt_url)
  //  C_TEXT($2;$vt_request)
  //  C_TEXT($3;$vt_clientIp)
  //  C_TEXT($4;$vt_serverIp)
  //  C_TEXT($5;$vt_username)
  //  C_TEXT($6;$vt_password)
  //
  //  ASSERT(Count parameters>5;"requires 6 parameters")
  //
  //  $vb_allowed:=False
  //  $vt_url:=$1
  //  $vt_request:=$2
  //  $vt_clientIp:=$3
  //  $vt_serverIp:=$4
  //  $vt_username:=$5
  //  $vt_password:=$6
  //
  //  Case of 
  //    : (acme_onWebAuthentication ($vt_url;->$vb_allowed))
  //
  //  Else 
  //
  //  End case 
  //
  //  $0:=$vb_allowed
  //
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:08:59 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_match)
C_TEXT:C284($1;$vt_url)
C_POINTER:C301($2;$vp_allowedPtr)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(Type:C295($2->)=Is boolean:K8:9;"$2 should be a boolean pointer")

$vb_match:=False:C215
$vt_url:=$1
$vp_allowedPtr:=$2

  //  {
  //      "type": "http-01",
  //      "url": "https://example.com/acme/authz/0",
  //      "status": "pending",
  //      "token": "LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0"
  //    }

  // the letsencrypt HTTP-01 challenge is on a plain http (not https) connection
  // note : it could be on a port other than 80 (behind a NAT for instance)
If (Not:C34(WEB Is secured connection:C698))
	
	  // {
	  //     "method": "GET",
	  //     "url": "/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0",
	  //     "version": "HTTP/1.1",
	  //     "ssl": false,
	  //     "requestHeaders": {
	  //         "Accept": "*/*",
	  //         "Accept-Encoding": "gzip",
	  //         "Connection": "close",
	  //         "Host": "www.example.org",
	  //         "User-Agent": "Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org)"
	  //     }
	  // }
	
	  // /.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0
	
	$vb_match:=acme__challengeReqUrlMatch ($vt_url)
	
	If ($vb_match)
		$vp_allowedPtr->:=True:C214
		acme__log (4;Current method name:C684;"url match \""+$vt_url+"\"")
	End if 
	
End if 

$0:=$vb_match