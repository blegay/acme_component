//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslCertToTexttest
  //@scope : private
  //@deprecated : no
  //@description : This is a test method
  //@notes : 
  //@example : acme__opensslCertToTexttest
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/06/2018, 11:45:49 - 1.0
  //@xdoc-end
  //================================================================================

C_TEXT:C284($vt_cert)
$vt_cert:=Document to text:C1236("Macintosh HD:Users:ble:Documents:Projets:BaseRef_v15:acme_component:source:acme_component.4dbase:cert.pem";"utf-8";Document unchanged:K24:18)
ALERT:C41(acme__opensslCertToText (->$vt_cert))