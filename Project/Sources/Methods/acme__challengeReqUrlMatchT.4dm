//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  // acme__challengeReqUrlMatchT 

SET ASSERT ENABLED:C1131(True:C214)


ASSERT:C1129(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0"))
ASSERT:C1129(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/-P9Ukqz_ehOWBxaB3H-StJVwWmvHVadfW8HA-H1zJIM"))

C_TEXT:C284($vt_token)
ASSERT:C1129(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/-P9Ukqz_ehOWBxaB3H-StJVwWmvHVadfW8HA-H1zJIM";->$vt_token))
ASSERT:C1129($vt_token="-P9Ukqz_ehOWBxaB3H-StJVwWmvHVadfW8HA-H1zJIM")

  //ASSERT(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0="))
  //ASSERT(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0=="))
  //ASSERT(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0==="))
  //ASSERT(Non(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0====")))
ASSERT:C1129(Not:C34(acme__challengeReqUrlMatch ("/.WELL-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0")))
ASSERT:C1129(Not:C34(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0$")))


ASSERT:C1129(acme__challengeReqUrlMatch (".well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0"))
ASSERT:C1129(acme__challengeReqUrlMatch (".well-known/acme-challenge/-P9Ukqz_ehOWBxaB3H-StJVwWmvHVadfW8HA-H1zJIM"))

  //ASSERT(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0="))
  //ASSERT(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0=="))
  //ASSERT(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0==="))
  //ASSERT(Non(acme__challengeReqUrlMatch ("/.well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0====")))
ASSERT:C1129(Not:C34(acme__challengeReqUrlMatch (".WELL-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0")))
ASSERT:C1129(Not:C34(acme__challengeReqUrlMatch (".well-known/acme-challenge/LoqXcYV8q5ONbJQxbmR7SCTNo3tiAXDfowyjxAjEuX0$")))



