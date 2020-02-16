//%attributes = {"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : acme_digestFile
  //@scope : public
  //@deprecated : no
  //@description : This function returns to generate a digest on a file using the component openssl library
  //@parameter[0-OUT-digest-TEXT] : digest (in hex fomrat e.g. "d0ccab71ae6185d36f0705b88d4ac681")
  //@parameter[1-IN-filepath-TEXT] : file path
  //@parameter[2-IN-digestAlg-TEXT] : digest algorithm (optional, default "md5")
  //@notes : 
  // can compress large files without having to load them in a blob
  //
  // uses openssl 
  //
  // digestAlg :
  //  - gost-mac       to use the gost-mac message digest algorithm
  //  - md_gost94      to use the md_gost94 message digest algorithm
  //  - md4            to use the md4 message digest algorithm
  //  - md5            to use the md5 message digest algorithm
  //  - mdc2           to use the mdc2 message digest algorithm
  //  - ripemd160      to use the ripemd160 message digest algorithm
  //  - sha            to use the sha message digest algorithm
  //  - sha1           to use the sha1 message digest algorithm
  //  - sha224         to use the sha224 message digest algorithm
  //  - sha256         to use the sha256 message digest algorithm
  //  - sha384         to use the sha384 message digest algorithm
  //  - sha512         to use the sha512 message digest algorithm
  //  - whirlpool      to use the whirlpool message digest algorithm
  // 
  //@example : acme_digestFile
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 28/02/2019, 11:51:57 - 0.90.02
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_digest)
C_TEXT:C284($1;$vt_filepath)
C_TEXT:C284($1;$vt_alg)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
ASSERT:C1129(Test path name:C476($1)=Is a document:K24:1;"file \""+$1+"\" not found")

$vt_digest:=""
$vt_filepath:=$1

If (Count parameters:C259>1)
	$vt_alg:=$2
	$vt_alg:=Lowercase:C14($vt_alg)
Else 
	$vt_alg:=""
End if 

  // gost-mac       to use the gost-mac message digest algorithm
  // md_gost94      to use the md_gost94 message digest algorithm
  // md4            to use the md4 message digest algorithm
  // md5            to use the md5 message digest algorithm
  // mdc2           to use the mdc2 message digest algorithm
  // ripemd160      to use the ripemd160 message digest algorithm
  // sha            to use the sha message digest algorithm
  // sha1           to use the sha1 message digest algorithm
  // sha224         to use the sha224 message digest algorithm
  // sha256         to use the sha256 message digest algorithm
  // sha384         to use the sha384 message digest algorithm
  // sha512         to use the sha512 message digest algorithm
  // whirlpool      to use the whirlpool message digest algorithm

Case of 
	: ($vt_alg="gost-mac")
	: ($vt_alg="md_gost94")
	: ($vt_alg="md4")
	: ($vt_alg="md5")
	: ($vt_alg="mdc2")
	: ($vt_alg="ripemd160")
	: ($vt_alg="sha")
	: ($vt_alg="sha1")
	: ($vt_alg="sha224")
	: ($vt_alg="sha256")
	: ($vt_alg="sha384")
	: ($vt_alg="sha512")
	: ($vt_alg="whirlpool")
	Else 
		$vt_alg:="md5"
End case 


C_TEXT:C284($vt_filepathPosix)
$vt_filepathPosix:=UTL_pathToPosixConvert ($vt_filepath)

C_TEXT:C284($vt_args;$vt_in;$vt_out;$vt_err)
$vt_args:="dgst -"+$vt_alg+" -hex "+$vt_filepathPosix
$vt_in:=""
$vt_out:=""
$vt_err:=""

C_TEXT:C284($vt_err)
If (acme__openSslCmd ($vt_args;->$vt_in;->$vt_out;->$vt_err))
	
	  //"MD5(/Volumes/.../file.jpg)= d0cc...81"
	
	If (Length:C16($vt_out)>0)
		C_TEXT:C284($vt_regex)
		$vt_regex:="(?mi)^.*=\\s([0-9a-f]+)\\s*$"
		
		C_LONGINT:C283($vl_start)
		ARRAY LONGINT:C221($tl_pos;0)
		ARRAY LONGINT:C221($tl_len;0)
		$vl_start:=1
		
		If (Match regex:C1019($vt_regex;$vt_out;1;$tl_pos;$tl_len))
			$vt_digest:=Substring:C12($vt_out;$tl_pos{1};$tl_len{1})
		End if 
		
	End if 
End if 

$0:=$vt_digest