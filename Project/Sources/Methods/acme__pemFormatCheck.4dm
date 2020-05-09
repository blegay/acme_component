//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__pemFormatCheck
  //@scope : public
  //@deprecated : no
  //@description : This function check some pem data
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-pemDataPtr-POINTER] : pem data blob pointer (not modified)
  //@parameter[2-IN-pemTypeKey-TEXT] : pem type "key" (e.g. "CERTIFICATE" or "RSA PRIVATE KEY")
  //@parameter[3-IN-multiple-BOOLEAN] : multiple entries (optional, default value : FALSE)
  //@notes : 
  //@example : acme__pemFormatCheck
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 01/07/2019, 08:58:34 - 0.90.08
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_POINTER:C301($1;$vp_pemDataPtr)
C_TEXT:C284($2;$vt_pemTypeKey)
C_BOOLEAN:C305($3;$vb_multiple)

$vb_ok:=False:C215
$vp_pemDataPtr:=$1
$vt_pemTypeKey:=$2

ASSERT:C1129(Count parameters:C259>1;"expecting 2 parameters")
ASSERT:C1129(Not:C34(Is nil pointer:C315($1));"$1 should not be nil")
ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12;"$1 should be a blob pointer")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vp_pemDataPtr:=$1
	$vt_pemTypeKey:=$2
	
	If ($vl_nbParam=2)
		$vb_multiple:=False:C215
	Else 
		$vb_multiple:=$3
	End if 
	
	C_TEXT:C284($vt_pem;$vt_pemDebug)
	$vt_pem:=Convert to text:C1012($vp_pemDataPtr->;"UTF-8")
	
	$vt_pemDebug:=Replace string:C233(Replace string:C233($vt_pem;"\r";"<CR>";*);"\n";"<LF>";*)
	
	  // force indentation to "\n"
	$vt_pem:=TXT_endOfLineNormalize ($vt_pem;Document with LF:K24:22)
	
	C_BOOLEAN:C305($vb_exit)
	$vb_exit:=False:C215
	C_LONGINT:C283($vl_start;$vl_count;$vl_countValid)
	$vl_start:=1
	$vl_count:=0
	$vl_countValid:=0
	
	C_TEXT:C284($vt_startTag;$vt_endTag)
	$vt_startTag:="-----BEGIN "+$vt_pemTypeKey+"-----\n"
	$vt_endTag:="-----END "+$vt_pemTypeKey+"-----\n"
	
	
	  // pattern to search for non base64 chracters
	C_TEXT:C284($vt_regex)
	$vt_regex:="^[-A-Za-z0-9+/]+$"
	  //$vt_regex:="[^-A-Za-z0-9+/=]"
	  //$vt_regex:="[^-A-Za-z0-9+/=]|=[^=]|={3,}$"
	
	Repeat 
		
		C_LONGINT:C283($vl_posStart;$vl_posEnd)
		$vl_posStart:=Position:C15($vt_startTag;$vt_pem;$vl_start)
		$vl_posEnd:=Position:C15($vt_endTag;$vt_pem;$vl_start)
		If (($vl_posStart>0) & ($vl_posEnd>0) & ($vl_posEnd>$vl_posStart))
			
			$vl_count:=$vl_count+1
			C_TEXT:C284($vt_pemData)
			$vt_pemData:=Substring:C12($vt_pem;$vl_posStart+Length:C16($vt_startTag);$vl_posEnd-$vl_posStart-Length:C16($vt_startTag))
			
			If (False:C215)  // debug
				SET TEXT TO PASTEBOARD:C523($vt_pemData)
			End if 
			
			  // remove indentation
			$vt_pemData:=Replace string:C233($vt_pemData;"\n";"";*)
			
			If (False:C215)  // debug
				SET TEXT TO PASTEBOARD:C523($vt_pemData)
			End if 
			
			If (Length:C16($vt_pemData)>0)  // should not be empty
				If ((Length:C16($vt_pemData)%4)=0)  // base64 encoded data is multiple of 4
					
					  // remove padding ("=" or "==")
					Case of 
						: (Substring:C12($vt_pemData;Length:C16($vt_pemData)-1)="==")
							$vt_pemData:=Substring:C12($vt_pemData;1;Length:C16($vt_pemData)-2)
							
						: (Substring:C12($vt_pemData;Length:C16($vt_pemData))="=")
							$vt_pemData:=Substring:C12($vt_pemData;1;Length:C16($vt_pemData)-1)
							
					End case 
					
					If (Match regex:C1019($vt_regex;$vt_pemData;1;*))
						  //Si (Non(Trouver regex($vt_regex;$vt_pemData;1;*)))  // check that is is clean base64 data
						$vl_countValid:=$vl_countValid+1
					End if 
					
				End if 
			End if 
			
			$vt_pem:=Substring:C12($vt_pem;$vl_posEnd+Length:C16($vt_endTag))
			
			If (Not:C34($vb_multiple))
				$vb_exit:=True:C214
			End if 
			
		Else 
			$vb_exit:=True:C214
		End if 
		
	Until ($vb_exit)
	
	$vb_ok:=(($vl_count>0) & ($vl_count=$vl_countValid))
	
	acme__log (Choose:C955($vb_ok;6;2);Current method name:C684;"pem data \""+$vt_pemDebug+"\" "+Choose:C955($vb_ok;" valid. [OK]";"  invalid. [KO]"))
End if 

$0:=$vb_ok