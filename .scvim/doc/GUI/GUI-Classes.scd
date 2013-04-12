GUI Classes		

Lists of kit-specific and kit-independant gui classes.

See also: GUI, GUI-Overview

List of Kit-independant GUI Classes

These classes are platform neutral in themselves.
				




EZSlider	


EZNumber


EZRanger


EZListView




EZPopUpMenu


EZScroller


EZKnob


EZText




Gradient	


HiliteGradient	


FlowLayout


Color





List of Redirection Classes and their Corresponding Kit-specific GUI Classes

The following list contains the ViewRedirect subclass and corresponding CocoaGUI and SwingGUI platform dependent classes:





ViewRedirect


CocoaGUI


SwingGUI


Description




Window


SCWindow


JSCWindow


a frame that can contain gadgets




-----------------


SCModalWindow


-----------------


a modal window




-----------------


SCModalSheet


-----------------


a modal sheet to attach to windows




View


SCView


JSCView


The base class for most view classes. Important help file.




CompositeView


SCCompositeView


JSCCompositeView


container view for nesting layouts




HLayoutView


SCHLayoutView


JSCHLayoutView


container view with horizontal distribution of children




VLayoutView


SCVLayoutView


JSCVLayoutView


container view with vertical distribution of children




Button


SCButton


JSCButton


a multiple state push button




PopUpMenu


SCPopUpMenu


JSCPopUpMenu


a collapsed multiple choice button




Slider


SCSlider


JSCSlider


a horizontal or vertical slider




RangeSlider


SCRangeSlider


JSCRangeSlider


horizontal or vertical interval slider




Slider2D


SC2DSlider


JSC2DSlider


a horizontally and vertically moveable slider




TextField


SCTextField


JSCTextField


an editable one line text field




ListView


SCListView


JSCListView


a list of text items




StaticText


SCStaticText


JSCStaticText


a text label




NumberBox


SCNumberBox


JSCNumberBox


editable number field




DragSource


SCDragSource


JSCDragSource


object container acting as a source for drag-n-drop




DragSink


SCDragSink


JSCDragSink


object container acting as a target for drag-n-drop




DragBoth


SCDragBoth


JSCDragBoth


combination of DragSource and DragSink




Stethoscope


SCStethoscope


JStethoscope


oscilloscope tool




ScopeView


SCScope


JSCScope


oscilloscope view




TabletView


SCTabletView


JSCTabletView


view for receiving graphic tablet data




TabletSlider2D


SC2DTabletSlider


-----------------


2D slider with support for graphic tablet data




FreqScope


SCFreqScopeWindow


JFreqScope


spectrum tool




FreqScopeView


SCFreqScope


JSCFreqScope


spectrum view




MultiSliderView


SCMultiSliderView


JSCMultiSliderView


array of sliders




EnvelopeView


SCEnvelopeView


JSCEnvelopeView


breakpoint envelope editor




UserView


SCUserView


JSCUserView


view for user-defined drawing operations




SoundFileView


SCSoundFileView


JSCSoundFileView


waveform view / editor for sound files




MovieView


SCMovieView


JSCMovieView


canvas for movie (QuickTime) and image display




TextView


SCTextView


JSCTextView


multiline text editor




-----------------


SCQuartzComposerView


-----------------


view for displaying QuartzComposer documents




-----------------


SCImage


-----------------


an image component for the Mac OS X




-----------------


SCImageFilter


-----------------


a filter class to use with SCImage




-----------------


SCImageKernel


-----------------


a kernel class to use with SCImage.




Knob


SCKnob


JKnob


a knob view





Other Redirects and Platform Specific Classes





Cross Platform


CocoaGUI


SwingGUI


Description




Dialog


CocoaDialog


SwingDialog


file selection dialog management




Font


SCFont


JFont


a font typeface description.




Pen


SCPen


JPen


custom drawing operations class




MouseX


MouseX


JMouseX


UGen. JMouseX for backward compatiblility only.




MouseY


MouseY	


JMouseY


UGen. JMouseY for backward compatiblility only.




MouseButton


MouseButton


JMouseButton


UGen. JMouseButton for backward compatiblility only.




KeyState


KeyState	


JKeyState


UGen. JKeyState for backward compatiblility only.




use GUI.speech


Speech


JSpeech


text-to-speech synthesis management





Helper Methods





Cross Platform


CocoaGUI


SwingGUI


Description




GUI.stringBounds


is synchronous


is asynchronous


returns a Rect with the graphic size of a string. See the example in GUI-Overview for asynchronous use









