Nil

Inherits from: Object 

Nil has a single instance named nil and is used to represent uninitialized data,
bad values, or terminal values such as end-of-stream.

Instance Methods

isNil
	Answers true because this is nil. In class Object this message is defined to answer false.

notNil
	Answer false. In class Object this message answers true.

? anObject
	? means return first non-nil argument. Since this IS nil then return anObject.
	In class Object, ? is defined to answer the receiver.

?? aFunction
If the receiver is nil, value the function and return the result.  Since this IS nil, then value the function and return the result. In class Object, ?? is defined to answer the receiver.

add(value)
Returns an array with the value. This makes it unnecessary to initialize when adding to a variable.

addAll(array)
Returns an array with all the values. This makes it unnecessary to initialize when adding to a variable.

remove
Returns nil. This makes it unnecessary to initialize when adding to a variable.

++ array
Returns an array with all the values. This makes it unnecessary to initialize when adding to a variable.

Dependancy

All the messages for the Dependancy protocol (See class Object) are defined in class Nil 
to do nothing. This eliminates the need to check for nil when sending dependancy messages.

Other Methods

Many other messages are defined in class Nil to do nothing. This eliminates the need to check for nil.




