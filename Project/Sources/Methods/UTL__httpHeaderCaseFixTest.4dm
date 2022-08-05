//%attributes = {"shared":false,"invisible":true}
C_OBJECT:C1216($vo_headers)

$vo_headers:=New object:C1471
$vo_headers.first:=""
$vo_headers.location:=""
$vo_headers.last:=""
ASSERT:C1129(TXT_isEqualStrict (UTL__httpHeaderCaseFix ($vo_headers;"Location");"location"))


$vo_headers:=New object:C1471
$vo_headers.first:=""
$vo_headers.Location:=""
$vo_headers.last:=""
ASSERT:C1129(TXT_isEqualStrict (UTL__httpHeaderCaseFix ($vo_headers;"Location");"Location"))

$vo_headers:=New object:C1471
$vo_headers.first:=""
$vo_headers.location:=""
$vo_headers.last:=""
ASSERT:C1129(TXT_isEqualStrict (UTL__httpHeaderCaseFix ($vo_headers;"location");"location"))

C_OBJECT:C1216($vo_headers)
$vo_headers:=New object:C1471
$vo_headers.first:=""
$vo_headers.Location:=""
$vo_headers.last:=""
ASSERT:C1129(TXT_isEqualStrict (UTL__httpHeaderCaseFix ($vo_headers;"location");"Location"))

