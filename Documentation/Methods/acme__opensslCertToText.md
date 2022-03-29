# **Method :** acme__opensslCertToText
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function checks a csr output
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | certText | TEXT | certificate output | 
| $2 | IN | certPointer | POINTER | certiticate pointer (if blob assumed in DER format, else PEM format) (not modified) | 

## **Notes :** 

## **Example :** 
```
acme__opensslCertToText
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 

        CREATION : Bruno LEGAY (BLE) - 29/06/2018, 11:44:55 - 1.0
