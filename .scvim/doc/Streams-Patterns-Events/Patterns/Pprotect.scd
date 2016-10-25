Pprotect			evaluate a function when an error occurred in the thread

superclass: FilterPattern


Pprotect(pattern func)
		
		pattern		any pattern
		func			the function to be evaluated when an error occurs. 
					The error and the thread are passed as arguments to the function.	
		

// example

(
var x;
var func = { "an error happened".postln };
a = Pprotect(Pseq([1, 3, 3, Pfuncn({ Error.throw }), 2]), func);
x = Pbind(\degree, a, \dur, 0.5).play;
)


