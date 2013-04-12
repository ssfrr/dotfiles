convertRhythm			convert a rhythm-list to durations

message for SequenceableCollection


supports a variation of Mikael Laurson's rhythm list RTM-notation. 

see Laurson and Kuuskankare's 2003, "From RTM-notation to ENP-score-notation"
http://jim2003.agglo-montbeliard.fr/articles/laurson.pdf 


The method converts a collection of the form [beat-count, [rtm-list], repeats] to a List of Floats. A negative integer within the rtm-list equates to a value tied over to the duration following. The method is recursive in that any subdivision within the rtm-list can itself be a nested convertRhythm collection (see Example below). The repeats integer has a default value of 1.

If the divisions in the rtm-list are events, the event durations are interpreted as relative durations, and a list of events is returned.

// Examples

// using numbers as score

[3, [1, 2, 1], 1].convertRhythm; // List[ 0.75, 1.5, 0.75 ]

[2, [1, 3, [1, [2, 1, 1, 1]], 1, 3], 1].convertRhythm;

[2, [1, [1, [2, 1, 1, 1]]], 1].convertRhythm;

[2, [1, [1, [2, 1, 1, 1]]], 2].convertRhythm; // repeat

[2, [1, [1, [2, 1, 1, -1]]], 2].convertRhythm; // negative value is tied over.


// sound example

Pbind(\degree, Pseries(0, 1, inf), \dur, Pseq([2, [1, [1, [2, 1, 1, -1]]], 2].convertRhythm)).play;



