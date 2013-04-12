Number			mathematical quantity

Superclass: Object : Magnitude 

Number represents a mathematical quantity.

Math

	+ aNumber
	
	Addition.
	
	- aNumber
	
	Subtraction.
	
	* aNumber
	
	Multiplication.
	
	/ aNumber
	
	Division.
	
	div(aNumber)
	
	Integer division.
	
	% aNumber
	
	Modulo.
	
	** aNumber
	
	Exponentiation.
	
	squared
	
	The square of the number.
	
	cubed
	
	The cube of the number.
	


Polar Coordinate Support

	rho
	
	Answer the polar radius of the number.
	
	theta
	
	Answer the polar angle of the number.
	
	
	

Complex Number Support

	real
	
	Answer the real part of the number.
	
	imag
	
	Answer the imaginary part of the number.
	
	

Conversion

	@ aNumber
	
	Create a new Point whose x coordinate is the receiver and whose y coordinate is aNumber.
	
	complex(imaginaryPart)
	
	Create a new Complex number whose real part is the receiver with the given imaginary part.
	
	polar(angle)
	
	Create a new Polar number whose radius is the receiver with the given angle.
	
	
	

Iteration

	for(endval, function)
	
		Calls function for numbers from this up to endval, inclusive, stepping each time by 1.
		endval - a Number.
		function - a Function which is passed two arguments, the first which is an number from this to
		endval, and the second which is a number from zero to the number of iterations minus one.
	
	forBy(endval, step, function)
	
		Calls function for numbers from this up to endval stepping each time by step.
		endval - a Number.
		step - a Number.
		function - a Function which is passed two arguments, the first which is an number from this to
		endval, and the second which is a number from zero to the number of iterations minus one.
		
	
	forSeries(second, last, function)
	
		Calls function for numbers from this up to endval stepping each time by a step specified by second.
		second - a Number.
		last - a Number.
		function - a Function which is passed two arguments, the first which is an number from this to
		endval, and the second which is a number from zero to the number of iterations minus one.
		
	
	
	


