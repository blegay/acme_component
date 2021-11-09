//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__csrReqConfObjectToText
  //@scope : private
  //@deprecated : no
  //@description : This function returns an openssl csr configuration file from a csr object
  //@parameter[0-OUT-csrConf-TEXT] : openssl csr configuration
  //@parameter[1-IN-csrObj-OBJECT] : csr object
  //@notes : 
  //@example : 
  //     
  //     
  //     C_OBJET($vo_csrObj)
  //     OB FIXER($vo_csrObj;"C";"FR")
  //     OB FIXER($vo_csrObj;"L";"Paris")
  //     OB FIXER($vo_csrObj;"ST";"Paris (75)")
  //     OB FIXER($vo_csrObj;"O";"AC Consulting")
  //     OB FIXER($vo_csrObj;"OU";"AC Consulting")
  //     OB FIXER($vo_csrObj;"emailAddress";"john@example.com")
  //     OB FIXER($vo_csrObj;"CN";"www.example.com")
  //     
  //     
  //     C_OBJET($vo_altNames)
  //     OB FIXER($vo_altNames;"DNS.1";"api.example.com")
  //     OB FIXER($vo_altNames;"DNS.2";"status.example.com")
  //
  //     acme__csrReqConfObjectNew ($vo_csrObj;$vo_altNames) :
  //     
  //     [req]
  //     default_bits = 2048
  //     prompt = no
  //     default_md = sha256
  //     req_extensions = req_ext
  //     distinguished_name = dn
  //     
  //     [dn]
  //     C = FR
  //     L = Paris
  //     ST = Paris (75)
  //     O = AC Consulting
  //     OU = AC Consulting
  //     emailAddress = john@example.com
  //     CN = www.example.com
  //     
  //     [req_ext]
  //     subjectAltName = @alt_names
  //     
  //     [alt_names]
  //     DNS.1 = api.example.com
  //     DNS.2 = status.example.com


  //@see : acme_csrReqConfObjectNew, acme__opensslCsrNew
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 07:36:56 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_csrConf)
C_OBJECT:C1216($1;$vo_csr)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(OB Is defined:C1231($1);"$1 should be defined")

$vt_csrConf:=""
$vo_csr:=$1

C_TEXT:C284($vt_endLine)
If (ENV_onWindows )
	$vt_endLine:="\r\n"
Else 
	$vt_endLine:="\n"
End if 

$vt_csrConf:=acme__csrReqConfObjectToTextSub ($vo_csr;$vt_endLine)

If (False:C215)
	  //%T-
	SET TEXT TO PASTEBOARD:C523($vt_csrConf)
	  //%T+
End if 

  //TABLEAU TEXTE($tt_propertyNames;0)
  //TABLEAU ENTIER LONG($tl_propertyTypes;0)

  //Si (OB Est défini($vo_csr;"req"))
  //$vt_buffer:=$vt_buffer+"[req]"+$vt_endLine
  //OB LIRE NOMS PROPRIÉTÉS($vo_csr;$tt_propertyNames;$tl_propertyTypes)

  //$vt_buffer:=$vt_buffer+$vt_endLine
  //Fin de si 

$0:=$vt_csrConf