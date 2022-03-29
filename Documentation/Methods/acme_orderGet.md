# **Method :** acme_orderGet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function retrieves an order object from Let's Encrypt®
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | status | LONGINT | 200 if http request is ok | 
| $1 | IN | orderUrl | TEXT | order url | 
| $2 | OUT | order | PONTER | order object pointer (modified) | 

## **Notes :** 

## **Example :** 
```
acme_orderGet
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 02/03/2020, 18:48:07 - v1.00.00
