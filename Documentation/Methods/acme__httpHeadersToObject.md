# **Method :** acme__httpHeadersToObject
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function converts http header array into an object
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | object | OBJECT | http header object | 
| $1 | IN | headerKeyArrayPtr | POINTER | http header key text array pointer (not modified) | 
| $2 | IN | headerValueArrayPtr | POINTER | http header value text array pointer (not modified) | 

## **Notes :** 

## **Example :** 
```
acme__httpHeadersToObject
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 23/06/2018, 06:34:32 - v1.00.00
