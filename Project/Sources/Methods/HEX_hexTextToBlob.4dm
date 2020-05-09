//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HEX_hexTextToBlob
  //@scope : private
  //@deprecated : no
  //@description : This method converts some hexadecimal data into blob raw data 
  //@parameter[1-IN-hexadecimal-TEXT] : hexa decimal data
  //@parameter[2-OUT-blobPtr-POINTER] : blob pointer (modified)
  //@parameter[3-IN-bigEndian-BOOLEAN] : TRUE = bigEndian, FALSE = littleEndian  (optional, default TRUE)
  //@notes :
  //@example : HEX_hexTextToBlob 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : CREATION : Bruno LEGAY (BLE) - 20/11/2012, 12:00:12 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_hexData)
C_POINTER:C301($2;$vp_blobData)
C_BOOLEAN:C305($3;$vb_bigEndian)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vt_hexData:=$1
	$vp_blobData:=$2
	
	Case of 
		: ($vl_nbParam=2)
			$vb_bigEndian:=True:C214
			
		Else 
			$vb_bigEndian:=$3
	End case 
	
	$vt_hexData:=Replace string:C233($vt_hexData;" ";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"-";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"%";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"\r";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"\n";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"\t";"";*)
	
	If (Type:C295($vp_blobData->)=Is BLOB:K8:12)
		SET BLOB SIZE:C606($vp_blobData->;0)
		
		C_LONGINT:C283($vl_textLength)
		$vl_textLength:=Length:C16($vt_hexData)
		If (LONG_isEven ($vl_textLength))
			
			SET BLOB SIZE:C606($vp_blobData->;$vl_textLength\2;0x00FF)
			
			C_LONGINT:C283($i;$vl_offset)
			  //C_ALPHA(2;$va_hex)
			C_TEXT:C284($va_hex)
			
			$vl_offset:=0
			For ($i;1;$vl_textLength;2)
				
				  //$va_hex:=Sous chaine($vt_hexData;$i;2)
				
				If ($vb_bigEndian)
					$va_hex:=Substring:C12($vt_hexData;$i;2)
				Else 
					$va_hex:=Substring:C12($vt_hexData;$i+1;1)+Substring:C12($vt_hexData;$i;1)
				End if 
				  //$va_hex:=Sous chaine($vt_hexData;$i;2)
				
				$vp_blobData->{$vl_offset}:=HEX_hexByteStrToByteInteger ($va_hex)
				
				$vl_offset:=$vl_offset+1
			End for 
			
		End if 
		
	End if 
	
End if 

