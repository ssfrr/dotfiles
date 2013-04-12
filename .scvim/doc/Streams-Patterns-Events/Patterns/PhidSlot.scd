PhidSlot				pattern that polls values from a human device interface, based on an indexed slot


superclass: Pattern


*new(slot, type, device, repeats)
	
		slot		index pointing to a slot like a button or an axis
		
		type		index pointing to the type of slot (see GeneralHID for a description of this)
		
		device		a GeneralHIDDevice, or an element from the GeneralHID.deviceList, which will then be opened by the pattern
		
		repeats		number of values to return (defaults to inf)
		
See also: GeneralHID and PhidKey

		
// example 

// build the device list and start the event loop: 
GeneralHID.buildDeviceList; 
GeneralHID.startEventLoop; 
 
// find an Impact game device and open it: 
a = GeneralHID.open( GeneralHID.findBy( 1973 ) ); 

// inspect the capabilities of this device:
a.caps; 

// boot the server 
s.boot; 

// simple example: 
p = Pbind( 
        \degree, ( PhidSlot( 0, 3, a, inf )*12 ).round(1), 
        \dur, 0.25 
).play; 

p.stop; 

// more complex example, showing multichannel expansion and sequences of slots: 
p = Pbind( 
        \degree, ( PhidSlot( Pseq([[0,1],2,5],inf), 3, a, inf )*12 ).round(1), 
        \dur, 0.25 
).play; 

// the type argument can also be replaced by an Array or pattern.

p.stop; 


// clean up: close the device and stop the eventloop 
a.close; 
GeneralHID.stopEventLoop; 



