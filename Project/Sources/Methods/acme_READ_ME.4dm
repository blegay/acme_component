//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_READ_ME
  //@scope : public
  //@deprecated : no
  //@description : documentation
  //@notes : 

  // https://tools.ietf.org/html/rfc8555

  // https://github.com/ietf-wg-acme/acme/blob/master/draft-ietf-acme-acme.md

  //    +-----------------------+--------------------------+----------------+
  //    | Action                | Request                  | Response       |
  //    +-----------------------+--------------------------+----------------+
  //    | Get directory         | GET  directory           | 200            |
  //    |                       |                          |                |
  //    | Get nonce             | HEAD newNonce            | 200            |
  //    |                       |                          |                |
  //    | Create account        | POST newAccount          | 201 -> account |
  //    |                       |                          |                |
  //    | Submit order          | POST newOrder            | 201 -> order   |
  //    |                       |                          |                |
  //    | Fetch challenges      | GET  order               | 200            |
  //    |                       | authorizations           |                |
  //    |                       |                          |                |
  //    | Respond to challenges | POST challenge urls      | 200            |
  //    |                       |                          |                |
  //    | Poll for status       | GET  order               | 200            |
  //    |                       |                          |                |
  //    | Finalize order        | POST order finalize      | 200            |
  //    |                       |                          |                |
  //    | Poll for status       | GET  order               | 200            |
  //    |                       |                          |                |
  //    | Download certificate  | GET  order certificate   | 200            |
  //    +-----------------------+--------------------------+----------------+

  //@example : acme_READ_ME
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 23/06/2018, 08:44:58 - 1.00.00
  //@xdoc-end
  //================================================================================



  //  "No Key ID in JWS header" => account was not created (see sample method "cert_accountInit", and call acme_newAccount)
  // 2022-01-26T08:16:41.523Z - acme - 02 - acme_accountObjectGet ==> file "...:letsencrypt:org.letsencrypt.api.acme-v02:_account:account.json" not found. [KO]
  // ...
  // 2022-01-26T08:08:13.577Z - acme - 02 - acme_newOrder ==> url : "https://acme-v02.api.letsencrypt.org/acme/new-order", status : 400, duration : 0,407s, protected : "{
  //     "alg": "RS256",
  //     "jwk": {
  //         "kty": "RSA",
  //         "n": "uS9....Uw",
  //         "e": "A...B"
  //     },
  //     "nonce": "010....K00",
  //     "url": "https://acme-v02.api.letsencrypt.org/acme/new-order"
  // }", payload : "{
  //     "identifiers": [
  //         {
  //             "type": "dns",
  //             "value": "www.example.com"
  //         }
  //     ]
  // }", request body : "{
  //     "protected": "eyJ...iJ9",
  //     "payload": "eyJ...V19",
  //     "signature": "VRW...7WQ"
  // }", response body : "{
  //   "type": "urn:ietf:params:acme:error:malformed",
  //   "detail": "No Key ID in JWS header",
  //   "status": 400
  // }". [KO]

