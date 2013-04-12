DC			create a constant amplitude signal 

DC.ar(in)

This UGen simply outputs the initial value you give it. 

in - constant value to output, cannot be modulated, set at initialisation time


//won't work (the output is 0.5*0.0), which is why we need the DC UGen!
{0.5}.play

//constantly zero 
{DC.ar(0.0) }.play;


//DC offset; will click on start and finish
{DC.ar(0.5) + SinOsc.ar(440,0,0.1) }.play;


//test - note the transient before LeakDC adapts and suppresses the offset
{LeakDC.ar(DC.ar(0.5))}.play;


//For these examples, you might want to boot the internal server
Server.default =s = Server.internal;
s.boot; 
s.scope


