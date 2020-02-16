//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : DAT_tsNew
  //@scope : private
  //@deprecated : no
  //@description : This function returns a timestamp stored in a longint
  //@parameter[0-OUT-timestamp-LONGINT] : timestamp
  //@parameter[1-IN-date-DATE] : date (optional, default value : current server date)
  //@parameter[2-IN-time-TIME] : time (optional, default value : current server time)
  //@notes :
  //@example :  
  // $vl_myTimestamp:=DAT_tsNew($vd_myDate;$vh_myTime)
  // $vl_myTimestamp:=DAT_tsNew($vd_myDate)
  // $vl_myTimestamp:=DAT_tsNew 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 25/08/2015, 12:54:57 - v1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$vl_timestamp)  //Timestamp and number of parameters
C_DATE:C307($1;$vd_date)  //Date pour laquelle on veut un timestamp
  //(optionelle, défaut Date du Jour Serveur 4D)
C_TIME:C306($2;$vh_time)  //Heure pour laquelle on veut un timestamp 
  //(optionelle, défaut Heure Courrante Serveur 4D)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

Case of 
	: ($vl_nbParam=0)  //Pas de paramètres: on utilise Date du jour et Heure courante dur Serveur 4D
		$vd_date:=Current date:C33(*)
		$vh_time:=Current time:C178(*)
		
	: ($vl_nbParam=1)  //On utilise la date passée en paramètres
		$vd_date:=$1
		$vh_time:=Current time:C178(*)
		
	: ($vl_nbParam=2)  //On utilise la date et l'heure passées en paramètres
		$vd_date:=$1
		$vh_time:=$2
End case 

  //Calcul du date/time stamp
If ($vd_date=!00-00-00!)
	$vl_timestamp:=0+$vh_time
Else 
	$vl_timestamp:=(($vd_date-DAT__tsBaseDate )*86400)+$vh_time  //86400 = 24*60*60
End if 
$0:=$vl_timestamp