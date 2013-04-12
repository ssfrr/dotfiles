Randomness in SC

As in any computer program, there are no "truly random" number generators in SC. 
They are pseudo-random, meaning they use very complex, but deterministic 
algorithms to generate sequences of numbers that are long enough and complicated enough 
to seem "random" for human beings. (i.e. the patterns are too complex for us to detect.)

If you start a random number generator algorithm with the same "seed" number 
several times, you get the same sequence of random numbers. 
(See example below, randomSeed)


Create single random numbers:


1. Between zero and <number>:

5.rand				// evenly distributed.

1.0.linrand			// probability decreases linearly from 0 to <number>.


2. Between -<number> and <number>:

5.0.rand2				// evenly distributed.

10.bilinrand			// probability is highest around 0, 
					// decreases linearly toward +-<number>.

1.0.sum3rand			// quasi-gaussian, bell-shaped distribution.

3. Within a given range:

rrand(24, 48)			// linear distribution in the given range.

exprand(0.01, 1)		// exponential distribution; 
					// both numbers must have the same sign.


Test them multiple times with a do loop:


20.do({ 5.rand.postln; });			// evenly distributed

20.do({ 1.0.linrand.postln; });		// probability decreases linearly from 0 to 1.0


20.do({ 5.0.rand2.postln; });		// even

20.do({ 10.bilinrand.postln; });		// probability is highest around 0, 
							// decreases linearly toward +-<number>.
							
20.do({ 1.0.sum3rand.postln; });	// quasi-gaussian, bell-shaped.



Collect the results in an array:

Array.fill(10, { 1000.linrand }).postln; 

// or more compact: 

{ 1.0.sum3rand }.dup(100) 

// or:

({ 1.0.sum3rand } ! 100)



You can seed a random generator in order to repeat 
the same sequence of random numbers:

(
5.do({ 
	thisThread.randSeed = 4;
	Array.fill(10, { 1000.linrand}).postln; 
});
)

// Just to check, no seeding:

(
5.do({ Array.fill(10, { 1000.linrand }).postln; });
)

// see also randomSeed.



Demonstrate the various statistical distributions visually, with histograms:

[plot may not work in non-Mac SC3 versions.]

Array.fill(500, {  1.0.rand }).plot("Sequence of 500x 1.0.rand");

Array.fill(500, {  1.0.linrand }).plot("Sequence of 500x 1.0.linrand");

Array.fill(500, {  1.0.sum3rand }).plot("Sequence of 500x 1.0.sum3rand");

// Use a histogram to display how often each (integer) 
// occurs in a collection of random numbers, :
(
var randomNumbers, histogram, maxValue = 500, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { maxValue.rand; });
histogram = randomNumbers.histo(numBins, 0, maxValue);
histogram.plot("histogram for rand 0 - " ++ maxValue);
)



A histogram for linrand:

(
var randomNumbers, histogram, maxValue = 500.0, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { maxValue.linrand; });
histogram = randomNumbers.histo(numBins, 0, maxValue);
histogram.plot("histogram for linrand 0 - " ++ maxValue);
)

A histogram for bilinrand:

(
var randomNumbers, histogram, minValue = -250, maxValue = 250, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { maxValue.bilinrand; });
histogram = randomNumbers.histo(numBins, minValue, maxValue);
histogram.plot("histogram for bilinrand" + minValue + "to" + maxValue);
)



A histogram for exprand:

(
var randomNumbers, histogram, minValue = 5.0, maxValue = 500, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { exprand(minValue, maxValue); });
histogram = randomNumbers.histo(numBins, minValue, maxValue);
histogram.plot("histogram for exprand: " ++ minValue ++ " to " ++ maxValue);
)


And for sum3rand (cheap quasi-gaussian):


(
var randomNumbers, histogram, minValue = -250, maxValue = 250, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { maxValue.sum3rand; });
histogram = randomNumbers.histo(numBins, minValue, maxValue);
histogram.plot("histogram for sum3rand " ++ minValue ++ " to " ++ maxValue);
)



All of the single-number methods also work for (Sequenceable)Collections, 
simply by applying the given random message to each element of the collection:

[ 1.0, 10, 100.0, \aSymbol ].rand.postln;		// note: Symbols are left as they are.
List[ 10, -3.0, \aSymbol ].sum3rand.postln;




Arbitrary random distributions

An integral table can be used to create an arbitrary random distribution quite efficiently. The table
building is expensive though. The more points there are in the random table, the more accurate the
distribution.

(
var randomNumbers, histogram, distribution, randomTable, randTableSize=200;
var minValue = -250, maxValue = 250, numVals = 10000, numBins = 500;

// create some random distribution with values between 0 and 1
distribution = Array.fill(randTableSize, 
	{ arg i; (i/ randTableSize * 35).sin.max(0) * (i / randTableSize) }
);

// render a randomTable
randomTable = distribution.asRandomTable; 

// get random numbers, scale them

randomNumbers = Array.fill(numVals, { randomTable.tableRand * (maxValue - minValue) + minValue; }); 
histogram = randomNumbers.histo(numBins, minValue, maxValue);


histogram.plot("this is the histogram we got");
distribution.plot("this was the histogram we wanted");
)






Random decisions:


coin 	simulates a coin toss and results in true or false. 
		1.0 is always true, 0.0 is always false, 0.5 is 50:50 chance.

20.do({ 0.5.coin.postln });

biased random decision can be simulated bygenerating a single value 
and check against a threshhold:

20.do({ (1.0.linrand > 0.5).postln });
20.do({ (exprand(0.05, 1.0) > 0.5).postln });

Generating Collections of random numbers:

		// size, minVal, maxVal 
Array.rand(7, 0.0, 1.0).postln;				

// is short for:

Array.fill(7, { rrand(0.0, 1.0) }).postln;	


		// size, minVal, maxVal 
List.linrand(7, 10.0, 15.0).postln;			

// is short for:

List.fill(7, { 10 + 5.0.linrand }).postln;	

Signal.exprand(10, 0.1, 1);

Signal.rand2(10, 1.0);



Random choice from Collections
	
choose 			equal chance for each element.

10.do({ [ 1, 2, 3 ].choose.postln });			


Weighted choice:

wchoose(weights)	An array of weights sets the chance for each element.

10.do({ [ 1, 2, 3 ].wchoose([0.1, 0.2, 0.7]).postln });	



Randomize the order of a Collection: 	

scramble

List[ 1, 2, 3, 4, 5 ].scramble.postln;


Generate random numbers without duplicates: 	

f = { |n=8, min=0, max=7| (min..max).scramble.keep(n) };
f.value(8, 0, 7)



Randomly group a Collection:	

curdle(probability)

The probability argument sets the chance that two adjacent elements will be separated.

[ 1, 2, 3, 4, 5, 6, 7, 8 ].curdle(0.2).postln;	// big groups

[ 1, 2, 3, 4, 5, 6, 7, 8 ].curdle(0.75).postln;	// small groups






Random signal generators, i.e. UGens:

PinkNoise
WhiteNoise
GrayNoise
BrownNoise
PinkerNoise
ClipNoise
LFNoise0
LFNoise1
LFNoise2
LFClipNoise
LFDNoise0
LFDNoise1
LFDNoise3
LFDClipNoise
Dust
Dust2
Crackle
TWChoose




UGens that generate random numbers once, or on trigger:

Rand		uniform distribution of float between (lo, hi), as for numbers.
IRand		uniform distribution of integer numbers.
TRand		uniform distribution of float numbers, triggered
TIRand		uniform distribution of integer numbers, triggered
LinRand		skewed distribution of float numbers, triggered
NRand 		sum of n uniform distributions, approximates gaussian distr. with higher n.
ExpRand 		exponential distribution
TExpRand	exponential distribution, triggered
CoinGate		statistical gate for a trigger
TWindex		triggered weighted choice between a list

	Like using randSeed to set the random generatorsfor each thread in sclang,  
	you can choose which of several random generators on the server to use,
	and you can reset (seed) these random generators: 
RandID
RandSeed


UGens that generate random numbers on demand ("Demand UGens"):

Dwhite
Dbrown
Diwhite
Dibrown
Drand
Dxrand

see random patterns with analogous names



Random Patterns: 


Prand([ 1, 2, 3 ], inf);		// choose randomly one from a list ( list, numRepeats)
Pxrand([ 1, 2, 3 ]);			// choose one element from a list, no repeat of previous choice
Pwhite(24, 72);				// within range [<hi>, <lo>], choose a random value.
Pbrown(24, 72, 5)				// within range [<hi>, <lo>], do a random walk
							// with a maximum <step> to the next value.
Pgbrown(24, 72, 1.4)			// geometric brownian motion

Plprand			 
Phprand
Pmeanrand
Pbeta
Pcauchy
Pgauss
Ppoisson
Pexprand
						
Pwrand([ 1, 2, 3 ], [0.1, 0.3, 0.6], 20);	// choose from a list, probabilities by weights

Pshuf([ 1, 2, 3, 4 ], 2);		// scramble the list, then repeat that order <repeats> times.

Pwalk( (0 .. 10), Prand([ -2,-1, 1, 2], inf));		// random walk. 

Pfsm 						// random finite state machine pattern, see its help file. 
							// see also MarkovSet in MathLib quark

Pseed(seed, pattern)			// sets the random seed for that stream.


// some basic examples

(
Pbind(\note, Prand([ 0, 2, 4 ], inf), 
	\dur, 0.2
).play;
)

(
Pbind(
	\note, Pxrand([ 0, 2, 4 ], inf),
	\dur, 0.2
).play;
)

(
Pbind(
	\note, Pwrand([ 0, 2, 4 ], [0.1, 0.3, 0.6], inf),
	\dur, 0.2
).play;
)

(
Pbind(
	\midinote, Pwhite(48, 72, inf),
	\dur, 0.2
).play;
)

(
Pbind(
	\midinote, Pbrown(48, 72, 5, inf),
	\dur, 0.2
).play;
)

(
Pbind(
	\midinote, Pgbrown(48, 72, 0.5, inf).round,
	\dur, 0.2
).play;
)



