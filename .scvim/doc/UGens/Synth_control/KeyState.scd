KeyState		 respond to the state of a key

superclass: UGen

*kr(keycode, minval, maxval, lag)
	
keycode - The keycode value of the key to check. This corresponds to the keycode values passed into the keyDownActions of SCViews. See example below.
minval - The value to output when the key is not pressed.
maxval - The value to output  when the key is pressed.
lag - A lag factor.
	
See also MouseButton, MouseX, MouseY 
	
Note that this UGen does not prevent normal typing. It therefore may be helpful to select a GUI window rather than an SC document when using KeyState, as the latter will be altered by any keystrokes.
	
	
s.boot;

// execute the code below to find out a key's keycode
// the char and keycode of any key you press will be printed in the post window
(
w = SCWindow.new("I catch keystrokes");
w.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;  [char, keycode].postln; };
w.front;
)

// then execute this and then press the 'j' key
(
w.front; // something safe to type on
{ SinOsc.ar(800, 0, KeyState.kr(38, 0, 0.1)) }.play;
)
	


