//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslVersionGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the openssl version
  //@parameter[0-OUT-opensslVersion-TEXT] : openssl version (e.g. "OpenSSL 0.9.8zg 14 July 2015", "OpenSSL 1.0.2o  27 Mar 2018")
  //@notes : 
  //@example : acme__opensslVersionGet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 12:29:47 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_opensslVersion)

$vt_opensslVersion:=""

C_TEXT:C284($vt_args)
$vt_args:="version"

acme__opensslConfigDefault 

C_TEXT:C284($vt_in;$vt_out;$vt_err)
If (acme__openSslCmd ($vt_args;->$vt_in;->$vt_out;->$vt_err))
	  //  "OpenSSL 0.9.8zg 14 July 2015\n"
	  //  "OpenSSL 1.0.2o  27 Mar 2018\n"
	
	  // remove leading and trailing white spaces from the text
	C_TEXT:C284($vt_exponent;$vt_regex)
	$vt_regex:="^(?s)\\s*(.+?)\\s*$"
	
	If (TXT_regexGetMatchingGroup ($vt_regex;$vt_out;1;->$vt_opensslVersion))
		acme__log (6;Current method name:C684;"openssl version : \""+$vt_opensslVersion+"\". [OK]")
	Else 
		acme__log (2;Current method name:C684;"reged \""+$vt_regex+"\" failed on \""+$vt_out+"\". [KO]")
	End if 
	
Else 
	acme__log (2;Current method name:C684;"openssl version unknown, out : \""+$vt_out+"\", err : \""+$vt_err+"\". [KO]")
End if 

$0:=$vt_opensslVersion