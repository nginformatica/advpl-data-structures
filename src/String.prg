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
