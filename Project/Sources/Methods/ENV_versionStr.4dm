//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : ENV_versionStr
  //@scope : private
  //@deprecated : no
  //@description : This function returns the 4D version (i.e. "4D 2004.9", "4D v11r6",  "4D v12.5 Final (Build 122263)")
  //@parameter[0-OUT-4dversion-TEXT] : 4d version
  //@notes :
  //@example : ENV_versionStr => "4D v12.5 Final (Build 122263)"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 29/12/2011, 14:13:23 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_versionStr)

  //<Modif> Bruno LEGAY (BLE) (14/01/2015)

C_TEXT:C284($vt_appVersLong)
C_LONGINT:C283($vl_build)
$vt_appVersLong:=Application version:C493($vl_build;*)  //e.g. "F0011250"

  //C_TEXTE($vt_appVersLong)
  //$vt_appVersLong:=Version application(*)

  //<Modif>
C_TEXT:C284($va_appVers)
  //C_ALPHA(4;$va_appVers)
$va_appVers:=Application version:C493  //e.g. "1250"
If (Length:C16($va_appVers)=4)
	
	C_TEXT:C284($va_appVersMajeur)
	  //C_ALPHA(2;$va_appVersMajeur)
	$va_appVersMajeur:=Substring:C12($va_appVers;1;2)
	
	C_LONGINT:C283($vl_subversion)
	$vl_subversion:=Num:C11(Substring:C12($vt_appVersLong;2;3))
	
	Case of 
		: ($va_appVersMajeur="06")
			$vt_versionStr:="4D 6."+$va_appVers[[3]]+"."+$va_appVers[[4]]
			
		: ($va_appVersMajeur="07")
			$vt_versionStr:="4D 2003."+$va_appVers[[4]]
			
		: ($va_appVersMajeur="08")
			$vt_versionStr:="4D 2004."+$va_appVers[[4]]
			
		: ($va_appVersMajeur="11")
			$vt_versionStr:="4D v11."+$va_appVers[[3]]
			
		: ($va_appVersMajeur="12")
			$vt_versionStr:="4D v12."+$va_appVers[[3]]
			
		: ($va_appVersMajeur="13")
			$vt_versionStr:="4D v13."+$va_appVers[[3]]
			
		: ($va_appVersMajeur="14")
			  //4D v13.1    "1310" Précédent système de numérotation
			  //4D v14 R2   "1420" Release R2
			  //4D v14 R3   "1430" Release R3
			  //4D v14.1    "1401" Première version "bug fix" de 4D v14
			  //4D v14.2    "1402" Seconde version "bug fix" de 4D v14
			If ($va_appVers[[3]]="0")
				$vt_versionStr:="4D v14."+$va_appVers[[4]]
			Else 
				$vt_versionStr:="4D v14 R"+$va_appVers[[3]]
			End if 
			
		: ($va_appVersMajeur="15")
			  //4D v15 R2   "1520" Release R2
			  //4D v15 R3   "1530" Release R3
			  //4D v15.1    "1501" Première version "bug fix" de 4D v15
			  //4D v15.2    "1502" Seconde version "bug fix" de 4D v15
			If ($va_appVers[[3]]="0")
				$vt_versionStr:="4D v15."+$va_appVers[[4]]
			Else 
				$vt_versionStr:="4D v15 R"+$va_appVers[[3]]
			End if 
			
			  //<Modif> Bruno LEGAY (BLE) (22/12/2017)
		: ($va_appVersMajeur="16")
			  //4D v16 R2   "1620" Release R2
			  //4D v16 R3   "1630" Release R3
			  //4D v16.1    "1601" Première version "bug fix" de 4D v16
			  //4D v16.2    "1602" Seconde version "bug fix" de 4D v16
			If ($va_appVers[[3]]="0")
				$vt_versionStr:="4D v16."+$va_appVers[[4]]
			Else 
				$vt_versionStr:="4D v16 R"+$va_appVers[[3]]
			End if 
			
		: (($va_appVersMajeur="17") | ($va_appVersMajeur="18") | ($va_appVersMajeur="19"))
			If ($va_appVers[[3]]="0")
				$vt_versionStr:="4D v"+$va_appVersMajeur+"."+$va_appVers[[4]]
			Else 
				$vt_versionStr:="4D v"+$va_appVersMajeur+" R"+$va_appVers[[3]]
			End if 
			  //<Modif>
			
		Else 
			$vt_versionStr:=$va_appVers+" ?"
	End case 
	
	Case of 
		: (Substring:C12($vt_appVersLong;1;1)="F")
			
			If ($vl_subversion>1)
				$vl_subversion:=$vl_subversion-1
				$vt_versionStr:=$vt_versionStr+" Hotfix "+String:C10($vl_subversion)
			Else 
				$vt_versionStr:=$vt_versionStr+" Final"
			End if 
			
		: (Substring:C12($vt_appVersLong;1;1)="B")
			$vt_versionStr:=$vt_versionStr+" Beta"
			
		: (Substring:C12($vt_appVersLong;1;1)="A")
			$vt_versionStr:=$vt_versionStr+" Alpha"
			
	End case 
	
	$vt_versionStr:=$vt_versionStr+" (Build "+String:C10($vl_build)+")"
	
	  //__moduleDebugDateTimeLine(4;Nom methode courante;"Application version : \""+$va_appVers+"\" => version : \""+$vt_versionStr+"\" ("+$vt_appVersLong+")...")
Else 
	$vt_versionStr:=$va_appVers+" ?"
	  //ENV__moduleDebugDateTimeLine(2;Nom methode courante;"error Application version : \""+$va_appVers+"\" ("+$vt_appVersLong+")...")
End if 

$0:=$vt_versionStr

If (False:C215)
	  // http://forums.4d.fr/Post/FR/15756574/1/15756575#15756575
	
	  //C_TEXTE($vt_text)
	  //C_ENTIER LONG($vl_build)
	  //$vt_text:=Version application($vl_build;*)  //$vt_text : "F0011250", $vl_build : 122263
	  //
	  //C_ENTIER LONG($vl_r_release)
	  //$vl_r_release:=Num(Sous chaine($vt_text;7;1))
	  //
	  //C_TEXTE($vt_version)
	  //$vt_version:=Chaine(Num(Sous chaine($vt_text;5;2)))+"."+Sous chaine($vt_text;8;1)
	  //
	  //Si ($vl_r_release>0)
	  //$vt_version:=$vt_version+"R"+Chaine($vl_r_release)
	  //Fin de si 
	  //
	  //C_ENTIER LONG($vl_subversion)
	  //$vl_subversion:=Num(Sous chaine($vt_text;2;3))
	  //
	  //Au cas ou 
	  //: (Sous chaine($vt_text;1;1)="F")
	  //
	  //Si ($vl_subversion>1)
	  //$vt_version:=$vt_version+" Hotfix"
	  //$vl_subversion:=$vl_subversion-1
	  //Sinon 
	  //$vt_version:=$vt_version+" Final"
	  //Fin de si 
	  //
	  //: (Sous chaine($vt_text;1;1)="B")
	  //$vt_version:=$vt_version+" Beta"
	  //
	  //: (Sous chaine($vt_text;1;1)="A")
	  //$vt_version:=$vt_version+" Alpha"
	  //
	  //Fin de cas 
	  //
	  //$vt_version:="Version "+$vt_version
	  //
	  //$vt_version:=$vt_version+" "+Chaine($vl_subversion)+" (Build "+Chaine($vl_build)+")"
	  //
	  //$0:=$vt_version
End if 


