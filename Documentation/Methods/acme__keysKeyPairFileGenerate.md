# **Method :** acme__keysKeyPairFileGenerate
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This method methods generates key pair files "key.pub" and "key.pem"
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if ok, FALSE otherwise | 
| $1 | IN | $vt_certDir | TEXT | dir where to store keypairs (e.g. "Macintosh HD:Users:ble:Documents:certs:", or if not used, will use host db home dir) | 

## **Notes :** 
"key.pub" is the public key. "key.pem" is the private key. The key pair is generated in 2048 bits.
## **Example :** 
```
acme__keysKeyPairFileGenerate
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
       CREATION : Bruno LEGAY (BLE) - 23/06/2018, 17:24:20 - 1.00.00
