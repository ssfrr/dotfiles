TdefEditor will be replaced - please use TdefGui now!

has been rewritten and renamed TdefGui, which has largely the same functionality, 
but is more consistent and more flexible.
There are some changes to the *new method: instead of

	*new(px, nVars, height, width, parent, makeWatcher)
	
	*new (object, numItems, parent, bounds, extras)

	px 			is now 		object 
	nVars 		is now 		numItems 
	height &		can be put as	bounds: height @ width
	width
	parent 		is still		parent
	makeWatcher	is now 		makeSkip

Please see TdefGui for more details.



