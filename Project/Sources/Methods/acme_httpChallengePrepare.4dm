//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_httpChallengePrepare
  //@scope : public
  //@deprecated : no
  //@description : This will the the authorization for the domain, prepare the "http-01" challenge response and request the challenge to be requested by CA
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-authorizationUrl-TEXT] : authorization url "https://acme-staging-v02.api.letsencrypt.org/acme/authz/nP...oi-abc...deZ"
  //@notes : 
  //@example : acme_httpChallengePrepare
  //@see : acme_onWebConnection
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 19:24:39 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_authorizationUrl)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"$1 authorization url cannot be empty")

$vt_authorizationUrl:=$1

acme__init 

C_TEXT:C284($vt_workingDir;$vt_directoryUrl)
$vt_workingDir:=acme_workingDirGet 
$vt_directoryUrl:=acme_directoryUrlGet 

  //C_TEXTE($1;$vt_directoryUrl)
  //C_TEXTE($2;$vt_workingDir)
  //C_TEXTE($3;$vt_authorizationUrl)

  //ASSERT(Nombre de paramètres>2;"requires 3 parameters")
  //ASSERT(Longueur($1)>0;"$1 directory url cannot be empty")
  //  //ASSERT(OB Est défini($2);"$2 (\"payload\") property is not defined")
  //ASSERT(Tester chemin acces($2)=Est un dossier;"working dir \""+$2+"\" not found")
  //ASSERT(Longueur($3)>0;"$3 authorization url cannot be empty")

  //$vt_directoryUrl:=$1
  //$vt_workingDir:=$2
  //$vt_authorizationUrl:=$3

C_OBJECT:C1216($vo_authObj)

acme__log (4;Current method name:C684;"url : \""+$vt_authorizationUrl+"\"...")

If (acme_authorizationGet ($vt_authorizationUrl;->$vo_authObj))
	
	If (False:C215)
		  //  curl https://acme-staging-v02.api.letsencrypt.org/acme/authz/UOO_ci1...sLI
		  // {
		  //   "identifier": {
		  //     "type": "dns",
		  //     "value": "www.example.com"
		  //   },
		  //   "status": "pending",
		  //   "expires": "2018-06-29T15:36:28Z",
		  //   "challenges": [
		  //     {
		  //       "type": "dns-01",
		  //       "status": "pending",
		  //       "url": "https://acme-staging-v02.api.letsencrypt.org/acme/challenge/UOO_ci1...sLI/1234567",
		  //       "token": "R2VX-K...m7Y"
		  //     },
		  //     {
		  //       "type": "http-01",
		  //       "status": "pending",
		  //       "url": "https://acme-staging-v02.api.letsencrypt.org/acme/challenge/UOO_ci1...sLI/1234568",
		  //       "token": "IFYoEg...SQ"
		  //     },
		  //     {
		  //       "type": "tls-alpn-01",
		  //       "status": "pending",
		  //       "url": "https://acme-staging-v02.api.letsencrypt.org/acme/challenge/UOO_ci1...sLI/1234569",
		  //       "token": "fx-t44...SA"
		  //     }
		  //   ]
		  // 
	End if 
	
	  //<Modif> Bruno LEGAY (BLE) (14/02/2019)
	C_BOOLEAN:C305($vb_wildcard)
	$vb_wildcard:=False:C215
	If (OB Is defined:C1231($vo_authObj;"wildcard"))
		$vb_wildcard:=OB Get:C1224($vo_authObj;"wildcard";Is boolean:K8:9)
		acme__log (4;Current method name:C684;"wildcard : "+Choose:C955($vb_wildcard;"true";"false"))
	Else 
		acme__log (4;Current method name:C684;"no \"wildcard\" property")
	End if 
	  //<Modif>
	
	ARRAY OBJECT:C1221($to_challenges;0)
	OB GET ARRAY:C1229($vo_authObj;"challenges";$to_challenges)
	
	C_TEXT:C284($vt_status;$vt_url;$vt_token)
	C_BOOLEAN:C305($vb_httpPendingChallengeFound)
	$vb_httpPendingChallengeFound:=False:C215
	
	C_LONGINT:C283($i)
	For ($i;1;Size of array:C274($to_challenges))
		C_TEXT:C284($vt_challengeType)
		
		ASSERT:C1129(OB Is defined:C1231($to_challenges{$i};"type"))
		$vt_challengeType:=OB Get:C1224($to_challenges{$i};"type")
		
		Case of 
			: ($vt_challengeType="http-01")
				ASSERT:C1129(OB Is defined:C1231($to_challenges{$i};"status"))
				$vt_status:=OB Get:C1224($to_challenges{$i};"status")
				
				Case of 
					: ($vt_status="valid")
						$vb_ok:=True:C214
						
						acme__log (4;Current method name:C684;"authorization "+String:C10($i)+" / "+String:C10(Size of array:C274($to_challenges))+\
							", challenge type : \""+$vt_challengeType+"\""+\
							", status : \""+$vt_status+"\"")
						
					: ($vt_status="pending")
						$vb_httpPendingChallengeFound:=True:C214
						ASSERT:C1129(OB Is defined:C1231($to_challenges{$i};"url"))
						$vt_url:=OB Get:C1224($to_challenges{$i};"url")
						
						ASSERT:C1129(OB Is defined:C1231($to_challenges{$i};"token"))
						$vt_token:=OB Get:C1224($to_challenges{$i};"token")
						
						acme__log (4;Current method name:C684;"authorization "+String:C10($i)+" / "+String:C10(Size of array:C274($to_challenges))+\
							", challenge type : \""+$vt_challengeType+"\""+\
							", status : \""+$vt_status+"\""+\
							", url : \""+$vt_url+"\""+\
							", token : \""+$vt_token+"\"...")
						
					Else 
						acme__log (2;Current method name:C684;"authorization "+String:C10($i)+" / "+String:C10(Size of array:C274($to_challenges))+\
							", challenge type : \""+$vt_challengeType+"\""+\
							", status : \""+$vt_status+"\"")
				End case 
				
			Else 
				acme__log (4;Current method name:C684;"authorization "+String:C10($i)+" / "+String:C10(Size of array:C274($to_challenges))+\
					", challenge type : \""+$vt_challengeType+"\" (not supported)")
		End case 
	End for 
	
	ARRAY OBJECT:C1221($to_challenges;0)
	
	If ($vb_httpPendingChallengeFound)
		
		  // get the account key dir (to get the account private key to sign request)
		C_TEXT:C284($vt_accountKeyDir)
		$vt_accountKeyDir:=acme__accountInit   // ($vt_workingDir;$vt_directoryUrl)
		
		  // the the private key file path
		C_TEXT:C284($vt_privateKeyPath)
		$vt_privateKeyPath:=acme__keysKeyPairFilepathGet ("private";$vt_accountKeyDir)
		
		  // compute the "jwkThumbprint" and append it to the token, we will write this string to a file
		  // the CA will request this file and we will have to return it to prove we have control of the DNS (and the server)
		C_TEXT:C284($vt_challengeResponse)
		$vt_challengeResponse:=$vt_token+"."+UTL_base64UrlSafeEncode (acme__jwkThumbprint ($vt_privateKeyPath))
		
		acme__log (4;Current method name:C684;" token : \""+$vt_token+"\""+\
			", challengeResponse : \""+$vt_challengeResponse+"\"")
		
		  // write a "<token>.txt" file in the "/.well-known/acme-challenge/" directory
		C_TEXT:C284($vt_challengeDirPath)
		$vt_challengeDirPath:=Get 4D folder:C485(HTML Root folder:K5:20)+".well-known"+Folder separator:K24:12+"acme-challenge"+Folder separator:K24:12
		
		If (Test path name:C476($vt_challengeDirPath)#Is a folder:K24:2)
			CREATE FOLDER:C475($vt_challengeDirPath;*)
			ASSERT:C1129(ok=1;"failed creating dir \""+$vt_challengeDirPath+"\"")
			acme__log (Choose:C955(ok=1;4;2);Current method name:C684;"acme-challenge dir  \""+$vt_challengeDirPath+"\" creation. "+Choose:C955(ok=1;"[OK]";"[KO]"))
		End if 
		acme__log (4;Current method name:C684;"store challengeResponse in : \""+$vt_challengeDirPath+"\"")
		
		  // save the challengeResponse
		C_TEXT:C284($vt_challengeFilePath)
		$vt_challengeFilePath:=$vt_challengeDirPath+acme__tokenToFilenameSafe ($vt_token)
		
		acme__log (4;Current method name:C684;"url : \""+$vt_url+"\""+\
			", token : \""+$vt_token+"\""+\
			", challengeResponse : \""+$vt_challengeResponse+"\""+\
			", file : \""+$vt_challengeFilePath+"\"...")
		
		UTL_textToFile ($vt_challengeFilePath;$vt_challengeResponse)
		
		acme__log (4;Current method name:C684;"challengeResponse file \""+$vt_challengeFilePath+"\" created, file content : "+$vt_challengeResponse)
		
		If (False:C215)  // for debugging
			SHOW ON DISK:C922($vt_challengeFilePath)
		End if 
		
		  // start 4D web server if necessary
		  // database method "On web connexion" calling "acme_onWeConnection"
		If (Not:C34(WEB Is server running:C1313))
			acme__log (4;Current method name:C684;"starting web server...")
			acme__notify ("4D http server : starting...")
			
			  // #4D-v19-newhttpServer
			
			WEB START SERVER:C617
			
			ASSERT:C1129(ok=1;"web server failed to start")
			acme__log (Choose:C955(ok=1;4;2);Current method name:C684;"web server started. "+Choose:C955(ok=1;"[OK]";"[KO]"))
			
			acme_logHttpServerInfos 
			
		Else 
			acme__log (4;Current method name:C684;"web server already running...")
		End if 
		
		  // get the CA to do the challenge
		  // the CA will try to do an "HTTP GET /.well-known/acme-challenge/<token>" (and we will return the file we have just generated)
		  // see "acme_onWebAuthentication" and "acme_onWebConnection"
		
		acme__log (4;Current method name:C684;"url : \""+$vt_url+"\" challenge request...")
		$vb_ok:=acme__challengeRequest ($vt_directoryUrl;$vt_url;$vt_workingDir)
		acme__log (Choose:C955($vb_ok;4;2);Current method name:C684;"url : \""+$vt_url+"\" challenge request done."+Choose:C955($vb_ok;"[OK]";"[KO]"))
		
	End if 
	
End if 
$0:=$vb_ok
