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
