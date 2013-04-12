Pwhile		while a condition holds,  repeatedly embed  stream

superclass: FuncFilterPattern

Pwhile(func, pattern)



(
z = true;
a = Pwhile({ z }, Pseq(#[1, 2, 3]));
x = a.asStream;
);


7.do({ x.next.postln; }); // while z == true, the values are embedded
z = false; // set z to false
x.next; // the rest of the stream is still embedded
x.next;
x.next; // but then it is not continued.
x.next;
x.next;
x.next;



