
C_TEXT:C284($1;$vt_url)
C_TEXT:C284($2;$vt_request)
C_TEXT:C284($3;$vt_clientIp)
C_TEXT:C284($4;$vt_serverIp)
C_TEXT:C284($5;$vt_username)
C_TEXT:C284($6;$vt_password)

ASSERT:C1129(Count parameters:C259>5;"requires 6 parameters")

$vt_url:=$1
$vt_request:=$2
$vt_clientIp:=$3
$vt_serverIp:=$4
$vt_username:=$5
$vt_password:=$6


Case of 
	: (acme_onWebConnection ($vt_url))
		
	Else 
		
End case 
