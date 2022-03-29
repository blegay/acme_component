# **Method :** acme_sampleCode
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
sample code
## **Parameters :** 
## **Notes :** 

## **Example :** 
```

        //================================================================================
        // name : Sur authentification web
        // scope : public
        // deprecated : no
        // description : http client authentication handler 
        // parameter[0-OUT-allowed-BOOLEAN] : TRUE if authenticated, FALSE otherwise
        // parameter[1-IN-url-TEXT] : url
        // parameter[2-IN-request-TEXT] : http request (header + body, 32 kb max size)
        // parameter[3-IN-clientIp-TEXT] : client ip address
        // parameter[4-IN-serverIp-TEXT] : server ip address
        // parameter[5-IN-username-TEXT] : username
        // parameter[6-IN-password-TEXT] : password
        // notes : 
        // example : Sur uthentification web
        // see : 
        // version : 1.00.00
        // author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
        // history : 
        //  CREATION : Bruno LEGAY (BLE) - 01/07/2019, 16:03:41 - 0.90.08
        //================================================================================
      C_BOOLÉEN($0;$vb_allowed)
      C_TEXTE($1;$vt_url)
      C_TEXTE($2;$vt_request)
      C_TEXTE($3;$vt_clientIp)
      C_TEXTE($4;$vt_serverIp)
      C_TEXTE($5;$vt_username)
      C_TEXTE($6;$vt_password)
      ASSERT(Nombre de paramètres>5;"requires 6 parameters")
      $vb_allowed:=Faux
      $vt_url:=$1
      $vt_request:=$2
      $vt_clientIp:=$3
      $vt_serverIp:=$4
      $vt_username:=$5
      $vt_password:=$6
      Au cas ou 
      : (acme_onWebAuthentication ($vt_url;->$vb_allowed))  // gestion letsencrypt (challenge)
      Sinon   // code application spécifique
      $vb_allowed:=...
      Fin de cas 
      $0:=$vb_allowed
        //================================================================================
        // name : Sur connexion Web
        // scope : public
        // deprecated : no
        // description : http client connexion handler 
        // parameter[1-IN-url-TEXT] : url
        // parameter[2-IN-request-TEXT] : http request (header + body, 32 kb max size)
        // parameter[3-IN-clientIp-TEXT] : client ip address
        // parameter[4-IN-serverIp-TEXT] : server ip address
        // parameter[5-IN-username-TEXT] : username
        // parameter[6-IN-password-TEXT] : password
        // notes : 
        // example : Sur connexion Web
        // see : 
        // version : 1.00.00
        // author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
        // history : 
        //  CREATION : Bruno LEGAY (BLE) - 01/07/2019, 16:03:41 - 0.90.08
        //================================================================================
      C_TEXTE($1;$vt_url)
      C_TEXTE($2;$vt_request)
      C_TEXTE($3;$vt_clientIp)
      C_TEXTE($4;$vt_serverIp)
      C_TEXTE($5;$vt_username)
      C_TEXTE($6;$vt_password)
      ASSERT(Nombre de paramètres>5;"requires 6 parameters")
      $vt_url:=$1
      $vt_request:=$2
      $vt_clientIp:=$3
      $vt_serverIp:=$4
      $vt_username:=$5
      $vt_password:=$6
      Au cas ou 
      : (acme_onWebConnection ($vt_url))  // gestion letsencrypt (challenge)
      Sinon   // code application spécifique
      Fin de cas 
        //================================================================================
        // name : cert_accountCreate
        // scope : public
        // deprecated : no
        // description : This function creates an account for letsencrypt
        // notes :
        // example : cert_accountCreate 
        // see : 
        // version : 1.00.00
        // author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
        // history : CREATION : Bruno LEGAY (BLE) - 13/02/2019, 18:48:34 - v1.00.00
        //================================================================================
      C_TEXTE($vt_contact)
      $vt_contact:="mailto:me@example.com"
      C_BOOLÉEN($vt_termsOfserviceAgreed)
      $vt_termsOfserviceAgreed:=Vrai
      C_OBJET($vo_payload)
      $vo_payload:=acme_newAccountObject (->$vt_contact;$vt_termsOfserviceAgreed)
      acme_newAccount ($vo_payload)
        //================================================================================
        // name : cert_renewAuto
        // scope : public
        // deprecated : no
        // description : This method will check that the certificate will expire within few days and starts the certifcate renewal operation
        // notes :
        // example : cert_renewAuto 
        // see : 
        // version : 1.00.00
        // author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
        // history : CREATION : Bruno LEGAY (BLE) - 13/02/2019, 18:49:31 - v1.00.00
        //================================================================================
      C_BOOLÉEN($vb_renew)
      $vb_renew:=Faux
        // Load current certificates (and private key)
      C_TEXTE($vt_cert)
      Si (acme_certCurrentGet (->$vt_cert))
      C_ENTIER LONG($vl_nbDays;$vl_secs)
      $vl_nbDays:=30
      $vl_secs:=$vl_nbDays*86400  // 86400 = 24 x 60 x 60
        // check if the certificate will expire
      $vb_renew:=acme_certCheckEnd ($vt_cert;$vl_secs)
      Si ($vb_renew)  // do some logs here...
      Fin de si 
      Sinon   // no certificates
      $vb_renew:=Vrai
      Fin de si 
      Si ($vb_renew)
      cert_renew
      Fin de si 
        //================================================================================
        // name : cert_renew
        // scope : public
        // deprecated : no
        // description : This function will perform the certificate renewal
        // parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
        // notes :
        // example : cert_renew 
        // see : 
        // version : 1.00.00
        // author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
        // history : CREATION : Bruno LEGAY (BLE) - 13/02/2019, 18:47:24 - v1.00.00
        //================================================================================
      C_BOOLÉEN($0;$vb_ok)
      Si (Vrai)  // list of domains to challenge
      TABLEAU TEXTE($tt_domain;0)
      AJOUTER À TABLEAU($tt_domain;"example.com")
      AJOUTER À TABLEAU($tt_domain;"www.example.com")
      AJOUTER À TABLEAU($tt_domain;"api.example.com")
      AJOUTER À TABLEAU($tt_domain;"status.example.com")
      AJOUTER À TABLEAU($tt_domain;"blog.example.com")
      C_OBJET($vo_newOrderObject)
      $vo_newOrderObject:=acme_newOrderObject (->$tt_domain)
      Fin de si 
      Si (Vrai)  // information for the csr
      C_OBJET($vo_dn)
      OB FIXER($vo_dn;"C";"FR")
      OB FIXER($vo_dn;"L";"Paris")
      OB FIXER($vo_dn;"ST";"Paris (75)")
      OB FIXER($vo_dn;"O";"Example")
      OB FIXER($vo_dn;"OU";"Example Inc")
      OB FIXER($vo_dn;"emailAddress";"me@example.com")
      OB FIXER($vo_dn;"CN";$tt_domain{1})
      C_OBJET($vo_altNames)
      $vo_altNames:=acme_csrAltnamesNew (->$tt_domain;2)  // starting at 2
      C_OBJET($vo_csrReqConfObject)
      $vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_dn;$vo_altNames)
      Fin de si 
      $vb_ok:=acme_newOrderAndInstall ($vo_newOrderObject;$vo_csrReqConfObject)
        //ASSERT($vb_ok;"failed to install new certificate")
      Si (Vrai)  // send a mail to notify the result of the operation
      C_TEXTE($vt_subject;$vt_body;$vt_from;$vt_to;$vt_cc)
      $vt_from:="me@example.com"
      $vt_to:="boss@example.com"
      $vt_cc:="devops@example.com"
      Si ($vb_ok)
      $vt_subject:="[Example] certificate renewal [OK]"
      $vt_body:="Certificate renewal success."
      $vt_body:=$vt_body+"\r"+"certificate dir path : \""+acme_activeCertsDirPathGet+"\""
      C_TEXTE($vt_cert;$vt_certText)
      Si (acme_certCurrentGet (->$vt_cert))
      $vt_certText:=acme_certToText (->$vt_cert)
      $vt_certText:=Remplacer chaîne($vt_certText;"\n";"\r";*)
      $vt_body:=$vt_body+"\r\r"+$vt_certText
      Fin de si 
      Sinon 
      $vt_subject:="[Example] certificate renewal [KO]"
      $vt_body:="Certificate renewal failure !!!."
      Fin de si 
        //C_TEXTE($vt_host)  //smtp host
        //C_TEXTE($vt_port)  //smtp port
        //C_BOOLÉEN($vb_useSsl)  //use ssl
        //C_TEXTE($vt_authLogin)  //smtp authLogin
        //C_TEXTE($vt_authPasword)  //smtp authPassword
        //C_TEXTE($vt_authMode)  //smtp authMode
        //C_TEXTE($vt_encryptPasswordMethod)  //encrypt password method
        //  //C_TEXTE($vt_bcc)  //bcc
        //  //C_TEXTE($vt_replyTo)  //replyTo
        //  // lecture des paramètres sur le serveur
        //ut_smtp_paramReadOnServer(->$vt_host;->$vt_port;->$vb_useSsl;->$vt_authLogin;->$vt_authPasword;->$vt_authMode;->$vt_encryptPasswordMethod)
        //C_ENTIER LONG($vl_error)
        //$vl_error:=smtp_sendText($vt_host;$vt_port;$vb_useSsl;$vt_authLogin;$vt_authPasword;$vt_authMode;$vt_subject;$vt_body;$vt_from;$vt_to;$vt_cc)  //;$vt_bcc;$vt_replyTo;
      Fin de si 
      TABLEAU TEXTE($tt_domain;0)
      EFFACER VARIABLE($vo_csrReqConfObject)
      EFFACER VARIABLE($vo_altNames)
      EFFACER VARIABLE($vo_dn)
      $0:=$vb_ok
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 01/07/2019, 16:21:25 - 0.90.08
