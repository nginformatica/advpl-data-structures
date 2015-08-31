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
  Method Insert( xElem )
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
