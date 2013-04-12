s.waitForBoot {
	{ SinOsc.ar(EnvGen.kr(Env([440, 440, 324, 10000], [4, 2, 1], \exp), doneAction:2)) * 0.1 }.play
}


