//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_sslCipherListSet
  //@scope : public
  //@deprecated : no
  //@description : This method sets the cipher list for 4D openssl library and 4D http server
  //@parameter[1-IN-cipherList-TEXT] : ParamDescription
  //@notes :
  // 4D default is probably "ALL:!EXPORT:!LOW:!aNULL:!eNULL:!SSLv2" (strings /Applications/dev/4D/4D_v17_0_HF43/4D\ v17.0/4D.app/Contents/Frameworks/libssl.1.0.0.dylib  | grep SSLv)
  //  openssl ciphers -v 'ALL:!EXPORT:!LOW:!aNULL:!eNULL:!SSLv2'
  //@example : 
  //  // disable SSLv2, SSLv3 and TLSv1.0 (i.e. use "TLSv1.2" only)
  // acme_sslCipherListSet ("HIGH:!EXPORT:!LOW:!aNULL:!eNULL:!SSLv2:!SSLv3:!TLSv1:@STRENGTH")
  //@see : acme_sslCipherListGet
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 13/03/2019, 17:15:27 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_cipherList)

If (Count parameters:C259>0)
	$vt_cipherList:=$1
Else 
	$vt_cipherList:=""
End if 

acme__init 

C_TEXT:C284($vt_cipherListRead)
C_REAL:C285($vr_result)
$vr_result:=Get database parameter:C643(SSL cipher list:K37:54;$vt_cipherListRead)  // not "thread-safe" compatible (in v18.0) #thread-safe : todo
acme__log (6;Current method name:C684;"cipher list (old) : \""+$vt_cipherListRead+"\"")

If (Not:C34(TXT_isEqualStrict ($vt_cipherList;$vt_cipherListRead)))
	
	SET DATABASE PARAMETER:C642(SSL cipher list:K37:54;$vt_cipherList)  // not "thread-safe" compatible (in v18.0) #thread-safe : todo
	acme__log (Choose:C955((ok=1);4;2);Current method name:C684;"cipher list : \""+$vt_cipherList+"\" set. "+Choose:C955((ok=1);"[OK]";"[KO]"))
	
	C_REAL:C285($vr_result)
	$vr_result:=Get database parameter:C643(SSL cipher list:K37:54;$vt_cipherListRead)  // not "thread-safe" compatible (in v18.0) #thread-safe : todo
	acme__log (6;Current method name:C684;"cipher list (new) : \""+$vt_cipherListRead+"\"")
	
	  // we need to restart the web server if it was started...
	If (WEB Is server running:C1313)
		acme_webServerRestart 
	End if 
	
End if 