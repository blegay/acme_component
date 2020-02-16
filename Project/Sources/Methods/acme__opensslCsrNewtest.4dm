//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslCsrNewtest
  //@scope : private
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-paramName-TEXT] : ParamDescription
  //@parameter[2-IN-paramName-POINTER] : ParamDescription (not modified)
  //@parameter[3-INOUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[4-OUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[5-IN-paramName-LONGINT] : ParamDescription (optional, default value : 1)
  //@notes : 
  //@example : acme__opensslCsrNewtest
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 00:01:09 - 1.00.00
  //@xdoc-end
  //================================================================================

  //C_TEXTE($vt_directoryUrl)
  //$vt_directoryUrl:="https://acme-staging-v02.api.letsencrypt.org/directory"

  //C_TEXTE($vt_workingDir)
  //$vt_workingDir:=fs_pathToParent (Dossier 4D(Dossier base;*))

  //C_TEXTE($vt_domain)
  //$vt_domain:="test-ssl.example.com"

  //C_BLOB($vx_csr)
  //$vx_csr:=acme__opensslCsrNew ($vt_directoryUrl;)  //;$vt_workingDir;$vt_domain)

