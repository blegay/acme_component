//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__dateFormatIso8601
  //@scope : private
  //@deprecated : no
  //@description : This function returns a date in ISO 8601 format
  //@parameter[0-OUT-dateIso8601-TEXT] : date in ISO 8601 format (e.g. "2016-01-08T00:00:00Z")
  //@parameter[1-IN-date-DATE] : date
  //@notes : no time, no timezone shift
  //@example : acme__dateFormatIso8601
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 21:38:38 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_dateFormat)
C_DATE:C307($1;$vd_date)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vd_date:=$1

If ($vd_date=!00-00-00!)
	$vd_date:=Current date:C33
End if 

$vt_dateFormat:=String:C10(Year of:C25($vd_date);"0000")+"-"+\
String:C10(Month of:C24($vd_date);"00")+"-"+\
String:C10(Day of:C23($vd_date);"00")+\
"T00:00:00Z"

$0:=$vt_dateFormat