Unary messages

Some synthesis processes can be initiated with a unary message (a message with no arguments).

////////////////////////////////////////////////////////////////////////////////////////////////////

For example, compare

{ SinOsc.ar(500, 0, 0.5) }.scope;

to

{ SinOsc.ar(500, 0, 0.5).distort }.scope;

The .distort message modulates the SinOsc to create more partials.

////////////////////////////////////////////////////////////////////////////////////////////////////

Q: Where does the .distort message come from?

A: It's defined in the AbstractFunction class. The UGen class is a subclass of the AbstractFunction class. The idea is that all classes inherit methods defined in their superclasses; all ugens thus inherit from AbstractFunction).

Compare

{ SinOsc.ar(500, 0, 0.5) }.scope;

to

// .cubed is a unary operation
{ SinOsc.ar(500, 0, 0.5).cubed }.scope;

////////////////////////////////////////////////////////////////////////////////////////////////////

See the files in the UnaryOps folder in the SuperCollider help system 

////////////////////////////////////////////////////////////////////////////////////////////////////

go to 9_BinaryOpSynthesis


