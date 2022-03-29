# **Method :** acme__keysKeyPairFileGet
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns the content of keyfile as blob (pem format)
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | keyBlob | BLOB | content of keyfile as blob (pem format) | 
| $1 | IN | keyType | TEXT | key type "private" or "public" | 
| $2 | IN | keyDir | TEXT | keypair dir (optional, default value : host db home dir) | 

## **Notes :** 

## **Example :** 
```
acme__keysKeyPairFileGet
      
       $privateKeyBlob := acme__keysKeyPairFileGet("private";{"/path/to/certs"})
       $publicKeyBlob := acme__keysKeyPairFileGet("public";{"/path/to/certs"})
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
       CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:20:30 - 1.00.00
