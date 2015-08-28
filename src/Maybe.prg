#include "protheus.ch"
#xtranslate \<<obj>\> => <obj>():New

// Maybe
Class Maybe
  Method New( xVal ) Constructor
EndClass

Method New( xVal ) Class Maybe
  Local cType := ValType( xVal )
  Local oRet

  If cType == "O" .And. GetClassName( xVal ) == "Maybe"
    oRet := xVal
  ElseIf cType == "U"
    oRet := Nothing():New()
  Else
    oRet := Just():New( xVal )
  EndIf
  Return oRet

// Nothing
Class Nothing
  Method New() Constructor
  Method Bind( bFunc )
  Method FromJust()
  Method FromMaybe( xDef )
  Method IsJust()
  Method IsNothing()
  Method Maybe( xDef, bFunc )
  Method ToList()
EndClass

Method New() Class Nothing
  Return Self

Method Bind( _ ) Class Nothing
  Return Self

Method FromJust() Class Nothing
  UserException( "Cannot call FromJust() on Nothing" )
  Return Nil

Method FromMaybe( xDef ) Class Nothing
  Return xDef

Method IsJust() Class Nothing
  Return .F.

Method IsNothing() Class Nothing
  Return .T.

Method Maybe( xDef, _ ) Class Nothing
  Return xDef

Method ToList()
  Return { }

// Just
Class Just
  Data xValue

  Method New( xVal ) Constructor
  Method Bind( bFunc )
  Method FromJust()
  Method FromMaybe( xDef )
  Method IsJust()
  Method IsNothing()
  Method Maybe( xDef, bFunc )
  Method ToList()
EndClass

Method New( xVal ) Class Just
  ::xValue := xVal

Method Bind( bFunc ) Class Just
  Return Maybe:New( Eval( bFunc, ::xValue ) )

Method FromJust() Class Just
  Return ::xValue

Method FromMaybe( _ ) Class Just
  Return ::xValue

Method IsJust() Class Just
  Return .T.

Method IsNothing() Class Just
  Return .F.

Method Maybe( _, bFunc ) Class Just
  Return Eval( bFunc, ::xValue )

Method ToList() Class Just
  Return { ::xValue }
