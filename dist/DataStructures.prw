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

/**
 * Algebraic representation of a wrapped value.
 * @package DataStructures
 */
Class Just
  /**
   * Holder for the value.
   */
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

/**
 * Instantiates a Nothing representation.
 * @constructor
 * @author Marcelo Camargo
 * @param xVal :: any
 * @return Just
 */
Method New( xVal ) Class Just
  ::xValue := xVal
  Return Self

/**
 * Equivalent to Haskell's `>>=` operator. Its first argument is a value in
 * a monadic type, its second argument is a function that maps from the
 * underlying type of the first argument to another monadic type, and its
 * results is in that other monadic type.
 * @param bFunc :: Block
 * @return Maybe
 */
Method Bind( bFunc ) Class Just
  Return Maybe:New( Eval( bFunc, ::xValue ) )

/**
 * Extracts the element out of a `Just` and returns an error if its argument
 * is `Nothing`.
 * @author Marcelo Camargo
 * @throws UserException
 * @return any
 */
Method FromJust() Class Just
  Return ::xValue

/**
 * Takes a `Maybe` value and a default value. If the `Maybe` is `Nothing`, it
 * returns the default values; otherwise, it returns the value contained in
 * the `Maybe`.
 * @author Marcelo Camargo
 * @param _ ignore
 * @return any
 */
Method FromMaybe( _ ) Class Just
  Return ::xValue

/**
 * Returns true if its argument is of the form `Just _`.
 * @author Marcelo Camargo
 * @return Bool
 */
Method IsJust() Class Just
  Return .T.

/**
 * Returns true if its argument is of the form `Nothing`.
 * @author Marcelo Camargo
 * @return Bool
 */
Method IsNothing() Class Just
  Return .F.

/**
 * Takes a default value, a function and, of course, a `Maybe` value. If the
 * `Maybe` value is `Nothing`, the function returns the default value.
 * Otherwise, it applies the function to the value inside the `Just` and
 * returns the result.
 * @author Marcelo Camargo
 * @param _ ignore
 * @param bFunc :: Block
 * @return any
 */
Method Maybe( _, bFunc ) Class Just
  Return Eval( bFunc, ::xValue )

/**
 * Returns an empty list when given `Nothing` or a singleton list when not
 * given `Nothing`.
 * @return Array<any>
 */
Method ToList() Class Just
  Return { ::xValue }

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

/**
 * Algebraic representation of Nothing.
 * @package DataStructures
 */
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

/**
 * Instantiates a Nothing representation.
 * @constructor
 * @author Marcelo Camargo
 * @return Nothing
 */
Method New() Class Nothing
  Return Self

/**
 * Equivalent to Haskell's `>>=` operator. Its first argument is a value in
 * a monadic type, its second argument is a function that maps from the
 * underlying type of the first argument to another monadic type, and its
 * results is in that other monadic type.
 * @param _ ignore
 * @return Nothing
 */
Method Bind( _ ) Class Nothing
  Return Self

/**
 * Extracts the element out of a `Just` and returns an error if its argument
 * is `Nothing`.
 * @author Marcelo Camargo
 * @throws UserException
 * @return Nil
 */
Method FromJust() Class Nothing
  UserException( "Cannot call FromJust() on Nothing" )
  Return Nil

/**
 * Takes a `Maybe` value and a default value. If the `Maybe` is `Nothing`, it
 * returns the default values; otherwise, it returns the value contained in
 * the `Maybe`.
 * @author Marcelo Camargo
 * @param xDef :: any
 * @return any
 */
Method FromMaybe( xDef ) Class Nothing
  Return xDef

/**
 * Returns true if its argument is of the form `Just _`.
 * @author Marcelo Camargo
 * @return Bool
 */
Method IsJust() Class Nothing
  Return .F.

/**
 * Returns true if its argument is of the form `Nothing`.
 * @author Marcelo Camargo
 * @return Bool
 */
Method IsNothing() Class Nothing
  Return .T.

/**
 * Takes a default value, a function and, of course, a `Maybe` value. If the
 * `Maybe` value is `Nothing`, the function returns the default value.
 * Otherwise, it applies the function to the value inside the `Just` and
 * returns the result.
 * @author Marcelo Camargo
 * @param xDef :: any
 * @param _ ignore
 * @return any
 */
Method Maybe( xDef, _ ) Class Nothing
  Return xDef

/**
 * Returns an empty list when given `Nothing` or a singleton list when not
 * given `Nothing`.
 * @return Array<any>
 */
Method ToList() Class Nothing
  Return { }

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

/**
 * An efficient implementation of sets.
 * @package DataStructures
 */
Class Set
  Data oValue
  Data nLen

  Method New( aData ) Constructor
  Method Null()
  Method Size()
  Method Member( xElem )
  Method NotMember( xElem )
  Method Insert( xElem )
  Method Delete( xElem )
EndClass

/**
 * Initializes a set. If the constructor receives an array, maps over it and
 * adds unique elements to the set. Otherwise, initializes an empty set.
 * @author Marcelo Camargo
 * @constructor
 * @param aData :: Array<any>
 * @return Set
 */
Method New( aData ) Class Set
  Local nI

  ::nLen   := 0
  ::oValue := HMNew()

  If ValType( aData ) == "A"
    For nI := 1 To Len( aData )
      If !::oValue:Get( aData[ nI ] )
        ::oValue:Set( aData[ nI ], ++::nLen )
      EndIf
    Next nI
  EndIf
  Return Self

/**
 * Is this the empty set?
 * @author Marcelo Camargo
 * @return Bool
 */
Method Null() Class Set
  Return ::nLen == 0 .Or. ::nLen == Nil

/**
 * The number of elements in the set.
 * @author Marcelo Camargo
 * @return Integer
 */
Method Size() Class Set
  Return ::nLen

/**
 * Is the element in the set?
 * @author Marcelo Camargo
 * @param elem :: any
 * @return Bool
 */
Method Member( xElem ) Class Set
  Return ::oValue:Get( xElem )

/**
 * Is the element not in the set?
 * @author Marcelo Camargo
 * @param elem :: any
 * @return Bool
 */
Method NotMember( xElem ) Class Set
  Return !::oValue:Get( xElem )

/**
 * Inserts an element in the set if it is not already contained there.
 * @author Marcelo Camargo
 * @param xElem :: any
 * @return Set
 */
Method Insert( xElem ) Class Set
  If !::oValue:Get( xElem )
    ::oValue:Set( xElem, ++::nLen )
  EndIf
  Return Self

/**
 * Deletes an element from the set.
 * @author Marcelo Camargo
 * @param xElem : any
 * @return Set
 */
Method Delete( xElem ) Class Set
  If ::oValue:Get( xElem )
    ::oValue:Del( xElem)
  EndIf
  Return Self

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

/**
 * A small library for string manipulations.
 * @package DataStructures
 */
Class String
  /**
   * String holder.
   */
  Data cValue

  Method New( cStr ) Constructor
  Method ToPrimitive()
  Method AllTrim()
//Method ToAscii()
//Method ANSIToOem()
//Method Find()
EndClass

/**
 * Instantiates a string object to allow method chaining.
 * @author Marcelo Camargo
 * @param cStr :: String
 * @return String
 */
Method New( cStr ) Class String
  ::cValue := Str( cStr )
  Return Self

/**
 * Gives an AdvPL representation of the string.
 * @author Marcelo Camargo
 * @return string
 */
Method ToPrimitive() Class String
  Return ::cValue

/**
 * Removes spaces in the left and in the right of the string.
 * @author Marcelo Camargo
 * @return String
 */
Method AllTrim() Class String
  Return <String>( AllTrim( ::cValue ) )

/**
 * Converts to the ASCII representation of the character
 * @author Marcelo Camargo
 * @return int
 */
Method ToAscii() Class String
  Return <String>( Asc( ::cValue ) )
