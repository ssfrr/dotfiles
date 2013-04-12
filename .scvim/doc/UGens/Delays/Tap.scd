Tap			A single tap into a delayline

Tap.ar(bufnum, numChannels, delaytime)

The Tap UGen allows a single tap at a delay into a buffer. 
bufnum - the index of the buffer to use
numChannels - number of channels of the buffer
delaytime - tap delay; cannot be modulated 

See also: PlayBuf (Tap uses the PlayBuf UGen internally). 


// Create a buffer. 
b=Buffer.alloc(s, s.sampleRate, 1); //enough space for one second of mono audio  

// Write to the Buffer with BufWr, read using two Taps, one for each ear!
(
SynthDef(\helpTap, {|bufnum|
	var source, capture; 
	
	source= SoundIn.ar(0); //use headphones to avoid feedback
	capture= BufWr.ar(source, bufnum, Phasor.ar(0,1, 0, BufFrames.ir(bufnum),1));
 
	Out.ar(0, Tap.ar(bufnum, 1, [0.1,0.9])); //multichannel expansion, so one tap each ear  
}).send(s); 
)

x=Synth(\helpTap,[\bufnum, b]);

x.free;


