PdegreeToKey

superclass: FilterPattern


PdegreeToKey(keypattern,  scale,  stepsPerOctave)

returns a series of notes derived from an index into a scale.
if the scale is a pattern, it streams the scales accordingly


keypattern 		integer index into the scale
scale 			an array
stepsPerOctave	the number of steps per octave in the scale. The default is 12.



(
Pbind(\note, PdegreeToKey(
				Pseq([1, 2, 3, 2, 5, 4, 3, 4, 2, 1], 2),
				#[0, 2, 3, 6, 7, 9],
				12
			),
		\dur, 0.25
).play;
)


(
var scales;
scales = #[[0, 2, 3, 6, 7, 9], [0, 1, 5, 6, 7, 9, 11], [0, 2, 3]];
Pbind(\note, PdegreeToKey(
				Pseq([1, 2, 3, 2, 5, 4, 3, 4, 2, 1], 4),
				Pstutter(3, Prand(scales, inf)),
				12
			),
		\dur, 0.25
).play;
)




