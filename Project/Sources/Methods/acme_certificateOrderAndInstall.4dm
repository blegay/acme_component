//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
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
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
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

  // mutex semaphore
C_TEXT:C284($vt_semaphore)
$vt_semaphore:="$acme_certificateOrderAndInstall"
If (Not:C34(Semaphore:C143($vt_semaphore;120)))
	acme__log (4;Current method name:C684;"semaphore \""+$vt_semaphore+"\" set in process "+acme__processInfosDebug )
	
	acme__progressInit ("title")  //"Zertifikat anfordern / erneuern")
	acme__progressUpdate (0;"initialization")  //"Initialisieren der Zertifikats-Anforderung")
	
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
		
		acme__progressUpdate (10;"newOrderObject")  //"Zertifikat Anforderungs-Objekt abrufen")
		  //If ($vb_progress)
		  //Progress SET PROGRESS ($vl_progressID;10;"Zertifikat Anforderungs-Objekt abrufen";True)
		  //End if 
		
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
		
		acme__progressUpdate (20;"csrReqConfObjectNew")  //"Zertifikat Anforderung (CSR) erstellen")
		  //If ($vb_progress)
		  //Progress SET PROGRESS ($vl_progressID;20;"Zertifikat Anforderung (CSR) erstellen";True)
		  //End if 
		
		  // create the acme csr object
		C_OBJECT:C1216($vo_csrReqConfObject)
		$vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_subject;$vo_altNames)
		
		acme__progressUpdate (30;"newOrderAndInstall")  //"Zertifikat Anforderung (CSR) senden")
		  //If ($vb_progress)
		  //Progress SET PROGRESS ($vl_progressID;30;"Zertifikat Anforderung (CSR) senden";True)
		  //End if 
		
		  // sends the csr to Let's Encrypt®
		$vb_ok:=acme_newOrderAndInstall ($vo_newOrderObject;$vo_csrReqConfObject)
		
	End if 
	
	ARRAY TEXT:C222($tt_domains;0)
	
	acme__progressDeinit 
	
	
	CLEAR SEMAPHORE:C144($vt_semaphore)
	acme__log (4;Current method name:C684;"semaphore \""+$vt_semaphore+"\" cleared in process "+acme__processInfosDebug )
Else 
	acme__log (2;Current method name:C684;"semaphore \""+$vt_semaphore+"\" already set, process "+acme__processInfosDebug )
End if 

  //End if 

$0:=$vb_ok