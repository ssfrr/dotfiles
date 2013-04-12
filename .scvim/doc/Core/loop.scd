loop / repeat


create an object that behaves like a stream that returns values for a limited (or infinite) number of times.


Function-loop
	repeats the function forever.
	
	f = { 3.yield };
	x = Routine({ f.loop });
	10.do({ x.next.postln })


Object-repeat(n)
	repeat to yield the object
	
	x = 5;
	y = x.repeat(6);
	y.nextN(8);


Pattern-repeat(n)
	
	x = Prand([1, 2]).repeat(6).asStream;
	x.nextN(8);

Pattern-loop
	
	x = Prand([1, 2]).loop.asStream;
	x.nextN(8);
	

Stream-repeat(n)

	embeds the stream repeatedly
	
	x = Routine({ 3.do({ arg i; i.yield }) }).repeat(6);
	x.nextN(8);
	
Stream-loop

	embeds the stream repeatedly
	
	x = Routine({ 3.do({ arg i; i.yield }) }).loop;
	x.nextN(8);
	





