# **Method :** acme_certToText
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns text data about a private key, a csr, or certificate in PEM or DER format
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | text | TEXT | text | 
| $1 | IN | sourcePtr | POINTER | source pointer (private key, csr, or certificate in PEM or DER format) (not modified) | 
| $2 | IN | param | TEXT | "text", "startdate", "enddate" (optional, default "text") | 
| $3 | IN | inform | TEXT | "PEM" or "DER" (optional, default "PEM" if $2 is text, "DER" if $2 is blob) | 

## **Notes :** 

       "startdate" => "notBefore=Jan 23 19:15:40 2019 GMT\n"
       "enddate" => "notAfter=Jan 20 19:15:40 2029 GMT\n"
       "text" =>
           Certificate:
               Data:
                   Version: 1 (0x0)
                   Serial Number:
                       9e:df:23:80:9f:8d:b7:0b
               Signature Algorithm: sha256WithRSAEncryption
                   Issuer: C=FR, L=Paris, ST=Paris (75), O=AC Consulting, OU=AC Consulting/emailAddress=john@example.com, CN=www.example.com
                   Validity
                       Not Before: Jan 23 19:15:40 2019 GMT
                       Not After : Jan 20 19:15:40 2029 GMT
                   Subject: C=FR, L=Paris, ST=Paris (75), O=AC Consulting, OU=AC Consulting/emailAddress=john@example.com, CN=www.example.com
                   Subject Public Key Info:
                       Public Key Algorithm: rsaEncryption
                           Public-Key: (2048 bit)
                           Modulus:
                               00:c4:0a:31:62:5f:a3:af:98:d5:61:87:00:50:7e:
                               .......
                               62:64:89:56:cd:be:4c:a7:ce:d3:7d:6d:3e:8b:0a:
                               73:d7
                           Exponent: 65537 (0x10001)
               Signature Algorithm: sha256WithRSAEncryption
                    a7:cd:27:50:f8:b9:ea:2f:91:57:7f:97:f2:95:3d:fa:df:d0:
                    .......
                    c3:b9:94:e3:d9:fd:b3:dc:25:6d:04:86:3f:87:c8:93:3c:3c:
                    ea:0e:54:24
## **Example :** 
```

       If (acme_certCurrentGet (->$vt_key;->$vt_cert))
         C_OBJECT($vo_certificateProperties)
         OB SET($vo_certificateProperties;"text";acme_certToText (->$vt_cert;"text"))
         OB SET($vo_certificateProperties;"dates";acme_certToText (->$vt_cert;"dates"))
         OB SET($vo_certificateProperties;"startdate";acme_certToText (->$vt_cert;"startdate"))
         OB SET($vo_certificateProperties;"enddate";acme_certToText (->$vt_cert;"enddate"))
         OB SET($vo_certificateProperties;"serial";acme_certToText (->$vt_cert;"serial"))
         OB SET($vo_certificateProperties;"hash";acme_certToText (->$vt_cert;"hash"))
         OB SET($vo_certificateProperties;"subject_hash";acme_certToText (->$vt_cert;"subject_hash"))
         OB SET($vo_certificateProperties;"issuer_hash";acme_certToText (->$vt_cert;"issuer_hash"))
         OB SET($vo_certificateProperties;"subject";acme_certToText (->$vt_cert;"subject"))
         OB SET($vo_certificateProperties;"issuer";acme_certToText (->$vt_cert;"issuer"))
         OB SET($vo_certificateProperties;"email";acme_certToText (->$vt_cert;"email"))
         OB SET($vo_certificateProperties;"purpose";acme_certToText (->$vt_cert;"purpose"))
         OB SET($vo_certificateProperties;"modulus";acme_certToText (->$vt_cert;"modulus"))
         OB SET($vo_certificateProperties;"fingerprint";acme_certToText (->$vt_cert;"fingerprint"))
         OB SET($vo_certificateProperties;"ocspid";acme_certToText (->$vt_cert;"ocspid"))
         OB SET($vo_certificateProperties;"ocsp_uri";acme_certToText (->$vt_cert;"ocsp_uri"))
         OB SET($vo_certificateProperties;"pubkey";acme_certToText (->$vt_cert;"pubkey"))
         OB SET($vo_certificateProperties;"alias";acme_certToText (->$vt_cert;"alias"))
       End if
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
## **History :** 

        CREATION : Bruno LEGAY (BLE) - 23/01/2019, 22:35:47 - 1.00.00
