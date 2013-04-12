WiiMote			use the Nintendo (tm) Wii Remote	

Inherits from: Object

The WiiMote class allows you to access the WiiMote from SuperCollider, both to receive data from the device, as well as send data to the device.


Some Important Issues Regarding WiiMote

This class has been developed to work both on the Mac and on Linux. The interface is mostly the same, but there are some usage issues on the Mac.
Personally, I found that it works better with an external BlueTooth receiver, than with the internal one (tested on the MacBook Pro). I also found that on the Mac, I have to connect, disconnect and then reconnect to get everything to work properly.

The IR options, as well as the Classic controller have not been tested (due to lack of access to either complementary device by the developer).

Creation / Class Methods

	*start(updtime)
		Starts the eventloop. Only really necessary on Mac, but use it for cross platform robustness.
		updtime - updatetime of the eventloop in milliseconds

	*discover
		Discovers a new device. This calls for the creation of a new device and class instance by calling the method new. new should not be called directly. When discover is called, the buttons 1 and 2 on the Wii Remote should be pushed to put the device in discovery mode.

	*all
		Returns an Array with all WiiMote devices.

		// Example to start up:
		WiiMote.start;    // start the eventloop
		WiiMote.discover; // discover a new device
		WiiMote.all;      // post an array of all devices
		
		// cleanup:
		WiiMote.closeAll; // close all devices
		WiiMote.stop;
		
	*closeAll
		Close all WiiMote devices.
		
	*stop
		Stops the eventloop. Only really necessary on Mac, but use it for cross platform robustness.
				
Accessing Instance and Class Variables

	dumpEvents_( bool )
	dumpEvents
		dump incoming events for debugging purposes
	spec
		Returns the device specification, with symbolic names for each item. Each name links to the current value.
	actionSpec
		Returns the device action specification, with symbolic names for each item. Each name in the dictionary links to an action to be performed upon receiving a new value.

	closeAction( aFunction )
		Set an action to be performed when the device closes
	connectAction( aFunction )
		Set an action to be performed when the device connects
	disconnectAction( aFunction )
		Set an action to be performed when the device disconnects

	at( key )
		Get the value of a device property at the given key
		
	setAction( key, aFunction )
		Set an action to be performed when the value of key changes. The key name must be one that occurs in the spec.
	removeAction( key )
		Remove the previously defined action at the key
	close
		Close the device	
	
The properties of the Wii Remote:

	battery
		Returns the current battery status of the device
	ext_type
		Returns the extension type that is connected

	remote_buttons
		Returns an Array with the current button values
	remote_motion
		Returns an Array with the current acceleration values (x,y,z, orientation). Orientation is Mac only.
	remote_ir
		Returns an Array with the found IR objects. (not tested!).
	remote_leds
		Returns an Array with the current LED values
		
	setLEDState( id, value )
		Set the LED with number id to value value (1=on, 0=off).
	rumble( value )
		Turn on the rumble, value (1=on, 0=off).
		
	enable( onoff ) 
		Enable the device
	enableExpansion( onoff ) 
		Enable the device expansion (nunchuk or classic controller)
	enableButtons( onoff ) 
		Enable the buttons on the device
	enableMotionSensor( onoff ) 
		Enable the motion sensor on the device
	enableIRSensor( onoff ) 
		Enable the IR sensor on the device

The properties of the NunChuk:
	nunchuk_buttons
		Returns an Array with the current button values
	nunchuk_motion
		Returns an Array with the current acceleration values (x,y,z, orientation). Orientation is Mac only.
	nunchuk_stick
		Returns an Array with the current stick values

The properties of the Classic Controller:
	classic_buttons
		Returns an Array with the current button values
	classic_stick1
		Returns an Array with the current stick values of stick 1
	classic_stick2
		Returns an Array with the current stick values of stick 2
	classic_analog
		Returns an Array with the current analog values

Examples

// Example to start up and view values
		WiiMote.start;    // start the eventloop
		WiiMote.discover; // discover a new device (wait for post about connected)
		
		WiiMote.all;      // post an array of all devices
		
		w = WiiMote.all[0];
		x = WiiMoteGUI.new( w ); // create a GUI (only covers the WiiMote and NunChuk currently)
		
		w.enableMotionSensor( 1 );
		w.enableExpansion( 1 );
		
		w.setLEDState( 0,1 ); // turn the first LED on
		w.rumble( 1 ); // rumble the device
		w.rumble( 0 ); // rumble the device
		
		w.setAction( \bA, { |v| v.postln; } ); // post the value when button A changes.
		w.removeAction( \bA );
		
	// (MacOSX) if you do not see any changes in the motion sensors, then the connection is bad.
	// push the red button inside the battery compartment, or the buttons 1 and 2 on the WiiMote and start over again to discover...
	
		WiiMote.discover; // discover a new device
		WiiMote.all;      // post an array of all devices
		
		w = WiiMote.all[1];
		x.w.close; // close previous window
		x = WiiMoteGUI.new( w ); // create a GUI (only covers the WiiMote and NunChuk currently)
		
		// now it should work..., if not, repeat the exercise...
		
		
	// clean up
		WiiMote.closeAll; // close all devices
		WiiMote.stop;
		x.w.close;


