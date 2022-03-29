# **Method :** acme__opensslConfigDefault
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns a default config path for openss on Windows
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | configArg | TEXT | config argument " -config \"C:\.....\openssl.cnf\"") | 

## **Notes :** 
even on windows the "openssl.cnf" file provided in the component SHOULD have line endings as LF (same file used on Windows and OS X)
## **Example :** 
```
acme__opensslConfigDefault
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 21/02/2019, 19:37:56 - 0.90.01
