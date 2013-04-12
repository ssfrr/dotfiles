PingPong  ping pong delay

PingPong.ar(bufnum, inputArray, delayTime, feedback, rotate)

Bounces sound between a number of outputs ...  like a ping-pong ball.
PingPong is actually a compound built upon RecordBuf and PlayBuf.

bufnum - first index of a multi channel buffer .
inputArray - an array of audio inputs, the same size as your buffer.
delaytime - delay time in seconds..
feedback - feedback coefficient.
rotate - default 1: which rotates the inputArray by one step.  (left -> right, right -> left)
 rotation of 0 (or 2) would result in no rotation to the inputArray


(
s = Server.local;
s.waitForBoot({

b = Buffer.alloc(s,44100 * 2, 2);

SynthDef("help-PingPong",{ arg out=0,bufnum=0,feedback=0.5,delayTime=0.2; 
 var left, right;
 left = Decay2.ar(Impulse.ar(0.7, 0.25), 0.01, 0.25, 
  SinOsc.ar(SinOsc.kr(3.7,0,200,500)));
 right = Decay2.ar(Impulse.ar(0.5, 0.25), 0.01, 0.25, 
  Resonz.ar(PinkNoise.ar(4), SinOsc.kr(2.7,0,1000,2500), 0.2));
  
 Out.ar(0,
  PingPong.ar(bufnum, [left,right], delayTime, feedback, 1)
 )
}).play(s,[\out, 0, \bufnum, b,\feedback,0.5,\delayTime,0.1]);
});
)


(
s = Server.local;
s.waitForBoot({

b = Buffer.alloc(s,44100 * 2, 2);

SynthDef("help-PingPong",{ arg out=0,bufnum=0;
 var left, right;
 left = Decay2.ar(Impulse.ar(0.7, 0.25), 0.01, 0.25,
  SinOsc.ar(SinOsc.kr(3.7,0,200,500)));
 right = Decay2.ar(Impulse.ar(0.5, 0.25), 0.01, 0.25,
  Resonz.ar(PinkNoise.ar(4), SinOsc.kr(2.7,0,1000,2500),
0.2));

 Out.ar(0,
  PingPong.ar(bufnum, [left,right] *  EnvGen.kr(Env([1, 1, 0], [2, 0.1])), 
   0.1, 0.8, 1)
 )
}).play(s,[\out, 0, \bufnum, b]);
});
)




