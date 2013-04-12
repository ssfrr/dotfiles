PhidKey				pattern that polls values from a human device interface, based on a named slot


superclass: Pattern


*new(key, device, repeats)
	
		key		key defined in the Spec of the device, pointing to a slot like a button or an axis
		
		device		a GeneralHIDDevice, or an element from the GeneralHID.deviceList, which will then be opened by the pattern
		
		repeats		number of values to return (defaults to inf)
		
See also: GeneralHID and PhidSlot

		

// example 

// build the device list and start the event loop: 
GeneralHID.buildDeviceList; 
GeneralHID.startEventLoop; 
 
// find an Impact game device and open it: 
a = GeneralHID.open( GeneralHID.findBy( 1973 ) ); 

// define a spec: 
( 
a.add( \lx, [3,0]); // left x 
a.add( \ly, [3,1]); // left y 
a.add( \rx, [3,2]); // right x 
a.add( \ry, [3,5]); // right y 
); 

// or find a spec defined previously for this device: 
c = a.findSpec; 
// set it: 
a.setSpec( c[0] ); 

// inspect the spec 
a.spec.map 
a.caps; 

// boot the server 
s.boot; 

// simple example: 
p = Pbind( 
        \degree, ( PhidKey( \lx, a, inf )*12 ).round(1), 
        \dur, 0.25 
).play; 

p.stop; 

// more complex example, showing multichannel expansion and sequences of slots: 
p = Pbind( 
        \degree, ( PhidKey( Pseq([[\lx,\ly],\rx,\ry],inf), a, inf )*12 ).round(1), 
        \dur, 0.25 
).play; 

p.stop; 


// clean up: close the device and stop the eventloop 
a.close; 
GeneralHID.stopEventLoop; 




