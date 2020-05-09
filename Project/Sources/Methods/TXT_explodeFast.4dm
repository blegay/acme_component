//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : TXT_explodeFast
  //@scope : public
  //@deprecated : no
  //@description : This function returns into a text array the result of a text delimiter parse
  //   (break-up a text according to a given delimiter) 
  //@parameter[0-OUT-nbLines-LONGINT] : number of lines in the array
  //@parameter[1-IN-text-TEXT] : text to "explode"
  //@parameter[2-IN-arrayPtr-POINTER] : text array pointer (modified)
  //@parameter[3-IN-delimiter-TEXT] delimiter (optionnal, default value : "\t" i.e. tab/HT)
  //@notes : 
  //@example : TXT_explodeFast 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 22/01/2015, 15:14:37 - v1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$vl_counter)  //array size
C_TEXT:C284($1;$vt_text)  //Texte à "exploser"
C_POINTER:C301($2;$vp_arrayPtr)  //text array pointer
C_TEXT:C284($3;$va_sep)  //caractère séparateur

$vl_counter:=0

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	$vt_text:=$1
	$vp_arrayPtr:=$2
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($2));"$2 is a nil pointer, expecting text array pointer")
	ASSERT:C1129(Type:C295($2->)=Text array:K8:16;"$2 is not a text pointer, expecting text array pointer")
	
	  //Gestion des paramètres optionnels
	Case of 
		: ($vl_nbParam=2)
			$va_sep:=""
			  //$va_sep:="\t"
			
		Else 
			  // : ($vl_nbParam=2) 
			$va_sep:=$3
	End case 
	
	If (Length:C16($va_sep)=0)
		$va_sep:="\t"
	End if 
	
	C_LONGINT:C283($vl_sepLength)
	$vl_sepLength:=Length:C16($va_sep)
	
	ARRAY TEXT:C222($tt_lines;0)
	
	If (Length:C16($vt_text)>0)
		$vl_counter:=1
		
		  // first loop to count the number of lines we need to presize the text array for...
		C_LONGINT:C283($vl_position)
		$vl_position:=Position:C15($va_sep;$vt_text;*)
		While ($vl_position>0)
			$vl_counter:=$vl_counter+1
			
			IDLE:C311  // be nice to other processes
			
			$vl_position:=Position:C15($va_sep;$vt_text;$vl_position+$vl_sepLength;*)
		End while 
		
		
		  // presize the array
		ARRAY TEXT:C222($tt_lines;$vl_counter)
		
		
		  // second loop to copy the text into the array.
		  // the speed up is obtained by not modyfing the main/big text variable...
		C_LONGINT:C283($vl_start;$vl_lineIndex)
		$vl_start:=1
		$vl_lineIndex:=1
		
		C_LONGINT:C283($vl_position)
		$vl_position:=Position:C15($va_sep;$vt_text;*)
		While ($vl_position>0)
			$tt_lines{$vl_lineIndex}:=Substring:C12($vt_text;$vl_start;$vl_position-$vl_start)
			$vl_lineIndex:=$vl_lineIndex+1
			
			$vl_start:=$vl_position+$vl_sepLength
			
			IDLE:C311  // be nice to other processes
			
			$vl_position:=Position:C15($va_sep;$vt_text;$vl_position+$vl_sepLength;*)
		End while 
		$tt_lines{$vl_lineIndex}:=Substring:C12($vt_text;$vl_start)
		
	End if 
	
	  //%W-518.1
	COPY ARRAY:C226($tt_lines;$vp_arrayPtr->)
	  //%W+518.1
	
	ARRAY TEXT:C222($tt_lines;0)
	
End if 

$0:=$vl_counter