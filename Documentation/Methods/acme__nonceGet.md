# **Method :** acme__nonceGet
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function will return a "nonce" value by doing a HEAD http request to the "newNonce" url (e.g. "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce")
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | nonce | TEXT | nonce (e.g. "A-oIXIMunC6AL2VJqn-g0EobW_PidYijJ-KhZbGz3k4") | 

## **Notes :** 

       the "nonce" value is contained in the repsonse "Replay-Nonce" header
       https://tools.ietf.org/html/draft-ietf-acme-acme-12#section-7.1.6
## **Example :** 
```
acme__nonceGet
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
       CREATION : Bruno LEGAY (BLE) - 23/06/2018, 06:15:49 - 1.00.00
