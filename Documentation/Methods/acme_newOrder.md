# **Method :** acme_newOrder
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function sends the order to letsencrypt
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if OK, FALSE otherwise | 
| $1 | IN | newOrderObject | OBJECT | new order object (see acme_newOrderObject) | 
| $2 | OUT | orderId | POINTER | orderId (modified) | 
| $3 | OUT | orderObjectPtr | POINTER | order object, this object will be created (modified) | 

## **Notes :** 

## **Example :** 
```

       TABLEAU OBJET($to_identifiers;0)
       AJOUTER À TABLEAU($to_identifiers;acme_identifierObjectNew ("dns";"test.example.com"))
       AJOUTER À TABLEAU($to_identifiers;acme_identifierObjectNew ("dns";"test1.example.com"))
       AJOUTER À TABLEAU($to_identifiers;acme_identifierObjectNew ("dns";"test2.example.com"))
       AJOUTER À TABLEAU($to_identifiers;acme_identifierObjectNew ("dns";"test3.example.com"))
      
      C_TEXT($vt_directoryUrl)
        //$vt_directoryUrl:="https://acme-v02.api.letsencrypt.org/directory"
      $vt_directoryUrl:="https://acme-staging-v02.api.letsencrypt.org/directory"
      
      C_TEXT($vt_workingDir)
      $vt_workingDir:=FS_pathToParent (Get 4D Folder(Database folder))
      
      TABLEAU TEXTE($tt_domain;0)
      AJOUTER À TABLEAU($tt_domain;"test.example.com")
      AJOUTER À TABLEAU($tt_domain;"test1.example.com")
      AJOUTER À TABLEAU($tt_domain;"test2.example.com")
      AJOUTER À TABLEAU($tt_domain;"test3.example.com")
      
      C_OBJECT($vo_newOrderObject)
      $vo_newOrderObject:=acme_newOrderObject (->$tt_domain;$vt_workingDir;$vt_directoryUrl)
      
      C_TEXT($vt_id)
      C_OBJECT($vo_order)
      If(acme_newOrder ($vo_newOrderObject;->$vt_id;->$vo_order))
      
      End if
      
       {
           "status": "pending",
           "expires": "2018-07-05T16:15:24Z",
           "identifiers": [
               {
                   "type": "dns",
                   "value": "test.example.com"
               },
               {
                   "type": "dns",
                   "value": "test1.example.com"
               },
               {
                   "type": "dns",
                   "value": "test2.example.com"
               },
               {
                   "type": "dns",
                   "value": "test3.example.com"
               }
           ],
           "authorizations": [
               "https://acme-staging-v02.api.letsencrypt.org/acme/authz/n...k",
               "https://acme-staging-v02.api.letsencrypt.org/acme/authz/x...M",
               "https://acme-staging-v02.api.letsencrypt.org/acme/authz/J...U",
               "https://acme-staging-v02.api.letsencrypt.org/acme/authz/m...o"
           ],
           "finalize": "https://acme-staging-v02.api.letsencrypt.org/acme/finalize/12345/6789"
       }
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
       CREATION : Bruno LEGAY (BLE) - 23/06/2018, 21:22:28 - 1.00.00
