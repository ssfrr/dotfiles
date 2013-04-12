InterplXYC					envelope specification

superclass: InterplEnv

See InterplEnv Help for more info

Basic Creation

takes sets of x, y and curve values and returns a new instance of InterplEnv.
x values can be negative (for use in indexing with negartive values or signals).

*new([x0, y0, c0], [x1, y1, c1]...[xn, yn])

	a = InterplXYC([0, 0, \lin], [1, 2, \sin], [2, 0]);
	
	a.plot;
	
	a = InterplXYC([[-1, 1, \sin], [0, 2, \lin], [1, 0]]);
	a.plot; 
	a.at(-0.5); 
	a.at(0.2);



