NdefMixer 		mix control for an Ndef proxyspace

NdefMixer is nearly identical to ProxyMixer, except that it looks at the 
proxyspaces for each server that Ndef.all contains.

See also ProxyMixer, JITGui, NdefGui


n = NdefMixer(s);

s.boot;

"bcdefghijk".do { |k| Ndef(k.asSymbol).ar };

"lmnopqrtuvw".do { |k| Ndef(k.asSymbol).kr };

"abcdefghijk".do { |k| Ndef(k.asSymbol).playN };
(
Ndef(\aaaaaa, { |freq=250, intv=19, timescale=1, curve=0, loopnode=0| 
	var env = EnvGen.kr(
		Env({ 1.0.rand2 }!11, {1.0.rand}!10, curve, releaseNode: 9, loopNode: loopnode), 
		timeScale: timescale);
	var pitch = (env * [1, 0.33, -1] * intv).midiratio * freq;
	Splay.ar(Formant.ar(pitch, pitch.scramble * 2, pitch.scramble)) * 0.1;
});
)

n.switchSize(2);
n.switchSize(1);
n.switchSize(0);
n.editGui.object_(Ndef(\aaaaaa));

NdefMixer(Server.internal, 24);



