GeneralHIDSlot			
A uniform class to a slot of an HID device.
	

Inherits from: Object

GeneralHID is a cross platform wrapper for accessing HID devices. Currently the MacOSX and Linux HID support has been wrapped. Some of the code is inspired by the GUI wrapper.
A GeneralHIDSlot accesses one specific capability of a device, such as a button, an axis or an LED. Its value can be retrieved, an action can be set to be performed when data comes in, and the slot can be mapped to a control bus to use the value directly on the server. Slots are automatically created when a device is opened, so it is not necessary for a user to create a new slot.

See  GeneralHID for a complete explanation and an example of how to access an HID device.

It is advised to use this class instead of the platform specific classes: HIDDeviceService (on MacOSX) and LID (on Linux)


Some outstanding issues

This class is not completely finished yet. Common slot numbers across platforms are not yet guaranteed. On Windows there is not yet a proper implementation available.


Accessing Instance and Class Variables
	debug_( arg onoff )
		Turns on debugging for the slot.
	

	value
		Get the current value of the slot.
	

	value_(arg val)
		Set the current value of the slot to val. This is only sensible when the slot represents an LED on the device.
	

	rawValue
		Return the unscaled value of the slot.
	

	action_(arg function)
		Assign a function to the slot. The function has as an argument the slot.
	

	createBus( arg server )
		Create a control bus on the specified server, and map the incoming values to this bus.
	

	bus
		Returns the bus to which this slot is mapped, if a bus has been created.
	

	freeBus
		Free the bus on the server.
	

	kr
		JITLib support. This calls .createBus, and returns an In.kr on the bus for you.
	

Example
See  GeneralHID for a complete example of using an HID device.





