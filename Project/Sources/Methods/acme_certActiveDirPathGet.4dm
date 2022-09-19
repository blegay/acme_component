//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certActiveDirPathGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the active certificates dir path
  //@parameter[0-OUT-activeCertificateDirPath-TEXT] : active certificates dir path
  //@notes : 
  // on standalone or server, (binary mode) certificates and rsa private key files are in the same folder as the structure file (e.g. "myApp.4DB", "myApp.4DC")
  // on standalone or server, (project mode) certificates and rsa private key files are in the same folder as the "Project" folder/dir
  // on 4D Client, certificates and rsa private key files are next to the 4D executable file
  //@example : acme_certActiveDirPathGet
  //@see : acme__certActiveDirPathDfltGet
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 09/10/2018, 08:47:14 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_certActiveDir)

If (ENV_isv17OrAbove )
	If (Storage:C1525.acme=Null:C1517)
		acme__init 
	End if 
	$vt_certActiveDir:=Storage:C1525.acme.config.certificateDir
Else 
	$vt_certActiveDir:=acme__certActiveDirPathDfltGet 
End if 

acme__log (4;Current method name:C684;"active certificates dir path : \""+$vt_certActiveDir+"\"")

$0:=$vt_certActiveDir