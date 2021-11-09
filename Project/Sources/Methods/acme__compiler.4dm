//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
  //================================================================================
  //@xdoc-start : en
  //@name : acme__compiler
  //@scope : private
  //@deprecated : no
  //@description : compiler method for interprocess variables
  //@notes :
  //@example : acme__compiler 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 28/06/2019, 20:20:39 - v1.00.00
  //@xdoc-end
  //================================================================================

  //declare the interprocess variable which will indicate if the module had been inited once (interprocess)
  //initialized, used in acme_init
  // C_BOOLEAN(<>vb_ACME_init)

  //declare the interprocess variable which will contain the name of the debug method
  //initialized in acme__initSub
  //used in acme__moduleDebugDateTimeLine
  // C_TEXT(<>vt_ACME_dbgMethodName)

  // C_BOOLEAN(<>vb_ACME_execBitForced)

  // C_TEXT(<>vt_ACME_workingDir;<>vt_ACME_directoryUrl)
