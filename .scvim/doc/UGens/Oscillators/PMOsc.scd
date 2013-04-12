PMOsc			phase modulation oscillator pair

PMOsc.ar(carfreq, modfreq, pmindex, modphase, mul, add)

Phase modulation sine oscillator pair.
carfreq - carrier frequency in cycles per second.
modfreq - modulator frequency in cycles per second.
pmindex - modulation index in radians.
modphase - a modulation input for the modulator's phase in radians

play({ PMOsc.ar(Line.kr(600, 900, 5), 600, 3, 0, 0.1) }); // modulate carfreq

play({ PMOsc.ar(300, Line.kr(600, 900, 5), 3, 0, 0.1) }); // modulate modfreq

play({ PMOsc.ar(300, 550, Line.ar(0,20,8), 0, 0.1) }); // modulate index

(
e = Env.linen(2, 5, 2);
Routine.run({ 
	loop({
		play({
			LinPan2.ar(EnvGen.ar(e) *
				PMOsc.ar(2000.0.rand,800.0.rand, Line.kr(0.0, 12.0.rand,9),0,0.1), 1.0.rand2)});
		2.wait;
	})
}))


