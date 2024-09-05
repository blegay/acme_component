//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certCheckEnd
  //@scope : public
  //@deprecated : no
  //@description : This function returns TRUE if the certificates will expire expires in the next $2 seconds
  //@parameter[0-OUT-willExpire-BOOLEAN] : TRUE if the certificates will expire in the next $2 seconds, FALSE otherwise
  //@parameter[1-IN-cert-TEXT] : cert in PEM format
  //@parameter[2-IN-nbSeconds-LONGINT] : number of seconds (optional, default 0)
  //@notes : this function uses openssl x509 "checkend" feature
  //@example : acme_certCheckEnd
  //
  // C_TEXT($vt_cert)
  // If (acme_certCurrentGet (->$vt_cert))
  //    C_LONGINT($vl_nbDays;$vl_secs)
  //    $vl_nbDays:=30
  //    $vl_secs:=$vl_nbDays*86400 // 86400 = 24 x 60 x 60
  //    If (acme_certCheckEnd ($vt_cert;$vl_secs))
  //      // Do something here because the certificate will expire in the next $vl_nbDays days
  //    Else
  //      // not to worry, the certificate will be valid for the next $vl_nbDays days :-)
  //    End if
  // End if
  //
  //@see :
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history :
  //  CREATION : Bruno LEGAY (BLE) - 12/02/2019, 09:19:06 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_willExpire)
C_TEXT:C284($1;$vt_cert)
C_LONGINT:C283($2;$vl_nbSeconds)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"cert is empty")

$vb_willExpire:=True:C214
If (Count parameters:C259>0)
	$vt_cert:=$1
	
	If (Count parameters:C259=1)
		$vl_nbSeconds:=0
	Else 
		$vl_nbSeconds:=$2
	End if 
	
	If ($vl_nbSeconds<0)
		$vl_nbSeconds:=0
	End if 
	
	If (Length:C16($vt_cert)>0)
		
		If (Is Windows:C1573)
			
			C_TEXT:C284($vt_uuid)
			$vt_uuid:=Generate UUID:C1066
			
			C_TEXT:C284($vt_certTempPath;$vt_certTempPathPosix;$vt_batTempPath)
			$vt_certTempPath:=Temporary folder:C486+"acme_component_checkend_"+$vt_uuid+".crt"
			$vt_batTempPath:=Temporary folder:C486+"acme_component_checkend_"+$vt_uuid+".bat"
			
			C_TEXT:C284($vt_inform)
			$vt_inform:="PEM"
			
			C_TEXT:C284($vt_bat)
			$vt_bat:="@ECHO OFF\r"+\
				"set OPENSSL_CONF="+acme__opensslConfigDefaultSub +"\r"+\
				acme__opensslPathGet +" x509 -noout -checkend "+String:C10($vl_nbSeconds)+" -inform "+$vt_inform+" -in "+UTL_pathToPosixConvert ($vt_certTempPath)+"\r"+\
				"echo %ERRORLEVEL%\r"
			
			acme__log (6;Current method name:C684;"bat file :\r"+$vt_bat)
			
			  // write UTF8 file without bom with CRLF as line separator
			UTL_textToDocument ($vt_certTempPath;TXT_endOfLineNormalize ($vt_cert;Document with CRLF:K24:20))
			UTL_textToDocument ($vt_batTempPath;TXT_endOfLineNormalize ($vt_bat;Document with CRLF:K24:20))
			
			  // writes files without bom (but not UTF8), converts CR to CRLF on windows :
			  // TEXTE VERS DOCUMENT($vt_certTempPath;$vt_cert;"windows-1252")
			  // TEXTE VERS DOCUMENT($vt_batTempPath;$vt_bat;"windows-1252")
			  //
			  // writes files with bom, converts CR to CRLF on windows :
			  // TEXTE VERS DOCUMENT($vt_certTempPath;$vt_cert)
			  // TEXTE VERS DOCUMENT($vt_batTempPath;$vt_bat)
			
			
			  // C:\Users\SRV-4D>"C:\Users\SRV-4D\Documents\INP-4D\prod\app\Components\acme_component.4dbase\Resources\openssl\win32\openssl.exe" x509  -noout  -checkend 1000  -inform PEM -in C:\Users\SRV-4D\Desktop\cert_test.pem & echo %errorlevel%
			  // WARNING: can't open config file: /usr/local/ssl/openssl.cnf
			  // 0
			  // $vb_willExpire => Faux
			
			  // C:\Users\SRV-4D>"C:\Users\SRV-4D\Documents\INP-4D\prod\app\Components\acme_component.4dbase\Resources\openssl\win32\openssl.exe" x509  -noout  -checkend 10000000  -inform PEM -in C:\Users\SRV-4D\Desktop\cert_test.pem & echo %errorlevel%
			  // WARNING: can't open config file: /usr/local/ssl/openssl.cnf
			  // 1
			  // $vb_willExpire => Vrai
			
			C_BOOLEAN:C305($vb_ok)
			C_TEXT:C284($vt_out;$vt_err)
			$vb_ok:=acme__executeBatFile ($vt_batTempPath;->$vt_out;->$vt_err)
			
			acme__log (4;Current method name:C684;"bat file :\r"+$vt_bat+"\rout : \""+Replace string:C233(Replace string:C233($vt_out;"";"<LF>";*);"";"<CR>";*)+"\"\rerr : \""+Replace string:C233(Replace string:C233($vt_err;"";"<LF>";*);"";"<CR>";*))
			If ($vb_ok)
				$vb_willExpire:=(Replace string:C233($vt_out;"\r\n";"";*)="1")
				acme__log (4;Current method name:C684;"nb seconds : "+String:C10($vl_nbSeconds)+", windows (execute bat ok), out : \""+Replace string:C233($vt_out;"\r\n";"";*)+"\" => "+Choose:C955($vb_willExpire;"invalid";"valid"))
			Else 
				$vb_willExpire:=True:C214
				acme__log (4;Current method name:C684;"nb seconds : "+String:C10($vl_nbSeconds)+", windows (execute bat ko) => invalid")
			End if 
			
			  // @ECHO OFF
			  //
			  // set OPENSSL_CONF=C:\Users\Win\Documents\bruno\acme_component.4dbase\Resources\openssl\openssl.cnf
			  //
			  // "C:\Users\Win\Documents\bruno\acme_component.4dbase\Resources\openssl\win32\openssl.exe" x509  -noout  -checkend 3024000  -inform PEM -in "C:\Users\Win\Documents\bruno\test\20190424-cert\cert.pem"
			  // REM "C:\Users\Win\AppData\Local\Temp\acme_component_checkend_6FC8DD3B1EA6564BA14807A7CE40D12D.crt"
			  //
			  // echo %ERRORLEVEL%
			
			If (Test path name:C476($vt_certTempPath)=Is a document:K24:1)
				DELETE DOCUMENT:C159($vt_certTempPath)
				ASSERT:C1129(ok=1;"error deleting file \""+$vt_certTempPath+"\"")
			End if 
			If (Test path name:C476($vt_batTempPath)=Is a document:K24:1)
				DELETE DOCUMENT:C159($vt_batTempPath)
				ASSERT:C1129(ok=1;"error deleting file \""+$vt_batTempPath+"\"")
			End if 
			
			
		Else 
			
			C_TEXT:C284($vt_inform)
			$vt_inform:="PEM"
			
			C_TEXT:C284($vt_args)
			$vt_args:="x509 "+\
				" -checkend "+String:C10($vl_nbSeconds)+\
				" -inform "+$vt_inform
			
			  //" -noout " => "Certificate will not expire" or "Certificate will expire" output
			  // we need to remove "noout" option to get "Certificate will not expire" or "Certificate will expire" output
			  // This is a change of behaviour observed in 4D v17+ (LEP always set ok to 1 regarldess of function result i.e. $?)
			
			C_TEXT:C284($vt_in;$vt_out;$vt_err)
			$vt_in:=$vt_cert
			$vt_out:=""
			$vt_err:=""
			
			  //  -checkend arg   - check whether the cert expires in the next arg seconds, exit 1 (error i.e. ok=0) if so, 0 (no error i.e. ok=1) if not
			
			  // MacBook-Pro-Bruno-5:~ ble$ '/Users/ble/Documents/Projets/BaseRef_v15/acme_component/source/acme_component.4dbase/Resources/openssl/osx/openssl' x509  -noout  -checkend 1000  -inform PEM  -in /Users/ble/Documents/Projets/BaseRef_v15/acme_component/source/test/20190424-cert/cert.pem
			  // MacBook-Pro-Bruno-5:~ ble$ echo $?
			  // 0 (no error, $vb_willExpire = False)
			  // MacBook-Pro-Bruno-5:~ ble$ '/Users/ble/Documents/Projets/BaseRef_v15/acme_component/source/acme_component.4dbase/Resources/openssl/osx/openssl' x509  -noout  -checkend 10000000  -inform PEM  -in /Users/ble/Documents/Projets/BaseRef_v15/acme_component /source/test/20190424-cert/cert.pem
			  // MacBook-Pro-Bruno-5:~ ble$ echo $?
			  // 1 ($vb_willExpire = True)
			
			C_BOOLEAN:C305($vb_ok)
			  //$vb_ok:=acme_opensslCmd($vt_args;->$vt_in;->$vt_out;->$vt_err)
			  //If ($vb_ok)
			  //$vb_willExpire:=True  // the certificat will expire  in the next $vl_nbSeconds second
			  //acme__log(4;Current method name;"nb seconds : "+String($vl_nbSeconds)+", os x (lpe ok) => invalid")
			  //Else 
			  //$vb_willExpire:=False
			  //acme__log(4;Current method name;"nb seconds : "+String($vl_nbSeconds)+", os x (lpe ko) => valid")
			  //End if 
			
			C_BOOLEAN:C305($vb_ok)
			$vb_ok:=acme_opensslCmd ($vt_args;->$vt_in;->$vt_out;->$vt_err)
			If ($vb_ok)
				$vt_out:=Replace string:C233($vt_out;"\n";"";*)
				$vt_out:=Replace string:C233($vt_out;"\r";"";*)
				
				  //out : "Certificate will not expire"
				  //out : "Certificate will expire"
				Case of 
					: ($vt_out="Certificate will expire")
						$vb_willExpire:=True:C214  // the certificat will expire  in the next $vl_nbSeconds second
						
					: ($vt_out="Certificate will not expire")
						$vb_willExpire:=False:C215
						
					Else 
						$vb_willExpire:=True:C214
						ASSERT:C1129(False:C215;"unexpected value \""+$vt_out+"\"")
				End case 
				
				acme__log (4;Current method name:C684;"nb seconds : "+String:C10($vl_nbSeconds)+", os x (lpe ok) => valid")
			Else 
				$vb_willExpire:=True:C214
				acme__log (4;Current method name:C684;"nb seconds : "+String:C10($vl_nbSeconds)+", os x (lpe ko) => invalid")
			End if 
			
		End if 
		
	End if 
End if 
$0:=$vb_willExpire
