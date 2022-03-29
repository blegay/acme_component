//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_pemFormatChainToObject
  //@scope : private 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-certificateObj-OBJECT] : certificate object
  //@parameter[1-IN-pemData-TEXT] : p12 file content in PEM format
  //@notes : 
  //   {"cert":"-----BEGIN CERTIFICATE-----\n
  //   MIIEmDCCA4CgAwIBAgI
  //   ...
  //   qAgimwTdPueU/mtExw+7z1/A==\n
  //   -----END CERTIFICATE-----\n",
  //   "pkey":"-----BEGIN PRIVATE KEY-----\n
  //   MIIEvgIBADA
  //   ...
  //   naBppNGFVNdI4PqmEG0Kk5Xsd\n
  //   -----END PRIVATE KEY-----\n",
  //   "extracerts":["-----BEGIN CERTIFICATE-----\n
  //   MIIE2TCCA\n
  //   ...
  //   SUZBQ41Tt4OTKWg\n
  //   -----END CERTIFICATE-----\n"]}
  //@example : acme_pemFormatChainToObject
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 14/12/2020, 10:08:14 - 1.00.03
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_p12Object)
C_TEXT:C284($1;$vt_pem)

$vt_pem:=$1

If (Length:C16($vt_pem)>0)
	
	ARRAY TEXT:C222($tt_pemData;0)
	ARRAY TEXT:C222($tt_type;0)
	
	  // parse the pem file into an array of individual pem with their types
	acme_pemFormatChainToArray ($vt_pem;->$tt_pemData;->$tt_type)
	
	$vo_p12Object:=New object:C1471("cert";"";\
		"pkey";"";\
		"extracerts";New collection:C1472)
	
	C_LONGINT:C283($i;$vl_certCount)
	$vl_certCount:=0
	For ($i;1;Size of array:C274($tt_pemData))
		Case of 
			: ($tt_type{$i}="CERTIFICATE")
				$vl_certCount:=$vl_certCount+1
				If ($vl_certCount=1)
					$vo_p12Object.cert:=$tt_pemData{$i}
				Else 
					$vo_p12Object.extracerts.push($tt_pemData{$i})
				End if 
				
			: ($tt_type{$i}="PRIVATE KEY")
				$vo_p12Object.pkey:=$tt_pemData{$i}
				
		End case 
		
	End for 
	
	ARRAY TEXT:C222($tt_pemData;0)
	ARRAY TEXT:C222($tt_type;0)
	
End if 
$0:=$vo_p12Object

