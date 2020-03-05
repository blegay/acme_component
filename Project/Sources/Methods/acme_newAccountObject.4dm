//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_newAccountObject
  //@scope : public
  //@deprecated : no
  //@description : This function inializes a new account object
  //@parameter[0-OUT-newAccountObject-OBJET] : new account object
  //@parameter[1-IN-contactListPtr-POINTER] : text or text array containing emails of contacts (e.g. "john@example.com")
  //@parameter[2-IN-termsOfServiceAgreed-BOOLEAN] : set to TRUE to say that the "terms of service are agreed", set to FALSE otherwise
  //@notes : 
  //@example : 
  //
  //ARRAY TEXT($tt_contacts;2)
  //$tt_contacts{1}:="blegay@example.com"
  //$tt_contacts{2}:="jlaclavere@example.com"
  //
  //$vo_payload:=acme_newAccountObject (->$tt_contacts;True)
  //ARRAY TEXT($tt_contacts;0)
  //acme_newAccount ($vo_payload)
  //
  // // OR
  //
  //C_TEXT($vt_contact)
  //$vt_contact:="blegay@example.com"
  //$vo_payload:=acme_newAccountObject (->$tt_contacts;True)
  //acme_newAccount ($vo_payload)
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 03/07/2018, 18:43:01 - 1.0
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vb_newAccountObject)
C_POINTER:C301($1;$vp_contactListPtr)
C_BOOLEAN:C305($2;$vb_termsOfServiceAgreed)
  //C_TEXTE($3;$vt_workingDir)
  //C_TEXTE($4;$vt_directoryUrl)

ASSERT:C1129(Count parameters:C259>1;"Requires 2 parameter")
ASSERT:C1129((Type:C295($1->)=Is text:K8:3) | (Type:C295($1->)=Text array:K8:16);"$1 should be a text or text array pointer")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

If ($vl_nbParam>1)
	$vp_contactListPtr:=$1
	$vb_termsOfServiceAgreed:=$2
	
	  //acme__init 
	
	  //C_TEXTE($vt_workingDir;$vt_directoryUrl)
	  //$vt_workingDir:=acme_workingDirGet 
	  //$vt_directoryUrl:=acme_directoryUrlGet 
	
	  //Au cas ou 
	  //: ($vl_nbParam=2)
	  //$vt_workingDir:=Dossier 4D(Dossier base;*)
	  //$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
	
	  //: ($vl_nbParam=3)
	  //$vt_workingDir:=$3
	  //$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
	
	  //Sinon 
	  //  //: ($vl_nbParam=4)
	  //$vt_workingDir:=$3
	  //$vt_directoryUrl:=$4
	  //Fin de cas 
	
	  //OB FIXER($vb_newAccountObject;"workingDir";$vt_workingDir)
	  //OB FIXER($vb_newAccountObject;"directoryUrl";$vt_directoryUrl)
	
	ARRAY TEXT:C222($tt_contacts;0)
	
	Case of 
		: (Type:C295($vp_contactListPtr->)=Is text:K8:3)
			APPEND TO ARRAY:C911($tt_contacts;$vp_contactListPtr->)
			
		: (Type:C295($vp_contactListPtr->)=Text array:K8:16)
			  //%W-518.1
			COPY ARRAY:C226($vp_contactListPtr->;$tt_contacts)
			  //%W+518.1
	End case 
	
	C_LONGINT:C283($vl_contactIndex)
	For ($vl_contactIndex;Size of array:C274($tt_contacts);1;-1)
		Case of 
			: (Length:C16($tt_contacts{$vl_contactIndex})=0)
				DELETE FROM ARRAY:C228($tt_contacts;$vl_contactIndex;1)
				
			: (Substring:C12($tt_contacts{$vl_contactIndex};1;7)#"mailto:")
				$tt_contacts{$vl_contactIndex}:="mailto:"+$tt_contacts{$vl_contactIndex}
		End case 
	End for 
	
	OB SET ARRAY:C1227($vb_newAccountObject;"contact";$tt_contacts)
	OB SET:C1220($vb_newAccountObject;"termsOfServiceAgreed";$vb_termsOfServiceAgreed)
	
	ARRAY TEXT:C222($tt_contacts;0)
	
	If (False:C215)
		SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vb_newAccountObject;*))
	End if 
	
End if 
$0:=$vb_newAccountObject
CLEAR VARIABLE:C89($vb_newAccountObject)