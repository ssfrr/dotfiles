DemandEnvGen			demand rate envelope generator

Inherits from: Object : AbstractFunction : UGen

Plays back break point envelope contours (levels, times, shapes) given by demand ugens. The next values are called when the next node is reached.


*ar(levels, times, shapes, curves, gate, reset, levelScale, levelOffset, timeScale, doneAction)
*kr(levels, times, shapes, curves, gate, reset, levelScale, levelOffset, timeScale, doneAction)
		
	levels - demand ugen (or other ugen) returning level values
	times - demand ugen (or other ugen) returning time values
	shapes - demand ugen (or other ugen) returning shape number - the number given is the shape number
	curves - demand ugen (or other ugen) returning curve values -  if shape is 5, this is the curve factor
		The possible values are:
		0 - flat segments
		1 - linear segments, the default
		2 - natural exponential growth and decay. In this case, the levels must all be nonzero
					and the have the same sign.
		3 - sinusoidal S shaped segments.
		4 - sinusoidal segments shaped like the sides of a Welch window.
		a Float - a curvature value for all segments.
		An Array of Floats - curvature values for each segments.

	gate	- control rate gate
			if gate is x >= 1, the ugen runs
			if gate is 0 > x > 1, the ugen is released at the next level (doneAction)
			if gate is x <= 0, the ugen is sampled end held

	reset - if reset crosses from nonpositive to positive, the ugen is reset at the next level
		if it is > 1, it is reset immediately.
		
	levelScale - demand ugen returning level scaling values
	levelOffset - demand ugen returning level offset values
	timeScale - demand ugen returning time scaling values

	doneAction - a done action to do when one of the demand series ended (Synth-Controlling-UGens)

		
structurally related: EnvGen, Pseg
see also: Demand	
	


// frequency envelope with random times
(
	{
		var freq;
		freq = DemandEnvGen.ar(
				Dseq([204, 400, 201, 502, 300, 200], inf),
				Drand([1.01, 0.2, 0.1, 2], inf) * MouseY.kr(0.01, 3, 1),
				7 // cubic interpolation
			); 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)

// frequency modulation
(
	{
		var freq, list;
		list = { exprand(200, 1000.0) } ! 32;
		freq = DemandEnvGen.ar(
				{ Dseq(list.scramble, inf) } ! 2,
				SampleDur.ir * MouseY.kr(1, 3000, 1),
				5, // curve interpoaltion
				MouseX.kr(-0.01, -4) // curve must be negative for fast interpol.
			); 
		SinOsc.ar(freq) * 0.1
	
	}.play;
)


//  gate
// mouse x on right side of screen toggles gate
(
	{
		var freq;
		freq = DemandEnvGen.kr(
				Dwhite(300, 1000, inf).round(100),
				0.1,
				5, 0.3, // curve: 0.3
				MouseX.kr > 0.5, 
				1
			); 
		SinOsc.ar(freq * [1, 1.21]) * 0.1
	
	}.play;
)

// sample and hold (0.5 > gate > 0)
// mouse x on right side of screen toggles gate
// mouse y scales frequency
(
	{
		var freq;
		freq = DemandEnvGen.kr(
				Dwhite(300, 1000, inf).round(100),
				0.1,
				5, 0.3,
				MouseX.kr > 0.5 + 0.1
			); 
		SinOsc.ar(freq * [1, 1.21]) * 0.1
	
	}.play;
)

// gate
// mouse x on right side of screen toggles gate 
// mouse button does soft reset
(
	{
		var freq;
		freq = DemandEnvGen.kr(
				Dseq([Dseries(400, 200, 5), 500, 800, 530, 4000, 900], 2),
				Dseq([0.2, 0.1, 0.2, 0.3, 0.1], inf),
				Dseq([1, 0, 0, 6, 1, 1, 0, 2], inf), // shapes
				0, 
				MouseX.kr > 0.5, // gate
				MouseButton.kr > 0.5, // reset
				doneAction:0
			); 
		SinOsc.ar(freq * [1, 1.001]) * 0.1
	
	}.play;
)


//  gate
// mouse x on right side of screen toggles sample and hold 
// mouse button does hard reset
(
	{
		var freq;
		freq = DemandEnvGen.kr(
				Dseq([Dseries(400, 200, 5), 500, 800, 530, 4000, 900], 2),
				0.1,
				3, 0,
				MouseX.kr > 0.5 - 0.1, // gate: sample and hold
				MouseButton.kr > 0.5 * 2, // hard reset
				doneAction: 0
			); 
		SinOsc.ar(freq * [1, 1.001]) * 0.1
	
	}.play;
)





// short sequence with doneAction, linear
(
	{
		var freq;
		freq = DemandEnvGen.kr(
				Dseq([1300, 500, 800, 300, 400], 1),
				0.2,
				1,
				doneAction:2
			); 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)

// short sequence with doneAction, step
(
	{
		var freq;
		freq = DemandEnvGen.kr(
				Dseq([1300, 500, 800, 300, 400], 1),
				0.2, 
				0,
				doneAction:2
			); 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)



// a linear ramp
(
	{
		var freq;
		freq = DemandEnvGen.kr(
				Dseq([300, 800], 1),
				1,
				1
			); 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)



// random gate:  release. gate low level > 0.
// only end points are kept as release levels
(
	{
		var freq;
		freq = DemandEnvGen.kr(
				Dseq([500, 800], inf),
				0.03,
				1,0, // linear
				ToggleFF.kr(Dust.kr(5)) + 0.1 // gate
				
	
			); 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)

// random gate: sample and hold. gate low level = 0.
(
	{
		var freq;
		freq = DemandEnvGen.kr(
				Dseq([500, 800, 600], inf),
				0.03,
				1,0, // linear
				ToggleFF.kr(Dust.kr(5)), // gate
				0 // reset
	
			); 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)




// lfnoise1
(
	{
			DemandEnvGen.ar(
				Dwhite(-0.1, 0.1, inf),
				SampleDur.ir * MouseY.kr(0.5, 20),
				5,
				-4
			); 
		
	
	}.play;
)

// lfbrownnoise
(
	{
			DemandEnvGen.ar(
				Dbrown(-0.1, 0.1, 0.1, inf),
				SampleDur.ir * MouseY.kr(1, 100, 1)
			); 
		
	
	}.play;
)






Server.internal.boot;

// hardsyncing a saw
(
	{
		
			DemandEnvGen.ar(
				Dseq([Dseries(-0.1, 0.01, 20)], inf),
				SampleDur.ir * MouseY.kr(1, 100, 1),
				1, 0,
				K2A.ar(1),
				Impulse.ar(MouseX.kr(1, SampleRate.ir * MouseX.kr(0.002, 1, 1), 1), 0, 1.5)
				
			)
		
	
	}.scope;
)


// softsyncing a saw
(
	{
		
			DemandEnvGen.ar(
				Dseq([Dseries(-0.1, 0.01, 20)], inf),
				SampleDur.ir * MouseY.kr(1, 100, 1),
				1, 0,
				K2A.ar(1),
				Impulse.ar(MouseX.kr(1, SampleRate.ir * MouseX.kr(0.002, 1, 1), 1)) + [0, 0.3]
				
			)
		
	
	}.scope;
)



// hardsyncing a saw, som random elements
(
	{
		
			DemandEnvGen.ar(
				Dseq([Dseries(-0.1, 0.01, 20), Dseries(-0.1, 0.01, 20), Dwhite(-0.1, 0.1, 5)], inf),
				SampleDur.ir * MouseY.kr(1, 100, 1),
				3, 0,
				1,
				Impulse.ar(MouseX.kr(1, SampleRate.ir * MouseX.kr(0.002, 1, 1), 1), 0, 1.5)
				
			)
		
	
	}.scope;
)

// softsyncing a saw, som random elements
(
	{
		
			DemandEnvGen.ar(
				Dseq([Dseries(-0.1, 0.01, 20), Dseries(-0.1, 0.01, 20), Dwhite(-0.1, 0.1, 5)], inf),
				SampleDur.ir * MouseY.kr(1, 100, 1),
				1, 0, // linear interpolation
				1,
				Impulse.ar(MouseX.kr(1, SampleRate.ir * MouseX.kr(0.002, 1, 1), 1))
				
			)
		
	
	}.scope;
)


// multichannel expansion
// mouse x on right side of screen toggles gate 
// mouse y controls speed

(
	{
		var freq;
		freq = DemandEnvGen.kr(
				{ Dseq([300, 800, Drand([1000, 460, 300], 1), 400], inf) + 3.0.rand } ! 2,
				MouseY.kr(0.001, 2, 1), 
				5, -4,
				MouseX.kr > 0.5
			);
		SinOsc.ar(freq) * 0.1
	
	}.play;
)






