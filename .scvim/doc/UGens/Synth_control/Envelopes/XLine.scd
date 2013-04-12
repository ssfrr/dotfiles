XLine			exponential line generator

XLine.ar(start, end, dur, mul, add, doneAction)
XLine.kr(start, end, dur, mul, add, doneAction)

Generates an exponential curve from the start value to the end value. Both the start and end values
must be non-zero and have the same sign.
start - starting value
end - ending value
dur - duration in seconds
doneAction - a doneAction to be evaluated when the Line is completed. See UGen-doneActions for more detail.

play({ SinOsc.ar(XLine.kr(200,17000,10),0,0.1) });



