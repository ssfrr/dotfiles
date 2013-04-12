hypot		hypotenuse

BinaryOperator

hypot(x, y)
x hypot: y
x.hypot(y)

Returns the square root of the sum of the squares of a and b. Or equivalently, the distance from the origin
to the point (x, y). 
See also atan2.

In this example, hypot is used to calculate a doppler shift pitch and amplitude based on distance.

(
{
	var x, y, distance, velocity, pitchRatio, amplitude;
	// object travels 200 meters in 6 secs (=120kph) passing 10 meters 
	// from the listener
	x = 10;
	y = LFSaw.kr(1/6, 0, 100);
	distance = hypot(x, y);
	velocity = Slope.kr(distance);
	pitchRatio = (344 - velocity) / 344;  // speed of sound is 344 meters/sec
	amplitude = 10 / distance.squared;
	FSinOsc.ar(1000 * pitchRatio, 0, amplitude)
}.play)

The next example uses the distance to modulate a delay line.

(
{
	var x, y, distance, velocity, pitchRatio, amplitude, motorSound;
	// object travels 200 meters in 6 secs (=120kph) passing 10 meters 
	// from the listener
	x = 10;
	y = LFSaw.kr(1/6, 0, 100);
	distance = hypot(x, y);
	amplitude = 40 / distance.squared;
	motorSound = RLPF.ar(FSinOsc.ar(200, 0, LFPulse.ar(31.3, 0, 0.4)), 400, 0.3);
	DelayL.ar(motorSound, 110/344, distance/344, amplitude)
}.play)


