#include "prelude.ch"

/**
 * Implements LIFO concept (last-in, first-out), where the first item to enter
 * is the last item to leave.
 * @package DataStructures
 */
Class Stack From Collection
  /**
   * Holds a native array with the AdvPL representation of the data.
   * @member aValue
   */
  Data aValue

  Method New( aData ) Constructor
  Method Push( xData )
  Method Pop()
  Method Peek()
EndClass

/**
 * Initializes a stack. If the passed data is an array, it is the start value
 * of the stack and it keeps unmodified. When no data or *Nil* data is passed
 * to the stack, an empty stack is initialized. Otherwise, throw an exception.
 * @constructor
 * @author Marcelo Camargo
 * @throws UserException
 * @param aData :: Array<any>
 * @return Stack
 */
Method New( aData ) Class Stack
  If ValType( aData ) == "A"
    ::aValue := aData
  ElseIf aData == Nil
    ::aValue := { }
  Else
    UserException("")
  EndIf
  Return Self

/**
 * Append an element to the stack. A new space is created in the memory and the
 * item is natively put there.
 * @author Marcelo Camargo
 * @param xData :: any
 * @return (typeof xData)
 */
Method Push( xData ) Class Stack
  aAdd( ::aValue, xData )
  Return xData

/**
 * Takes the item in the top of the stack, removing and returning it.
 * @author Marcelo Camargo
 * @return any
 */
Method Pop() Class Stack
  Local nSize := Len( ::aValue )
  Local xLast := Nil

  If nSize > 0
    xLast := ::aValue[ nSize ]
    aSize( ::aValue, nSize - 1 )
  EndIf
  Return xLast

/**
 * Works like Pop, but takes an element without removing it. Returns Nil
 * when no element is found.
 * @author Marcelo Camargo
 * @return any
 */
Method Peek() Class Stack
  Local nSize := Len( ::aValue )
  Local xRet  := Nil

  If nSize > 0
    xRet := ::aValue[ nSize ]
  EndIf
  Return xRet
