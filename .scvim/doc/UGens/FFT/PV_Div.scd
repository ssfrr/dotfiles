PV_Div			complex division

PV_Div(bufferA,  bufferB)

Complex division.
bufferA - fft buffer A.
bufferB - fft buffer B.

See also PV_Mul, PV_MagDiv, FFT Overview.


Example
In this example we estimate the transfer function of the LPF UGen. The transfer function is estimated by dividing the FFT of the output, by the FFT of the input, and looking at the magnitudes in the result.

(
s.waitForBoot {
	var fftsize = 16384;
	b = Buffer.alloc(s, fftsize)
}
);


(
x = {
	// Any input should theoretically be OK, white noise is a good choice
	var son = WhiteNoise.ar;
//	var son = Impulse.ar;
	var out = LPF.ar(son, MouseX.kr(100, 10000, 1));
	var fft1 = FFT(LocalBuf(b.numFrames), son, wintype: 1);
	var fft2 = FFT(b, out, wintype: 1);
	
	// As with most PV_ ugens, the result is *actually* stored in the first fft buf
	var result = PV_Div(fft2, fft1);
	
	Out.ar(0, out.dup * 0.1);
}.play;
)

// Now we can grab the FFT buffer and peek at the magnitudes
(
w = Window.new.front;
t = Task{loop{
	0.1.wait;
	b.loadToFloatArray(action: {|data| {
		w.view.children.do(_.remove);
		w.refresh;
		data[2..].clump(2)
		.collect {|a| (a[0].squared + a[1].squared)}
		.collect {|a| if(a.isNaN){ 0.post }{ a } }
		.plot(parent: w)
	}.defer});
}}.play;
)


