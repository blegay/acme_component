//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__protectedObjGet
  //@scope : private
  //@deprecated : no
  //@description : This function returns the "protected" object for the JWT signature
  //@parameter[0-OUT-protected-OBJECT] : protected object
  //@parameter[1-IN-url-TEXT] : url (e.g. "https://acme-staging-v02.api.letsencrypt.org/acme/new-acct")
  //@parameter[2-IN-accountKeyDir-TEXT] : account key directory
  //@parameter[3-IN-algorithme-TEXT] : alogithm for the jwt protected "alg" property (e.g. "RS256" for RSA 256)
  //@notes : 
  //@example : acme__protectedObjGet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 12:09:47 - 1.00.00
  //@xdoc-end
  //================================================================================
  //@parameter[1-IN-directoryUrl-TEXT] : directory url (to get the "nonce" service url)
  //@parameter[2-IN-url-TEXT] : url
  //@parameter[3-IN-accountKeyDir-TEXT] : account key directory
  //@parameter[4-IN-algorithme-TEXT] : alogithm for the jwt protected "alg" property (e.g. "RS256" for RSA 256)

C_OBJECT:C1216($0;$vo_protected)
C_TEXT:C284($1;$vt_url)
C_TEXT:C284($2;$vt_accountKeyDir)
C_TEXT:C284($3;$vt_algorithm)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")

$vt_url:=$1
$vt_accountKeyDir:=$2
$vt_algorithm:=$3  // "RS256"  

  //C_TEXTE($1;$vt_directoryUrl)
  //C_TEXTE($2;$vt_url)
  //C_TEXTE($3;$vt_accountKeyDir)
  //C_TEXTE($4;$vt_algorithm)

  //$vt_directoryUrl:=$1
  //$vt_url:=$2
  //$vt_accountKeyDir:=$3
  //$vt_algorithm:=$4  // "RS256"  

  //ASSERT(Nombre de paramètres>3;"requires 4 parameters")
ASSERT:C1129(Test path name:C476($vt_accountKeyDir)=Is a folder:K24:2;"dir \""+$vt_accountKeyDir+"\" not found")

  // get a "nonce" from the server...
C_TEXT:C284($vt_nonce)
$vt_nonce:=acme__nonceGet   //($vt_directoryUrl)

OB SET:C1220($vo_protected;"alg";$vt_algorithm)
acme__jswKeyInfosSet ($vo_protected;$vt_accountKeyDir)
OB SET:C1220($vo_protected;"nonce";$vt_nonce)
OB SET:C1220($vo_protected;"url";$vt_url)

$0:=$vo_protected