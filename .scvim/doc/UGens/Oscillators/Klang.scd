Klang		sine oscillator bank

Klang.ar(specificationsArrayRef, freqscale, freqoffset)

Klang is a bank of fixed frequency sine oscillators. Klang is more efficient than creating individual oscillators but offers less flexibility.

The parameters in specificationsArrayRef can't be changed after it has been started. 
For a modulatable but less efficient version, see DynKlang.

specificationsArrayRef - a Ref to an Array of three Arrays :
	frequencies - an Array of filter frequencies.
	amplitudes - an Array of filter amplitudes, or nil. If nil, then amplitudes default to 1.0
	phases - an Array of initial phases, or nil. If nil, then phases default to 0.0
freqscale - a scale factor multiplied by all frequencies at initialization time.
freqoffset - an offset added to all frequencies at initialization time.


play({ Klang.ar(`[ [800, 1000, 1200],[0.3, 0.3, 0.3],[pi,pi,pi]], 1, 0) * 0.4});

play({ Klang.ar(`[ [800, 1000, 1200], nil, nil], 1, 0) * 0.25});

play({ Klang.ar(`[ Array.rand(12, 600.0, 1000.0), nil, nil ], 1, 0) * 0.05 });



(
{
loop({
	play({
		Pan2.ar(Klang.ar(`[ Array.rand(12, 200.0, 2000.0), nil, nil ], 1, 0), 1.0.rand) 
			* EnvGen.kr(Env.sine(4), 1, 0.02, doneAction: 2);
	});
	2.wait;
})
}.fork;
)



