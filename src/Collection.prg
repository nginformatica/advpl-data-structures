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
