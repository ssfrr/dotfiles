NetAddr			network address

superclass: Object


	*new(hostname, port)	create new net address. 
						Hostname is a string, either an ip number (e.g. "192.168.34.56") or a hostname such as "otherHost.local".
						Port is a port number, like 57110.
						Note: to send messages internally, loopback ip is used: "127.0.0.1"
	
	*fromIP(ip, port)	create new net address using an integer ip number.
	
	*langPort		Get the port sclang is currently listening on (may change after a recompile).
	
	*localAddr		Get a NetAddr which corresponds to localhost and the port sclang is listening on.
	
	sendMsg(args...)		send a message without timestamp to the addr.
	
	sendBundle(timestamp, args...)	send a bundle with timestamp to the addr.
	
	sendRaw(rawArray)	send a raw message without timestamp to the addr.
	
	connect(disconnectHandler)		open TCP connection. disconnectHandler is called when
						the connection is closed (either by the client or by the server)
	
	disconnect			close TCP connection
	
	ip 					returns the ip number (as string)
						example: 
						n = NetAddr("localhost", 57110);
						n.ip;
	
	*disconnectAll			close all TCP connections
	
	*broadcastFlag			check broadcast flag
	
	*broadcastFlag_( flag )			Sets the broadcast flag (whether or not broadcast messages can be sent)
	
	*useDoubles_( flag )			
	


// example


n = NetAddr("127.0.0.1", 57120); // 57120 is sclang default port
r = OSCresponder(n, '/good/news', { arg time, resp, msg; [time, msg].postln }).add;

n.sendMsg("/good/news", "you", "not you");
n.sendMsg("/good/news", 1, 1.3, 77);


n.sendBundle(0.2, ["/good/news", 1, 1.3, 77]);

r.remove;
n.disconnect;

// note that different NetAddr objects with the same port and ip are independent.

r = OSCresponder(nil, '/x', { "message arrived".postln }).add;

n = NetAddr("127.0.0.1", 57120);
n.sendMsg("/x")


u = NetAddr("127.0.0.1", 57120);
u.sendMsg("/x");

n.disconnect

u.sendMsg("/x");

r.remove;
u.disconnect;





