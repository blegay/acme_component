# **Method :** acme__objectToBlob
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This method converts an object to a blob
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | requestBodyPtr | POINTER | request body blob pointer (modified) | 
| $1 | IN | object | OBJECT | object | 

## **Notes :** 
the JWS MUST is in the "Flattened JSON Serialization" [RFC7515]
## **Example :** 
```
acme__objectToBlob
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
       CREATION : Bruno LEGAY (BLE) - 23/06/2018, 06:00:29 - 1.00.00
