//%attributes = {"shared":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_sslCipherListGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns the 4D web server cipher list
  //@parameter[0-OUT-cipherList-TEXT] : cipher list
  //@notes : 
  //@example : acme_sslCipherListGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 13/03/2019, 17:28:04 - 0.90.03
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_cipherList)

If (ENV_isv17OrAbove )  // "Get database parameter" is not "thread-safe" compatible (in v18.0)
	
	C_OBJECT:C1216($vo_webServerInfos)
	$vo_webServerInfos:=WEB Get server info:C1531
	
	$vt_cipherList:=$vo_webServerInfos.security.cipherSuite
	
Else 
	
	  //%T-
	C_REAL:C285($vr_databaseParamResult)
	$vr_databaseParamResult:=Get database parameter:C643(SSL cipher list:K37:54;$vt_cipherList)  // not "thread-safe" compatible (in v18.0) #thread-safe : OK
	  //%T+
	
End if 

acme__log (Choose:C955((ok=1);4;2);Current method name:C684;"cipher list : \""+$vt_cipherList+"\" "+Choose:C955((ok=1);"[OK]";"[KO]"))

$0:=$vt_cipherList

If (False:C215)
	
	  // 15.6 build 15.222813
	  // OpenSSL 1.0.2j  26 Sep 2016
	
	  // 18.0 build 18.246179 :
	  // OpenSSL 1.1.1d  10 Sep 2019
	  //  default cipher list :
	  //   TLS_AES_256_GCM_SHA384
	  //   TLS_CHACHA20_POLY1305_SHA256
	  //   TLS_AES_128_GCM_SHA256
	  //   ECDHE-RSA-AES128-GCM-SHA256
	  //   ECDHE-ECDSA-AES128-GCM-SHA256
	  //   ECDHE-RSA-AES256-GCM-SHA384
	  //   ECDHE-ECDSA-AES256-GCM-SHA384
	  //   DHE-RSA-AES128-GCM-SHA256
	  //   DHE-DSS-AES128-GCM-SHA256
	  //   DHE-DSS-AES256-GCM-SHA384
	  //   DHE-RSA-AES256-GCM-SHA384
	  //   ECDHE-RSA-AES128-SHA256
	  //   ECDHE-ECDSA-AES128-SHA256
	  //   ECDHE-RSA-AES128-SHA
	  //   ECDHE-ECDSA-AES128-SHA
	  //   ECDHE-RSA-AES256-SHA384
	  //   ECDHE-ECDSA-AES256-SHA384
	  //   ECDHE-RSA-AES256-SHA
	  //   ECDHE-ECDSA-AES256-SHA
	  //   DHE-RSA-AES128-SHA256
	  //   DHE-RSA-AES128-SHA
	  //   DHE-DSS-AES128-SHA256
	  //   DHE-RSA-AES256-SHA256
	  //   DHE-DSS-AES256-SHA
	  //   DHE-RSA-AES256-SHA
	  //   AES128-GCM-SHA256
	  //   AES256-GCM-SHA384
	  //   ECDHE-ECDSA-AES128-CCM8
	  //   ECDHE-ECDSA-AES128-CCM
	  //   DHE-RSA-AES128-CCM8
	  //   DHE-RSA-AES128-CCM
	  //   DHE-DSS-AES128-SHA
	  //   AES128-CCM8
	  //   AES128-CCM
	  //   AES128-SHA256
	  //   SRP-DSS-AES-128-CBC-SHA
	  //   SRP-RSA-AES-128-CBC-SHA
	  //   SRP-AES-128-CBC-SHA
	  //   AES128-SHA
	  //   ECDHE-ECDSA-AES256-CCM8
	  //   ECDHE-ECDSA-AES256-CCM
	  //   DHE-RSA-AES256-CCM8
	  //   DHE-RSA-AES256-CCM
	  //   DHE-DSS-AES256-SHA256
	  //   AES256-CCM8
	  //   AES256-CCM
	  //   AES256-SHA256
	  //   SRP-DSS-AES-256-CBC-SHA
	  //   SRP-RSA-AES-256-CBC-SHA
	  //   SRP-AES-256-CBC-SHA
	  //   AES256-SHA
	  //   ECDHE-ECDSA-CHACHA20-POLY1305
	  //   ECDHE-RSA-CHACHA20-POLY1305
	  //   DHE-RSA-CHACHA20-POLY1305
	  //   ECDHE-ECDSA-ARIA256-GCM-SHA384
	  //   ECDHE-ARIA256-GCM-SHA384
	  //   DHE-DSS-ARIA256-GCM-SHA384
	  //   DHE-RSA-ARIA256-GCM-SHA384
	  //   ECDHE-ECDSA-ARIA128-GCM-SHA256
	  //   ECDHE-ARIA128-GCM-SHA256
	  //   DHE-DSS-ARIA128-GCM-SHA256
	  //   DHE-RSA-ARIA128-GCM-SHA256
	  //   ECDHE-ECDSA-CAMELLIA256-SHA384
	  //   ECDHE-RSA-CAMELLIA256-SHA384
	  //   DHE-RSA-CAMELLIA256-SHA256
	  //   DHE-DSS-CAMELLIA256-SHA256
	  //   ECDHE-ECDSA-CAMELLIA128-SHA256
	  //   ECDHE-RSA-CAMELLIA128-SHA256
	  //   DHE-RSA-CAMELLIA128-SHA256
	  //   DHE-DSS-CAMELLIA128-SHA256
	  //   DHE-RSA-CAMELLIA256-SHA
	  //   DHE-DSS-CAMELLIA256-SHA
	  //   DHE-RSA-CAMELLIA128-SHA
	  //   DHE-DSS-CAMELLIA128-SHA
	  //   ARIA256-GCM-SHA384
	  //   ARIA128-GCM-SHA256
	  //   CAMELLIA256-SHA256
	  //   CAMELLIA128-SHA256
	  //   CAMELLIA256-SHA
	  //   CAMELLIA128-SHA
	
End if 