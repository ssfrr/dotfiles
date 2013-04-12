Ref			a reference to a value
superclass: AbstractFunction

A Ref holds an object which may be retrieved and altered with the messages value and value_(obj).   
The backquote ` is a unary operator that is equivalent to calling Ref.new(obj).

Refs are most commonly used to prevent multi-channel expansion in SynthDefs and Patterns (see Klank for an example).
Refs can also be used to simplify the coding of co-routines used in EventStreams (see Proutine for an example).

example:   

x = Ref(nil);
z = obj.method(x);		// method puts something in reference
x.value.doSomething;	// retrieve value and use it

Ref is also used as a quoting device to protect against multi channel expansion in certain UGens that require Arrays.

Class methods:

new(anObject)

create a Ref of an object.

`anObject

create a Ref of an object.

Instance methods:

dereference

	Answer the value. This message is also defined in class Object where it just returns the receiver.  Therefore anything.dereference will remove a Ref if there is one. This is slightly different than the value message, because value will also cause functions to evaluate themselves whereas dereference will not.

asRef

	Answers the receiver. In class Object this message is defined to create a Ref of the object.

value

	Returns value.

value_(aValue)

	Sets value.

get

	Returns value.

set(aValue)

	Sets value.

at (index)
	Returns value.at(index)

put(index, value)
	Executes value.put(index, value)
	
seq(output)
	this method is used to return values from within a Routine definition
		{ this.value = output.embedInStream(this.value); }

asUGenInput
	Returns the Ref - this prevents multi-channel expansion in a SynthDef
	
asControlInput
	Returns the value - this is used when sending a Ref as a control value to a server Node.
	
Typical uses of Ref:

preventing multi-channel expansion:
	
Consult MultiChannel for details on multi-channel expansion in SynthDefs.

Refs prevent multi-channel expansion in a SynthDef, so the array below defines one Klank UGen rather than three.
		
		{ Klank.ar(`[[800, 1071, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1)) }.play;
	

Refs cannot be used reliably to suppress multi-channel expansion within Events and Patterns.  
Instead, it is necessary to enclose the array of values in another array:

(
	SynthDef(\multi, { | out, freq = #[100,200,300], amp = 0.1, pan = 0, sustain = 1|
		var audio, env;
		env = EnvGen.kr(Env.perc(0.01, sustain), doneAction:2);
		audio = Mix(Saw.ar(freq));
		audio = Pan2.ar(audio * env, pan, amp);	
		OffsetOut.ar(out, audio)
	}).add;

	( instrument: \multi, freq: [ [500, 501, 700] ], sustain: 2).play

)
(
	Pbind(*[
		instrument: \multi,
		freq: 	Prand([ 
						[[100, 141, 103] ], 
						[[100, 310, 190] ], 
						[[100, 100.1, 110] ], 
				], inf),
		dur: 0.2,
		sustain: 0.3
	]).play;
)


