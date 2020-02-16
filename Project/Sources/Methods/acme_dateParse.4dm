//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_dateParse
  //@scope : public
  //@deprecated : no
  //@description : This function converts a certificate date and time into a timestamp
  //@parameter[0-OUT-timestamp-TEXT] : timestamp
  //@parameter[1-IN-certDate-TEXT] : certificate date
  //@notes : 
  //@example : acme_dateParse("Jan 23 19:15:40 2019 GMT\n") => "20190123T191540Z"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/01/2019, 22:58:41 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_timestamp)
C_TEXT:C284($1;$vt_certDate)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_certDate:=$1

If (Length:C16($vt_certDate)>0)
	C_TEXT:C284($vt_regex)
	$vt_regex:="(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) +(\\d{1,2}) (\\d{2}:\\d{2}:\\d{2}) (\\d{4}) GMT"
	
	ARRAY LONGINT:C221($tl_pos;0)
	ARRAY LONGINT:C221($tl_len;0)
	
	If (Match regex:C1019($vt_regex;$vt_certDate;1;$tl_pos;$tl_len))
		C_TEXT:C284($vt_month;$vt_day;$vt_time;$vt_year)
		C_LONGINT:C283($vl_day)
		$vt_month:=Substring:C12($vt_certDate;$tl_pos{1};$tl_len{1})
		$vt_day:=Substring:C12($vt_certDate;$tl_pos{2};$tl_len{2})
		$vt_time:=Replace string:C233(Substring:C12($vt_certDate;$tl_pos{3};$tl_len{3});":";"";*)
		$vt_year:=Substring:C12($vt_certDate;$tl_pos{4};$tl_len{4})
		
		ARRAY TEXT:C222($tt_month;12)
		$tt_month{January:K10:1}:="Jan"  //1
		$tt_month{February:K10:2}:="Feb"  //2
		$tt_month{March:K10:3}:="Mar"  //3
		$tt_month{April:K10:4}:="Apr"  //4
		$tt_month{May:K10:5}:="May"  //5
		$tt_month{June:K10:6}:="Jun"  //6
		$tt_month{July:K10:7}:="Jul"  //7
		$tt_month{August:K10:8}:="Aug"  //8
		$tt_month{September:K10:9}:="Sep"  //9
		$tt_month{October:K10:10}:="Oct"  //10
		$tt_month{November:K10:11}:="Nov"  //11
		$tt_month{December:K10:12}:="Dec"  //12
		
		ARRAY TEXT:C222($tt_monthNum;12)
		$tt_monthNum{January:K10:1}:="01"  //1
		$tt_monthNum{February:K10:2}:="02"  //2
		$tt_monthNum{March:K10:3}:="03"  //3
		$tt_monthNum{April:K10:4}:="04"  //4
		$tt_monthNum{May:K10:5}:="05"  //5
		$tt_monthNum{June:K10:6}:="06"  //6
		$tt_monthNum{July:K10:7}:="07"  //7
		$tt_monthNum{August:K10:8}:="08"  //8
		$tt_monthNum{September:K10:9}:="09"  //9
		$tt_monthNum{October:K10:10}:="10"  //10
		$tt_monthNum{November:K10:11}:="11"  //11
		$tt_monthNum{December:K10:12}:="12"  //12
		
		C_LONGINT:C283($vl_found)
		$vl_found:=Find in array:C230($tt_month;$vt_month)
		If ($vl_found>0)
			
			$vt_timestamp:=$vt_year+\
				$tt_monthNum{$vl_found}+\
				((2-Length:C16($vt_day))*"0")+$vt_day+"T"+\
				$vt_time+"Z"
		End if 
		
		ARRAY TEXT:C222($tt_month;0)
		ARRAY TEXT:C222($tt_monthNum;0)
		
	End if 
	
	ARRAY LONGINT:C221($tl_pos;0)
	ARRAY LONGINT:C221($tl_len;0)
	
End if 
$0:=$vt_timestamp