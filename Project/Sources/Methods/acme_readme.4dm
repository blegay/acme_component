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
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
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





  // crypto

  // openssl genrsa   => generate rsa keypair

  // openssl rsa => get private key publicExponent (for acme__jwkThumbprint)
  // openssl rsa => get private key Modulus (for acme__jwkThumbprint)

  // openssl x509 => display human format for x509 certificates (get all or part and chain)
  // openssl x509 -checkend => check if certificate is valid (dates)

  // openssl csr => convert from DER to PEM, generate a new CSR (with alt_names), make CSR human readable -
  // openssl csr => create self signed certificates

  // openssl dgst -sha256  => generate a SHA256 digest
  // openssl dgst -sha256 -sign => sign a text with a private key (sha256)


  // 2022-01-27T21:33:49.535Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce"...
  // 2022-01-27T21:33:49.949Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce", status : 200

  // 2022-01-27T21:33:49.971Z - acme - 06 - acme_newAccount ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-acct"...
  // 2022-01-27T21:33:50.387Z - acme - 06 - acme_newAccount ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-acct", status : 201

  // 2022-01-27T21:33:51.080Z - acme - 06 - acme_newOrder ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-order"...
  // 2022-01-27T21:33:51.503Z - acme - 06 - acme_newOrder ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-order", status : 201

  // 2022-01-27T21:33:51.517Z - acme - 06 - acme_orderGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/order/42031288/1646246768"...
  // 2022-01-27T21:33:51.935Z - acme - 06 - acme_orderGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/order/42031288/1646246768", status : 200

  // 2022-01-27T21:33:52.500Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce"...
  // 2022-01-27T21:33:52.909Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce", status : 200

  // 2022-01-27T21:33:52.919Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398"...
  // 2022-01-27T21:33:53.343Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398", status : 200

  // 2022-01-27T21:33:53.780Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce"...
  // 2022-01-27T21:33:54.194Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce", status : 200
  // 
  // 2022-01-27T21:33:54.202Z - acme - 06 - acme__challengeRequest ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/chall-v3/1539742398/-42nrg"...
  // 2022-01-27T21:33:54.620Z - acme - 06 - acme__challengeRequest ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/chall-v3/1539742398/-42nrg", status : 200
  // 
  // 2022-01-27T21:33:54.676Z - acme - 04 - acme_onWebConnection ==> GET url : "/.well-known/acme-challenge/aXcRgN_ObjFHtHTRXEBJ7rzSPVdA6YNQ2NWVRnvbaJU", host : "test-acme-m1.ac-consulting.fr", ssl : false
  // 2022-01-27T21:33:54.673Z - acme - 04 - acme_onWebConnection ==> sending challenge "aXcRgN_ObjFHtHTRXEBJ7rzSPVdA6YNQ2NWVRnvbaJU-e406baeebc204a9975c8951b76e79368.txt" : 87 bytes
  // 
  // 3.67.34.92 - - [27/Jan/2022:21:33:54 +0100] "GET /.well-known/acme-challenge/aXcRgN_ObjFHtHTRXEBJ7rzSPVdA6YNQ2NWVRnvbaJU HTTP/1.1" 200 87
  // 
  // 2022-01-27T21:33:54.628Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398"...
  // 2022-01-27T21:33:55.038Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398", status : 200
  // 
  // 2022-01-27T21:33:55.322Z - acme - 04 - acme_onWebConnection ==> GET url : "/.well-known/acme-challenge/aXcRgN_ObjFHtHTRXEBJ7rzSPVdA6YNQ2NWVRnvbaJU", host : "test-acme-m1.ac-consulting.fr", ssl : false
  // 2022-01-27T21:33:55.317Z - acme - 04 - acme_onWebConnection ==> sending challenge "aXcRgN_ObjFHtHTRXEBJ7rzSPVdA6YNQ2NWVRnvbaJU-e406baeebc204a9975c8951b76e79368.txt" : 87 bytes
  // 
  // 66.133.109.36 - - [27/Jan/2022:21:33:55 +0100] "GET /.well-known/acme-challenge/aXcRgN_ObjFHtHTRXEBJ7rzSPVdA6YNQ2NWVRnvbaJU HTTP/1.1" 200 87
  // 
  // 2022-01-27T21:33:56.449Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce"...
  // 2022-01-27T21:33:56.860Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce", status : 200

  // 2022-01-27T21:33:56.871Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398"...
  // 2022-01-27T21:33:57.292Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398", status : 200
  // 
  // 2022-01-27T21:33:58.693Z - acme - 04 - acme_onWebConnection ==> GET url : "/.well-known/acme-challenge/aXcRgN_ObjFHtHTRXEBJ7rzSPVdA6YNQ2NWVRnvbaJU", host : "test-acme-m1.ac-consulting.fr", ssl : false
  // 2022-01-27T21:33:58.689Z - acme - 04 - acme_onWebConnection ==> sending challenge "aXcRgN_ObjFHtHTRXEBJ7rzSPVdA6YNQ2NWVRnvbaJU-e406baeebc204a9975c8951b76e79368.txt" : 87 bytes
  // 
  // 18.236.228.243 - - [27/Jan/2022:21:33:58 +0100] "GET /.well-known/acme-challenge/aXcRgN_ObjFHtHTRXEBJ7rzSPVdA6YNQ2NWVRnvbaJU HTTP/1.1" 200 87
  // 
  // 2022-01-27T21:33:58.716Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce"...
  // 2022-01-27T21:33:59.130Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce", status : 200

  // 2022-01-27T21:33:59.143Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398"...
  // 2022-01-27T21:33:59.563Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398", status : 200

  // 2022-01-27T21:34:00.968Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce"...
  // 2022-01-27T21:34:01.369Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce", status : 200

  // 2022-01-27T21:34:01.379Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398"...
  // 2022-01-27T21:34:01.794Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398", status : 200

  // 2022-01-27T21:34:03.198Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce"...
  // 2022-01-27T21:34:03.609Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce", status : 200

  // 2022-01-27T21:34:03.619Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398"...
  // 2022-01-27T21:34:04.046Z - acme - 06 - acme_authorizationGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/authz-v3/1539742398", status : 200

  // 2022-01-27T21:34:04.479Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce"...
  // 2022-01-27T21:34:04.896Z - acme - 06 - acme__nonceGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/new-nonce", status : 200

  // 2022-01-27T21:34:04.905Z - acme - 06 - acme_orderFinalize ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/finalize/42031288/1646246768"...
  // 2022-01-27T21:34:05.943Z - acme - 06 - acme_orderFinalize ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/finalize/42031288/1646246768", status : 200

  // 2022-01-27T21:34:05.959Z - acme - 06 - acme_certificateGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/cert/fabdfee3405b4f95f85b7883a302ed48a9d3"...
  // 2022-01-27T21:34:06.377Z - acme - 06 - acme_certificateGet ==> http request, method : POST, url : "https://acme-staging-v02.api.letsencrypt.org/acme/cert/fabdfee3405b4f95f85b7883a302ed48a9d3", status : 200

