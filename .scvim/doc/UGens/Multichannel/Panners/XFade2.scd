XFade2   equal power two
channel cross fade





XFade2.ar(inA, inB, pan, level)





pan -&nbsp; -1 ..
1





(

SynthDef("help-XFade2",
{

 Out.ar(0, XFade2.ar(
Saw.ar, SinOsc.ar
, LFTri.kr(0.1), 0.1 ));

}).play

)



