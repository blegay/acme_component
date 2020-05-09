//%attributes = {"invisible":true,"preemptive":"capable","shared":false}


ASSERT:C1129(TXT_lineSepGet ("a\r")="\r")
ASSERT:C1129(TXT_lineSepGet ("a\r\n")="\r\n")
ASSERT:C1129(TXT_lineSepGet ("a\n\r\n")="\n")
ASSERT:C1129(TXT_lineSepGet ("\n\r\n")="\n")
ASSERT:C1129(TXT_lineSepGet ("\r\r\n")="\r")
ASSERT:C1129(TXT_lineSepGet ("\r\n\n")="\r\n")

ASSERT:C1129(TXT_lineSepGet ("bruno\n\r\n")="\n")
ASSERT:C1129(TXT_lineSepGet ("bruno\r\r\n")="\r")
ASSERT:C1129(TXT_lineSepGet ("bruno\r\n\n")="\r\n")


ASSERT:C1129(TXT_lineSepGet ("bruno\n")="\n")
ASSERT:C1129(TXT_lineSepGet ("bruno\r")="\r")
ASSERT:C1129(TXT_lineSepGet ("bruno\r\n")="\r\n")

ASSERT:C1129(TXT_lineSepGet ("bruno";"\n")="\n")
ASSERT:C1129(TXT_lineSepGet ("bruno";"\r")="\r")
ASSERT:C1129(TXT_lineSepGet ("bruno";"\r\n")="\r\n")