NdefMixer 		mix control for all Ndefs on a given server 

Inherits from: Object : ProxyMixer

For more details see: ProxyMixer


Creation / Class Methods


*new(server, nProxies = 16, title, bounds)
	Return a new window for a given server.
	server: Server object (Server) or server name (Symbol)
	// ndef mxers for other servers
	n = NdefMixer(\internal);
	n = NdefMixer(\localhost);
	n = NdefMixer(\trala); 		// fails, no such server

proxyspace
	Return the proxyspace.
	


Example
		

n = NdefMixer(s);			// for the default server
// make a new proxy
(
Ndef(\a, { 
	Pan2.ar(
		Ringz.ar(
			Impulse.ar(exprand(0.5, 4)), 
			exprand(300, 3000), 
			0.02
		), 
	1.0.rand2, 
	0.2)
})
);



n.proxyspace;

Ndef(\duster, { Dust.kr(4) });

Ndef(\a).ar;
Ndef(\a).fadeTime = 2;
Ndef(\a).end;





