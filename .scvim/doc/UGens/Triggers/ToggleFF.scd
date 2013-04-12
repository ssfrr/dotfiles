ToggleFF			toggle flip flop

ToggleFF.ar(trig)

Toggles between zero and one upon receiving a trigger.
trig - trigger input

(
play({
	SinOsc.ar((ToggleFF.ar(Dust.ar(XLine.kr(1,1000,60))) * 400) + 800, 0, 0.1)
}))



