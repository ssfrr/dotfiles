SetResetFF			set-reset flip flop

SetResetFF.ar(trig, reset)

When a trigger is received the output is set to 1.0
Subsequent triggers have no effect
When a trigger is received in the reset input, the output is set back to 0.0
One use of this is to have some precipitating event cause something to
happen until you reset it.

trig - trigger sets output to one
reset - trigger resets output to zero

(
play({
	a = Dust.ar(5); // the set trigger
	b = Dust.ar(5); // the reset trigger
	SetResetFF.ar(a,b) * BrownNoise.ar(0.2); 

})
)


