s.waitForBoot {
	{ Saw.ar(EnvGen.kr(Env([440, 440, 324, 10000] * 0.4, [4, 2, 1], \exp), doneAction:2)) * 0.1 }.play
}


