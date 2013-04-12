Phid				pattern that polls values from a human device interface (OSX only)

Note: this class is OSX specific. Please use the cross platform versions (based on GeneralHID), PhidKey or PhidSlot, instead.

superclass: Pattern


*new(element, locID, repeats)
	
		element		one element of the interface of the device, like a button or an axis
					can be an index or, if the devicespec is present, also a symbol
		
		locID		the index of the device, defaults to 0 (first device)
		
		repeats		number of values to return (defaults to inf)
		
		
		
// example

// while this is running, test your device
(
a = Phid(0,0);
x = a.asStream;

Routine({ loop({
	x.next.postln;
	0.2.wait;
}) }).play;
)

// using devicespecs:
// for example wingman. for other specs see [HIDDeviceService]
(
HIDDeviceService.deviceSpecs.put('WingMan Action Pad', 
			IdentityDictionary[
				// buttons
				\a -> 0, \b-> 1, \c-> 2,
				\x-> 3, \y-> 4, \z-> 5,
				\l-> 6, //front left
				\r-> 7, //front right
				\s-> 8, 
				\mode-> 9,
				\xx-> 10,		//analog controller x axis
				\yy-> 11,		//analog controller y axis
				\slider-> 12,
				\hat-> 13
			])
)


// then you can use the named key:
(
a = Phid(\x, 0, inf);
x = a.asStream;

Routine({ loop({
	x.next.postln;
	0.2.wait;
}) }).play;
)



// 'musical' example:
(
	Pbind(
		\freq, Pseq([Phid(\x,0,8),Phid(\y,0,8)],inf) * 500 + 200,
		\dur, Phid(\slider) + 0.02,
		\pan, Phid(\hat) * 2 - 1
	).play;
) 





