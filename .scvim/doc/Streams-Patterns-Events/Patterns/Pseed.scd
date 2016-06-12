Pseed 			set the random seed in subpattern


superclass: FilterPattern



set the random generator seed of the resulting stream.
see also: randomSeed

	Pseed(seed, pattern)
	
	seed: integer number, pattern or stream that return an integer number
	



a = Pseed(1972, Prand([1,2,3], inf));

b = a.asStream; 
10.do({ b.next.post });

c = a.asStream; 
10.do({ c.next.post });


// using a seed pattern as input:

a = Pseed(Pseq([1812, 1912], inf), Prand([1,2,3], 5));

b = a.asStream; 
2.do({ 5.do({ b.next.post });"".postln;  });

c = a.asStream; 
2.do({ 5.do({ c.next.post });"".postln;  });



// outer thread is independent:

a = Pseed(Prand([1534, 1600, 1798, 1986, 2005], inf), Pshuf([1, Prand([7, 9], 2), 1, 2, 3], 1));

// returns random streams
b = a.asStream; 
2.do({ 5.do({ b.next.post });"".postln;  });

c = a.asStream; 
2.do({ 5.do({ c.next.post });"".postln;  });




