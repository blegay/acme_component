//%attributes = {"invisible":true,"shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : acme__orderStatusGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns the order status ("pending", "ready",  "processing", "valid", "invalid")
  //@parameter[0-OUT-status-TEXT] : order status
  //@parameter[1-IN-locationUrl-TEXT] : location url
  //@notes :
  //@example : acme__orderStatusGet 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 02/03/2020, 19:53:28 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_status)
C_TEXT:C284($1;$vt_orderUrl)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_status:=""
$vt_orderUrl:=$1

  //C_BOOLEAN($vb_exit)
  //$vb_exit:=False

  //Repeat 

C_OBJECT:C1216($vo_order)
C_LONGINT:C283($vl_status)
$vl_status:=acme_orderGet ($vt_orderUrl;->$vo_order)
If ($vl_status=200)
	
	C_TEXT:C284($vt_status)
	$vt_status:=OB Get:C1224($vo_order;"status")
	
	acme__log (4;Current method name:C684;"url : \""+$vt_orderUrl+"\""+\
		", order status : \""+$vt_status+"\""+\
		", http status : "+String:C10($vl_status)+". [OK]")
	
	  //$vb_exit:=True
	  //Else 
	  //$vb_exit:=True
Else 
	acme__log (2;Current method name:C684;"url : \""+$vt_orderUrl+"\""+\
		", unexpected http status : "+String:C10($vl_status)+". [KO]")
End if 

  //Until ($vb_exit)

$0:=$vt_status

