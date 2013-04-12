Environment

superclass: IdentityDictionary
related classes: Event, IdentityDictionary

An Environment is an IdentityDictionary with additional features that allow it to serve as a 'name space' within
which functions can be defined and/or evaluated.

PseudoVariables (global variables)

	currentEnvironment	determines environment used by "~" syntax, valueEnvir, and valueArrayEnvir
	topEnvironment		initial value of currentEnvironment, can be used for 'global variables'

Class variables
	
	stack
			Maintains a stack of Environments accessed by push and pop

Class methods

	*make(function)		creates a new Environment and sends make message
	*use(function)			creates a new Environment and sends use message
	*push				saves currentEnvironment on the stack	
	*pop					restores currentEnvironment from the stack

Methods

	make(function)		evaluates the function within the environment, returns the environment.	
	use(function)			evaluates the function within the environment, returns the return valus of the function.	
	push				saves the receiver on the stack
	pop					restores currentEnvironment from the stack

Related Messages

	valueEnvir (arg1, arg2...)		evaluates a function, looking up unspecified arguments in currentEnvironment
	valueArrayEnvir (argArray)	same as valueEnvir, but with arguments in an array
	

Overview: topEnvironment, currentEnvironment, make and use


When SuperCollider starts, it creates an Environment that it stores in the pseudovariables 
topEnvironment and currentEnvironment.  The topEnvironment provides a universally
accessible collection of named values  similar to the Interpreter variables a, b, c, ....

The compiler provides a shortcut syntax where ~ is a placeholder for currentEnvironment. 
This makes the expression

	~myvariable;  		equivalent to 		currentEnvironment.at(\myvariable);
		
and the expression
		
	~myvariable = 888;		equivalent to		currentEnvironment.put(\myvariable, 888);

The messages make(function) and use(function) replace currentEnvironment with the receiver. evaluate
the function and then restore currentEnvironment's original value.  The message make is intended
to be used when initializing an Environment, so it returns the Environment.  The message use is for
evaluating a functions within an Environment, so it returns the return value of the function.

For example
		(
		a = Environment.make({
			~a = 100;
			~b = 200;
			~c = 300;
		});
		a.postln;
		)
creates an environment, while

		a.use({
			~a + ~b + ~c
		}).postln;
		
evaluates the function within that environment.


valueEnvir and valueArrayEnvir

When Functions are evaluated with valueEnvir and valueArrayEnvir unspecified arguments are looked up in the current Environment.
If the argument is not found in the Environment its default value is used.

(
var f;

// define a function
f = { arg x, y, z; [x, y, z].postln; };

Environment.use({
	~x = 7;
	~y = 8;
	~z = 9;
	
	f.valueEnvir(1, 2, 3);	// all values supplied
	f.valueEnvir(1, 2);	// z is looked up in the current Environment
	f.valueEnvir(1);		// y and z are looked up in the current Environment 
	f.valueEnvir;			// all arguments are looked up in the current Environment
	f.valueEnvir(z: 1);	// x and y are looked up in the current Environment
});
)

Now here is how this can be used with an instrument function. Environments allow you to define instruments without having to worry about argument ordering conflicts. Even though the three functions below have the freq, amp and pan args declared in different orders it does not matter, because valueEnvir looks them up in the
environment. 

s.boot;

(
var orc;
orc = Environment.make {
	~a = { arg freq, amp, pan;
		Pan2.ar(SinOsc.ar(freq), pan, amp);
	};
	~b =  { arg amp, pan, freq;
		Pan2.ar(RLPF.ar(Saw.ar(freq), freq * 6, 0.1), pan, amp);
	};
	~c =  { arg pan, freq, amp;
		Pan2.ar(Resonz.ar(GrayNoise.ar, freq * 2, 0.1), pan, amp * 2);
	};
	~orc = [~a, ~b, ~c];
};
// 'reverb'
{ var in; in = In.ar(0, 2); CombN.ar(in, 0.2, 0.2, 3, 1, in); }.play(addAction: \addToTail);

{ loop({
	orc.use({
			// set values in the environment
		~freq = exprand(80, 600);
		~amp = 0.1;
		~pan = 1.0.rand2;
		
			// call a randomly chosen instrument function 
			// with values from the environment
		
		 x = { ~orc.choose.valueEnvir; }.play(fadeTime: 0.2, addAction: \addToHead); 
		 0.2.wait; 
		 x.release(0.2); 
	});
}) }.fork;
	
)


Environments and asynchronous functions

Local variables declared in functions, and class and instance variables, use lexical scope. That is, the context in which they are understood depends on where the declaration is read during compilation. Asynchronous functions -- any function that will execute outside (later than) the current execution flow -- carry their lexically scoped variables with them.

f = { var a = "got it"; { a.postln }.defer(0.5) };
f.value;

Asynchronous functions include any scheduled function, responder function associated with OSCresponder, MIDIResponder, HID or GUI action functions, or actions used in server messaging (such as Buffer.read, Buffer or Bus .get, and so on).

Environment variables have dynamic scope; they are read from whichever environment is current, whether or not it was the current environment when the function was declared. For instance, the following fails because e is no longer the current environment when the deferred function wakes up.

e = (a: "got it", f: { { ~a.postln }.defer(0.5) });
e.use { e.f };

Function's inEnvir method attaches a function to a specific environment. If no environment is given, the current environment at the time of executing inEnvir is the default.

e = (a: "got it", f: { { ~a.postln }.inEnvir.defer(0.5) });
e.use { e.f };




Using Environments as object prototypes

Environment's know variable holds a Boolean value controlling whether the Environment may be used as an object prototype or not. If know is true, any messages sent to the Environment that it does not already understand will be relayed into items in the Environment. (If false, not-understood messages will produce a standard "does not understand" error message.)

The default for know is false for Environment, and true for Event.

e = Environment[
	'someVariable' -> 5,
	'printMe' -> { |self, string| string.postln }
];

e.know = true;

More typically, Events are used to define such prototypes because the syntax is simpler.

e = (someVariable: 5, printMe: { |self, string| string.postln });


An object prototype looks up the method selector in the Environment to decide what to do.

Most objects are simply returned -- the method call behaves like a getter for any other object.

e.someVariable;
// same as
e.at('someVariable');
e['someVariable'];

If the selector is a setter, e.g. someVariable_(value) or e.someVariable = value, the new value is put into the Environment.

e.someVariable = 10;
// same as
e.put('someVariable', 10);

If the Environment item is a function, it is evaluated as if it were a method definition. The first argument passed into the function is the Environment that holds the function; arguments to the method call follow as the second, third etc. arguments passed into the function.

e.printMe("Oh hai wrldz");
// same as
e['printMe'].value(e, "Oh hai wrldz");

The function may access objects in the Environment using the first function argument.

e.mul2 = { |z| z.someVariable * 2 };
e.mul2;

Environment variables inside a function will refer to the currently active environment -- not to the Environment being addressed. This is to allow the object prototype to interact with the currentEnvironment.

e.mul2 = { |z| ~someVariable * 2 };
// this will throw an error because ~someVariable is nil in the currentEnvironment
e.mul2;

If you wish to access objects in the environment using environment variable syntax, 'use' the environment within the function.

e.mul2 = { |z| z.use { ~someVariable * 2 } };
e.mul2;


IMPORTANT: Be careful to avoid method names that are defined in any of the superclasses of environment (or event). Object prototyping works by trapping method selectors that are not already defined as class library methods. Using a generic method selector such as 'stop' or 'reset' will cause the corresponding class library method to respond, and the items in the environment will never be checked.

Assigning a value into an environment using a setter -- name_() or .name = ... -- posts a warning message if the name is already defined in the class library.

e.reset = { "My reset function".postln };

// prints:
WARNING:
'reset' exists a method name, so you can't use it as pseudo-method.

// this does NOT execute the reset function above
// because Object:reset responds
e.reset;



