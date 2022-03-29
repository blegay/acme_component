# **Method :** acme__opensslCsrNew
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function generates a binary certificat request (csr) signed with a private key
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if OK, FALSE otherwise | 
| $1 | IN | csrObj | OBJECT | csr object (see acme_csrReqConfObjectNew) | 
| $2 | IN | privateKeyPath | TEXT | private rsa key path (do not use the account private key) | 
| $3 | OUT | csrPtr | POINTER | csr text (PEM format) or blob (DER format) pointer (modified) | 

## **Notes :** 

       do not use the account private key to avoid error "certificate public key must be different than account key"
## **Example :** 
```
acme__opensslCsrNew
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 

        CREATION : Bruno LEGAY (BLE) - 23/06/2018, 23:18:01 - 1.00.00
