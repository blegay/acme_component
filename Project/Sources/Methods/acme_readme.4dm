//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_readme
  //@scope : public
  //@deprecated : no
  //@description : 
  //@notes : 
  //@example : acme_readme
  //@see : 
  // https://letsencrypt.org/docs/acme-protocol-updates/
  // https://tools.ietf.org/html/draft-ietf-acme-acme-12
  // https://tools.ietf.org/html/rfc7638
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2018
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 28/06/2018, 17:28:09 - 1.0
  //@xdoc-end
  //================================================================================


  // 
  //          Client                                                   Server
  // 
  //          Order
  //          Signature                     ------->
  //                                        <-------  Required Authorizations
  // 
  //          Responses
  //          Signature                     ------->
  // 
  //                              <~~~~~~~~Validation~~~~~~~~>
  // 
  //          CSR
  //          Signature                     ------->
  // 
  //                              <~~~~~~Await issuance~~~~~~>
  // 
  //                                        <-------             Certificate
  // 
  // 
  //          Revocation request
  //          Signature                    -------->
  // 
  //                                       <--------                 Result


