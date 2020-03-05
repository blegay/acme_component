//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_certificateOrderAndInstall
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function will generate the certifcate request, sent it to Let's Encrypt®, retrive the certificate, install it and restart 4D web/http server
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-domainListPtr-POINTER] : domain list text or text array pointer (not modified)
  //@notes : 
  //@example : acme_certificateOrderAndInstall
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2020
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 05/03/2020, 18:33:43 - 0.90.15
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_POINTER:C301($1;$vp_domainListPtr)

ASSERT:C1129(Count parameters:C259>0;"Requires 1 parameter")
ASSERT:C1129((Type:C295($1->)=Is text:K8:3) | (Type:C295($1->)=Text array:K8:16);"$1 should be a text or text array pointer")

  //C_LONGINT($vl_nbParam)
  //$vl_nbParam:=Count parameters

$vb_ok:=False:C215
  //If ($vl_nbParam>0)
$vp_domainListPtr:=$1

ARRAY TEXT:C222($tt_domains;0)

Case of 
	: (Type:C295($vp_domainListPtr->)=Is text:K8:3)
		APPEND TO ARRAY:C911($tt_domains;$vp_domainListPtr->)
		
	: (Type:C295($vp_domainListPtr->)=Text array:K8:16)
		  //%W-518.1
		COPY ARRAY:C226($vp_domainListPtr->;$tt_domains)
		  //%W+518.1
End case 

If (Size of array:C274($tt_domains)>0)
	
	  // prepare an "order" object
	C_OBJECT:C1216($vo_newOrderObject)
	$vo_newOrderObject:=acme_newOrderObject (->$tt_domains)
	
	  // create the subject object (with a "CN" property corresponding to the first domain)
	C_OBJECT:C1216($vo_subject)
	$vo_subject:=acme_csrSubjectAutoFromDomains (->$tt_domains)
	
	C_OBJECT:C1216($vo_altNames)
	If (Size of array:C274($tt_domains)>1)
		
		  // create a list of alternative names
		$vo_altNames:=acme_csrAltnamesNew (->$tt_domains)
		
	End if 
	
	  // create the acme csr object
	C_OBJECT:C1216($vo_csrReqConfObject)
	$vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_subject;$vo_altNames)
	
	  // sends the csr to Let's Encrypt®
	$vb_ok:=acme_newOrderAndInstall ($vo_newOrderObject;$vo_csrReqConfObject)
	
End if 

ARRAY TEXT:C222($tt_domains;0)

  //End if 

$0:=$vb_ok