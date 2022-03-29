# **Method :** acme__httpServerRequestToObject
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns a web connexion http headers and connexion information into an object
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | httpServerHeaderObject | OBJECT | http server header object | 

## **Notes :** 
improvement/todo/limitation : http header key does not have to be unique. This is not supported in this method.
## **Example :** 
```
acme__httpServerRequestToObject
       {
         "method": "GET",
         "url": "/index.html",
         "version": "HTTP/1.1",
         "ssl": false,
         "thread-safe": true,
         "timestamp": "2020-02-17T20:43:38.712Z",
         "requestHeaders": {
           "Accept": "*/*",
           "Host": "www.example.com",
           "User-Agent": "curl/7.55.1"
         }
       }
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:00:18 - 1.0
