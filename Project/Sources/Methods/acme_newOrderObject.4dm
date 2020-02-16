//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_newOrderObject
  //@scope : public
  //@deprecated : no
  //@description : This function returns a newOrder object
  //@parameter[0-OUT-newOrderObject-OBJECT] : new order object
  //@parameter[1-IN-domainListPtr-POINTER] : domain list text or text array pointer (not modified)
  //@notes :
  //@example : acme_newOrderObject 
  //
  // ARRAY TEXT($tt_domain;0)
  // APPEND TO ARRAY($tt_domain;"test-ssl.example.com")
  // APPEND TO ARRAY($tt_domain;"test1-ssl.example.com")
  // APPEND TO ARRAY($tt_domain;"test2-ssl.example.com")
  // APPEND TO ARRAY($tt_domain;"test3-ssl.example.com")
  // 
  // C_OBJECT($vo_newOrderObject)
  // $vo_newOrderObject:=acme_newOrderObject (->$tt_domain)
  //
  // {
  //     "workingDir": "Macintosh HD:Users:ble:Documents:Projets:myapp:",
  //     "directoryUrl": "https://acme-v02.api.letsencrypt.org/directory",
  //     "identifiers": [
  //         {
  //             "type": "dns",
  //             "value": "test-ssl.example.com"
  //         },
  //         {
  //             "type": "dns",
  //             "value": "test1-ssl.example.com"
  //         },
  //         {
  //             "type": "dns",
  //             "value": "test2-ssl.example.com"
  //         },
  //         {
  //             "type": "dns",
  //             "value": "test3-ssl.example.com"
  //         }
  //     ]
  // }
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 03/07/2018, 07:59:52 - v1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vb_newOrderObject)
C_POINTER:C301($1;$vp_domainListPtr)
  //C_TEXTE($2;$vt_workingDir)
  //C_TEXTE($3;$vt_directoryUrl)

ASSERT:C1129(Count parameters:C259>0;"Requires 1 parameter")
ASSERT:C1129((Type:C295($1->)=Text array:K8:16) | (Type:C295($1->)=Is text:K8:3);"$1 should be a text or text array pointer")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

If ($vl_nbParam>0)
	$vp_domainListPtr:=$1
	
	acme__init 
	
	C_TEXT:C284($vt_workingDir;$vt_directoryUrl)
	$vt_workingDir:=acme_workingDirGet 
	$vt_directoryUrl:=acme_directoryUrlGet 
	
	  //Au cas ou 
	  //: ($vl_nbParam=1)
	  //$vt_workingDir:=Dossier 4D(Dossier base;*)
	  //$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
	
	  //: ($vl_nbParam=2)
	  //$vt_workingDir:=$2
	  //$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
	
	  //Sinon 
	  //  //: ($vl_nbParam=3)
	  //$vt_workingDir:=$2
	  //$vt_directoryUrl:=$3
	  //Fin de cas 
	
	ASSERT:C1129(Length:C16($vt_workingDir)>0;"working dir is empty")
	ASSERT:C1129(Test path name:C476($vt_workingDir)=Is a folder:K24:2;"working dir \""+$vt_workingDir+"\" does not exist")
	If (Length:C16($vt_workingDir)>0)
		If (Substring:C12($vt_workingDir;Length:C16($vt_workingDir);1)#Folder separator:K24:12)
			$vt_workingDir:=$vt_workingDir+Folder separator:K24:12
			
		End if 
	End if 
	acme__moduleDebugDateTimeLine (4;Current method name:C684;"workingDir : \""+$vt_workingDir+"\"")
	acme__moduleDebugDateTimeLine (4;Current method name:C684;"directoryUrl : \""+$vt_directoryUrl+"\"")
	
	OB SET:C1220($vb_newOrderObject;"workingDir";$vt_workingDir)
	OB SET:C1220($vb_newOrderObject;"directoryUrl";$vt_directoryUrl)
	
	ARRAY OBJECT:C1221($to_identifiers;0)
	
	If (Type:C295($vp_domainListPtr->)=Is text:K8:3)
		APPEND TO ARRAY:C911($to_identifiers;acme_identifierObjectNew ("dns";$vp_domainListPtr->))
	Else 
		
		C_LONGINT:C283($i)
		For ($i;1;Size of array:C274($vp_domainListPtr->))
			APPEND TO ARRAY:C911($to_identifiers;acme_identifierObjectNew ("dns";$vp_domainListPtr->{$i}))
		End for 
		
	End if 
	OB SET ARRAY:C1227($vb_newOrderObject;"identifiers";$to_identifiers)
	CLEAR VARIABLE:C89($to_identifiers)
	
	acme__moduleDebugDateTimeLine (4;Current method name:C684;"new order object :\r"+JSON Stringify:C1217($vb_newOrderObject;*))
	If (False:C215)
		SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vb_newOrderObject;*))
	End if 
	
End if 
$0:=$vb_newOrderObject
CLEAR VARIABLE:C89($vb_newOrderObject)