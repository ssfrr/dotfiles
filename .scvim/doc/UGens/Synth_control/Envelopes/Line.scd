Line			line generator

Inherits from: Object : AbstractFunction : UGen

Line.ar(start, end, dur, mul, add, doneAction)
Line.kr(start, end, dur, mul, add, doneAction)

Generates a line from the start value to the end value.
start - starting value
end - ending value
dur - duration in seconds
doneAction - a doneAction to be evaluated when the Line is completed. See UGen-doneActions for more detail.

See also: XLine, EnvGen, Ramp

plot { Line.ar(0, 1, 0.01) };

play { SinOsc.ar(Line.kr(200, 17000, 10), 0, 0.1) };

// for certain values, like frequency, XLine sounds usually 'better' than Line:

play { SinOsc.ar(XLine.kr(200, 17000, 10), 0, 0.1) };


