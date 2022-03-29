# **Method :** acme_accountObjectGet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns the account object (from file stored locally)
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | accountObject | OBJECT | account object | 

## **Notes :** 

## **Example :** 
```

        // optional custom pref files storage location
       C_TEXT($vt_baseDir)
       $vt_baseDir:=Get 4D folder(Database folder)
       $vt_baseDirParent:=FS_pathToParent ($vt_baseDir)
       
       acme_workingDirSet ($vt_baseDirParent)
       
        // try to read the account data from the local json file (if it exists)
       C_OBJECT($vo_account)
       $vo_account:=acme_accountObjectGet  
       
       If (OB Is defined($vo_account))  // the account exists (at least a local file exists)
      
         C_TEXT($vt_accountId)
         $vt_accountId:=OB Get($vo_account;"id")
      
       Else // the local file does not exists, lets create the account
         cert_accountCreate
      
          // C_TEXT($vt_contact)
          // $vt_contact:="mailto:me@example.com"
      
          // C_BOOLEAN($vt_termsOfserviceAgreed)
          // $vt_termsOfserviceAgreed:=True
      
          // C_OBJECT($vo_payload)
          // $vo_payload:=acme_newAccountObject (->$vt_contact;$vt_termsOfserviceAgreed)
      
          // acme_newAccount ($vo_payload)
        End if
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 31/07/2019, 16:48:26 - v1.00.00
