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
