Operators

SuperCollider supports operator overloading. Operators can thus be applied to a variety of different objects; Numbers, Ugens, Collections, and so on. When operators are applied to ugens they result in BinaryOpUGens or UnaryOpUGens. See the BinaryOpUGen overview helpfile for details.

Unary Operators

neg .. inversion
reciprocal .. reciprocal
abs .. absolute value
floor .. next lower integer
ceil .. next higher integer
frac .. fractional part
sign .. -1 when a < 0, +1 when a > 0, 0 when a is 0
squared .. a*a
cubed .. a*a*a
sqrt .. square root
exp .. exponential
midicps .. MIDI note number to cycles per second
cpsmidi .. cycles per second to MIDI note number
midiratio .. convert an interval in MIDI notes into a frequency ratio
ratiomidi .. convert a frequency ratio to an interval in MIDI notes
dbamp .. decibels to linear amplitude
ampdb .. linear amplitude to decibels
octcps .. decimal octaves to cycles per second
cpsoct .. cycles per second to decimal octaves
log .. natural logarithm
log2 .. base 2 logarithm
log10 .. base 10 logarithm
sin .. sine
cos .. cosine
tan .. tangent
asin .. arcsine
acos .. arccosine
atan .. arctangent
sinh .. hyperbolic sine
cosh .. hyperbolic cosine
tanh .. hyperbolic tangent
distort .. distortion
softclip .. distortion
isPositive .. 1 when a >= 0, else 0
isNegative .. 1 when a < 0, else 0
isStrictlyPositive .. 1 when a > 0, else 0
(36)

Binary Operators

+ .. addition
- .. subtraction
* .. multiplication
/ .. division
% .. float modulo
** .. exponentiation
<  .. less than
<= .. less than or equal
>  .. greater than
>= .. greater than or equal
== .. equal
!= .. not equal
<! .. return first argument
min .. minimum of two
max .. maximum of two
round .. quantization by rounding
trunc .. quantization by truncation
atan2 .. arctangent
hypot .. hypotenuse   sqrt(a*a + b*b)
hypotApx .. hypotenuse approximation
ring1 .. a*b + a   or equivalently:   a*(b + 1)
ring2 .. a*b + a + b
ring3 .. a*a*b
ring4 .. a*a*b - a*b*b
sumsqr .. a*a + b*b
difsqr .. a*a - b*b
sqrsum .. (a + b)**2
sqrdif .. (a - b)**2
absdif .. fabs(a - b)
thresh .. threshholding   { 0 when a < b, a when a >= b }
amclip .. two quadrant multiply   { 0 when b <= 0, a*b when b > 0 }
scaleneg .. nonlinear amplification   { a when a >= 0, a*b when a < 0 }
clip2  .. bilateral clipping { b when a > b, -b when a < -b, else a }
wrap2  .. bilateral wrapping
fold2  .. bilateral folding
excess .. residual of clipping   a - clip2(a,b)
(36)





