Point		Cartesian point

Superclass: Object

Defines a point on the Cartesian plane.


Creation

new(inX, inY)

defines a new point.


Accessing

x

get the x coordinate value.

y

get the y coordinate value.

x_(aValue)

set the x coordinate value.

y_(aValue)

set the y coordinate value.

set(inX, inY)

Sets the point x and y values.


Testing

== aPoint

answers a Boolean whether the receiver equals the argument.

hash

returns a hash value for the receiver.


Math

+ aPointOrScalar

Addition.

- aPointOrScalar

Subtraction.

* aPointOrScalar

Multiplication.

/ aPointOrScalar

Division.

translate(aPoint)

Addition by a Point.

scale(aPoint)

Multiplication by a Point.

rotate(angle)

Rotation about the origin by the angle given in radians.

abs

Absolute value of the point.

rho

return the polar coordinate radius of the receiver.

theta

return the polar coordinate angle of the receiver.

dist(aPoint)

return the distance from the receiver to aPoint.

transpose

return a Point whose x and y coordinates are swapped.

round(quantum)

round the coordinate values to a multiple of quantum.

trunc(quantum)

truncate the coordinate values to a multiple of quantum.


Conversion

asPoint

returns the receiver.

asComplex

returns a complex number with x as the real part and y as the imaginary part.

asString

return a string representing the receiver.

asShortString

return a short string representing the receiver.

paramsCompileString

represent parameters to 'new' as compileable strings. (See Object::asCompileString)



