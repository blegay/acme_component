//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_componentVersionGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns the component version 
  //@parameter[0-OUT-componentVersion-TEXT] : component version (e.g. "2.00.05")
  //@notes :
  //@example : acme_componentVersionGet 
  //@see : 
  //@version : 2.00.05
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 04/12/2018, 23:39:22 - v0.90.00
  //  - beta release
  // MODIFICATION : Bruno LEGAY (BLE) - 14/02/2009, 12:00:00 - v0.90.01
  //  - refactoring, nonce: optimisation / improving performance
  //  - added acme_orderAuthorisationWait
  // MODIFICATION : Bruno LEGAY (BLE) - 21/02/2009, 12:00:00 - v0.90.02
  //  - added default configuration openssl file for Windows (see acme__opensslConfigDefault)
  //  - changed default working dir location, now : Get 4D folder(Database folder)
  // MODIFICATION : Bruno LEGAY (BLE) - 28/02/2019, 15:32:57 - v0.90.03
  //  - added acme_digestFile
  // MODIFICATION : Bruno LEGAY (BLE) - 13/03/2019, 17:51:21 - v0.90.04
  //  - added acme_sslCipherListSet
  // MODIFICATION : Bruno LEGAY (BLE) - 25/04/2019, 16:00:00 - v0.90.05
  //  - fixed a bug in acme_certCheckEnd on Windows
  // MODIFICATION : Bruno LEGAY (BLE) - 25/04/2019, 19:30:00 - v0.90.06
  //  - fixed (another) bug in acme_certCheckEnd on Windows
  // MODIFICATION : Bruno LEGAY (BLE) - 26/04/2019, 12:17:14 - v0.90.07
  //  - fixed bug in UTL_textToDocument (UTF8 chaîne en C => UTF8 texte sans longueur)
  // MODIFICATION : Bruno LEGAY (BLE) - 30/06/2019, 23:56:47 - v0.90.08
  //  - documentation, activation of http request default options
  //  - IMPORTANT : acme_certCurrentGet change order of parameters, optional keyPtr parameter
  // MODIFICATION : Bruno LEGAY (BLE) - 31/07/2019, 16:37:00 - v0.90.09
  //  - added acme_accountObjectGet
  //  - refactored acme__extractDomainFromUrl
  // MODIFICATION : Bruno LEGAY (BLE) - 06/09/2019, 13:18:25 - v0.90.10
  //  - fix in acme_certCurrentGet
  //  - fix in acme__challengeReqUrlMatch (allow compatibility options which strip the leading "/")
  //  - fix issue since account id is not returned in reponse json (since 01-08/2019) but in "Location" url instead
  //       https://community.letsencrypt.org/t/acme-v2-scheduled-removal-of-id-from-account-objects/94744/2
  // MODIFICATION : Bruno LEGAY (BLE) - 30/09/2019, 08:26:11 - v0.90.11
  //  - fix in acme_certCurrentGet : was returning false if only one parameter was passed
  // MODIFICATION : Bruno LEGAY (BLE) - 27/01/2020, 15:05:36 - v0.90.12
  //  - loop with delay = 2 mins when "HTTP Request" returns 0 in acme__nonceGet and acme__directoryUrlGet
  // MODIFICATION : Bruno LEGAY (BLE) - 19/02/2020, 18:26:24 - v0.90.13
  //  - do a POST as GET to send a jws
  //     https://community.letsencrypt.org/t/acme-v2-scheduled-deprecation-of-unauthenticated-resource-gets/74380
  //     https://tools.ietf.org/html/rfc8555#section-6.3
  // MODIFICATION : Bruno LEGAY (BLE) - 03/03/2020, 00:22:30 - v0.90.14
  //  - acme_certActiveDirPathGet : fix value returned when used in "Project" mode
  //  - acme_certChainToText : fix problems with end of line character
  //  - acme_newOrder : added a check to wait for the order to be in the expected state 
  //  - acme_orderGet : added
  // MODIFICATION : Bruno LEGAY (BLE) - 05/03/2020, 13:29:07 - v0.90.15
  //  - added acme_termsOfServiceUrlGet
  // MODIFICATION : Bruno LEGAY (BLE) - 05/03/2020, 18:46:01 - v0.90.16
  //  - added acme_certificateOrderAndInstall
  // MODIFICATION : Bruno LEGAY (BLE) - 20/04/2020, 00:27:19 - v1.00.00
  //  - first official release
  //  - in acme__nonceGet do not display ASSERT when HTTP GET returns 0 with error 30 (this happens sometimes)
  // MODIFICATION : Bruno LEGAY (BLE) - 29/07/2020, 17:42:31 - v1.00.01
  //  - fixed folder location for Engined app in acme_certActiveDirPathGet (the fix is commented out until it is properly tested/validated)
  // MODIFICATION : Bruno LEGAY (BLE) - 01/10/2020, 22:55:49 - v1.00.02
  //  - fixed bug with execBitForced (execution bit was not set when calling openssl on a MacOS X client). Fix suggested by Stanislas Caron
  // MODIFICATION : Bruno LEGAY (BLE) - 09/10/2020, 19:11:12 - v1.00.03
  //  - fixing a bug with getting modulus from "key.pem" from "account" dir (reported by Armin Deeg)
  // MODIFICATION : Bruno LEGAY (BLE) - 22/02/2021, 09:51:24 - 1.00.03
  //  - making code pre-emptive (4D v18.3)
  // MODIFICATION : Bruno LEGAY (BLE) - 04/05/2021, 13:25:59 - 2.00.00
  //  - making code pre-emptive (4D v18.3)
  //  - using Storage so code is now 4D v17+
  // MODIFICATION : Bruno LEGAY (BLE) - 09/05/2021, 15:16:01 - 2.00.01
  //  - fixed bug in acme_certCheckEnd, on OS X with 4D v17+ (change of behavior in LEP) 
  //  - fixed documentation bug in acme_certCheckEnd
  // MODIFICATION : Bruno LEGAY (BLE) - 21/07/2021, 16:28:30 - 2.00.02
  //  - added acme_assertionGet / acme_assertionSet
  //  - added code to detect headless/running as service (if so no assertions)
  //  - added acme__opensslConfigDefault call in acme__opensslCsrNew
  //  - notifications are disabled if application is headless or running as service
  //  - disabled assertions check in "err" stream in acme__openSslCmd
  //  MODIFICATION : Bruno LEGAY (BLE) - 29/09/2021, 10:19:15 - 2.00.03
  //  - acme__openSslCmd : use blob parameters to LAUNCH EXTERNAL PROCESS
  //  MODIFICATION : Bruno LEGAY (BLE) - 28/03/2022, 09:48:16 - 2.00.04
  //  - checked compatibility with 4D v19 (not tested with new Web server, only with Legacy)
  //  - added progress
  //  - fixed spurious ASSERT in UTL_textToFile with empty text
  //  - methods made public : acme_opensslVersionGet, acme_opensslCmd
  //  - sanitize openssl (hide passwords) commands for log files
  //  MODIFICATION : Bruno LEGAY (BLE) - 28/03/2022, 09:48:16 - 2.00.05
  //  - fixed a bug where the progress bar would not be closed properly
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_componentVersion)

  //<Modif> Bruno LEGAY (BLE) (01/03/2019)
  // #todo ? : 
  //    - dns challenge
  //    - interface
  //    - proxy auth ?
  //<Modif>
  //  MODIFICATION : Bruno LEGAY (BLE) - 17/01/2022, 12:07:55 - 2.00.03

  //<Modif> Bruno LEGAY (BLE) (28/03/2022)
  // fixed a bug where the progress bar would not be closed properly
$vt_componentVersion:="2.00.05"
  //<Modif>

  //<Modif> Bruno LEGAY (BLE) (26/01/2022)
  //  checked compatibility with 4D v19 (not tested with new Web server, only with Legacy)
  //  added progress
  //  fixed spurious ASSERT in UTL_textToFile with empty text
  //  methods made public : acme_opensslVersionGet, acme_opensslCmd
  //  sanitize openssl (hide passwords) commands for log files
  // $vt_componentVersion:="2.00.04"
  //<Modif>

If (False:C215)
	  //<Modif> Bruno LEGAY (BLE) (29/09/2021)
	  // acme__openSslCmd : use blob parameters to LAUNCH EXTERNAL PROCESS
	  // $vt_componentVersion:="2.00.03"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (21/07/2021)
	  // added acme_assertionGet / acme_assertionSet
	  // added code to detect headless/running as service (if so no assertions)
	  // added acme__opensslConfigDefault call in acme__opensslCsrNew
	  // notifications are disabled if application is headless or running as service
	  // disabled assertions check in "err" stream in acme__openSslCmd
	  // $vt_componentVersion:="2.00.02"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (09/05/2021)
	  // fixed bug in acme_certCheckEnd, on OS X with 4D v17+ (change of behavior in LEP)
	  // https://github.com/blegay/acme_component/commit/7dd33a8027e6ac807fe598651bebbe6c09ba1f4d 
	  // fixed documentation bug in acme_certCheckEnd
	  // https://github.com/blegay/acme_component/commit/de8bdcc4feb3f6f1b3ee749910b899b9fb2ac1ac#diff-80203937ff5648671c6ddb5b18c879d798a1ecb93884a58202d6832314156e97
	  // $vt_componentVersion:="2.00.01"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (22/02/2021)
	  // making code pre-emptive (4D v18.3)
	  // using Storage so code is now 4D v17+
	  // $vt_componentVersion:="2.00.00"
	  //<Modif>
	
	
	  //<Modif> Bruno LEGAY (BLE) (01/10/2020)
	  // fixing a bug with getting modulus from "key.pem" from "account" dir (reported by Armin Deeg)
	  // $vt_componentVersion:="1.00.03"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (01/10/2020)
	  // fixed bug with execBitForced (execution bit was not set when calling openssl on a MacOS X client)
	  //$vt_componentVersion:="1.00.02"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (29/07/2020)
	  // fixed folder location for Engined app in acme_certActiveDirPathGet (the fix is commented out until it is properly tested/validated). Fix suggested by Stanislas Caron
	  //$vt_componentVersion:="1.00.01"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (20/04/2020)
	  // $vt_componentVersion:="1.00.00"
	  //    - first official release
	  //    - in acme__nonceGet do not display ASSERT when HTTP GET returns 0 with error 30 (this happens sometimes)
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (05/03/2020)
	  //    - added acme_certificateOrderAndInstall
	  // $vt_componentVersion:="0.90.16"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (05/03/2020)
	  //    - added acme_termsOfServiceUrlGet
	  // $vt_componentVersion:="0.90.15"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (03/03/2020)
	  //    - acme_certActiveDirPathGet : fix value returned when used in "Project" mode
	  //    - acme_certChainToText : fix problems with end of line character
	  //    - acme_newOrder : added a check to wait for the order to be in the expected state 
	  //    - acme_orderGet : added
	  // $vt_componentVersion:="0.90.14"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (11/02/2020)
	  // do a POST as GET to send a jws
	  // https://community.letsencrypt.org/t/acme-v2-scheduled-deprecation-of-unauthenticated-resource-gets/74380
	  // https://tools.ietf.org/html/rfc8555#section-6.3
	  //$vt_componentVersion:="0.90.13"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (27/01/2020)
	  //    - loop with delay = 2 mins "HTTP Request" returns 0 in acme__nonceGet and acme__directoryUrlGet
	  // $vt_componentVersion:="0.90.12"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (30/09/2019)
	  // - fix in acme_certCurrentGet : was returning false if only one parameter was passed
	  //$vt_componentVersion:="0.90.11"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (06/09/2019)
	  // - fix in acme_certCurrentGet
	  // - fix in acme__challengeReqUrlMatch (allow compatibility options which strip the leading "/")
	  // - fix issue since account id is not returned in reponse json (since 01-08/2019) but in "Location" url instead
	  //       https://community.letsencrypt.org/t/acme-v2-scheduled-removal-of-id-from-account-objects/94744/2
	  // $vt_componentVersion:="0.90.10"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (31/07/2019)
	  // added acme_accountObjectGet
	  // refactored acme__extractDomainFromUrl
	  //$vt_componentVersion:="0.90.09"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (30/06/2019)
	  // documentation, activation of http request default options
	  // IMPORTANT : acme_certCurrentGet change order of parameters, optional keyPtr parameter
	  // $vt_componentVersion:="0.90.08"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (26/04/2019)
	  // fixed bug in UTL_textToDocument (UTF8 chaîne en C => UTF8 texte sans longueur)
	  // $vt_componentVersion:="0.90.07"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (25/04/2019)
	  // fixed (another) bug in acme_certCheckEnd on Windows
	  // $vt_componentVersion:="0.90.06"
	  //<Modif>s
	
	  //<Modif> Bruno LEGAY (BLE) (25/04/2019)
	  // fixed a bug in acme_certCheckEnd on Windows
	  // $vt_componentVersion:="0.90.05"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (13/03/2019)
	  // added acme_sslCipherListSet
	  //$vt_componentVersion:="0.90.04"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (28/02/2019)
	  // added acme_digestFile
	  // $vt_componentVersion:="0.90.03"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (21/02/2019)
	  // added default configuration openssl file for Windows (see acme__opensslConfigDefault)
	  // changed default working dir location, now : Get 4D folder(Database folder)
	  // $vt_componentVersion:="0.90.02"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (14/02/2019)
	  // refactoring, nonce: optimisation / improving performance
	  // added acme_orderAuthorisationWait
	  // $vt_componentVersion:="0.90.01"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (13/02/2019)
	  // first beta release
	  // $vt_componentVersion:="0.90.00"
	  //<Modif>
End if 

$0:=$vt_componentVersion
