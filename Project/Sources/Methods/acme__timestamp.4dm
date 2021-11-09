//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__timestamp
  //@scope : private
  //@deprecated : no
  //@description : This function returns a timestamp in "yyyymmddhhmiss" format
  //@parameter[0-OUT-timestamp-TEXT] : timestamp in "yyyymmddhhmiss" format (e.g.  "20180629110407")
  //@parameter[1-IN-date-DATE] : date (optional, default current date)
  //@parameter[2-IN-time-TIME] : time (optional, default current time)
  //@notes : uses current local date and time
  //@example : acme__timestamp => "20180629110407"
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 00:14:39 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_timestamp)
C_DATE:C307($1;$vd_date)
C_TIME:C306($2;$vh_heure)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
Case of 
	: ($vl_nbParam=0)
		$vd_date:=Current date:C33
		$vh_heure:=Current time:C178
		
	: ($vl_nbParam=1)
		$vd_date:=$1
		$vh_heure:=Current time:C178
		
	Else 
		$vd_date:=$1
		$vh_heure:=$2
End case 

$vt_timestamp:=String:C10(Year of:C25($vd_date);"0000")+\
String:C10(Month of:C24($vd_date);"00")+\
String:C10(Day of:C23($vd_date);"00")+\
Replace string:C233(Time string:C180($vh_heure);":";"";*)

$0:=$vt_timestamp