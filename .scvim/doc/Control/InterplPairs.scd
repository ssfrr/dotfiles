InterplPairs					envelope specification

superclass: InterplEnv

See InterplEnv Help for more info

Basic Creation

takes an array of [x, y] pairs and a curve value for all break points
x values can be negative (for use in indexing with negartive values or signals).


*new([[x0, y0], [x1, y1] ... [xn, yn]], curve)

	a = InterplPairs([[0, 1], [1, 2], [2, 0]], \sin);
	
	a.plot;
	
	a = InterplPairs([[-1, 1], [0, 2], [1, 0]], \sin);
	a.plot; 
	a.at(-0.5); 
	a.at(0.2);


