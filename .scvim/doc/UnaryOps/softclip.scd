softclip		nonlinear distortion

a.softclip
softclip(a)

Distortion with a perfectly linear region from -0.5 to +0.5

Server.internal.boot;

{ FSinOsc.ar(500,0.0, XLine.kr(0.1, 10, 10)).softclip * 0.25 }.scope(2);



