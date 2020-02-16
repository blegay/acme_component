//%attributes = {"invisible":true}

C_TEXT:C284($0;$vt_lineSep)
C_TEXT:C284($1;$vt_text)
C_TEXT:C284($2;$vt_lineSepDefault)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameters")

$vt_lineSep:=""
$vt_text:=$1

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vt_lineSep:=$2
	
Else 
	If (Is Windows:C1573)
		$vt_lineSep:="\r\n"
	Else 
		$vt_lineSep:="\r"
	End if 
End if 

C_LONGINT:C283($i;$vl_length)
$vl_length:=Length:C16($vt_text)

For ($i;1;$vl_length)
	C_LONGINT:C283($vl_ascii)
	$vl_ascii:=Character code:C91($vt_text[[$i]])
	Case of 
		: ($vl_ascii=0x000A)  // 10 i.e. LF
			$vt_lineSep:="\n"
			$i:=$vl_length+1
			
		: ($vl_ascii=0x000D)  // 13 i.e. CR
			$vt_lineSep:="\r"  //$vt_text[[$i]]
			
			If ($i<$vl_length)
				If (Character code:C91($vt_text[[$i+1]])=0x000A)  // 10 i.e. LF
					$vt_lineSep:="\r\n"  //$vt_text[[$i]]
				End if 
			End if 
			
			$i:=$vl_length+1
	End case 
	
End for 

$0:=$vt_lineSep