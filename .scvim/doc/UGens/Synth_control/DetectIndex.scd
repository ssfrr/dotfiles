DetectIndex			search a buffer for a value		

DetectIndex.ar(bufnum, in, mul, add)
DetectIndex.kr(bufnum, in, mul, add)



bufnum - index of the buffer
in - the input signal.


(
var max = 300;
t = Array.series(max, 0, 1).curdle(0.06).scramble.flat;
b = Buffer(s, t.size, 1);

// alloc and set the values
s.listSendMsg( b.allocMsg( b.setnMsg(0, t) ) );


{
	var index, in, out, f0, fdiff;
	var bufnum = b;
	var input;
	input = MouseX.kr(0, max).round(1); // round to precision
	index = DetectIndex.kr(bufnum, input);
	index.poll;
	SinOsc.ar(index.linexp(0, max, 200, 700)) * 0.1
}.play;
)

b.free;


