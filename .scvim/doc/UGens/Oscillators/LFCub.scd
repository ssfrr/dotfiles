LFCub 

- a sine like shape made of two cubic pieces. smoother than LFPar.

freq = 440.0, iphase = 0.0, mul = 1.0, add = 0.0


{ LFCub.ar(LFCub.kr(LFCub.kr(0.2,0,8,10),0, 400,800),0,0.1) }.play
{ LFCub.ar(LFCub.kr(0.2, 0, 400,800),0,0.1) }.play
{ LFCub.ar(800,0,0.1) }.play
{ LFCub.ar(XLine.kr(100,8000,30),0,0.1) }.play




compare:

{ LFPar.ar(LFPar.kr(LFPar.kr(0.2,0,8,10),0, 400,800),0,0.1) }.play
{ LFPar.ar(LFPar.kr(0.2, 0, 400,800),0,0.1) }.play
{ LFPar.ar(800,0,0.1) }.play
{ LFPar.ar(XLine.kr(100,8000,30),0,0.1) }.play



{ SinOsc.ar(SinOsc.kr(SinOsc.kr(0.2,0,8,10),0, 400,800),0,0.1) }.play
{ SinOsc.ar(SinOsc.kr(0.2, 0, 400,800),0,0.1) }.play
{ SinOsc.ar(800,0,0.1) }.play
{ SinOsc.ar(XLine.kr(100,8000,30),0,0.1) }.play

{ LFTri.ar(LFTri.kr(LFTri.kr(0.2,0,8,10),0, 400,800),0,0.1) }.play
{ LFTri.ar(LFTri.kr(0.2, 0, 400,800),0,0.1) }.play
{ LFTri.ar(800,0,0.1) }.play
{ LFTri.ar(XLine.kr(100,8000,30),0,0.1) }.play


