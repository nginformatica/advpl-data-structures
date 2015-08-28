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
