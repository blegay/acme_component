# **Method :** acme_onWebAuthentication
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns manages the authentication for the LetsEncrypt service
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | match | BOOLEAN | true if the url looks like "/.well-known/acme-challenge/@" | 
| $1 | IN | url | TEXT | url | 
| $2 | OUT | allowedPtr | POINTER | allowed boolean pointer (modified) | 

## **Notes :** 
the expected connexion is on plain http connexion (not https)
## **Example :** 
```
On Web authentification : 
      
        C_BOOLEEN($0;$vb_allowed)
        C_TEXT($1;$vt_url)
        C_TEXT($2;$vt_request)
        C_TEXT($3;$vt_clientIp)
        C_TEXT($4;$vt_serverIp)
        C_TEXT($5;$vt_username)
        C_TEXT($6;$vt_password)
      
        ASSERT(Count parameters>5;"requires 6 parameters")
      
        $vb_allowed:=False
        $vt_url:=$1
        $vt_request:=$2
        $vt_clientIp:=$3
        $vt_serverIp:=$4
        $vt_username:=$5
        $vt_password:=$6
      
        Case of 
          : (acme_onWebAuthentication ($vt_url;->$vb_allowed))
      
        Else 
      
        End case 
      
        $0:=$vb_allowed
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:08:59 - 1.00.00
