//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_newOrderAndInstall
  //@scope : public
  //@deprecated : no
  //@description : This function orders the certificate, prepares to repond to lets-encrypt challenges, 
  //  retrieves the certificates and installs them and restarts the web server
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if OK, FALSE otherwise
  //@parameter[1-IN-newOrderObject-OBJECT] : new order object (see acme_newOrderObject)
  //@parameter[2-IN-csrReqConfObject-OBJECT] : csr configuration request (see acme_csrReqConfObjectNew)
  //@notes : calling this function will stop and restart the web server
  // if the web server is not started, it will be started
  //@example : 

  //  // ==========================
  //  // Simple / basic example
  //  // ==========================

  // // just one domain
  //C_TEXT($vt_domain)
  //$vt_domain:="www.example.com"

  //C_OBJECT($vo_newOrderObject)
  //$vo_newOrderObject:=acme_newOrderObject (->$vt_domain)

  //C_OBJET($vo_dn)
  //OB SET($vo_dn;"C";"FR")
  //OB SET($vo_dn;"L";"Paris")
  //OB SET($vo_dn;"ST";"Paris (75)")
  //OB SET($vo_dn;"O";"AC Consulting")
  //OB SET($vo_dn;"OU";"AC Consulting")
  //OB SET($vo_dn;"emailAddress";"john@example.com")
  //OB SET($vo_dn;"CN";$vt_domain)

  //C_OBJECT($vo_csrReqConfObject)
  //$vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_dn)

  //  // order the certificate, prepare to repond to lets-encrypt challenges, 
  //  // retrieve the certificates and install them
  //acme_newOrderAndInstall ($vo_newOrderObject;$vo_csrReqConfObject)


  //  // ==========================
  //  // Example with alt-names
  //  // ==========================

  // // list of domains, firt one will be the "CN" and the other ones will be the alt-names...
  //TEXT ARRAY($tt_domain;0)
  //APPEND TO ARRAY($tt_domain;"www.example.com")  // main CN
  //APPEND TO ARRAY($tt_domain;"api.example.com")  // alt name #1
  //APPEND TO ARRAY($tt_domain;"status.example.com")  // alt name #2

  //C_OBJECT($vo_newOrderObject)
  //$vo_newOrderObject:=acme_newOrderObject (->$tt_domain)

  // // infos for the certiticate request
  //C_OBJECT($vo_dn)
  //OB SET($vo_dn;"C";"FR")
  //OB SET($vo_dn;"L";"Paris")
  //OB SET($vo_dn;"ST";"Paris (75)")
  //OB SET($vo_dn;"O";"AC Consulting")
  //OB SET($vo_dn;"OU";"AC Consulting")
  //OB SET($vo_dn;"emailAddress";"john@example.com")
  //OB SET($vo_dn;"CN";$tt_domain{1})

  //C_OBJECT($vo_altNames)
  //$vo_altNames:=acme_csrAltnamesNew (->$tt_domain;2)  // starting at 2

  //C_OBJECT($vo_csrReqConfObject)
  //$vo_csrReqConfObject:=acme_csrReqConfObjectNew ($vo_dn;$vo_altNames)

  //  // order the certificate, prepare to repond to lets-encrypt challenges, 
  //  // retrieve the certificates and install them
  //acme_newOrderAndInstall ($vo_newOrderObject;$vo_csrReqConfObject)

  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 13/02/2019, 17:42:25 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_OBJECT:C1216($1;$vo_newOrderObject)
C_OBJECT:C1216($2;$vo_csrReqConfObject)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(OB Is defined:C1231($1);"$1 (newOrderObject) is null")
ASSERT:C1129(OB Is defined:C1231($2);"$2 (csrReqConfObject) is null")

$vb_ok:=False:C215
$vo_newOrderObject:=$1
$vo_csrReqConfObject:=$2

C_TEXT:C284($vt_id)
C_OBJECT:C1216($vo_order)
If (acme_newOrder ($vo_newOrderObject;->$vt_id;->$vo_order))
	
	C_TEXT:C284($vt_orderDir)
	$vt_orderDir:=acme_orderDirPathGet ($vt_id)
	
	$vb_ok:=acme_csrGenerateAndSign ($vo_order;$vo_csrReqConfObject;$vt_orderDir)
	
End if 

$0:=$vb_ok
