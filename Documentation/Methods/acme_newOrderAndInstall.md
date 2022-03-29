# **Method :** acme_newOrderAndInstall
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function orders the certificate, prepares to repond to lets-encrypt challenges, 
        retrieves the certificates and installs them and restarts the web server
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if OK, FALSE otherwise | 
| $1 | IN | newOrderObject | OBJECT | new order object (see acme_newOrderObject) | 
| $2 | IN | csrReqConfObject | OBJECT | csr configuration request (see acme_csrReqConfObjectNew) | 

## **Notes :** 
calling this function will stop and restart the web server
       if the web server is not started, it will be started
## **Example :** 
```

        // ==========================
        // Simple / basic example
        // ==========================
       // just one domain
      C_TEXT($vt_domain)
      $vt_domain:="www.example.com"
      C_OBJECT($vo_newOrderObject)
      $vo_newOrderObject:=acme_newOrderObject (->$vt_domain)
      C_OBJET($vo_dn)
      OB SET($vo_dn;"C";"FR")
      OB SET($vo_dn;"L";"Paris")
      OB SET($vo_dn;"ST";"Paris (75)")
      OB SET($vo_dn;"O";"AC Consulting")
      OB SET($vo_dn;"OU";"AC Consulting")
      OB SET($vo_dn;"emailAddress";"john@example.com")
      OB SET($vo_dn;"CN";$vt_domain)
      C_OBJECT($vo_csrReqConfObject)
      $vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_dn)
        // order the certificate, prepare to repond to lets-encrypt challenges, 
        // retrieve the certificates and install them
      acme_newOrderAndInstall ($vo_newOrderObject;$vo_csrReqConfObject)
        // ==========================
        // Example with alt-names
        // ==========================
       // list of domains, firt one will be the "CN" and the other ones will be the alt-names...
      TEXT ARRAY($tt_domain;0)
      APPEND TO ARRAY($tt_domain;"www.example.com")  // main CN
      APPEND TO ARRAY($tt_domain;"api.example.com")  // alt name #1
      APPEND TO ARRAY($tt_domain;"status.example.com")  // alt name #2
      C_OBJECT($vo_newOrderObject)
      $vo_newOrderObject:=acme_newOrderObject (->$tt_domain)
       // infos for the certiticate request
      C_OBJECT($vo_dn)
      OB SET($vo_dn;"C";"FR")
      OB SET($vo_dn;"L";"Paris")
      OB SET($vo_dn;"ST";"Paris (75)")
      OB SET($vo_dn;"O";"AC Consulting")
      OB SET($vo_dn;"OU";"AC Consulting")
      OB SET($vo_dn;"emailAddress";"john@example.com")
      OB SET($vo_dn;"CN";$tt_domain{1})
      C_OBJECT($vo_altNames)
      $vo_altNames:=acme_csrAltnamesNew (->$tt_domain;2)  // starting at 2
      C_OBJECT($vo_csrReqConfObject)
      $vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_dn;$vo_altNames)
        // order the certificate, prepare to repond to lets-encrypt challenges, 
        // retrieve the certificates and install them
      acme_newOrderAndInstall ($vo_newOrderObject;$vo_csrReqConfObject)
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 13/02/2019, 17:42:25 - 1.00.00
