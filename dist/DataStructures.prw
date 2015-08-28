// The MIT License (MIT)
// 
// Copyright (c) 2015 Marcelo Camargo <marcelocamargo@linuxmail.org>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
#xtranslate \<<obj>\> => <obj>():New
#include "protheus.ch"

/**
 * Base class for all collections that hold a value. In AdvPL, a protected
 * member, this is, a member defined in the parent class is not visible by
 * reflection of the child classes, therefore, each class has not dependency
 * of its parent, and it is there just by contextual and contractual reasons.
 * @package DataStructures
 */
Class Collection
  Data aValue
EndClass

#include "protheus.ch"

/**
 * A Dictionary has a linear complexity and is an optimized structure with no
 * visible cost on access of its elements.
 * @package DataStructures
 */
Class Dictionary
  /**
   * Holds a native hashmap object of AdvPL.
   */
  Data oValue

  Method New( aData ) Constructor
  Method Set( cKey, xValue )
  Method Get( cKey )
  Method Unset( cKey )
  Method Dispose()
EndClass

/**
 * Initializes the dictionary. When an array is supplied, convert it to the
 * dictionary, with access by integer.
 * @constructor
 * @author Marcelo Camargo
 * @throws UserException
 * @param aData :: Array<any>
 * @return Dictionary
 */
Method New( aData ) Class Dictionary
  If ValType( aData ) == "A"
    ::oValue := aToHM( aData )
  ElseIf aData == Nil
    ::oValue := HMNew()
  Else
    UserException( "" )
  EndIf
  Return Self

/**
 * Sets a value or redefine a value in the dictionary.
 * @author Marcelo Camargo
 * @return any
 */
Method Set( cKey, xValue ) Class Dictionary
  Return ::oValue:Set( cKey, xValue )

/**
 * Returns either the value of the key of the dictionary or Nil, in case of
 * no value specified for the key.
 * @author Marcelo Camargo
 * @return any
 */
Method Get( cKey ) Class Dictionary
  Local xOut := Nil
  // A pointer to xOut, where, if exists a value by the key, it is there stored
  // by reference
  ::oValue:Get( cKey, @xOut )
  Return xOut

/**
 * Removes a value of the key of the dictionary, if it exists and frees space
 * in the memory.
 * @author Marcelo Camargo
 * @return any
 */
Method Unset( cKey ) Class Dictionary
  Return ::oValue:Del( cKey )

/**
 * Removes all the dictionary from the memory, freeing space.
 * @author Marcelo Camargo
 * @return any
 */
Method Dispose() Class Dictionary
  Return ::oValue:Clean()

#include "protheus.ch"

/**
 * An optimized structure for linear array access to replace the native array
 * of AdvPL.
 * @package DataStructures
 */
Class List
  Data nSeq
  Data nMax
  Data nSize
  Data oHash

  Method New( nMax ) Constructor
  Method Rewind()
  Method Add( xVal )
  Method Dispose()
  Method Index( n )
  Method Size()
  Method Select( nIndex )
EndClass

/**
 * Initializes a list, where, if the list receives a numeric value different
 * than zero in its constructor, we have a limited size list, otherwise, we
 * have a dynamic allocated data structure.
 * @constructor
 * @author Marcelo Camargo
 * @param nMax :: Integer
 * @return List
 */
Method New( nMax ) Class List
  Default nMax := 0

  ::Rewind()
  ::oHash := HMNew()
  ::nMax  := nMax
  ::nSize := 0
  Return Self

/**
 * Restarts the counter, where the list has its index one-indexed.
 * @author Marcelo Camargo
 * @return Nil
 */
Method Rewind() Class List
  ::nSeq := 1
  Return Nil

/**
 * Returns the size of the list.
 * @author Marcelo Camargo
 * @return Integer
 */
Method Size() Class List
  Return ::nSize

/**
 * Reposition of the counter in a specific index.
 * @author Marcelo Camargo
 * @param nIndex :: Integer
 * @return Integer
 */
Method Select( nIndex ) Class List
  ::nSeq := nIndex
  Return ::nSeq

/**
 * Adds a new value to the list, following the counter, or replace if the
 * counter reaches an existent index.
 * @author Marcelo Camargo
 * @param xVal :: any
 * @throws UserException
 * @return xVal
 */
Method Add( xVal ) Class List
  If ::nMax <> 0 .And. ::nSeq > ::nMax
    UserException( "Exceeded maximum size of array" )
  EndIf
  If ::oHash:Set( ::nSeq, xVal )
    ::nSeq  += 1
    ::nSize += 1
  EndIf
  Return xVal

/**
 * Frees space in the memory after the usage of the list.
 * @author Marcelo Camargo
 * @return Nil
 */
Method Dispose() Class List
  ::oHash:Clean()
  Return Nil

/**
 * Access of an element by index, with linear complexity.
 * @author Marcelo Camargo
 * @param n :: Integer
 * @return any
 */
Method Index( n ) Class List
  Local xResult := Nil
  ::oHash:Get( n, @xResult )
  Return xResult

#include "protheus.ch"

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
