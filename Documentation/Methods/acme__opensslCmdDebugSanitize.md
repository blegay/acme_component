# **Method :** acme__opensslCmdDebugSanitize
## **Scope :** private
## **Description :** 
This function returns an openssl cmd with password hidden for logs
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | opensslCmd | TEXT | openssl commande sanitized | 
| $1 | IN | opensslCmd | TEXT | openssl command | 

## **Notes :** 

       acme__opensslCmdDebugSanitize ("... -passin pass:password -passout pass:password -nodes .. ") =>  "... -passin pass:pa****rd -passout pass:pa****rd -nodes .. "
       acme__opensslCmdDebugSanitize ("... -passin pass:password -passout pass:password") => "... -passin pass:pa****rd -passout pass:pa****rd"
      
       ASSERT(acme__opensslCmdDebugSanitize ("... -passin pass:password -passout pass:password -nodes .. ")="... -passin pass:pa****rd -passout pass:pa****rd -nodes .. ")
       ASSERT(acme__opensslCmdDebugSanitize ("... -passin pass:password -passout pass:password")="... -passin pass:pa****rd -passout pass:pa****rd")
## **Example :** 
```
Méthode 298
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 26/01/2022, 14:23:42 - 2.00.04
