SimpleController

SimpleController can be used as a controller according to the model-view-controller (M-V-C) paradigm. It provides an IdentityDictionary of actions, which are called whenever the attached model sends a notification by calling changed.


Class Methods

	*new(model)
		
		Creates a SimpleController instance with the model to be observed. Model can an object of any class

Instance Methods

	put(what, action)
		
		Register an action, which is called when the model invokes changed(what, moreArgs).
	

Examples:

(
	var controller, model, view;
	
	model = Ref(0.5);
	controller = SimpleController(model);
	controller.put(\value, 
		{|theChanger, what, moreArgs| 
			view.value_(theChanger.value);
		});
	
	view = Slider(Window("slider", Rect(100, 100, 330, 38)).front, Rect(5, 5, 320, 20));
	view.onClose_{controller.remove};
	
	// run a routine to change the model's value:
	r{
		100.do{
			model.value_(1.0.rand.postln).changed(\value);
			0.5.wait;
		}
	}.play(AppClock)
)


