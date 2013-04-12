MulAdd		Multiply and add to a signal

MulAdd(in, mul, add)
	or
in.madd(mul, add)

Multiplies the signal by mul and adds add. This UGen is very efficient (it performs various optimisation checks, for example). It is used very heavily throughout SuperCollider to perform multiply and add operations on the server; in fact it is  what "really" performs the mul and add arguments found in many UGens.

See also: The discussion of mul and add arguments in the UGen help file.


Examples

s.boot;

// The mul and add arguments of SinOsc themselves use MulAdd!
// These two examples will create precisely the same synth graph:
x = { SinOsc.ar(440, 0, 0.1, 0.05) }.play(s);
x.trace; // You should see a "MulAdd" in the trace
x.free;

x = { MulAdd(SinOsc.ar(440, 0), 0.1, 0.05) }.play(s);
x.trace;
x.free;

// In fact this will produce the same graph too - the separate multiply and add are optimised into one MulAdd
x = { SinOsc.ar(440, 0) * 0.1 + 0.05 }.play(s);
x.trace;
x.free;

(Note: the "trace" message is described in the helpfile for Node.)


