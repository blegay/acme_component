# **Method :** acme__timestamp
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns a timestamp in "yyyymmddhhmiss" format
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | timestamp | TEXT | timestamp in "yyyymmddhhmiss" format (e.g.  "20180629110407") | 
| $1 | IN | date | DATE | date (optional, default current date) | 
| $2 | IN | time | TIME | time (optional, default current time) | 

## **Notes :** 
uses current local date and time
## **Example :** 
```
acme__timestamp => "20180629110407"
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 23/06/2018, 00:14:39 - 1.00.00
