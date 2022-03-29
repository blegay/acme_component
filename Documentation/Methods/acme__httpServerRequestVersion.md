# **Method :** acme__httpServerRequestVersion
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns the http version (e.g. "HTTP/1.1") from a http request
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | method | TEXT | version  (e.g. "HTTP/1.1") | 
| $1 | IN | httpServerHeaderObject | OBJECT | http server header object | 

## **Notes :** 

## **Example :** 
```
acme__httpServerRequestVersion
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 25/06/2018, 17:38:38 - 1.0
