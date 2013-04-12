Changed					triggers when a value changes

Inherits from: Object : AbstractFunction : UGen : Filter 

Changed.ar(in, thresh)
Changed.kr(in, thresh)

A special case fixed filter. Implements the formula:

out(i) = abs(in(i) - in(i-1)) > thresh




// detect changes in a signal:
(
{ 	
	var changingSignal = LFNoise0.ar(1000); 
	var changed = Changed.ar(changingSignal);
	[changingSignal, changed]
}.plot2
);



