//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__opensslCsrToText
  //@scope : private
  //@deprecated : no
  //@description : This function checks a csr output
  //@parameter[0-OUT-csrText-TEXT] : csr output
  //@parameter[2-IN-csrPointer-POINTER] : csr pointer (if blob assumed in DER format, else PEM format) (not modified)
  //@notes : 
  //@example : acme__opensslCsrToText
  //
  // Certificate Request:
  //     Data:
  //         Version: 0 (0x0)
  //         Subject: C=FR, L=Paris, ST=Paris (75), O=AC Consulting, OU=AC Consulting/emailAddress=john@example.com, CN=staging.example.com
  //         Subject Public Key Info:
  //             Public Key Algorithm: rsaEncryption
  //             RSA Public Key: (2048 bit)
  //                 Modulus (2048 bit):
  //                     00:c2:aa:84:2d:32:05:b0:b6:68:84:9f:a0:cd:f6:
  //                     00:c2:aa:84:2d:32:05:b0:b6:68:84:9f:a0:cd:f6:
  //                      ...
  //                     00:c2:aa:84:2d:32:05:b0:b6:68:84:9f:a0:cd:f6:
  //                     4b:0d
  //                 Exponent: 65537 (0x10001)
  //         Attributes:
  //             a0:00
  //     Signature Algorithm: sha256WithRSAEncryption
  //         b3:69:c2:48:77:b8:eb:1f:b1:dd:3d:52:da:22:e5:4f:9c:21:
  //         b3:69:c2:48:77:b8:eb:1f:b1:dd:3d:52:da:22:e5:4f:9c:21:
  //         ...
  //         b3:69:c2:48:77:b8:eb:1f:b1:dd:3d:52:da:22:e5:4f:9c:21:
  //         b3:69:c2:48:77:b8:eb:1f:b1:dd:3d:52:da:22:e5:4f:9c:21:
  //         11:4c:ba:a3
  //
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 08:21:47 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_out)
C_POINTER:C301($1;$vp_csrPtr)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129((Type:C295($1->)=Is text:K8:3) | (Type:C295($1->)=Is BLOB:K8:12);"$1 should be a text or blob pointer")

$vt_out:=""
$vp_csrPtr:=$1

C_TEXT:C284($vt_args)
$vt_args:="req"+\
" -noout"+\
" -text"+\
" -inform "+Choose:C955(Type:C295($vp_csrPtr->)=Is BLOB:K8:12;"DER";"PEM")

acme__opensslConfigDefault 

C_TEXT:C284($vt_err)
If (acme__openSslCmd ($vt_args;$vp_csrPtr;->$vt_out;->$vt_err))
	
Else 
	ASSERT:C1129(False:C215;$vt_err)
End if 

If (False:C215)
	SET TEXT TO PASTEBOARD:C523($vt_out)
End if 

$0:=$vt_out

