BeatTrack2						template matching beat tracker

#beattick, eighthtick, groovetick, tempo, phase, groove = BeatTrack2.kr(busindex, numfeatures, windowsize=2, phaseaccuracy=0.02, lock=0, weightingscheme)

busindex [sk]- Audio input to track, already analysed into N features, passed in via a control bus number from which to retrieve consecutive streams. 

numfeatures [s] How many features (ie how many control buses) are provided

windowsize [s] Size of the temporal window desired (2.0 to 3.0 seconds models the human temporal window). You might use longer values for stability of estimate at the expense of reactiveness. 

phaseaccuracy [s] Relates to how many different phases to test. At the default, 50 different phases spaced by phaseaccuracy seconds would be tried out for 60bpm; 16 would be trialed for 180 bpm. Larger phaseaccuracy means more tests and more CPU cost. 

lock [sk]- If this argument is greater than 0.5, the tracker will lock at its current periodicity and continue from the current phase. Whilst it updates the model's phase and period, this is not reflected in the output until lock goes back below 0.5.  

weightingscheme [s] Use (-2.5) for flat weighting of tempi, (-1.5) for compensation weighting based on the number of events tested (because different periods allow different numbers of events within the temporal window) or otherwise a bufnum from 0 upwards for passing an array of 120 individual tempo weights; tempi go from 60 to 179 bpm in steps of one bpm, so you must have a buffer of 120 values.  

This beat tracker is based on exhaustively testing particular template patterns against feature streams; the testing takes place every 0.5 seconds. The two basic templates are a straight (groove=0) and a swung triplet (groove=1) pattern of 16th notes; this pattern is tried out at scalings corresponding to the tempi from 60 to 180 bpm. This is the cross-corellation method of beat tracking. A majority vote is taken on the best tempo detected, but this must be confirmed by a consistency check after a phase estimate. Such a consistency check helps to avoid wild fluctuating estimates, but is at the expense of an additional half second delay. The latency of the beat tracker with default settings is thus at least 2.5 seconds; because of block-based amortisation of calculation, it is actually around 2.8 seconds latency for a 2.0 second temporal window.  

This beat tracker is designed to be flexible for user needs; you can try out different window sizes, tempo weights and combinations of features. However, there are no guarantees on stability and effectiveness, and you will need to explore such parameters for a particular situation.    


//required for MFCCs used below
b = Buffer.alloc(s,1024,1); //for sampling rates 44100 and 48000
//b = Buffer.alloc(s,2048,1); //for sampling rates 88200 and 96000

//this is a one minute pop song; you should load something equivalent for testing
d=Buffer.read(s,"/Volumes/data/stevebeattrack/samples/100.wav");
d=Buffer.read(s,"/Volumes/data/stevebeattrack/samples/019.wav");


//very feature dependent
(
a= SynthDef(\help_beattrack2_1,{arg vol=1.0, beepvol=1.0, lock=0;
var in, kbus; 
var trackb,trackh,trackq,tempo, phase, period, groove;
var bsound,hsound,qsound, beep;
var fft; 
var feature1, feature2, feature3; 

in= PlayBuf.ar(1,d.bufnum,BufRateScale.kr(d.bufnum),1,0,1);
//in = SoundIn.ar(0); 

//Create some features
fft = FFT(b.bufnum, in);

feature1= RunningSum.rms(in,64);
feature2= MFCC.kr(fft,2); //two coefficients
feature3= A2K.kr(LPF.ar(in,1000));

kbus= Out.kr(0, [feature1, feature3]++feature2); 

//Look at four features
#trackb,trackh,trackq,tempo, phase, period, groove=BeatTrack2.kr(0,4,2.0, 0.02, lock, -2.5);

beep= SinOsc.ar(1000,0.0,Decay.kr(trackb,0.1));

Out.ar(0,Pan2.ar((vol*in)+(beepvol*beep),0.0));
}).play
)


a.set(\vol,0.0);
a.set(\vol,1.0);

a.set(\beepvol,1.0);
a.set(\beepvol,0.0);

a.set(\lock,1); //fix it rigidly from current phase/period solution
a.set(\lock,0); //unfix, back to tracking








a.free;

//same thing, trying with Onsets UGen raw output
(
a= SynthDef(\help_beattrack2_1,{arg vol=1.0, beepvol=1.0, lock=0;
var in, kbus; 
var trackb,trackh,trackq,tempo, phase, period, groove;
var bsound,hsound,qsound, beep;
var fft; 
var feature1, feature2, feature3; 

in= PlayBuf.ar(1,d.bufnum,BufRateScale.kr(d.bufnum),1,0,1);
//in = SoundIn.ar(0); 

//Create some features
fft = FFT(b.bufnum, in);

feature1= Onsets.kr(fft,odftype:\mkl, rawodf:1);

feature2= Onsets.kr(fft,odftype:\complex, rawodf:1);//two coefficients

kbus= Out.kr(0, [feature1,feature2]); 

//Look at four features
#trackb,trackh,trackq,tempo, phase, period, groove=BeatTrack2.kr(0,2,3.0, 0.02, lock, -2.5);

beep= SinOsc.ar(1000,0.0,Decay.kr(trackb,0.1));

Out.ar(0,Pan2.ar((vol*in)+(beepvol*beep),0.0));
}).play
)








//favour higher tempi in own weighting scheme
(
c=Array.fill(120,{arg i; 0.5+(0.5*(i/120))});
e=Buffer.sendCollection(s, c, 1);
)


//track audio in (try clapping a beat or beatboxing, but allow up to 6 seconds for tracking to begin) and spawning stuff at quarters, eighths and sixteenths
(
SynthDef(\help_beattrack2_2,{
var trackb,trackh,trackq,tempo;
var source, kbus;
var bsound,hsound,qsound;

source= SoundIn.ar(0); //PlayBuf.ar(1,d.bufnum,BufRateScale.kr(d.bufnum),1,0,1);

//downsampling automatic via kr from ar
kbus= Out.kr(0, LPF.ar(source,1000)); //([feature1, feature3]++feature2); 

#trackb,trackh,trackq,tempo=BeatTrack2.kr(0,1,weightingscheme:e.bufnum);

bsound= Pan2.ar(LPF.ar(WhiteNoise.ar*(Decay.kr(trackb,0.05)),1000),0.0);

hsound= Pan2.ar(BPF.ar(WhiteNoise.ar*(Decay.kr(trackh,0.05)),3000,0.66),-0.5);

qsound= Pan2.ar(HPF.ar(WhiteNoise.ar*(Decay.kr(trackq,0.05)),5000),0.5);

Out.ar(0, source + bsound+hsound+qsound);
}).play;
)










//Research note: Designed by Nick Collins following work by Jean Laroche

//geometric tempo placement very similar to linear, and linear easier to deal with looking up related tempi at double and half speed
(
var startbps= 1, endbps=3; 
var numtempi=100;
var ratio; 
var tempi, periods; 

ratio= (endbps/startbps)**((numtempi-1).reciprocal); 

tempi= Array.geom(numtempi, startbps, ratio); 

periods= tempi.reciprocal;

Post << (tempi*60) << nl; 
Post << periods << nl; 
)

//create linear periods
Post << ((Array.series(120,1,2/120)).reciprocal) << nl; 

//tempo weights
 Post << (Array.fill(120,{arg i;  0.2*((1.0- ((abs(i-60))/60.0))**0.5) + 0.8; })) << nl; 



