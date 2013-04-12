Preject			reject values from a pattern

superclass: FuncFilterPattern

Preject(func, pattern)

rejects values for which the function returns true. the value is passed to the function

see also: Pcollect, Pselect

(
var a, b;
a = Preject({ arg item; item == 1 }, Pseq(#[1, 2, 3],inf));
x = a.asStream;
9.do({ x.next.postln; });
)

the message reject returns a Preject when passed to a pattern

(
var a, b;
a =  Pseq(#[1, 2, 3],inf).reject({ arg item; item == 1 });
a.postln;
x = a.asStream;
9.do({ x.next.postln; });
)


