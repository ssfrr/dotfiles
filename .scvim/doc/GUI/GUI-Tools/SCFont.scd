SCFont			a font object	

Inherits from: Object

This is the object you pass to other gui objects to set their font name or size. 

Creation / Class Methods

	*new (name, size)
	
		name - An instance of String. Must coincide with the name of a font on the system. See *availableFonts
		size - An Instance of Float.
		
		g = Font.new("Helvetica", 12);

	*availableFonts
	
		Returns an array of the available fonts.

	*antiAliasing_ (flag)
	.
		flag - An instance of Boolean. Default value is false.

	*smoothing_ (flag)
	
		flag - An instance of Boolean. Default value is false.

	*defaultSansFace
	
		Returns the default sans face Font.

	*defaultSerifFace
	
		Returns the default serif face Font.


	*defaultMonoFace
	
		Returns the default mono face Font.


Accessing Instance and Class Variables

	*default
	
		Class Variable. Gets/sets the default Font.
				
	name_(arg1)
	name
		
		Gets/sets the name of a font.
		arg1 - An instance of String.
				
	size_(arg1)
	size
		
		Gets/sets the size of a font.
		arg1 - An instance of Float.
					
	setDefault
	
		Makes the current instance of Font the default.
		
	storeArgs
	
		Returns an Array, [ name, size ].

	boldVariant
	
		Appendes "-Bold" to the name. This is only useful for fonts that have bold variants.


Examples

(
w=SCWindow.new.front;
t=SCStaticText(w, w.view.bounds).align_(\center);
t.string=" SUPERCOLLIDER";
)
t.font=Font("Monaco", 24);



(
var updateFont;
w=SCWindow("Fonts", Rect(150,SCWindow.screenBounds.height-500, 400,400)).front;
w.view.decorator = FlowLayout( w.view.bounds);
SCStaticText.new(w, Rect(5,0,30,20)).string_("Font").align_(\rght);
m=SCPopUpMenu(w, Rect(40,0,250,20));
m.items = Font.availableFonts;

SCStaticText.new(w, Rect(290,0,28,20)).string_("Size").align_(\right);
y=SCPopUpMenu(w, Rect(322,0,50,20));
y.items = ["6","7","8","9","10","12","13","14","18","24","36","48","60","72","96"];

t=SCTextView(w, Rect(10,40,380,150));
t.string="\nThe quick drowned fox jumped over the lazy blog. \n\n 0 1 2 3 4 5 6 7 8 9 ";

a=SCStaticText(w, 200@20).string_("The quick drowned fox").background_(Color.rand).align_(\center);
b=SCButton(w, 200@20).states_([["The quick drowned fox"]]).background_(Color.rand);
c=SCPopUpMenu(w, 200@20).items_(["The quick drowned fox"]).background_(Color.rand);

y.action={
	var font;
	font= Font(m.items[m.value],y.items[y.value].asInteger);
	a.font_(font).refresh;
	b.font_(font).refresh;
	c.font_(font).refresh;
	t.font_(font).refresh;
	};

m.action=y.action;

m.valueAction=3;
y.valueAction=5;

)


(
var w,f;

w = SCWindow("Fonts", Rect(128, 64, 340, 360));
w.view.decorator = f = FlowLayout(w.view.bounds,Point(4,4),Point(4,2));

[
"Helvetica-Bold",
"Helvetica",
"Monaco",
"Arial",
"Gadget",
"MarkerFelt-Thin"

].do({ arg name;
	var v, s, n, spec, p, height = 16;

		v = SCStaticText(w, Rect(0, 0, 56, height+2));
		v.font = Font(name, 13);
		v.string = name;

		s = SCButton(w, Rect(0, 0, 140, height+2));
		s.font = Font(name, 13);
		s.states = [[name]];
		
		n = SCNumberBox(w, Rect(0, 0, 56, height+2));
		n.font = Font(name, 13);
		n.object = pi;

	f.nextLine;
});

w.front;

)


(
var w,f,i=0;

w = SCWindow("Fonts", Rect(128, 64, 820, 760));
b = SCScrollView(w, w.view.bounds);

b.decorator = f = FlowLayout(b.bounds,Point(4,4),Point(4,2));

Font.availableFonts.do({ arg name;
	var v, s, n, spec, p, height = 16,font;
	font = Font(name,13);
	
		v = SCStaticText(b, Rect(0, 0, 56, height+2));
		v.font = font;
		v.string = name;

		s = SCButton(b, Rect(0, 0, 140, height+2));
		s.font = font;
		s.states = [[name]];
		s.action = { font.asCompileString.postln; };
		
		n = SCNumberBox(b, Rect(0, 0, 56, height+2));
		n.font = font;
		n.object = pi;
	if( (i = i + 1) % 3 == 0,{
		f.nextLine;
	});
});

w.front;

)




