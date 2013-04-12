SendReply		send an array of values from the server to all notified clients

SendReply.kr(trig, cmdName, values, replyID)
SendReply.ar(trig, cmdName, values, replyID)


	trig			a non-positive to positive transition triggers a message
	cmdName	a string or symbol, as a message name.
	values		array of ugens, or valid ugen inputs
	replyID		integer id (similar to SendTrig)
	

A message is sent to all notified clients. see Server See also: SendTrig.

cmdName		
	int - node ID
	int - reply ID
	... floats - values.



(
{
	SendReply.kr(Impulse.kr(3), 'the_answer', [40, 41, 42, 43] + MouseX.kr, 1905);
}.play(s);
)

o.remove; o = OSCresponder(nil, 'the_answer', { |t, r, msg| msg.postln }).add;


// multichannel expansion
(
{
	SendReply.kr(Impulse.kr(3), 
		'the_answer', 
		values: [[40, 80], [41, 56], 42, [43, 100, 200]], 
		replyID: [1905, 1906, 1907, 1908]
	);
}.play(s);
)


