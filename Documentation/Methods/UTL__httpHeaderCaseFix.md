# **Method :** UTL__httpHeaderCaseFix
## **Scope :** private
## **Description :** 
This method/function returns
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | headerKeyCaseSensitive | TEXT | headerKeyCaseSensitive | 
| $1 | IN | paramName | OBJECT | ParamDescription | 
| $2 | IN | $vt_headerKey | TEXT | headers key | 

## **Notes :** 

## **Example :** 
```

       $vt_locationHeaderKey:=UTL__httpHeaderCaseFix ($vo_responseHeaders;"Location")  // may return "location"
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 05/08/2022, 21:11:00 - 2.00.05
