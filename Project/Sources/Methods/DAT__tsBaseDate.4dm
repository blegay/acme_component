//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : DAT__tsBaseDate
  //@scope : private
  //@deprecated : no
  //@description : This function returns the arbitrary base date
  //@parameter[0-OUT-tsBaseDate-DATE] : timestamp base date
  //@notes :
  //Renvoie la date de base
  //Methode privée au module TS. Ne pas appler directement.
  //Seul endroit ou cette date est codée
  //Attention: si on change cette date dans une base existante
  //les valeurs stokées devront-être mises-à-jour...
  //
  //Dans les limites de entier long 32 bits -2^31 ...  2^31 
  //on peut stocker +/-24 855 jours 
  //à peut près +/- 68 années
  //Donc on peut stocker des date/heure 
  //de 1922 (13/12/1921 20:45:52) à 2058 (19/01/2058 03:14:07) 
  //avec un entier long 32 bits.
  //D'ici là on aurra surement des entiers très très long
  //64 ou 128 bits pour éviter le BUG de l'an 2058...
  //
  //@example : DAT__tsBaseDate 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 25/08/2015, 13:03:46 - v1.00.00
  //@xdoc-end
  //================================================================================

C_DATE:C307($0;$vd_baseDate)  //Date de base

$vd_baseDate:=!1990-01-01!  //Date de base

$0:=$vd_baseDate