Penvir     		use an environment when embedding the pattern in a stream

superclass: Pattern



Penvir(envir, pattern, independent)


	envir		an environment with objects to embed
	
	pattern		pattern or stream, ususally a Pfunc, Prout. 
	
	independent	if true (default) streams can write to the environment without influencing other
				streams created from this pattern. 
				if false, the streams write to a common namespace.
			



// examples:

(
x = (a:8);
y = Penvir(
	x,
	Pfunc { ~a * 2 }
);

t = y.asStream;
)

t.next;



(
x = (a:8);
y = Penvir(
	x,
	Pfunc { ~a = ~a * 2 }
);

t = y.asStream;
z = y.asStream;
)

t.next;
t.next;
x.postln; // x stays unchanged









