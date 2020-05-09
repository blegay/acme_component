//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_csrReqConfObjectNew
  //@scope : private
  //@deprecated : no
  //@description : This function returns a csr request configuration object from a "dn" object and an optional "alt_names" object
  //@parameter[0-OUT-csr-OBJECT] : csr object
  //@parameter[1-IN-dn-OBJECT] : "dn" object (see example)
  //@parameter[1-IN-altNames-OBJECT] : "alt_names" object (see example, optional)
  //@notes : 
  //@example : 
  //
  //  C_OBJET($vo_dn)
  //  OB FIXER($vo_dn;"C";"FR")
  //  OB FIXER($vo_dn;"L";"Paris")
  //  OB FIXER($vo_dn;"ST";"Paris (75)")
  //  OB FIXER($vo_dn;"O";"AC Consulting")
  //  OB FIXER($vo_dn;"OU";"AC Consulting")
  //  OB FIXER($vo_dn;"emailAddress";"webmaster@www.example.com")
  //  OB FIXER($vo_dn;"CN";"www.example.com")
  //
  //  C_OBJET($vo_csr)
  //  $vo_csr:=acme_csrReqConfObjectNew ($vo_dn)
  //
  //
  //  C_OBJET($vo_dn)
  //  OB FIXER($vo_dn;"C";"FR")
  //  OB FIXER($vo_dn;"L";"Paris")
  //  OB FIXER($vo_dn;"ST";"Paris (75)")
  //  OB FIXER($vo_dn;"O";"AC Consulting")
  //  OB FIXER($vo_dn;"OU";"AC Consulting")
  //  OB FIXER($vo_dn;"emailAddress";"webmaster@www.example.com")
  //  OB FIXER($vo_dn;"CN";"example.com")
  //
  //  C_OBJET($vo_altNames)
  //  OB FIXER($vo_altNames;"DNS.1";"www.example.com")
  //  OB FIXER($vo_altNames;"DNS.2";"staging.example.com")
  //
  //  C_OBJET($vo_csr)
  //  $vo_csr:=acme_csrReqConfObjectNew ($vo_dn;$vo_altNames)
  //
  // =>
  //     {
  //       "req": {
  //         "default_bits": 2048,
  //         "prompt": false,
  //         "default_md": "sha256",
  //         "req_extensions": "req_ext",
  //         "distinguished_name": "dn"
  //       },
  //       "dn": {
  //         "C": "FR",
  //         "L": "Paris",
  //         "ST": "Paris (75)",
  //         "O": "AC Consulting",
  //         "OU": "AC Consulting",
  //         "emailAddress": "john@example.com",
  //         "CN": "www.example.com"
  //       },
  //       "req_ext": {
  //         "subjectAltName": "@alt_names"
  //       },
  //       "alt_names": {
  //         "DNS.1": "api.example.com",
  //         "DNS.2": "status.example.com"
  //       }
  //     }
  //
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 07:00:57 - 1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_csr)
C_OBJECT:C1216($1;$vo_dn)
C_OBJECT:C1216($2;$vo_altNames)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(OB Is defined:C1231($1);"$1 should be defined")

$vo_dn:=$1
If (Count parameters:C259=1)
	$vb_altNames:=False:C215
Else 
	$vo_altNames:=$2
End if 

C_BOOLEAN:C305($vb_altNames)
$vb_altNames:=OB Is defined:C1231($vo_altNames)

C_OBJECT:C1216($vo_req)
OB SET:C1220($vo_req;"default_bits";2048)
OB SET:C1220($vo_req;"prompt";False:C215)
OB SET:C1220($vo_req;"default_md";"sha256")
If ($vb_altNames)
	OB SET:C1220($vo_req;"req_extensions";"req_ext")
End if 
OB SET:C1220($vo_req;"distinguished_name";"dn")
OB SET:C1220($vo_csr;"req";$vo_req)
CLEAR VARIABLE:C89($vo_req)

OB SET:C1220($vo_csr;"dn";$vo_dn)
CLEAR VARIABLE:C89($vo_dn)

If ($vb_altNames)
	C_OBJECT:C1216($vo_reqExt)
	OB SET:C1220($vo_reqExt;"subjectAltName";"@alt_names")
	OB SET:C1220($vo_csr;"req_ext";$vo_reqExt)
	CLEAR VARIABLE:C89($vo_reqExt)
	
	OB SET:C1220($vo_csr;"alt_names";$vo_altNames)
End if 

acme__log (4;Current method name:C684;"csr conf object :\r"+JSON Stringify:C1217($vo_csr;*))

$0:=$vo_csr