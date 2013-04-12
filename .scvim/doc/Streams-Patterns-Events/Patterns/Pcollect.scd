Pcollect				apply a function to a pattern

superclass: FuncFilterPattern

Pcollect(func, pattern)

modifies each value by passing it to the function


(
var a, b;
a = Pcollect({ arg item; item * 3 }, Pseq(#[1, 2, 3],inf));
x = a.asStream;
9.do({ x.next.postln; });
)

the message collect returns a Pcollect when passed to a pattern

(
var a, b;
a =  Pseq(#[1, 2, 3],inf).collect({ arg item; item * 3 });
a.postln;
x = a.asStream;
9.do({ x.next.postln; });
)


