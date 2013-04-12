EZListView			a wrapper class for a label plus a listView with per item actions	

Inherits from: Object : EZGui : EZLists

EZListView is wrapper class which creates an (optional) label and a listView. It includes per item actions as well as a global action which are both evaluated upon selection of an item. Convenience methods for inserting and deleting list items are also included . If the parent is nil, then EZListView will create its own window. See EZGui and EZLists for all of the options.

See also: ListView

Some Important Issues Regarding EZListView

The convenience methods for EZListView require that the items array is an array of associations of labels and functions, not like in ListView, where items is simply an array of strings. If label is nil, then no staticText is created. 

Creation / Class Methods

	*new (parentView, bounds, label, items, globalAction, initVal, initAction, labelWidth, labelHeight,layout,gap)
	
		parent - The parent view or window. If the parent is nil, then EZListView will create its own Window, and place it conveniently on the screen if the bounds are a Point. If the bounds are a Rect, then the Rect determines the window bounds.
		bounds - An instance of Rect or Point. Default value is 160@200.
		label - The label. Default value is nil. If nil, then no StaticText is created. 
		items - Default value is nil. An Array of Associations ['label' -> {arg listObj; value}, ].Or and Array Symbols (if you are only using globalAction).
		globalAction - a Global function to be performed in addition to the item functions {arg listObj; value}.
		initVal - Initial value of the List, i.e. the index selected. Default value is 0.
		initAction - An instance of Boolean. Performs the action at initVal on creation of the list, plus the globalAction. Default value is false.
		labelWidth - Default value is 80. Not used if layout is \vert.
		labelHeight - Default value is 20. Not used if layout is \horz.
		layout- \vert or \horz. default is vert;
		gap - A Point. By default, the view tries to get its parent's gap, otherwise it defaults to 2@2. Setting it overrides these.
		margin - A Point. This will inset the bounds occupied  by the subviews of view.
		
		
		(
		// default with vertical layout
		w=Window.new.front;
		w.view.decorator = FlowLayout(w.view.bounds);
		g = EZListView.new(w,
			230@230,
			"An ListView:",
			[	
				\item0 ->{|a| ("this is item 0 of " ++ a).postln},
				\item1 ->{|a| ("this is item 1 of " ++ a).postln},
				\item2 ->{|a| ("this is item 2 of " ++ a).postln},
			],
			globalAction: {|a| ("this is a global action of "++a.asString ).postln},
			initVal: 2,
			initAction: true,
			labelWidth: 120,
			labelHeight: 16,
			layout: \vert,
			gap: 2@2
			);
			
		)
		
		// or a more simple syntax (uses decorator gap settings):
		(
		w=Window.new.front;
		w.view.decorator = FlowLayout(w.view.bounds);
		g = EZListView.new(w,200@230, " List:");
		g.addItem(\item0, {|a| ("this is item 0 of " ++ a).postln});
		g.addItem(\item1, {|a| ("this is item 1 of " ++ a).postln});
		g.addItem(\item2, {|a| ("this is item 2 of " ++ a).postln});
		g.setColors(Color.grey,Color.white);
		)
		
Changing Appearance
	
	setColors(stringBackground,stringColor,listBackground,listStringColor,
		selectedStringColor,hiliteColor,background)
	
		stringBackground - An instance of Color. The background of the label and unit views.
		stringColor - An instance of Color. The stringColor of the label and unit views.
		listBackground - An instance of Color. The background of the list view.
		listStringColor - An instance of Color. The stringColor of the list view.
		selectedStringColor - An instance of Color. The selectedStringColor of the listView.
		hiliteColor - An instance of Color. The hiliteColor of the list view.
		background - An instance of Color. The background of the list view.
		
	font_(font)
		Set the Font used by all the views.
		font - An instance of Font. 

		
Examples
	
// Creates its own window if parent is nil:
(
g = EZListView.new(label: " My PopUp List: ");
g.addItem(\item0, {"this is item 0". postln});
g.addItem(\item1, {"this is item 1". postln});
g.addItem(\item2, {"this is item 2". postln});
g.setColors(Color.grey,Color.white);

)

// Layout horizontal:
(
g = EZListView.new(nil,205@180, "Choose One: ", layout:\horz);
10.do{|i| g.addItem("item"++i.asString, {("this is item" ++i.asString). postln})};
g.setColors(Color.grey,Color.white);
)

// No labelView created, so set the window title;
(
g = EZListView.new(bounds:200@230); // no label
12.do{|i| g.addItem("item"++i.asString, {("this is item" ++i.asString). postln})};
g.view.parent.findWindow.name=" choose item";
)
	
// insert item;
(
g = EZListView.new(nil,200@200, "List:");
g.addItem(\item0, {"this is item 0". postln});
g.addItem(\item1, {"this is item 1". postln});
g.addItem(\item2, {"this is item 2". postln});
g.addItem(\item4, {"this is item 4". postln});
)

g.insertItem(3, \item3, {"this is item 3". postln});
						
// remove item;
(
g = EZListView.new(nil,200@200, "List:");
g.addItem(\item0, {"this is item 0". postln});
g.addItem(\item1, {"this is item 1". postln});
g.addItem(\item2, {"this is item 2". postln});
g.addItem(\item4, {"this is item 4". postln});
g.insertItem(3, \item3, {"this is item 3". postln});
)

g. removeItemAt(1);



// replace item;
(
g = EZListView.new(nil,200@200, "List:");
g.addItem(\item0, {"this is item 0". postln});
g.addItem(\item1, {"this is item 1". postln});
g.addItem(\item2, {"this is item 2". postln});
g.addItem(\item3, {"this is item 3". postln});
)

g.replaceItemAt(2, \item2_replaced, {"this is item 2 replaced". postln});




