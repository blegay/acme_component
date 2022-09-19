//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__certActiveDirPathDfltGet
  //@scope : private 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-paramName-OBJECT] : ParamDescription
  //@parameter[2-IN-paramName-POINTER] : ParamDescription (not modified)
  //@parameter[3-INOUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[4-OUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[5-IN-paramName-LONGINT] : ParamDescription (optional, default value : 1)
  //@notes : 
  //@example : acme__certActiveDirPathDfltGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 19/09/2022, 14:42:30 - 2.00.06
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_activeCertificateDirPath)
C_LONGINT:C283($1;$vl_appType)

$vt_activeCertificateDirPath:=""

  // #4D-v19-newhttpServer

  // dir where to set the certificates
  // https://doc.4d.com/4Dv17/4D/17.3/Using-TLS-Protocol-HTTPS.300-4620625.en.html
If (Count parameters:C259=0)
	$vl_appType:=Application type:C494
Else 
	$vl_appType:=$1
End if 

Case of 
	: ($vl_appType=4D Remote mode:K5:5)
		  // - with 4D in remote mode, these files must be located in the local resources folder of the database on the remote machine 
		  // (for more information about the location of this folder, refer to the 4D Client Database Folder paragraph in the description of the Get 4D folder command). 
		  // You must copy these files manually on the remote machine.
		
		$vt_activeCertificateDirPath:=Get 4D folder:C485(4D Client database folder:K5:13;*)
		  // "Macintosh HD:Users:bruno:Library:Cache:myApp:myApp_192_168_1_1_19813_272:"
		
		  //: ($vl_appType=4D Volume desktop)
		  //  // https://doc.4d.com/4Dv18/4D/18/Structure-file.301-4505358.en.html
		  //  // Note: In the particular case of a database that has been compiled and merged with 4D Volume Desktop,
		  //  // this command returns the pathname of the application file (executable application) under Windows and macOS. 
		  //  // Under macOS, this file is located inside the software package, in the [Contents:Mac OS] folder. 
		  //  // This stems from a former mechanism and is kept for compatibility reasons. 
		  //  // If you want to get the full name of the software package itself, it is preferable to use the Application file command. 
		  //  // The technique consists of testing the application using the Application type command, 
		  //  // then executing Structure file or Application file depending on the context.
		
		  //$vt_activeCertificateDirPath:=Get 4D folder(Database folder;*)
		
	Else 
		  //  - with 4D in local mode or 4D Server, these files must be placed next to the database structure file
		  //$vt_activeCertificateDirPath:=Get 4D folder(Database folder;*)
		  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v18:acme_component:source:acme_component.4dbase:acme_component:"
		
		  // in v18, project mode, the certificates are not in the folder returned by Get 4D folder(Database folder;*)
		  // but in the same folder as the ".4DProject" file
		
		  // In 4D  v19 documentation and a test in 4D v18.3 project mode, the certificates, must be at the same level 
		  //   - with 4D in local mode or 4D Server, these files must be placed next to the project folder
		  //   - with 4D in remote mode, these files must be located in the client database folder on the remote machine (for more information about the location of this folder, see the Get 4D folder command).
		  // https://developer.4d.com/docs/en/Admin/tls.html#installation-and-activation
		
		C_TEXT:C284($vt_stuctureFilePath)
		$vt_stuctureFilePath:=Structure file:C489(*)
		
		  //acme__log (4;Current method name;"structure file path : \""+$vt_stuctureFilePath+"\"")
		
		  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v17:acme_component:source:acme_component.4dbase:acme_component.4DB"
		  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v18:acme_component:source:acme_component.4dbase:acme_component:Project:acme_component.4DProject"
		
		If ($vt_stuctureFilePath="@.4DProject")
			  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v18:acme_component:source:acme_component.4dbase:acme_component:Project:acme_component.4DProject"
			$vt_activeCertificateDirPath:=FS_pathToParent (FS_pathToParent ($vt_stuctureFilePath))
			  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v18:acme_component:source:acme_component.4dbase:acme_component:"
		Else 
			  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v17:acme_component:source:acme_component.4dbase:acme_component.4DB"
			$vt_activeCertificateDirPath:=FS_pathToParent ($vt_stuctureFilePath)
			  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v17:acme_component:source:acme_component.4dbase:"
		End if 
		
		  //$vt_activeCertificateDirPath:=FS_pathToParent (Structure file(*))
End case 

C_TEXT:C284($vt_appTypeTxtDebug)
Case of 
	: ($vl_appType=4D Local mode:K5:1)  // 0
		$vt_appTypeTxtDebug:="Local"
		
	: ($vl_appType=4D Volume desktop:K5:2)  // 1
		$vt_appTypeTxtDebug:="Volume desktop"
		
	: ($vl_appType=4D Desktop:K5:4)  // 3
		$vt_appTypeTxtDebug:="Desktop"
		
	: ($vl_appType=4D Remote mode:K5:5)  // 4 
		$vt_appTypeTxtDebug:="Remote"
		
	: ($vl_appType=4D Server:K5:6)  // 5 
		$vt_appTypeTxtDebug:="Server"
		
	Else 
		$vt_appTypeTxtDebug:="???"
End case 

acme__log (4;Current method name:C684;"app type : "+$vt_appTypeTxtDebug+" ("+String:C10($vl_appType)+"), active certificates dir path : \""+$vt_activeCertificateDirPath+"\"")

$0:=$vt_activeCertificateDirPath
