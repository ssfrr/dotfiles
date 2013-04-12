EZLists			an abstract superclass for EZListView and EZPopUpMenu	

Inherits from: Object : EZGui

Users will not normally directly create instances of EZLists, but only use it through its subclasses. It provides the basic mechanisms for EZListView and EZPopUpMenu.

See also: EZListView and EZPopUpMenu

Creation / Class Methods

	*new (parentView, bounds, label, items, globalAction, initVal, initAction, labelWidth, layout, gap)
	
Building and Changing the List

	globalAction_(function)
	globalAction
		
		a Global function to be performed in addition to the item functions: {arg listObj; value}.

	items
	items_ (assocArray)
	
		assocArray - An Array of Associations including the labels and the item functions: ['label' -> {arg listObj; value}, ]. In menus, the OS X graphics system gives special meanings to some characters. See SCPopUpMenu; Or and Array Symbols (if you are only using globalAction). Arrays of Symbols will get converted into and array of Associations with and empty Function:['label' -> {}, ].
		
	item
	
		Returns the item label of the current selection.
		
	itemFunc
	
		Returns the item function of the current selection

	addItem (name, action)
	
		Adds an item.
		name - An instance of String or Symbol. The name of the list/menu item.
		action - An instanc of Function.
		
	insertItem (index, name, action)
	
		Inserts a list/menu item at positiion of index.
		index - An integer. The index where to insert an item.
		name - An instance of String or Symbol. The name of the list/menu item.
		action - A n instanc of Function.

	replaceItemAt (index, name, action)
	
		Replace a list/menu item at positiion of index. 
		index - An integer. The index where to insert an item.
		name - An instance of String or Symbol. The name of the list/menu item. Default is the current item label.
		action - A n instanc of Function. Default is the current item action-

	removeItemAt (index)
	
		Removes a list/menu item at positiion of index.
		index - An integer. The index where to remove an item.
		
		
		
	remove
		removes both the view, label and the list/menu from the parent view.		

Accessing Values

	value
	value_ (val)
	
		Gets/sets the list/menu to the index at value. Does not perform the action.
		val - An integer.

	valueAction_ (val)
	
		Sets the value and performs the action at the index value and the global action.
		val - An integer.
		
	doAction
	
		Performs the action at the current index and the global action.
		
	initViews
	
		Called by init and overriden by all subclasses. This is where the class specific views are built.



