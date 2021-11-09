//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL_initAuto
  //@scope : private
  //@deprecated : no
  //@description : This method is a generic method to initialize a module 
  //@parameter[1-IN-initFlagPtr-POINTER] : initi flag (boolean) pointer (interprocess variable for interprocess initialization and process variable for process initialization) 
  //@parameter[2-IN-compilerMethod-TEXT] : compiler method name
  //@parameter[3-IN-initMethod-TEXT] : initilization method name (optionnal)
  //@notes :
  //@example : 
  //
  // `interprocess init
  //UTL_initAuto (->◊vb_PK_init;"PK__compiler";"PK__initSub")
  //
  //  `process init
  //UTL_initAuto (->vb_PK_init;"PK__compilerG";"PK__initGSub")
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : CREATION : Bruno LEGAY (BLE) - 10/02/2009, 11:23:09 - v1.00.00
  //@xdoc-end
  //================================================================================

C_POINTER:C301($1;$vp_intitVarFlagPtr)  //init var flag
C_TEXT:C284($2;$vt_compilerMethod)  //compiler method
C_TEXT:C284($3;$vt_initMethod)  //initialization method

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vp_intitVarFlagPtr:=$1
	$vt_compilerMethod:=$2
	
	C_BOOLEAN:C305($vb_hasInitMethod)
	Case of 
		: ($vl_nbParam=2)
			$vb_hasInitMethod:=False:C215
			
		Else 
			$vt_initMethod:=$3
			$vb_hasInitMethod:=True:C214  //(Longueur($vt_initMethod)>0)
	End case 
	
	  //Get the flag variable type
	C_LONGINT:C283($vl_initFlagVarType)
	$vl_initFlagVarType:=Type:C295($vp_intitVarFlagPtr->)
	
	  //Declare a local flag to execute the optional initialization method
	C_BOOLEAN:C305($vb_runInitMethod)
	
	Case of 
		: ($vl_initFlagVarType=Is undefined:K8:13)
			  //The compiler method has never been called
			  //we are in interpreted mode
			  //we will call the compiler method 
			EXECUTE METHOD:C1007($vt_compilerMethod)
			
			  //set the flag to declare that the compiler (and initialization method if required) method 
			  //have been (or will be) executed
			$vp_intitVarFlagPtr->:=True:C214
			
			  //set a local flag to exexute the init method (if required)
			$vb_runInitMethod:=$vb_hasInitMethod  //Vrai
			
		: ($vl_initFlagVarType#Is boolean:K8:9)
			  //The variable is defined but is not a boolean
			  //this is a serious/obvious programmer error
			  //display an alert
			C_TEXT:C284($vt_varName)
			C_LONGINT:C283($vl_tableNo;$vl_fieldNo)
			RESOLVE POINTER:C394($vp_intitVarFlagPtr;$vt_varName;$vl_tableNo;$vl_fieldNo)
			
			ALERT:C41(Current method name:C684+"\rThe variable \""+$vt_varName+"\" is not a boolean, but of type "+String:C10($vl_initFlagVarType)+" !!!")
			
			$vb_runInitMethod:=False:C215
			
		: (Not:C34($vp_intitVarFlagPtr->))
			
			  //The compiler method has never been called
			  //we may be in compiled mode
			  //but the compiler medthod needs to be executed anyway for arrays to be initialized
			  //arrays can be declared but not initialized in compiled mode 
			  //we will call the compiler method 
			EXECUTE METHOD:C1007($vt_compilerMethod)
			
			  //set the flag to declare that the compiler (and initialization method if required) method 
			  //have been (or will be) executed
			$vp_intitVarFlagPtr->:=True:C214
			
			  //set a local flag to exexute the init method (if required)
			$vb_runInitMethod:=$vb_hasInitMethod  //Vrai
			
		Else 
			
			
			  //The initialization flag ($1) is true so the compiler method
			  // (and the initialization method if required) have already been executed
			$vb_runInitMethod:=False:C215
	End case 
	
	If ($vb_runInitMethod)
		  //execute the init method (if required)
		EXECUTE METHOD:C1007($vt_initMethod)
	End if 
	
End if 