# **Method :** acme_pkcs12FileToPem
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function read a pkcs12 store and returns a certificate in PEM format
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | pem | TEXT | certificate in PEM format | 
| $1 | IN | filepath | TEXT | pkcs12 filepath | 
| $2 | IN | password | TEXT | pkcs12 password | 

## **Notes :** 

## **Example :** 
```
acme_pkcs12FileToPem
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 

        CREATION : Bruno LEGAY (BLE) - 14/12/2020, 10:10:23 - 1.00.03
