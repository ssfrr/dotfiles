atan2		arctangent

BinaryOperator

atan2(y, x)
y atan2: x
y.atan2(x)

Returns the arctangent of y/x.

See also hypot.

OK, now we can add a pan to the hypot doppler examples by using atan2 to find the azimuth, 
or direction angle, of the sound source.
Assume speakers at +/- 45 degrees and clip the direction to between those.

(
{
	var x, y, distance, velocity, pitchRatio, amplitude, azimuth, panValue;
	// object travels 200 meters in 6 secs (=120kph) passing 10 meters 
	// from the listener
	x = 10;
	y = LFSaw.kr(1/6, 0, 100);
	distance = hypot(x, y);
	velocity = Slope.kr(distance);
	pitchRatio = (344 - velocity) / 344;  // speed of sound is 344 meters/sec
	amplitude = 10 / distance.squared;
	azimuth = atan2(y, x); // azimuth in radians
	panValue = (azimuth / 0.5pi).clip2(1);
	Pan2.ar(FSinOsc.ar(1000 * pitchRatio), panValue, amplitude)
}.play)

(
{
	var x, y, distance, velocity, pitchRatio, amplitude, motorSound, 
			azimuth, panValue;
	// object travels 200 meters in 6 secs (=120kph) passing 10 meters 
	// from the listener
	x = 10;
	y = LFSaw.kr(1/6, 0, 100);
	distance = hypot(x, y);
	amplitude = 40 / distance.squared;
	motorSound = RLPF.ar(FSinOsc.ar(200, 0, LFPulse.ar(31.3, 0, 0.4)), 400, 0.3);
	azimuth = atan2(y, x); // azimuth in radians
	panValue = (azimuth / 0.5pi).clip2(1); // make a value for Pan2 from azimuth
	Pan2.ar(DelayL.ar(motorSound, 110/344, distance/344), panValue, amplitude)
}.play)


