//%attributes = {"shared":true,"invisible":false}
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