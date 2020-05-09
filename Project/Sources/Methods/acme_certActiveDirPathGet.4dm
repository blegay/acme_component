//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certActiveDirPathGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the active certificates dir path
  //@parameter[0-OUT-activeCertificateDirPath-TEXT] : active certificates dir path
  //@notes : 
  // on standalone or server, certificates and rsa private key files are in the same folder as the structure file
  // on 4D Client, certificates and rsa private key files are next to the 4D executable file
  //@example : acme_certActiveDirPathGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 09/10/2018, 08:47:14 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_activeCertificateDirPath)

$vt_activeCertificateDirPath:=""

  // dir where to set the certificates
  // https://doc.4d.com/4Dv17/4D/17.3/Using-TLS-Protocol-HTTPS.300-4620625.en.html
If (Application type:C494=4D Remote mode:K5:5)
	  // - with 4D in remote mode, these files must be located in the local resources folder of the database on the remote machine 
	  // (for more information about the location of this folder, refer to the 4D Client Database Folder paragraph in the description of the Get 4D folder command). 
	  // You must copy these files manually on the remote machine.
	$vt_activeCertificateDirPath:=Get 4D folder:C485(4D Client database folder:K5:13;*)
	  //$vt_activeCertificateDirPath:=FS_pathToParent (Application file)
Else 
	  //  - with 4D in local mode or 4D Server, these files must be placed next to the database structure file
	  //$vt_activeCertificateDirPath:=Get 4D folder(Database folder;*)
	  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v18:acme_component:source:acme_component.4dbase:acme_component:"
	
	  // in v18, project mode, the certificates are not in the folder returned by Get 4D folder(Database folder;*)
	  // but in the same folder as the ".4DProject" file
	$vt_activeCertificateDirPath:=FS_pathToParent (Structure file:C489(*))
	  // "Macintosh HD:Users:ble:Documents:Projets:BaseRef_v18:acme_component:source:acme_component.4dbase:acme_component:Project:"
End if 

acme__log (4;Current method name:C684;"active certificates dir path : \""+$vt_activeCertificateDirPath+"\"")

$0:=$vt_activeCertificateDirPath
