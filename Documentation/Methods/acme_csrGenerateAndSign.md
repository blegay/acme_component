# **Method :** acme_csrGenerateAndSign
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function creates the csr, calls the letsEncrypt "finalize" and retrieved the certificares and installs them
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if OK, FALSE otherwise | 
| $1 | IN | orderObject | OBJECT | order object (see acme_newOrder $3) | 
| $2 | IN | csrReqConfObject | OBJECT | csr object (see acme_csrReqConfObjectNew) | 
| $3 | IN | orderDir | TEXT | order dir | 

## **Notes :** 

## **Example :** 
```
acme_csrGenerateAndSign
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 12/02/2019, 23:07:47 - 1.00.00
