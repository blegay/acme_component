//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__openssl4dVersion
  //@scope : public
  //@deprecated : no
  //@description : This function returns 4D openssl library version
  //@parameter[0-OUT-openssl4dVersion-TEXT] : openssl 4D internal vesion (e.g. "OpenSSL 1.0.2j  26 Sep 2016")
  //@notes : 
  //@example : acme__openssl4dVersion
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 06/12/2019, 14:52:24 - 0.90.11
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_openSslVersion)

If (ENV_isv17OrAbove )  // "Get database parameter" is not "thread-safe" compatible (in v18.0)
	
	C_OBJECT:C1216($vo_webServerInfos)
	$vo_webServerInfos:=WEB Get server info:C1531
	
	  //$vt_openSslVersion:=$vo_webServerInfos.security.cipherSuite
	$vt_openSslVersion:=$vo_webServerInfos.security.openSSLVersion
	
Else 
	
	  //%T-
	C_REAL:C285($vr_databaseParamResult)
	$vr_databaseParamResult:=Get database parameter:C643(94;$vt_openSslVersion)  // not "thread-safe" compatible (in v18.0) #thread-safe : OK
	  //%T+
	
	  // e.g. "OpenSSL 1.0.2j  26 Sep 2016" (4D v15.6)
End if 

$0:=$vt_openSslVersion