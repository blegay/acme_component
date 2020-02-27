//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__httpClientOptionsSet
  //@scope : private
  //@deprecated : no
  //@description : this methos sets the default http options
  //@notes : 
  //@example : acme__httpClientOptionsSet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 11:53:31 - 1.00.00
  //@xdoc-end
  //================================================================================

If (True:C214)
	
	HTTP SET OPTION:C1160(HTTP display auth dial:K71:13;0)  // 0 = ne pas afficher le dialogue, 1 = afficher le dialogue
	HTTP SET OPTION:C1160(HTTP reset auth settings:K71:14;0)  // 0 = ne pas effacer les informations, 1 = effacer les informations
	
	HTTP SET OPTION:C1160(HTTP compression:K71:15;0)  // 0 = ne pas compresser, 1= compresser)
	
	HTTP SET OPTION:C1160(HTTP max redirect:K71:12;2)  // 2 redirections max
	HTTP SET OPTION:C1160(HTTP follow redirect:K71:11;1)  // 1 = accepter les redirections, 0 = ne pas accepter les redirections
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10;120)  // timeout 2 minutes
	
	C_TEXT:C284($vt_dir)
	$vt_dir:=Get 4D folder:C485(Current resources folder:K5:16)  // "Resources" dir for the component. Does not contain any client certificate
	HTTP SET CERTIFICATES FOLDER:C1306($vt_dir)
	
	acme__log (4;Current method name:C684;"default options set")
End if 