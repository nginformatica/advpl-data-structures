#include "protheus.ch"

/**
 * Implements FIFO concept (first-in, first-out). The first element to enter
 * the queue is the first element to leave it.
 * @package DataStructures
 */
Class Queue From Collection
  /**
   * Holds a native array with the AdvPL representation of the data.
   * @member aValue
   */
  Data aValue

  Method New( aData ) Constructor
  Method Enqueue( xData )
  Method Dequeue()
  Method Peek()
EndClass

/**
 * Initializes a queue. If the passed data is an array, it is the start value
 * of the queue and it keeps unmodified. When no data or *Nil* data is passed
 * to the queue, an empty queue is initialized. Otherwise, throw an exception.
 * @constructor
 * @author Marcelo Camargo
 * @throws UserException
 * @param aData :: Array<any>
 * @return Queue
 */
Method New( aData ) Class Queue
  If ValType( aData ) == "A"
    ::aValue := aData
  ElseIf aData == Nil
    ::aValue := { }
  Else
    UserException("")
  EndIf
  Return Self

/**
 * Append an element to the *END* of the queue. A new space is created in the
 * memory and the item is natively put there.
 * @author Marcelo Camargo
 * @param xData :: any
 * @return (typeof xData)
 */
Method Enqueue( xData ) Class Queue
  aAdd( ::aValue, xData )
  Return xData

/**
 * The first element to enter is the first element to leave. Takes the element
 * from the queue and returns it.
 * @author Marcelo Camargo
 * @return any
 */
Method Dequeue() Class Queue
  Local nSize := Len( ::aValue )
  Local xRet  := Nil

  // When there are items on the queue
  If nSize > 0
    // Peek the first element
    xRet := ::aValue[ 1 ]
    // Throw out the first element and pull all items 1 level behind
    aDel( ::aValue, 1 )
    // Free space in memory by one position
    aSize( ::aValue, nSize - 1 )
  EndIf
  Return xRet

/**
 * Works like Dequeue, but takes an element without removing it. Returns Nil
 * when no element is found.
 * @author Marcelo Camargo
 * @return any
 */
Method Peek() Class Queue
  Local xRet := Nil

  If Len( ::aValue ) > 0
    xRet := ::aValue[ 1 ]
  EndIf
  Return xRet
