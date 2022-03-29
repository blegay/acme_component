# **Method :** acme_httpChallengePrepare
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This will the the authorization for the domain, prepare the "http-01" challenge response and request the challenge to be requested by CA
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if ok, FALSE otherwise | 
| $1 | IN | authorizationUrl | TEXT | authorization url "https://acme-staging-v02.api.letsencrypt.org/acme/authz/nP...oi-abc...deZ" | 

## **Notes :** 

## **Example :** 
```
acme_httpChallengePrepare
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 23/06/2018, 19:24:39 - 1.00.00
