NodeProxyEditor has been replaced - please use NdefGui now!

NodeProxyEditor has been rewritten and renamed NdefGui, which has the same functionality, 
but is both more consistent and more flexible.
There are some changes to the *new method: instead of

	*new(proxy, nSliders=16, parent, extras=[\CLR, \reset, \scope, \doc, \end, \fade],
		monitor, sinks, morph)
	
	*new (object, numItems = 0, parent, bounds, makeSkip, options)

	proxy 		is now 		object 
	nSliders 		is now 		numItems 
	parent 		is still		parent
							bounds - can be Rect(l, t, w, h) or width@heights
							
							makeSkip - an option to build without skipjack.
	extras		are now		options, and have become more flexible.

Please see NdefGui for more details.



//////////////////////////
NodeProxyEditor  			editor for a nodeproxy

Inherits from: Object

NodeProxyEditor provides controls for handling and editing a node proxy and its monitors (cross-platform graphics).

	• sliders for numerical settings
	• mapping of kr proxies to parameters 
	• optional controls for playing / monitoring
	
NodeProxy and Ndef implement an edit message, which returns a NodeProxyEditor.
Overview: JITLib


Creation / Class Methods

	*new(proxy, nSliders=16, win, view)
	Returns a new instance for a given proxy. 
	If a window (win) or a composite view is given, it uses this.
	
	
Example	


	// preparation
s.boot;
p = ProxySpace.push(s); 

(
~test = { |freq=300, dens=20, amp=0.1, pan| 
	Pan2.ar(Ringz.ar(Dust.ar(dens, amp / (dens.max(1).sqrt)), freq, 0.2), pan) 
};
)

	// make a NodeProxyEditor
n = NodeProxyEditor();
n.proxy_(~test);

	// some configuration options	
	// number of sliders
n = NodeProxyEditor(~test, 6);

	// the top line has a choice of elements:
	\CLR 		button to clear proxy
	\reset		button to reset proxy nodemap
	\scope		button to scope proxy
	\doc			button to document proxy as code
	\end			button to end proxy
	\fade		EZNumber for setting fadetime

		not in the default elements:
	\rip			button to open a new editor on the proxy (used in ProxyMixer)
		
	\pausR		a button to toggle pause/resume
	\sendR		a button to re-send; alt-click does Rebuild

	\send		just send
	\rebuild		just rebuild
	\poll		poll the proxy
	
		// maybe provide later this? 
	\name -> { func }; 	// add your own element... 
	
	// The default buttons/controls are:
NodeProxyEditor(extras: nil, monitor: true, sinks: true);
	// these are:
NodeProxyEditor(extras: [\CLR, \reset, \scope, \doc, \end, \fade], monitor: true, sinks: true);
	// if no monitor line, you can add pausR and sendR buttons
NodeProxyEditor(extras: [\CLR, \reset, \pausR, \sendR, \scope], monitor: false, sinks: false);


	// barebones
NodeProxyEditor(extras: [], monitor: false);

	// not done yet - presets and morphing
NodeProxyEditor( morph: true);

	// also works with Ndef
Ndef(\a).ar; 
NodeProxyEditor(Ndef(\a));

	// place in existing window
(
w = Window("testing");
n = NodeProxyEditor(nSliders: 6, win: w);
n.proxy_(~test);
)
	// too many controls: an EZScroller helps.
(
~test = { |freq=300, dens=20, amp=0.1, pan, ping=12, tok=13, crak| 
	Pan2.ar(Ringz.ar(Dust.ar(dens, amp / (dens.max(1).sqrt)), freq, 0.2), pan) 
};
Spec.add(\dens, [0.1, 100, \exp, 0.01, 10]);
)
	// gets specs for slider ranges from global lookup in Spec.specs:
Spec.add(\dens, [0.1, 100, \exp, 0.01, 10]);
n.fullUpdate;

(	// keys go away if not needed
~test = { |freq=300, dens=20, amp=0.1| 
	Pan2.ar(Ringz.ar(Dust.ar(dens, amp / (dens.max(1).sqrt)), freq, 0.2)) 
};
)

(	// and are added in order if needed
~test = { |freq=300, intv=0, dens=20, amp=0.1, pan, pok, ting| 
	Pan2.ar(
		Ringz.ar(
			Dust.ar(dens ! 2, amp / (dens.max(1).sqrt)), 
			freq * [intv, intv.neg].midiratio, 0.2)) 
};
)

	// changes in settings are shown:
~test.set(\freq, exprand(100.0, 2000.0));
~test.playN;

	// mapping kr proxies to controls is shown
~lfo = { LFNoise0.kr(8, 4) };
~test.map(\intv, ~lfo);		
~test.unmap(\intv); 		

Spec.add(\intv, ControlSpec(0, 24, \lin, 0.01, 0)); n.fullUpdate;
	// setting a param value unmaps a previous control source
~test.set(\freq, rrand(200, 500), \intv, rrand(-5.5, 5.5));



You can drag and drop proxies between NodeProxyEditors: 

(
// p = ProxySpace.push(s.boot);

l = NodeProxyEditor(nil, 3); l.w.bounds_(l.w.bounds.moveBy(0, 120));
m = NodeProxyEditor(nil, 3); m.w.bounds_(m.w.bounds.moveBy(0, 240));
n = NodeProxyEditor(nil, 3); n.w.bounds_(n.w.bounds.moveBy(0, 360));
o = NodeProxyEditor(nil, 3); o.w.bounds_(o.w.bounds.moveBy(0, 480));

Spec.add(\dens, [0.1, 300, \exp]);

	// make 3 kinds of proxies: using tilde/proxyspace, Ndef, and unnamed.
~spacy = {|dens=5| Formlet.ar(Dust.ar(dens ! 2), LFDNoise0.kr(20 ! 2).lag(0.1).linexp(-1, 1, 300, 5000), 0.003, 0.03)  };
Ndef(\ndeffy, { GrayNoise.ar( 0.1 ! 2) });
c = NodeProxy.audio.source_({ PinkNoise.ar(0.1 ! 2) });
	
	// put one in each editor
l.proxy_(~spacy);
m.proxy_(Ndef(\ndeffy));
n.proxy_(c);		
)


