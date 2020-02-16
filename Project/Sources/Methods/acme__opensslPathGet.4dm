//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslPathGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the openssl executable path
  //@parameter[0-OUT-openSslPath-TEXT] : openssl executable path
  //@notes : 
  // => "'/Users/ble/Documents/Projets/BaseRef_v15/acme_component/source/acme_component.4dbase/Resources/openssl/osx/openssl'"
  //@example : acme__opensslPathGet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 12:45:56 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_openSslPath)
If (ENV_onWindows )
	
	C_BOOLEAN:C305($vb_64bits)
	$vb_64bits:=ENV_is64bits   // true 4D if 4D is running as a 64 bits app
	
	$vt_openSslPath:=Get 4D folder:C485(Current resources folder:K5:16)+"openssl"+Folder separator:K24:12+Choose:C955($vb_64bits;"win64";"win32")+Folder separator:K24:12+"openssl.exe"
	
Else 
	  // use os x default openssl binary
	  //$vt_openSslPath:="/usr/bin/openssl"
	$vt_openSslPath:=Get 4D folder:C485(Current resources folder:K5:16)+"openssl"+Folder separator:K24:12+"osx"+Folder separator:K24:12+"openssl"
	
End if 
ASSERT:C1129(Test path name:C476($vt_openSslPath)=Is a document:K24:1)

$vt_openSslPath:=UTL_pathToPosixConvert ($vt_openSslPath)

$0:=$vt_openSslPath