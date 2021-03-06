IndexInBetween		

IndexInBetween.ar(bufnum, in, mul, add)
IndexInBetween.kr(bufnum, in, mul, add)

Finds the (lowest) point in the Buffer at which the input signal lies in-between the two values, and returns the index. The fractional part of the index is suitable for linearly interpolating between the buffer slot values. 

For example, if the Buffer contains [3, 21, 25, 26] and the input has the value 22, then the output will be 1.25, because the value 22 is in-between the values stored in indices 1 and 2 and in fact is one-quarter of the way along the interval between them.

IndexInBetween is the complement of IndexL.

bufnum - index of the buffer
in - the input signal.



(
// autotune.
s = Server.local;
t = ([0, 1, 3, 4, 7, 11, 12] + 70).midicps;
b = Buffer(s, t.size, 1);

// alloc and set the values
s.listSendMsg( b.allocMsg( b.setnMsg(0, t) ).postln );

{
	var index, in, out, f0, fdiff;
	var bufnum = b;
	in = Pulse.ar(MouseX.kr(t.minItem, t.maxItem)) * 0.1;
	f0 = Pitch.kr(in).at(0);
	index = IndexInBetween.kr(bufnum, f0);
	fdiff = index.frac * (Index.kr(bufnum, index + 1) - Index.kr(bufnum, index));
	out = PitchShift.ar(in, 0.1, 1 - (fdiff / f0), 0.01, 0.01);
	RLPF.ar(out, [2000, 5000], 0.3)
}.play;
)

b.free;


// basic test.
(

s = Server.local;
t = [ 200, 210, 400, 430, 600, 800 ];
b = Buffer(s, t.size, 1);

// alloc and set the values
s.listSendMsg( b.allocMsg( b.setnMsg(0, t) ).postln );


{
	var index, f0, f1, f3;
	var bufnum = b;
	f0 = MouseX.kr(200, 900);
	index = IndexInBetween.kr(bufnum, f0);
	f1 = IndexL.kr(bufnum, index);
	SinOsc.ar([f0, f1]) * 0.1
	
}.play;
)

b.free;


// One way to map across from an arbitrary piecewise curve, onto another:
// We use IndexInBetween to "unmap" your input into integer slots, 
// and then use IndexL to do the reverse, to "map" onto your other distribution. 
// This example maps a sort-of-exponential curve onto a sort-of-sinusoidal curve:

~from = [1, 2, 4, 8, 16];
~to   = [0, 1,  0,  -1,    0];
(
x={
	IndexL.kr(~to.as(LocalBuf), IndexInBetween.kr(~from.as(LocalBuf),MouseX.kr(~from.first,~from.last).poll).poll).poll
}.play
)


