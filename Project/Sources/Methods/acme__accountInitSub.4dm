//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__accountInitSub
  //@scope : private
  //@deprecated : no
  //@description : This method methods generates key pair files "key.pub" and "key.pem"
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-$vt_certDir-TEXT] : dir where to store keypairs
  //@notes : 
  //@example : acme__accountInit
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 21:45:06 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_certDir)

ASSERT:C1129(Count parameters:C259>0;"$1 is mandatory")
ASSERT:C1129(Test path name:C476($1)=Is a folder:K24:2;"\""+$1+"\" is not a directory")

$vb_ok:=False:C215
$vt_certDir:=$1

C_TEXT:C284($vt_filenamebase)
$vt_filenamebase:="key"

C_TEXT:C284($vt_keyPrivPath;$vt_keyPubPath)
$vt_keyPubPath:=$vt_certDir+$vt_filenamebase+".pub"
$vt_keyPrivPath:=$vt_certDir+$vt_filenamebase+".pem"

If ((Test path name:C476($vt_keyPubPath)=Is a document:K24:1) & \
(Test path name:C476($vt_keyPrivPath)=Is a document:K24:1))
	$vb_ok:=True:C214
	
	acme__moduleDebugDateTimeLine (6;Current method name:C684;"account already registered (files \""+$vt_filenamebase+".pem\" and \""+$vt_filenamebase+".pub\" exist in \""+$vt_certDir+"\"). Continuing.")
	
Else 
	acme__moduleDebugDateTimeLine (4;Current method name:C684;"Starting new account registration (files \""+$vt_filenamebase+".pem\" and \""+$vt_filenamebase+".pub\" do not exist in \""+$vt_certDir+"\")")
	
	  // generate a key pair in the "_account" dir
	$vb_ok:=acme__keysKeyPairFileGenerate ($vt_certDir;$vt_filenamebase)
End if 

$0:=$vb_ok