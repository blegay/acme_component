# **Method :** acme_authorizationGet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function retrieves the authorization object
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if ok, FALSE otherwise | 
| $1 | IN | url | TEXT | authorization url (e.g. "https://acme-staging-v02.api.letsencrypt.org/acme/authz/UOO_ci...sLI") | 
| $2 | IN | authorizationObjPtr | POINTER | authorization object pointer (modified) | 

## **Notes :** 

      
        curl https://acme-staging-v02.api.letsencrypt.org/acme/authz/UOO_ci1...sLI
       {
         "identifier": {
           "type": "dns",
           "value": "www.example.com"
         },
         "status": "pending",
         "expires": "2018-06-29T15:36:28Z",
         "challenges": [
           {
             "type": "dns-01",
             "status": "pending",
             "url": "https://acme-staging-v02.api.letsencrypt.org/acme/challenge/UOO_ci1...sLI/1234567",
             "token": "R2VX-K...m7Y"
           },
           {
             "type": "http-01",
             "status": "pending",
             "url": "https://acme-staging-v02.api.letsencrypt.org/acme/challenge/UOO_ci1...sLI/1234568",
             "token": "IFYoEg...SQ"
           },
           {
             "type": "tls-alpn-01",
             "status": "pending",
             "url": "https://acme-staging-v02.api.letsencrypt.org/acme/challenge/UOO_ci1...sLI/1234569",
             "token": "fx-t44...SA"
           }
         ]
## **Example :** 
```
amce_authorizationGet
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 23/06/2018, 17:46:00 - 1.00.00
