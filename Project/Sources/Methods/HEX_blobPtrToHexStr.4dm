//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : HEX_blobPtrToHexStr
  //@scope : public
  //@deprecated : no
  //@description : This function returns a blob into an hex format  
  //@parameter[0-OUT-hexStr-TEXT] : binary data in hex format
  //@parameter[1-IN-blobPtr-POINTER] : pointer to blob/binary data (not modified)
  //@notes :
  //@example : HEX_blobPtrToHexStr 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 29/07/2013, 19:11:40 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_hex)  //hex representation of the binary data
C_POINTER:C301($1;$vp_blobPtr)  //binary data pointer

$vt_hex:=""

If (Count parameters:C259>0)
	$vp_blobPtr:=$1
	
	If (Type:C295($vp_blobPtr->)=Is BLOB:K8:12)
		
		$vt_hex:=""
		
		C_LONGINT:C283($vl_blobSize)
		$vl_blobSize:=BLOB size:C605($vp_blobPtr->)
		
		
		If ($vl_blobSize>0)
			
			C_TEXT:C284($vt_hexValues)
			$vt_hexValues:="0123456789ABCDEF"
			
			$vt_hex:=" "*(2*$vl_blobSize)
			
			C_LONGINT:C283($i;$vl_index;$vl_hi;$vl_lo;$vl_ubyte)
			$vl_index:=0
			For ($i;0;$vl_blobSize-1)
				$vl_ubyte:=$vp_blobPtr->{$i}
				
				$vl_hi:=$vl_ubyte & 0x00F0 >> 4
				$vl_lo:=$vl_ubyte & 0x000F
				
				$vl_index:=$vl_index+1
				$vt_hex[[$vl_index]]:=$vt_hexValues[[$vl_hi+1]]
				
				$vl_index:=$vl_index+1
				$vt_hex[[$vl_index]]:=$vt_hexValues[[$vl_lo+1]]
				
				  //$vt_hex:=$vt_hex+HEX_byteIntegerToHexByteStr ($vx_crcResult{$i})
			End for 
			
		End if 
		
		
	Else 
		ALERT:C41(Current method name:C684+" : paramter is not a blob pointer !!!")
	End if 
	
Else 
	ALERT:C41(Current method name:C684+" : parameters are missing !!!")
End if 

$0:=$vt_hex
