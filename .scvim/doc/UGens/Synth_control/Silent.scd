Silent			create a UGen which always outputs zero 

Silent.ar(in)

This UGen simply outputs zero

numChannels - Number of channels of silence to endure


//silence is golden
{Silent.ar}.play

//multichannel silence; the perfect electroacoustic work? 
{Silent.ar(8)}.play

//now with offset
{Silent.ar + 0.5 }.play;

//For these examples, you might want to boot the internal server
Server.default =s = Server.internal;
s.boot; 
s.scope


