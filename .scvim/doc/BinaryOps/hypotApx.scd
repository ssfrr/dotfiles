hypotApx		hypotenuse approximation

BinaryOperator

hypotApx(x, y)
x hypotApx: y
x.hypotApx(y)

Returns an approximation of the square root of the sum of the squares of x and y. 

The formula used is :

abs(x) + abs(y) - ((sqrt(2) - 1) * min(abs(x), abs(y)))

hypotApx is used to implement Complex method magnitudeApx.
This should not be used for simulating a doppler shift because it is discontinuous. Use hypot.

See also hypot, atan2.



