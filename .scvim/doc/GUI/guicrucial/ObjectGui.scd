ObjectGui

superclass for all Gui classes

In the MVC architecture this is the Controller, which creates Views for manipulating the properties of your Model, and receives messages from the View and enacts the changes on the Model.

Each class specifies its Gui class via the guiClass method.

The default guiClass for an Object is ObjectGui.  So if a class does not implement guiClass at all, then at least there is a default ObjectGui that will display the name.

Many subclasses overide the guiClass method to specify a different class, one that subclasses ObjectGui.

see [gui]

It is the simplest display, just the the object asString.




an example gui class

YourSimpleGuiClass : ObjectGui {

	guiBody { arg layout;
	
		// we refer to the model and
		// access its variable howFast.
		// if its a simple number, it will display
		// using the default ObjectGui class, which
		// will simply show its value as a string.
		model.howFast.gui(layout);
	}
}


// more complex
YourGuiClass : ObjectGui {
	
	var numberEditor;
	
	//for example
	guiBody { arg layout;
		var r;
		// the object you are making a gui for is referred to as the model
		
		// display some param on screen.
		// here we assume that someParam is something that
		//  has a suitable gui class
		// implemented, or that the default ObjectGui is sufficient.
		model.someParam.gui(layout);
		
		// using non 'gui' objects
		r = layout.layRight(300,300); // allocate yourself some space
		Button(layout.win,r)
			.action_({ arg butt;
				model.goApeShit;
			});
		
		// note: NumberEditor is a cruciallib class
		numberEditor = NumberEditor(model.howFast,[0,100])
			.action_({ arg val; 
				model.howFast = val; 
				model.changed(this); 
				// tell the model that this gui changed it
			});
		numberEditor.gui(layout);
	}
	
	// your gui object will have update called any time the .changed message
	// is sent to your model
	update { arg changed,changer;
	
		if(changer !== this,{ 
			/* if it is this gui object that changed the value
				using the numberEditor, then we already have a correct
				display and don't need to waste cpu to update it.
				if anyone else changed anything about the model,
				we will update ourselves here.
			*/
			numberEditor.value = model.howFast;
			/*
				note that 
					numberEditor.value = model.howFast;
				is passive, and does not fire the numberEditor's action.	

					numberEditor.activeValue = model.howFast
				would fire the action as well, resulting in a loop that would
				probably crash your machine.
			*/
		}
	}

}




