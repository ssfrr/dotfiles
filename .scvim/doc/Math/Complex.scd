Complex				complex number

inherits from: Object : Magnitude : Number

A class representing complex numbers.

Note that this is a simplified representation of a complex number, which does not implement the full mathematical notion of a complex number. 


Creation

new(real, imag)

	Create a new complex number with the given real and imaginary parts.
		
		a = Complex(2, 5);
		a.real;
		a.imag;


Accessing

	real
	real_(val)
	
		The real part of the number.
	
	imag 
	imag_(val)
	
		The imaginary part of the number.
	
	

Math

	+ aNumber
	
		Complex addition.
		
		Complex(2, 9) + Complex(-6, 2)
	
	- aNumber
	
		Complex subtraction.
		
		Complex(2, 9) - Complex(-6, 2)
	
	* aNumber
	
		Complex multiplication.
		
		Complex(2, 9) * Complex(-6, 2)
	
	/ aNumber
	
		Complex division.
		
		Complex(2, 9) / Complex(-6, 2)
		
	** aNumber
	
		Complex exponentiation (not implemented for all combinations - some are mathematically ambiguous).
		
		Complex(0, 2) ** 6
		2.3 ** Complex(0, 2)
		Complex(2, 9) ** 1.2 // not defined
		
	exp(aNumber)
	
		Complex exponentiation with base e.
				
		exp(Complex(2, 9))
		exp(Complex(0, pi)) == -1 // Euler's formula: true
		
	squared
	
		Complex self multiplication.
				
		squared(Complex(2, 1))
		
	cubed
	
		Complex double self multiplication.
				
		squared(Complex(2, 1))
		
		
	< aNumber
	
		Answer the comparison of just the real parts.
		
		Complex(2, 9) < Complex(5, 1);
	
	== aNumber
	
		Answer the comparison assuming that the reals (floats) are fully embedded in the complex numbers 
		
		Complex(1, 0) == 1;
		Complex(1, 5) == Complex(1, 5);
		
	neg
	
		Negation of both parts.
		
		Complex(2, 9).neg
		
	abs
	
		The absoulte value of a complex number is its magnitude.
		
		Complex(3, 4).abs
	
	conjugate
	
		Answer the complex conjugate.
			
		Complex(2, 9).conjugate


Conversion

	magnitude
	
		Answer the distance to the origin.
	
	rho
	
		Answer the distance to the origin.
	
	angle
	
		Answer the angle in radians.
	
	phase
	
		Answer the angle in radians.
	
	theta
	
		Answer the angle in radians.
	
	asPoint
	
		Convert to a Point.
	
	asPolar
	
		Convert to a Polar
	
	asInteger
	
		Answer real part as Integer.
	
	asFloat
	
		Answer real part as Float.
	



// example

a = Complex(0, 1);
a * a; // returns Complex(-1, 0);

// julia set approximation
f = { |z| z * z + Complex(0.70176, 0.3842) };

(
	var n = 80, xs = 400, ys = 400, dx = xs / n, dy = ys / n, zoom = 3, offset = -0.5;
	var field = { |x| { |y| Complex(x / n + offset * zoom, y / n + offset * zoom) } ! n } ! n;
	w = Window("Julia set", bounds:Rect(200, 200, xs, ys)).front;
	w.view.background_(Color.black);
	
		w.drawHook = {
			n.do { |x|
				n.do { |y|
					var z = field[x][y];
					z = f.(z);
					field[x][y] = z;
					Pen.color = Color.gray(z.rho.linlin(-100, 100, 1, 0));
				 
					Pen.addRect(
						Rect(x * dx, y * dy, dx, dy)
					);
				Pen.fill
				}
			}
		};
		fork({ 6.do { w.refresh; 2.wait } }, AppClock)
)






