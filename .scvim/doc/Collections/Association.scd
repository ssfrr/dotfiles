Association				relate two objects 

Inherits from: Object : Magnitude

Associates a key with a value. 
Associations can be created via the -> operator which is defined in class Object.

Associations are used internally in Dictionary

(
x = 'name' -> 100;
x.postln;
)

Accessing

<>key

the key object.

<>value

the value object.


Creation

*new(key, value)

Create an Association between two objects.
key - any object. 
value - any object.


Testing

== anAssociation

Compare the keys of two Associations.

< anAssociation

Compare the keys of two Associations.

hash

Compute the hash value of the Association.



Writing to streams

printOn(stream)

Write a string representation to the stream.

storeOn(stream)

Write a compileable string representation to the stream.




Examples

// associations can be a good way to store named data in order:
(
a = [\x -> 700, \y -> 200, \z -> 900];

fork {
	a.do { |assoc|
		assoc.key.postln;
		assoc.value.postln;
		(freq: assoc.value).play;
		2.wait;
	}
};
)




