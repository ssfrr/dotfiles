SCImageFilter

filter class to use with SCImage
currently this class represents the CoreImage Filters you can apply to a SCImage.

all the built-in filters and docs:

http://developer.apple.com/documentation/GraphicsImaging/Reference/CoreImageFilterReference/Reference/reference.html


Class Methods
	
	*new (filterName, args)
		filterName - The filter name Symbol or String
		args - The filter name Symbol or String
	
	f = SCImageFilter.new(\CIStarShineGenerator);
	f.attributes;
	
	// or you can do also Synth like style if you already know the attributes of this synth
	f = SCImageFilter.new(\CIStarShineGenerator, [\center, [200,200], \radius, 200*0.05]);
	f.values; //
	
	*filterCategories
		Returns a Dictionary containing all the filters associated by categories.
	// getting filter categories (dictionary)
	(
		SCImageFilter.filterCategories.keysDo({|cat|
			cat.postln;
		});
		"ok".postln;
	)
	
	// getting Filters for a category - returns a SymbolArray
	SCImageFilter.filterCategories.at(\CICategoryGeometryAdjustment);
	SCImageFilter.filterCategories.at(\CICategoryGenerator);
	
	// finding Non Built In Plugins usually plugins loaded in (/Library/Graphics/Image Units/)
	// all plugins are loaded at startup
	// you can find free plugins at http://www.noiseindustries.com/products/
	(
	var n = 0;
	SCImageFilter.filterCategories.do ({
		|symbolArray|
		symbolArray.do ({|pluginName|
			if(pluginName.asString.beginsWith("CI").not, {
				("External Filter Found: " ++ pluginName).postln;
				n = n+1;
			});
		});
	});
	(n + "plugins found").postln;
	n;
	)


Instance Methods

	attributes	
		returns an IdentityDictionary containing for each association:
		the attribute/property name as the key.
		the supercollider Class you should use as an argument to set the attribute.
		Once you know the attributes you can set them like using normal instance setters, use the name and append '_'.
		
	(
	f = SCImageFilter.new(\CIStarShineGenerator);
	f.attributes.keysValuesDo({|k, v|
		("CIStarShineGenerator responds to "++k.asString++"_("++v.asString++")").postln;
	});
	)
	
	f.center_([200,200]);
	f.radius_(200*0.05);
	
	attributeRange
		get the numerical range and the default Value for an attribute.
		returns an Array as [ min, max, default ]
		min, max, or default may be a Float, a Color, an Array or Nil.
	
	// a SCImageFilter
	f = SCImageFilter.new(\CIFlashTransition);
	
	f.dump;
	
	f.attributes;
	
	f.attributeRange(\time);
	
	// getting all attributes MIN - MAX possible values
	(
	f.attributes.keysDo({|attr|
		(attr ++ " = " + f.attributeRange(attr)).postln; // nil results means there is no min max for those attributes
	});
	)
	
	values
		returns all the values you setted for each attributes. If a value is not explicitely setted
		for an attribute, it will be set to default when applied to the SCImage.

	(
		f = SCImageFilter.new(\CIStarShineGenerator);
		f.center_([200,200]);
		f.radius_(200*0.05);
		f.color_(Color.blue);
		f.crossWidth_(2.0);
		f.crossAngle_(0.0);
		f.crossOpacity_(-4.0);
		f.values.postln;
	)

	set( args )
		set the attributes for this SCImageFilter
	(
		f = SCImageFilter.new(\CIStarShineGenerator);
		f.set(\center, [200,200], \radius, 200*0.05, \color, Color.blue, \crossWidth, 2.0);
		f.values.postln;
	)	

	enable_(yorn)
		enable or not the Filter when applied to a SCImage. If yorn is false, applying the filter will do
		nothing.
	
	enable
		is the filter enabled ? true is default
		
		
		

//EXAMPLES


// thor's fast experimentation request
// example with the filters array wich allows you to use filters without applying them in place
// convenient for RT use / test or whatever...

// here scale down the image otherwise with the zoomblur it will take your computer
// to its knees using addFilter and not applyFilter
// kinda fast swapping test

a = SCImage.new("/Library/Desktop Pictures/Plants/Peony.jpg").scalesWhenResized_(true).setSize(500, 400);
a.plot; // look at me first - i am beautiful

// but i want you to be posterize
(
h = SCImageFilter.new(\CIColorPosterize);
a.addFilter(h); // first call needed
a.plot; // there should have it
)

// then you can freely access and set the slot directly - easier
(
a.filters[0] = SCImageFilter.new(\CIColorInvert);
a.plot;
)

// again
(
a.filters[0] = SCImageFilter.new(\CIZoomBlur);
a.plot;
)

// again
(
a.filters[0] = SCImageFilter.new(\CIRandomGenerator);
a.plot;
)

(
a.removeAllFilters;
a.plot(freeOnClose:true);
)


// ** Masking Example **
(
f = SCImageFilter.new(\CIColorMonochrome); // create a GrayScale image
g = SCImageFilter.new(\CISourceInCompositing); // compositing we will use
f.color_(Color.black);
f.intensity_(1.0);
a = SCImage.new(Document.current.dir +/+ "vduck2.jpg");
a.bounds;
b = SCImage.new(Document.current.dir +/+ "flowers2.jpg");
a.applyFilters([f, SCImageFilter(\CIColorInvert), SCImageFilter(\CIMaskToAlpha)]); // grayscale + invert + maskToAlpha = create a mask
g.backgroundImage_(a); // set up background image
b.applyFilters(g); // create masked image
a.free;
w = b.plot(freeOnClose:true, background:Color.clear); // set to clear color to see plainly the image
)


// *** Kinda very simple real time FX using the .filters property of SCImage **
// SCImage.filters provides a way to set up filters to apply in the rendering chain
// this can be useful to modify in RT some filter properties
// but they won't be processed inplace, they will be computed at each rendering
// here the filter calc is performed at each rendering call
// so this is convenient but not optimal
// SCPhotoshop :)
(
var width=500, height=500, centerVector;
var controller, specs;

centerVector = [width*0.5, height*0.5];
a = SCImage.new(500@500);
a.accelerated_(true);
f = SCImageFilter.new(\CIStarShineGenerator);
g = SCImageFilter.new(\CIPixellate);
h = SCImageFilter.new(\CIZoomBlur);

f.center_(centerVector);
f.radius_(width*0.05);
f.color_(Color.green);
f.crossWidth_(2.0);
f.crossAngle_(0.0);
f.crossOpacity_(-4.0);
g.center_(centerVector);
h.center_(centerVector);
h.amount_(50);

// simple example control
specs = [
	[f, \crossOpacity_, [-8, 0].asSpec, -4],
	[f, \crossAngle_, [-pi, pi].asSpec, 0.0],
	[h, \amount_, [0, 200].asSpec, 50],
	
]; // CIStarShine opacity, CIZoomBlur

controller = SCWindow.new("Close Me First !!!", Rect(400,400,300,specs.size * 40));
controller.view.decorator = FlowLayout(controller.view.bounds.insetBy(10), 10@10);
specs.size.do {|i|
	SCSlider.new(controller, Rect(0,0,150,20))
	.action_({|obj|
		specs[i][0].perform(specs[i][1], specs[i][2].map(obj.value));
		w.refresh;
	})
	.value_(specs[i][2].unmap(specs[i][3]));
	controller.view.decorator.nextLine;
};

// adding filters
a.addFilter(f);
a.addFilter(g);
a.addFilter(h);

a.filters.do {|filt, i|
	if(i != 0, {
		SCButton.new(controller, Rect(0,0,20,20))
		.action_({|obj|
			filt.enable_(obj.value != 1);
			w.refresh;
		})
		.states_([["", Color.white], ["", Color.white, Color.black]]);
	});
};

// plotting
w = a.plot(background:Color.black);
controller.front;
controller.onClose_({
	{
	w.close;
	}.defer(0.1);
});
)


/*
// ******** Using EXTERNAL NI Image Units Generator + FX *******
// Download them --- MIGHT BE 10.5 Only so
// http://www.noiseindustries.com/downloads/Units.dmg
// When using for the first time an Image plugin, it might take some extra time due to the plugin loading
// Random
(
f = SCImageFilter.new(\NINoiseGenerator);
f.width_(500); f.height_(500);
f.grayscale_(true);
a = SCImage.new(500@500);
a.applyFilters(f);
w = a.plot(freeOnClose:true, background:Color.black);
)


(
f = SCImageFilter.new(\NIDropShadow);
f.offsetX_(0);
f.offsetY_(0);
f.radius_(30);
f.shadowColor_(Color.red);
a = SCImage.new("vduck2.jpg");
a.applyFilters(f, a.bounds.outsetBy(500));
w = a.plot(freeOnClose:true, background:Color.clear);
a.bounds;
)

(
f = SCImageFilter.new(\NIDotsGenerator);
f.softness_(1);
a = SCImage.new(500@500);
a.applyFilters(f);
w = a.plot(freeOnClose:true, background:Color.black);
)

(
f = SCImageFilter.new(\NICircle);
a = SCImage.new(500@500);
a.applyFilters(f);
w = a.plot(freeOnClose:true);
)
*/


