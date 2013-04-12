GeneralHIDDevice   
A uniform class to an HID device.
 





Inherits from: Object





GeneralHID is a cross platform wrapper for
accessing HID devices. Currently the MacOSX and Linux HID support has
been wrapped. Some of the code is inspired by the GUI wrapper.

A GeneralHIDDevice accesses one HID device,
such as a mouse, joystick or gamepad. Devices are automatically created
when a building the device list with GeneralHID,
so it is not necessary for a user to create a new device.





See  GeneralHID
for a complete explanation and an example of how to access an HID
device.

It is advised to use this class
instead of the platform specific classes: HIDDeviceService
(on MacOSX) and LID (on Linux)





Some outstanding issues





This class is not completely finished yet.
Common slot numbers across platforms are not yet guaranteed. On Windows
there is not yet a proper implementation available.






Accessing Instance and Class
Variables


open( arg device )

  Opens the device; the
device should be an item got from the device list.

 


isOpen

  Checks whether the
device is open.

 


info

  Display information
about the device, such as the name and vendor.

 


caps

  Display information
about the capabilities of the device in a readable format.

 


slots

  Access to the slots of
the device. See GeneralHIDSlot.

 


makeGui

  Make a generic gui to see the data coming in on the slots.

 


close

  Closes the device.




grab

  Get exclusive access to the device (linux only). Be careful with this when it is the only keyboard, as you will have no way to get back control

 


ungrab

  Give up exclusive access to the device (linux only).



 

Example

See  GeneralHID
for a complete example of using an HID device.



