//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__selftests
  //@scope : private
  //@deprecated : no
  //@description : This method will test openssl operations
  //@notes : tested with openssl v1.0.2o on OS X
  //@example : acme__selftests
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 09:24:03 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($vt_uuid)
$vt_uuid:=UUID_new 

  //<Modif> Bruno LEGAY (BLE) (31/07/2019)
  //acme__extractDomainFromUrl
C_TEXT:C284($vt_url;$vt_domain)
$vt_url:="https://acme-staging-v02.api.letsencrypt.org/directory/dz"
ASSERT:C1129(acme__domainExtractFromUrl ($vt_url;->$vt_domain))
ASSERT:C1129($vt_domain="acme-staging-v02.api.letsencrypt.org")
  //<Modif>

ASSERT:C1129(acme__domainReverse ("acme-v02.api.letsencrypt.org")="org.letsencrypt.api.acme-v02")

  // acme__accountInit
C_TEXT:C284($vt_url;$vt_regex;$vt_domain)
$vt_url:="https://acme-staging-v02.api.letsencrypt.org/directory/dz"
$vt_regex:="^https?://(.*?)/.*$"
ASSERT:C1129(TXT_regexGetMatchingGroup ($vt_regex;$vt_url;1;->$vt_domain))
ASSERT:C1129($vt_domain="acme-staging-v02.api.letsencrypt.org")

C_TEXT:C284($vt_url;$vt_uri;$vt_regex;$vt_domain)
$vt_url:="https://acme-staging-v02.api.letsencrypt.org/directory/dz"
$vt_regex:="^https?://(.*?)/(.*)$"
ASSERT:C1129(TXT_regexGetMatchingGroup ($vt_regex;$vt_url;1;->$vt_domain;->$vt_uri))
ASSERT:C1129($vt_domain="acme-staging-v02.api.letsencrypt.org")
ASSERT:C1129($vt_uri="directory/dz")

  // acme_urlLocationIdGet
C_TEXT:C284($vt_url;$vt_regex;$vt_id)
$vt_url:="https://acme-staging-v02.api.letsencrypt.org/acme/order/12345/6789"
$vt_regex:="^.*/(.+)$"
ASSERT:C1129(TXT_regexGetMatchingGroup ($vt_regex;$vt_url;1;->$vt_id))
ASSERT:C1129($vt_id="6789")


C_TEXT:C284($vt_expected;$vt_actual)

C_TEXT:C284($vt_newLine)
$vt_newLine:=Choose:C955(Is Windows:C1573;"\r\n";"\n")

C_TEXT:C284($vt_testDirPath)
$vt_testDirPath:=Get 4D folder:C485(Current resources folder:K5:16)+"testcases"+Folder separator:K24:12+"signature"+Folder separator:K24:12

ASSERT:C1129(Test path name:C476($vt_testDirPath)=Is a folder:K24:2;"testcase dir not found")

C_OBJECT:C1216($vo_protected;$vo_payload)
$vo_protected:=JSON Parse:C1218(Document to text:C1236($vt_testDirPath+"protected.json"))
$vo_payload:=JSON Parse:C1218(Document to text:C1236($vt_testDirPath+"payload.json"))

C_TEXT:C284($vt_openSslAlgorithm)
$vt_openSslAlgorithm:="sha256"

C_TEXT:C284($vt_privateKeyPath)
$vt_privateKeyPath:=$vt_testDirPath+"key.pem"


C_BLOB:C604($vb_blob;$vb_blob2)
SET BLOB SIZE:C606($vb_blob;0)
SET BLOB SIZE:C606($vb_blob2;0)
DOCUMENT TO BLOB:C525($vt_privateKeyPath;$vb_blob)

C_TEXT:C284($vt_base64)
$vt_base64:=UTL_base64UrlSafeEncode ($vb_blob)
$vb_blob2:=UTL_base64UrlSafeDecode ($vt_base64)

ASSERT:C1129(Generate digest:C1147($vb_blob;SHA1 digest:K66:2)=Generate digest:C1147($vb_blob2;SHA1 digest:K66:2);"UTL_base64UrlSafeEncode/UTL_base64UrlSafeDecode failed")
SET BLOB SIZE:C606($vb_blob;0)
SET BLOB SIZE:C606($vb_blob2;0)


$vt_actual:=acme__tokenToFilenameSafe ("IFYoEgcXKmHJOKpEG1S3kwfZPOksIKQbs4ZHU0yEeSQ")
$vt_expected:="IFYoEgcXKmHJOKpEG1S3kwfZPOksIKQbs4ZHU0yEeSQ-11bd9a9e7b8b400feac82575eca67ce2.txt"
ASSERT:C1129($vt_expected=$vt_actual;"acme_tokenToFilenameSafe failed")

$vt_actual:=acme__tokenToFilenameSafe ("iFYoEgcXKmHJOKpEG1S3kwfZPOksIKQbs4ZHU0yEeSQ")
$vt_expected:="iFYoEgcXKmHJOKpEG1S3kwfZPOksIKQbs4ZHU0yEeSQ-9f794b08e663d1afc40d47a33f88da5a.txt"
ASSERT:C1129($vt_expected=$vt_actual;"acme_tokenToFilenameSafe failed")


$vt_expected:="rJE_btQ6sJ4bUbt-mEXqRH7rjbhrN3Ax53TRAaymZa-Bzcg8viyQiZQScVHombiG4qiqM02pF5SzOIxdjB6tG6Yk1FaYLZlGMicyz12JtRFNhich7-PbnBEjiVA8Vdtd0f1Ruhmmn-J0z6NJks7MX0p4A59G6qv-CGcYu-LE2RBZJQzdkcaRyfFb4Ax1E1BsIGhwJdedul_sNlEtXTMjXAQHFX33dkgQboeVvSzdYCngQVf1AE3r6thiR19"+"_wi8J4c00TIa0HheonbqDsRXd6H2bd755dcuKxcryW4q1XgdzbCIGy5C7jUlyAdgaH3YzC-4Bm8Ye3NptJ0U1xPBMYQ"
$vt_actual:=UTL_base64UrlSafeEncode (acme__keyPrivModulusGet ($vt_privateKeyPath))
ASSERT:C1129($vt_expected=$vt_actual;"openssl get private key modulus failed")

$vt_expected:="AQAB"
$vt_actual:=UTL_base64UrlSafeEncode (acme__keyPrivExponentGet ($vt_privateKeyPath))
ASSERT:C1129($vt_expected=$vt_actual;"openssl get private key exponent failed")


C_OBJECT:C1216($vo_signature)
$vo_signature:=acme__jwsObjectSign ($vo_protected;$vo_payload;$vt_privateKeyPath;$vt_openSslAlgorithm)

$vt_expected:=Document to text:C1236($vt_testDirPath+"result.txt")
$vt_actual:=OB Get:C1224($vo_signature;"protected")+"."+OB Get:C1224($vo_signature;"payload")+"."+OB Get:C1224($vo_signature;"signature")

ASSERT:C1129($vt_expected=$vt_actual;"openssl siganture failed")


$vt_expected:="mir5SY_LC8ilQiWKE8XMvMU6XSatOUeZYBtO2TUBhkU"
$vt_actual:=UTL_base64UrlSafeEncode (acme__jwkThumbprint ($vt_privateKeyPath))
ASSERT:C1129($vt_expected=$vt_actual;"openssl get private key exponent failed")




C_OBJECT:C1216($vo_dn)
OB SET:C1220($vo_dn;"C";"FR")
OB SET:C1220($vo_dn;"L";"Paris")
OB SET:C1220($vo_dn;"ST";"Paris (75)")
OB SET:C1220($vo_dn;"O";"Example Inc")
OB SET:C1220($vo_dn;"OU";"Software services")
OB SET:C1220($vo_dn;"emailAddress";"webmaster@www.example.com")
OB SET:C1220($vo_dn;"CN";"www.example.com")

C_OBJECT:C1216($vo_csr)
$vo_csr:=acme_csrReqConfObjectNew ($vo_dn)

C_BLOB:C604($vx_csr)
ASSERT:C1129(acme__opensslCsrNew ($vo_csr;$vt_privateKeyPath;->$vx_csr))

$vt_expected:="4a5dbdfb0d9d77fea035f8de022d57700b50504a"
$vt_actual:=Generate digest:C1147($vx_csr;SHA1 digest:K66:2)
ASSERT:C1129($vt_expected=$vt_actual;"openssl csr genereate failed")

$vt_expected:=""
$vt_expected:=$vt_expected+"Certificate Request:"+$vt_newLine
$vt_expected:=$vt_expected+"    Data:"+$vt_newLine
$vt_expected:=$vt_expected+"        Version: 0 (0x0)"+$vt_newLine
$vt_expected:=$vt_expected+"        Subject: C=FR, L=Paris, ST=Paris (75), O=Example Inc, OU=Software services/emailAddress=webmaster@www.example.com, CN=www.example.com"+$vt_newLine
$vt_expected:=$vt_expected+"        Subject Public Key Info:"+$vt_newLine
$vt_expected:=$vt_expected+"            Public Key Algorithm: rsaEncryption"+$vt_newLine
$vt_expected:=$vt_expected+"                Public-Key: (2048 bit)"+$vt_newLine
$vt_expected:=$vt_expected+"                Modulus:"+$vt_newLine
$vt_expected:=$vt_expected+"                    00:ac:91:3f:6e:d4:3a:b0:9e:1b:51:bb:7e:98:45:"+$vt_newLine
$vt_expected:=$vt_expected+"                    ea:44:7e:eb:8d:b8:6b:37:70:31:e7:74:d1:01:ac:"+$vt_newLine
$vt_expected:=$vt_expected+"                    a6:65:af:81:cd:c8:3c:be:2c:90:89:94:12:71:51:"+$vt_newLine
$vt_expected:=$vt_expected+"                    e8:99:b8:86:e2:a8:aa:33:4d:a9:17:94:b3:38:8c:"+$vt_newLine
$vt_expected:=$vt_expected+"                    5d:8c:1e:ad:1b:a6:24:d4:56:98:2d:99:46:32:27:"+$vt_newLine
$vt_expected:=$vt_expected+"                    32:cf:5d:89:b5:11:4d:86:27:21:ef:e3:db:9c:11:"+$vt_newLine
$vt_expected:=$vt_expected+"                    23:89:50:3c:55:db:5d:d1:fd:51:ba:19:a6:9f:e2:"+$vt_newLine
$vt_expected:=$vt_expected+"                    74:cf:a3:49:92:ce:cc:5f:4a:78:03:9f:46:ea:ab:"+$vt_newLine
$vt_expected:=$vt_expected+"                    fe:08:67:18:bb:e2:c4:d9:10:59:25:0c:dd:91:c6:"+$vt_newLine
$vt_expected:=$vt_expected+"                    91:c9:f1:5b:e0:0c:75:13:50:6c:20:68:70:25:d7:"+$vt_newLine
$vt_expected:=$vt_expected+"                    9d:ba:5f:ec:36:51:2d:5d:33:23:5c:04:07:15:7d:"+$vt_newLine
$vt_expected:=$vt_expected+"                    f7:76:48:10:6e:87:95:bd:2c:dd:60:29:e0:41:57:"+$vt_newLine
$vt_expected:=$vt_expected+"                    f5:00:4d:eb:ea:d8:62:47:5f:7f:c2:2f:09:e1:cd:"+$vt_newLine
$vt_expected:=$vt_expected+"                    34:4c:86:b4:1e:17:a8:9d:ba:83:b1:15:dd:e8:7d:"+$vt_newLine
$vt_expected:=$vt_expected+"                    9b:77:be:79:75:cb:8a:c5:ca:f2:5b:8a:b5:5e:07:"+$vt_newLine
$vt_expected:=$vt_expected+"                    73:6c:22:06:cb:90:bb:8d:49:72:01:d8:1a:1f:76:"+$vt_newLine
$vt_expected:=$vt_expected+"                    33:0b:ee:01:9b:c6:1e:dc:da:6d:27:45:35:c4:f0:"+$vt_newLine
$vt_expected:=$vt_expected+"                    4c:61"+$vt_newLine
$vt_expected:=$vt_expected+"                Exponent: 65537 (0x10001)"+$vt_newLine
$vt_expected:=$vt_expected+"        Attributes:"+$vt_newLine
$vt_expected:=$vt_expected+"            a0:00"+$vt_newLine
$vt_expected:=$vt_expected+"    Signature Algorithm: sha256WithRSAEncryption"+$vt_newLine
$vt_expected:=$vt_expected+"         12:8b:18:75:2f:88:52:17:12:78:77:e6:a8:6c:f4:10:06:17:"+$vt_newLine
$vt_expected:=$vt_expected+"         bc:95:a0:37:4d:12:fc:53:ed:69:72:80:02:ee:b5:ea:dc:55:"+$vt_newLine
$vt_expected:=$vt_expected+"         72:5f:a4:76:d4:66:33:63:1b:62:dc:16:61:69:1c:fb:76:38:"+$vt_newLine
$vt_expected:=$vt_expected+"         20:d1:bb:0e:02:f0:63:75:a5:80:18:08:41:f5:d2:a4:81:27:"+$vt_newLine
$vt_expected:=$vt_expected+"         8a:8c:33:61:87:c5:94:b8:e3:a7:0a:ea:9a:86:54:dd:1d:6b:"+$vt_newLine
$vt_expected:=$vt_expected+"         6f:13:61:6e:98:89:86:eb:f1:93:9f:94:a4:7b:a7:b6:c1:26:"+$vt_newLine
$vt_expected:=$vt_expected+"         6f:10:88:e4:09:65:4f:6c:d7:5e:3c:91:89:2c:29:b0:e5:e3:"+$vt_newLine
$vt_expected:=$vt_expected+"         45:f3:59:15:dd:ee:ae:aa:27:0e:16:8f:6d:7d:ae:d2:4e:6a:"+$vt_newLine
$vt_expected:=$vt_expected+"         07:13:ec:d5:3c:62:bd:98:db:f9:7d:d0:3e:f0:13:47:16:f7:"+$vt_newLine
$vt_expected:=$vt_expected+"         0e:90:61:03:17:71:36:2f:f3:4e:ac:5e:e1:3a:15:ce:dd:08:"+$vt_newLine
$vt_expected:=$vt_expected+"         18:93:95:ed:60:6b:97:6c:84:7d:2c:5e:eb:f3:c6:dd:00:49:"+$vt_newLine
$vt_expected:=$vt_expected+"         9a:a5:64:54:47:1f:18:15:ad:f2:e2:09:30:ee:b7:0c:90:a3:"+$vt_newLine
$vt_expected:=$vt_expected+"         2e:0c:21:c0:46:ab:9d:41:f3:3c:62:f5:2c:d5:3e:a6:85:14:"+$vt_newLine
$vt_expected:=$vt_expected+"         76:b1:67:bd:75:81:f8:27:f8:5d:00:b4:19:e9:ab:b9:7b:75:"+$vt_newLine
$vt_expected:=$vt_expected+"         f2:fc:59:b6"+$vt_newLine

$vt_actual:=acme__opensslCsrToText (->$vx_csr)
ASSERT:C1129($vt_expected=$vt_actual;"openssl get private key exponent failed")

C_OBJECT:C1216($vo_dn)
OB SET:C1220($vo_dn;"C";"FR")
OB SET:C1220($vo_dn;"L";"Paris")
OB SET:C1220($vo_dn;"ST";"Paris (75)")
OB SET:C1220($vo_dn;"O";"Example Inc")
OB SET:C1220($vo_dn;"OU";"Software services")
OB SET:C1220($vo_dn;"emailAddress";"webmaster@www.example.com")
OB SET:C1220($vo_dn;"CN";"example.com")

C_OBJECT:C1216($vo_altNames)
OB SET:C1220($vo_altNames;"DNS.1";"www.example.com")
OB SET:C1220($vo_altNames;"DNS.2";"staging.example.com")

C_OBJECT:C1216($vo_csr)
$vo_csr:=acme_csrReqConfObjectNew ($vo_dn;$vo_altNames)

C_BLOB:C604($vx_csr)
ASSERT:C1129(acme__opensslCsrNew ($vo_csr;$vt_privateKeyPath;->$vx_csr))

$vt_expected:="0fc1863cdfba59ce1225f77f08f0ca127564fcd0"
$vt_actual:=Generate digest:C1147($vx_csr;SHA1 digest:K66:2)
ASSERT:C1129($vt_expected=$vt_actual;"openssl csr genereate failed")

$vt_expected:=""
$vt_expected:=$vt_expected+"Certificate Request:"+$vt_newLine
$vt_expected:=$vt_expected+"    Data:"+$vt_newLine
$vt_expected:=$vt_expected+"        Version: 0 (0x0)"+$vt_newLine
$vt_expected:=$vt_expected+"        Subject: C=FR, L=Paris, ST=Paris (75), O=Example Inc, OU=Software services/emailAddress=webmaster@www.example.com, CN=example.com"+$vt_newLine
$vt_expected:=$vt_expected+"        Subject Public Key Info:"+$vt_newLine
$vt_expected:=$vt_expected+"            Public Key Algorithm: rsaEncryption"+$vt_newLine
$vt_expected:=$vt_expected+"                Public-Key: (2048 bit)"+$vt_newLine
$vt_expected:=$vt_expected+"                Modulus:"+$vt_newLine
$vt_expected:=$vt_expected+"                    00:ac:91:3f:6e:d4:3a:b0:9e:1b:51:bb:7e:98:45:"+$vt_newLine
$vt_expected:=$vt_expected+"                    ea:44:7e:eb:8d:b8:6b:37:70:31:e7:74:d1:01:ac:"+$vt_newLine
$vt_expected:=$vt_expected+"                    a6:65:af:81:cd:c8:3c:be:2c:90:89:94:12:71:51:"+$vt_newLine
$vt_expected:=$vt_expected+"                    e8:99:b8:86:e2:a8:aa:33:4d:a9:17:94:b3:38:8c:"+$vt_newLine
$vt_expected:=$vt_expected+"                    5d:8c:1e:ad:1b:a6:24:d4:56:98:2d:99:46:32:27:"+$vt_newLine
$vt_expected:=$vt_expected+"                    32:cf:5d:89:b5:11:4d:86:27:21:ef:e3:db:9c:11:"+$vt_newLine
$vt_expected:=$vt_expected+"                    23:89:50:3c:55:db:5d:d1:fd:51:ba:19:a6:9f:e2:"+$vt_newLine
$vt_expected:=$vt_expected+"                    74:cf:a3:49:92:ce:cc:5f:4a:78:03:9f:46:ea:ab:"+$vt_newLine
$vt_expected:=$vt_expected+"                    fe:08:67:18:bb:e2:c4:d9:10:59:25:0c:dd:91:c6:"+$vt_newLine
$vt_expected:=$vt_expected+"                    91:c9:f1:5b:e0:0c:75:13:50:6c:20:68:70:25:d7:"+$vt_newLine
$vt_expected:=$vt_expected+"                    9d:ba:5f:ec:36:51:2d:5d:33:23:5c:04:07:15:7d:"+$vt_newLine
$vt_expected:=$vt_expected+"                    f7:76:48:10:6e:87:95:bd:2c:dd:60:29:e0:41:57:"+$vt_newLine
$vt_expected:=$vt_expected+"                    f5:00:4d:eb:ea:d8:62:47:5f:7f:c2:2f:09:e1:cd:"+$vt_newLine
$vt_expected:=$vt_expected+"                    34:4c:86:b4:1e:17:a8:9d:ba:83:b1:15:dd:e8:7d:"+$vt_newLine
$vt_expected:=$vt_expected+"                    9b:77:be:79:75:cb:8a:c5:ca:f2:5b:8a:b5:5e:07:"+$vt_newLine
$vt_expected:=$vt_expected+"                    73:6c:22:06:cb:90:bb:8d:49:72:01:d8:1a:1f:76:"+$vt_newLine
$vt_expected:=$vt_expected+"                    33:0b:ee:01:9b:c6:1e:dc:da:6d:27:45:35:c4:f0:"+$vt_newLine
$vt_expected:=$vt_expected+"                    4c:61"+$vt_newLine
$vt_expected:=$vt_expected+"                Exponent: 65537 (0x10001)"+$vt_newLine
$vt_expected:=$vt_expected+"        Attributes:"+$vt_newLine
$vt_expected:=$vt_expected+"        Requested Extensions:"+$vt_newLine
$vt_expected:=$vt_expected+"            X509v3 Subject Alternative Name: "+$vt_newLine
$vt_expected:=$vt_expected+"                DNS:www.example.com, DNS:staging.example.com"+$vt_newLine
$vt_expected:=$vt_expected+"    Signature Algorithm: sha256WithRSAEncryption"+$vt_newLine
$vt_expected:=$vt_expected+"         3d:5d:da:06:9d:77:dc:60:ee:5a:94:16:12:16:c4:c5:e7:63:"+$vt_newLine
$vt_expected:=$vt_expected+"         c9:bd:18:9c:fa:92:9b:09:6e:1a:7d:f0:5c:2b:d0:2a:f5:68:"+$vt_newLine
$vt_expected:=$vt_expected+"         0b:7c:de:0b:0e:e9:ed:48:fa:da:90:91:f0:d7:15:d8:8f:13:"+$vt_newLine
$vt_expected:=$vt_expected+"         a5:b8:1d:f1:9e:61:98:f3:26:4d:ce:71:2a:0d:cb:b6:a4:8d:"+$vt_newLine
$vt_expected:=$vt_expected+"         4f:98:95:38:19:53:59:f9:cf:1f:f7:75:6b:9e:4b:e4:10:25:"+$vt_newLine
$vt_expected:=$vt_expected+"         df:01:c9:80:17:3a:ab:bd:72:45:3c:e8:fd:c5:13:f2:bf:2a:"+$vt_newLine
$vt_expected:=$vt_expected+"         6a:3f:2f:b1:1f:57:21:39:56:58:8d:c2:4e:fa:6d:26:52:f1:"+$vt_newLine
$vt_expected:=$vt_expected+"         6b:a2:b5:e1:25:1b:ca:d3:81:89:2e:a3:bc:a3:7e:fd:71:29:"+$vt_newLine
$vt_expected:=$vt_expected+"         5a:94:2a:8c:6a:fe:76:85:c7:be:7b:91:06:6e:15:ea:f2:32:"+$vt_newLine
$vt_expected:=$vt_expected+"         69:03:78:93:30:3d:55:ba:02:4e:ee:42:64:93:d7:39:6a:7d:"+$vt_newLine
$vt_expected:=$vt_expected+"         7c:34:97:92:e8:b0:0b:46:b6:29:92:62:a7:bd:c3:43:d0:d3:"+$vt_newLine
$vt_expected:=$vt_expected+"         8c:f9:1e:5e:da:c4:dd:22:2d:bb:88:88:06:dd:86:a7:7e:a7:"+$vt_newLine
$vt_expected:=$vt_expected+"         f4:25:1f:8b:10:69:a4:94:01:6e:14:3b:19:da:cc:f6:5f:fb:"+$vt_newLine
$vt_expected:=$vt_expected+"         a8:8f:6a:20:92:02:8e:5a:3d:cd:bf:10:c1:9d:5c:97:8d:ba:"+$vt_newLine
$vt_expected:=$vt_expected+"         9a:61:c6:8c"+$vt_newLine
$vt_actual:=acme__opensslCsrToText (->$vx_csr)
ASSERT:C1129($vt_expected=$vt_actual;"openssl get private key exponent failed")
If (False:C215)
	  //%T-
	SET TEXT TO PASTEBOARD:C523($vt_actual+"\r"+$vt_expected)
	  //%T+
End if 

If (True:C214)
	C_TEXT:C284($vt_csrDerPath;$vt_csrPemPath)
	$vt_csrDerPath:=Get 4D folder:C485(Current resources folder:K5:16)+"testcases"+Folder separator:K24:12+"certificate"+Folder separator:K24:12+"csr.der"
	
	$vt_csrPemPath:=Get 4D folder:C485(Current resources folder:K5:16)+"testcases"+Folder separator:K24:12+"certificate"+Folder separator:K24:12+"csr.pem"
	
	C_TEXT:C284($vt_csr;$vt_csrExpected)
	DOCUMENT TO BLOB:C525($vt_csrDerPath;$vx_csr)
	
	$vt_csrExpected:=Document to text:C1236($vt_csrPemPath;"us-ascii";Document with LF:K24:22)
	acme__opensslCsrConvertFormat (->$vx_csr;->$vt_csr)
	
	ASSERT:C1129($vt_csrExpected=$vt_csr)
End if 

If (True:C214)
	C_BLOB:C604($vx_modulus)
	C_TEXT:C284($vt_expectedModulusMd5)
	$vt_expectedModulusMd5:="bd7e615e7f8f270fdfcf1e1bdbd4ea07"
	
	C_TEXT:C284($vt_dirPath)
	$vt_dirPath:=Get 4D folder:C485(Current resources folder:K5:16)+"testcases"+Folder separator:K24:12+"certificate"+Folder separator:K24:12
	
	
	C_TEXT:C284($vt_privKey;$vt_privKeyText)
	$vt_privKey:=Document to text:C1236($vt_dirPath+"key.pem";"us-ascii";Document with LF:K24:22)
	$vt_privKeyText:=Document to text:C1236($vt_dirPath+"key.txt";"us-ascii";Document with LF:K24:22)
	$vx_modulus:=acme__opensslModulus ("rsa";->$vt_privKey)
	ASSERT:C1129(Generate digest:C1147($vx_modulus;MD5 digest:K66:1)=$vt_expectedModulusMd5)
	ASSERT:C1129(acme__opensslToText ("rsa";->$vt_privKey)=$vt_privKeyText)
	
	C_TEXT:C284($vt_csrTxt)
	$vt_csrTxt:=Document to text:C1236($vt_dirPath+"csr.txt";"us-ascii";Document with LF:K24:22)
	
	C_BLOB:C604($vx_csr)
	DOCUMENT TO BLOB:C525($vt_dirPath+"csr.der";$vx_csr)
	If (False:C215)
		UTL_textToFile ($vt_dirPath+"csr.txt";acme__opensslToText ("req";->$vx_csr))
	End if 
	$vx_modulus:=acme__opensslModulus ("req";->$vx_csr)
	ASSERT:C1129(Generate digest:C1147($vx_modulus;MD5 digest:K66:1)=$vt_expectedModulusMd5)
	ASSERT:C1129(acme__opensslToText ("req";->$vx_csr)=$vt_csrTxt)
	
	
	C_TEXT:C284($vt_csr)
	$vt_csr:=Document to text:C1236($vt_dirPath+"csr.pem";"us-ascii";Document with LF:K24:22)
	$vx_modulus:=acme__opensslModulus ("req";->$vt_csr)
	ASSERT:C1129(Generate digest:C1147($vx_modulus;MD5 digest:K66:1)=$vt_expectedModulusMd5)
	ASSERT:C1129(acme__opensslToText ("req";->$vt_csr)=$vt_csrTxt)
	
	C_TEXT:C284($vt_cert;$vt_certTxt)
	$vt_cert:=Document to text:C1236($vt_dirPath+"cert.pem";"us-ascii";Document with LF:K24:22)
	If (False:C215)
		UTL_textToFile ($vt_dirPath+"cert.txt";acme__opensslToText ("x509";->$vt_cert))
	End if 
	$vt_certTxt:=Document to text:C1236($vt_dirPath+"cert.txt";"us-ascii";Document with LF:K24:22)
	$vx_modulus:=acme__opensslModulus ("x509";->$vt_cert)
	ASSERT:C1129(Generate digest:C1147($vx_modulus;MD5 digest:K66:1)=$vt_expectedModulusMd5)
	ASSERT:C1129(acme__opensslToText ("x509";->$vt_cert)=$vt_certTxt)
	
End if 
