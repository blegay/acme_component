//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : DAT_iso8601DateTimeGmt
  //@scope : private
  //@deprecated : no
  //@description : This function returns an timestamp from a timestamp in iso8601 format (e.g "20150323T135657Z")
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-iso8601-TEXT] : date and time in iso8601 format (e.g "20150323T135657Z")
  //@parameter[2-OUT-datePtr-POINTER] : gmt date pointer (modified)
  //@parameter[3-OUT-timePtr-POINTER] : gmt time pointer (modified)
  //@notes : 
  //@example : DAT_iso8601DateTimeGmt
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 12/07/2018, 07:16:09 - 1.00.11
  //@xdoc-end
  //================================================================================

  // "20150323T135657Z"

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_iso8601timestamp)  //rfc822Date
C_POINTER:C301($2;$vp_datePtr)
C_POINTER:C301($3;$vp_timePtr)

$vb_ok:=False:C215
If (Count parameters:C259>2)
	$vt_iso8601timestamp:=$1
	$vp_datePtr:=$2
	$vp_timePtr:=$3
	
	ASSERT:C1129(Type:C295($vp_datePtr->)=Is date:K8:7)
	ASSERT:C1129(Type:C295($vp_timePtr->)=Is time:K8:8)
	
	C_DATE:C307($vd_date)
	C_TIME:C306($vh_time)
	
	$vd_date:=!00-00-00!
	$vh_time:=?00:00:00?
	
	If (Length:C16($vt_iso8601timestamp)=16)
		C_TEXT:C284($vt_regex)
		$vt_regex:="(?i)^(\\d{4})(\\d{2})(\\d{2})T(\\d{2})(\\d{2})(\\d{2})Z$"
		ARRAY LONGINT:C221($tl_pos;0)
		ARRAY LONGINT:C221($tl_length;0)
		If (Match regex:C1019($vt_regex;$vt_iso8601timestamp;1;$tl_pos;$tl_length;*))
			$vb_ok:=True:C214
			
			C_LONGINT:C283($vl_year;$vl_month;$vl_day)
			$vl_year:=Num:C11(Substring:C12($vt_iso8601timestamp;$tl_pos{1};$tl_length{1}))
			$vl_month:=Num:C11(Substring:C12($vt_iso8601timestamp;$tl_pos{2};$tl_length{2}))
			$vl_day:=Num:C11(Substring:C12($vt_iso8601timestamp;$tl_pos{3};$tl_length{3}))
			
			$vd_date:=Add to date:C393(!00-00-00!;$vl_year;$vl_month;$vl_day)
			
			C_TEXT:C284($vt_time)
			$vt_time:=Substring:C12($vt_iso8601timestamp;$tl_pos{4};$tl_length{4})+":"+\
				Substring:C12($vt_iso8601timestamp;$tl_pos{5};$tl_length{5})+":"+\
				Substring:C12($vt_iso8601timestamp;$tl_pos{6};$tl_length{6})
			
			$vh_time:=Time:C179($vt_time)
			
		End if 
		ARRAY LONGINT:C221($tl_pos;0)
		ARRAY LONGINT:C221($tl_length;0)
	End if 
	
	$vp_datePtr->:=$vd_date
	$vp_timePtr->:=$vh_time
	
End if 
$0:=$vb_ok