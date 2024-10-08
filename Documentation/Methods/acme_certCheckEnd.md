﻿# **Method :** acme_certCheckEnd
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns TRUE if the certificates will expire expires in the next $2 seconds
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | willExpire | BOOLEAN | TRUE if the certificates will expire in the next $2 seconds, FALSE otherwise | 
| $1 | IN | cert | TEXT | cert in PEM format | 
| $2 | IN | nbSeconds | LONGINT | number of seconds (optional, default 0) | 

## **Notes :** 
this function uses openssl x509 "checkend" feature
## **Example :** 
```
acme_certCheckEnd
      
       C_TEXT($vt_cert)
       If (acme_certCurrentGet (->$vt_cert))
          C_LONGINT($vl_nbDays;$vl_secs)
          $vl_nbDays:=30
          $vl_secs:=$vl_nbDays*86400 // 86400 = 24 x 60 x 60
          If (acme_certCheckEnd ($vt_cert;$vl_secs))
            // Do something here because the certificate will expire in the next $vl_nbDays days
          Else
            // not to worry, the certificate will be valid for the next $vl_nbDays days :-)
          End if
       End if
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 

        CREATION : Bruno LEGAY (BLE) - 12/02/2019, 09:19:06 - 1.00.00
