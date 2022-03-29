# **Method :** acme_onWebConnection
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This method method will handle a web connection from an ACME / CA server (and return the predefined challenge response)
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | match | BOOLEAN | TRUE if the url looks like "/.well-known/acme-challenge/@", FALSE otherwise | 
| $1 | IN | url | TEXT | url | 

## **Notes :** 
the expected connexion is on plain http connexion (not https)
## **Example :** 
```

      
        C_TEXT($1;$vt_url)
        C_TEXT($2;$vt_request)
        C_TEXT($3;$vt_clientIp)
        C_TEXT($4;$vt_serverIp)
        C_TEXT($5;$vt_username)
        C_TEXT($6;$vt_password)
      
        ASSERT(Count parameters>5;"requires 6 parameters")
      
        $vt_url:=$1
        $vt_request:=$2
        $vt_clientIp:=$3
        $vt_serverIp:=$4
        $vt_username:=$5
        $vt_password:=$6
      
        Case of 
          : (acme_onWebConnection ($vt_url))
      
        Else 
      
        End case
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:17:41 - 1.00.00
