/**
 * Maybe monad implemenation. Takes a value and is able to return Just _ or
 * Nothing.
 * @package DataStructures
 */
Class Maybe
  Method New( xVal ) Constructor
EndClass

/**
 * Receives a value. If the value is nil, returns Nothing. Otherwise, returns
 * the value wrapped by a Just container. When it receives an instance of an
 * object of the same class, returns itself.
 * @constructor
 * @author Marcelo Camargo
 * @param xVal :: any
 * @return Just _ | Nothing
 */
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
