//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : TXT_regexGetMatchingGroup
  //@scope : private
  //@deprecated : no
  //@description : This function will perform a regex and extract text with matching groups
  //@parameter[0-OUT-match-BOOLEAN] : TRUE if regex match, FALSE otherwise
  //@parameter[1-IN-regex-TEXT] : regular expression
  //@parameter[2-IN-text-TEXT] : text
  //@parameter[3-IN-start-LONGINT] : start position (should be <= Length($2) )
  //@parameter[{4..n}-OUT-matchingGroup-POINTER] : matching group text pointer (modified)
  //@notes : 
  //@example : TXT_regexGetMatchingGroup
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 18:55:11 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_regex)
C_TEXT:C284($2;$vt_text)
C_LONGINT:C283($3;$vl_start)
C_POINTER:C301(${4})

$vb_ok:=False:C215
ASSERT:C1129(Count parameters:C259>3;"requires 4 parameters or more")
$vt_regex:=$1
$vt_text:=$2
$vl_start:=$3

C_LONGINT:C283($vl_matchingGroupIndex)
For ($vl_matchingGroupIndex;1;Count parameters:C259-3)
	C_POINTER:C301($vp_matchingGroupPtr)
	$vp_matchingGroupPtr:=${$vl_matchingGroupIndex+3}
	
	C_LONGINT:C283($vl_type)
	$vl_type:=Type:C295($vp_matchingGroupPtr->)
	Case of 
		: (($vl_type=Is text:K8:3) | \
			($vl_type=Is alpha field:K8:1))
			$vp_matchingGroupPtr->:=""
			
		: (($vl_type=Is real:K8:4) | \
			($vl_type=Is integer:K8:5) | \
			($vl_type=Is longint:K8:6) | \
			($vl_type=Is integer 64 bits:K8:25))
			
			  // ($vl_type=Is float) // deprecated in v18 ?
			
			$vp_matchingGroupPtr->:=0
			
	End case 
End for 

If ((Length:C16($vt_text)>=$vl_start) & ($vl_start>0))
	
	ARRAY LONGINT:C221($tl_pos;0)
	ARRAY LONGINT:C221($tl_len;0)
	
	If (Match regex:C1019($vt_regex;$vt_text;$vl_start;$tl_pos;$tl_len))
		
		If (Size of array:C274($tl_pos)>=(Count parameters:C259-3))
			$vb_ok:=True:C214
			
			C_LONGINT:C283($vl_matchingGroupIndex)
			For ($vl_matchingGroupIndex;1;Count parameters:C259-3)
				C_TEXT:C284($vt_matchingGroup)
				$vt_matchingGroup:=Substring:C12($vt_text;$tl_pos{$vl_matchingGroupIndex};$tl_len{$vl_matchingGroupIndex})
				
				C_POINTER:C301($vp_matchingGroupPtr)
				$vp_matchingGroupPtr:=${$vl_matchingGroupIndex+3}
				
				C_LONGINT:C283($vl_type)
				$vl_type:=Type:C295($vp_matchingGroupPtr->)
				Case of 
					: (($vl_type=Is text:K8:3) | \
						($vl_type=Is alpha field:K8:1))
						$vp_matchingGroupPtr->:=$vt_matchingGroup
						
					: (($vl_type=Is real:K8:4) | \
						($vl_type=Is integer:K8:5) | \
						($vl_type=Is longint:K8:6) | \
						($vl_type=Is integer 64 bits:K8:25))
						
						  // ($vl_type=Is float) // deprecated in v18 ?
						
						$vp_matchingGroupPtr->:=Num:C11($vt_matchingGroup)
						
				End case 
				
			End for 
			
		End if 
	End if 
	
	ARRAY LONGINT:C221($tl_pos;0)
	ARRAY LONGINT:C221($tl_len;0)
End if 
$0:=$vb_ok