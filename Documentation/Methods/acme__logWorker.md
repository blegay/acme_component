# **Method :** acme__logWorker
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This method is a simple/crude worker which writes log messages onto disk
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | paramName | TEXT | ParamDescription | 
| $1 | IN | moduleCode | TEXT | module code | 
| $2 | IN | level | LONGINT | log level | 
| $3 | IN | methodName | TEXT | method name | 
| $4 | IN | debugMessage | TEXT | debug message | 

## **Notes :** 

## **Example :** 
```
acme__logWorker
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 17/02/2020, 21:45:16 - v1.00.00
