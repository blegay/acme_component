//%attributes = {"invisible":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL_durationDifference
  //@scope : private
  //@deprecated : no
  //@description : This function returns a duration between two time measuring
  // values (returned by Milliseconds or Tickcount)
  //@parameter[0-OUT-diff-LONGINT] : signed difference
  //@parameter[1-IN-valueA-LONGINT] : unsigned value for instance returned by Milliseconds or Tickcount
  //@parameter[2-IN-valueB-LONGINT] : unsigned value for instance returned by Milliseconds or Tickcount
  //@notes : 
  // after 24.855134803241 days of running, a system will return negative values for Milliseconds
  // after 414.25224672068 days of running, a system will return negative values for Tickcount
  // This is may not be obvious on a dev machine, but more probable on a live/production server
  // (cf uptime http://en.wikipedia.org/wiki/Uptime )
  //@example : 
  // C_LONGINT ($vl_milliseconds;$vl_durationInMs)
  // $vl_milliseconds:=Milliseconds
  // `...
  // $vl_durationInMs:=LONG_durationDifference ($vl_milliseconds;Milliseconds)
  //
  //
  // C_LONGINT ($vl_tickCount;$vl_durationInTicks)
  // $vl_tickCount:=Tickcount
  // `...
  // $vl_durationInTicks:=LONG_durationDifference ($vl_tickCount;Tickcount)
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 12:03:34 - 1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$vl_diff)
C_LONGINT:C283($1;$vl_valStart)
C_LONGINT:C283($2;$vl_valEnd)

$vl_diff:=0
If (Count parameters:C259>1)
	$vl_valStart:=$1
	$vl_valEnd:=$2
	
	Case of 
			  //:($vl_valStart=$vl_valEnd)
			  //$vl_diff:=0
		: (($vl_valStart>=0) & ($vl_valEnd>=0))
			$vl_diff:=$vl_valEnd-$vl_valStart
			
		: (($vl_valStart<0) & ($vl_valEnd<0))
			$vl_diff:=$vl_valEnd-$vl_valStart
			
		: ($vl_valEnd>0)
			  //$vl_valStart < 0 but in unsigned char above $vl_valEnd
			$vl_diff:=Abs:C99((MAXLONG:K35:2-$vl_valEnd)+($vl_valStart-MAXLONG:K35:2))
			
		Else 
			$vl_diff:=($vl_valEnd-MAXLONG:K35:2)+(MAXLONG:K35:2-$vl_valStart)
			
	End case 
	
End if 
$0:=$vl_diff
