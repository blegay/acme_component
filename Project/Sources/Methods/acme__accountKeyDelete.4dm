//%attributes = {"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__accountKeyDelete
  //@scope : private
  //@deprecated : no
  //@description : This method will delete the account key from a given directory
  //@parameter[1-IN-keyDir-TEXT] : account key directory
  //@notes : deletes files "key.pem" and "key.pub"
  //@example : acme__accountKeyDelete
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 21:14:11 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($vt_keyDir;$1)
If (Count parameters:C259>0)
	$vt_keyDir:=$1
	
	If (Test path name:C476($vt_keyDir)=Is a folder:K24:2)
		ARRAY TEXT:C222($tt_filename;0)
		
		APPEND TO ARRAY:C911($tt_filename;"key.pem")
		APPEND TO ARRAY:C911($tt_filename;"key.pub")
		
		C_LONGINT:C283($i)
		For ($i;1;Size of array:C274($tt_filename))
			
			C_TEXT:C284($vt_filepath)
			$vt_filepath:=$vt_keyDir+$tt_filename{$i}
			
			If (Test path name:C476($vt_filepath)=Is a document:K24:1)
				acme__moduleDebugDateTimeLine (6;Current method name:C684;"deleting file \""+$vt_filepath+"\"...")
				DELETE DOCUMENT:C159($vt_filepath)
				If (ok=1)
					acme__moduleDebugDateTimeLine (4;Current method name:C684;"file \""+$vt_filepath+"\" deleted. [OK]")
				Else 
					acme__moduleDebugDateTimeLine (2;Current method name:C684;"file \""+$vt_filepath+"\" could not be deleted. [KO]")
				End if 
			End if 
			
		End for 
		
	Else 
		acme__moduleDebugDateTimeLine (2;Current method name:C684;"dir \""+$vt_filepath+"\" does not exist. [KO]")
	End if 
	
End if 
