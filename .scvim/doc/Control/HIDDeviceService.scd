HIDDeviceService

A Service that provides access to Human Interface Devices like joysticks and gamepads.

It is advised to use GeneralHID instead, which wraps the HIDDeviceService functionality, and produces crossplatform compatible code.


This service was mainly designed to use gamepads as control input. The name is derived from the mac osx specifications. 
The HIDDeviceService handles all the primitive calls. HIDDevice only stores information about a device and holds an array of HIDElements, which store information about the controllers of the device.
A HIDDevice's information consists out of: 
	the manufacturer, the product, the usage, the vendorID, the productID and the locID.
	The last three are used to identify the device. The vendorID and the productID are static for each device, the locID depends on the (usb) port the device is connected to.
A HIDDeviceElement's information consists out of: 
	the type, the usage, the cookie, the minimum and the maximum value.
	the cookie is a number that can be used to identify an element of a device.
	
There are two ways of getting values from the device: One is to poll a value, the other one is to start an eventloop that pushes every new value into the language and calls an action (like MIDIIn).
To set up an eventloop follow these steps:
	1. initialize the service by calling:
	
		HIDDeviceService.buildDeviceList;
		
	2. now the information about the devices can be found:
		
		(
		HIDDeviceService.devices.do({arg dev;
			[dev.manufacturer, dev.product, dev.vendorID, dev.productID, dev.locID].postln;
			dev.elements.do({arg ele;
				[ele.type, ele.usage, ele.cookie, ele.min, ele.max].postln;
			});
		});
		)
	
	3. the device needs to be queued, that means that the eventloop actually uses this device to push values. 
		
		HIDDeviceService.devices.at(0).queueDevice;
	
	4. set an action that is called by the incoming events. In addition to the value the events also deliver the productID, the vendorID and the locID of the device and the cookie of the element.
		
		(
		HIDDeviceService.action_({arg productID, vendorID, locID, cookie, val;
				[productID, vendorID, locID, cookie, val].postln;
		});
		)
		
	5. start the eventloop:
		
		HIDDeviceService.runEventLoop;
		
	6. stop the eventloop:
		
		HIDDeviceService.stopEventLoop;

		

buildDeviceList(usagePage, usage)

It is also possible to search for devices in other usage pages. (look in the class file)
the default is: page: GenericDesktop usage: Joystick. if a nil is passed in all devices are listed.


//HIDDeviceServis by jan trutzschler v. falkenstein

deviceSpecs
	you can add to the classvar deviceSpecs the specs of your device.
	the key used has to be the product name derived from the device info.
	

here is a collection of specs:

//wingman
(
HIDDeviceService.deviceSpecs.put('WingMan Action Pad', 
			IdentityDictionary[
				\a -> 0, \b-> 1, \c-> 2,
				\x-> 3, \y-> 4, \z-> 5,
				\l-> 6, //front left
				\r-> 7, //front right
				\s-> 8, 
				\mode-> 9,
				\xx-> 10,		
				\yy-> 11,		
				\slider-> 12,
				\hat-> 13
			])
)
//cyborg
(
HIDDeviceService.deviceSpecs.put(\cyborg,  //not the right product name yet, so this doesn't work.
			IdentityDictionary[
				\trig -> 0, \a-> 1, \b -> 2, \c -> 3,
				\f1-> 4, \f2-> 5, \f3-> 6, \f4 -> 7,
				\l -> 8, \r -> 9, // arrow buttons
				\hu -> 10, \hl -> 11, \hr -> 12, \hd -> 13, // hat positions
				\x -> 14, \y -> 15, \z -> 16, // axes
				\slider-> 17,
				\hat-> 18
			]);
)






