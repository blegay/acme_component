//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certDateValidyInSeconds
  //@scope : public
  //@deprecated : no
  //@description : This function returns the number of seconds remaining before a certificate expires
  //@parameter[0-OUT-diff-LONGINT] : number of seconds remaining for validity (valid if >=0)
  //@parameter[1-IN-cert-TEXT] : cert in PEM format
  //@parameter[2-IN-nbDaysMargin-LONGINT] : bDaysMargin (optional, default 0)
  //@notes : 
  //@example : 
  //
  // C_LONGINT($vl_validitySecs;$vl_days)
  // $vl_validitySecs:=acme_certDateValidyInSeconds ($vt_cert)
  // C_TIME($vh_time)
  // $vl_days:=$vl_validitySecs\86400
  // $vh_time:=time($vl_validitySecs%86400)
  // 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/01/2019, 23:30:00 - 1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$vl_validitySecs)
C_TEXT:C284($1;$vt_cert)
C_LONGINT:C283($2;$vl_nbDaysMargin)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0;"cert is empty")

$vl_validitySecs:=-1
If (Count parameters:C259>0)
	$vt_cert:=$1
	
	If (Count parameters:C259=1)
		$vl_nbDaysMargin:=0
	Else 
		$vl_nbDaysMargin:=$2
	End if 
	
	If (Length:C16($vt_cert)>0)
		  // get the end date from the certificate
		C_TEXT:C284($vt_certDate)
		$vt_certDate:=acme_certToText (->$vt_cert;"enddate")
		
		C_TEXT:C284($vt_certEndDateIso8601Gmt)
		$vt_certEndDateIso8601Gmt:=acme_dateParse ($vt_certDate)
		  // "20191217T172814Z"
		
		C_TEXT:C284($vt_nowIso8601Gmt)
		$vt_nowIso8601Gmt:=String:C10(Current date:C33+$vl_nbDaysMargin;ISO date GMT:K1:10;Current time:C178)
		  // "2019-12-17T17:28:14Z"
		$vt_nowIso8601Gmt:=Replace string:C233($vt_nowIso8601Gmt;"-";"";*)
		$vt_nowIso8601Gmt:=Replace string:C233($vt_nowIso8601Gmt;":";"";*)
		  // "20191217T172814Z"
		
		$vl_validitySecs:=DAT_iso8601Diff ($vt_certEndDateIso8601Gmt;$vt_nowIso8601Gmt)
	End if 
	
End if 
$0:=$vl_validitySecs



