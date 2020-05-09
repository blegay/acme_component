//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__keyPrivExponentGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the Exponent of the private key in binary form
  //@parameter[0-OUT-exponent-BLOB] : private key exponent in binary form
  //@parameter[1-IN-privateKeyPath-TEXT] : private key file path (in PEM format)
  //@notes : 
  //@example : acme__keyPrivExponentGet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 22:25:28 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_exponentBlob)
C_TEXT:C284($1;$vt_privateKeyPath)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Test path name:C476($1)=Is a document:K24:1;"private key path \""+$1+"\" not found")

SET BLOB SIZE:C606($vx_exponentBlob;0)
$vt_privateKeyPath:=$1

SET BLOB SIZE:C606($vx_exponentBlob;0)

  // get the private (key in pem format)
C_BLOB:C604($vx_private)
SET BLOB SIZE:C606($vx_private;0)
DOCUMENT TO BLOB:C525($vt_privateKeyPath;$vx_private)

C_TEXT:C284($vt_args)
$vt_args:="rsa"+" -noout"+" -text"

acme__opensslConfigDefault 

C_TEXT:C284($vt_out;$vt_err)
If (acme__openSslCmd ($vt_args;->$vx_private;->$vt_out;->$vt_err))
	
	  // search a line starting with "publicExponent: "
	C_TEXT:C284($vt_exponent;$vt_regex)
	$vt_regex:="(?m)^publicExponent: (.+) \\(0x.*$"
	
	  // ...
	  //    ff:ff
	  //publicExponent: 123456 (0x10101)
	  //privateExponent:
	  // ...
	
	If (TXT_regexGetMatchingGroup ($vt_regex;$vt_out;1;->$vt_exponent))
		
		C_BLOB:C604($vx_exponentBlob)
		LONGINT TO BLOB:C550(Num:C11($vt_exponent);$vx_exponentBlob;PC byte ordering:K22:3)
		
		  // remove trailing 0's from blob
		C_BOOLEAN:C305($vb_done)
		$vb_done:=False:C215
		Repeat 
			C_LONGINT:C283($vl_blobSize)
			$vl_blobSize:=BLOB size:C605($vx_exponentBlob)
			If ($vx_exponentBlob{$vl_blobSize-1}=0)
				SET BLOB SIZE:C606($vx_exponentBlob;$vl_blobSize-1)
			Else 
				$vb_done:=True:C214
			End if 
		Until ($vb_done)
		
		acme__log (6;Current method name:C684;"private key \""+$vt_privateKeyPath+"\" found exponent value (\""+$vt_regex+"\") : "+$vt_exponent+" success. [OK]")
	Else 
		acme__log (2;Current method name:C684;"private key \""+$vt_privateKeyPath+"\" exponent value (\""+$vt_regex+"\") not found in "+$vt_out+". [KO]")
	End if 
	
End if 

SET BLOB SIZE:C606($vx_private;0)

$0:=$vx_exponentBlob
SET BLOB SIZE:C606($vx_exponentBlob;0)