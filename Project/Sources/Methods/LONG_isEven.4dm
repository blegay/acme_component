//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : LONG_isEven
  //@scope : private
  //@deprecated : no
  //@description : This function returns TRUE if number is even, FALSE otherwise 
  //@parameter[0-OUT-isEven-BOOLEAN] : is even
  //@parameter[1-IN-number-LONGINT] : number to test
  //@notes :
  //@example : LONG_isEven 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : CREATION : Bruno LEGAY (BLE) - 20/11/2012, 12:04:00 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_isEven)  // renvoie Vrai si le nombre est pair 
C_LONGINT:C283($1;$vl_number)  // nombre à tester
$vb_isEven:=False:C215

  //C_ENTIER LONG($vl_nbParam)
  //$vl_nbParam:=Nombre de paramètres
  //Si ($vl_nbParam>0)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
$vl_number:=$1

  //$vb_isEven:=(($vl_number/2)=($vl_number\2))
$vb_isEven:=(($vl_number%2)=0)

  //Sinon 
  //ALERTE(Nom méthode courante+" : Nombre de paramètres insuffisants.")
  //Fin de si 

$0:=$vb_isEven