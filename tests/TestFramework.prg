/**
 * A small test framework for xBase.
 * @package DataStructures
 */

Function Throw( cError )
  Return UserException( "Test case failure: " + cError )

Function MainTest
  ? TestString()
  Return Nil


