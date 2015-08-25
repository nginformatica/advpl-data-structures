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

Exemplo de uso do `Dictionary`:
```
Function TestDict
  Local oFruits := <Dictionary>()

  oFruits:Set( "Apple", 4 )
  oFruits:Set( "Orange", 5 )
  oFruits:Set( "Watermelon", 1 )

  ? "Let's buy " + oFruits:Get( "Apple" ) + " apples!"

  Return
```
