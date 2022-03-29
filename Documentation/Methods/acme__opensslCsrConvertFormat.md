# **Method :** acme__opensslCsrConvertFormat
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function will convert a csr from a PEM format to DER or from DER to PEM
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | IN | ok | BOOLEAN | TRUE if ok, FALSE otherwise | 
| $1 | IN | inPtr | POINTER | csr source (not modified) | 
| $2 | OUT | outPtr | POINTER | csr converted (modified) | 

## **Notes :** 

## **Example :** 
```
acme__opensslCsrConvertFormat
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 29/06/2018, 12:15:08 - 1.0
