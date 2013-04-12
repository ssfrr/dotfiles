HistoryGui 			a gui for History objects


The gui elements in detail:

	button start stops and starts History _if_ gui.history is current. 
 	popUp sameDoc/newDoc switches whether the postDoc method posts to old post-doc window or new. 
 	button closeAll closes all documents called "History repeats", 
 	button closeOld closes only those created from this gui, except the latest.

 	button X/- turns filtering on/off
 	popup \all selects which key to search for (only useful if networked)
 	textview allows for typing in search string.
 	
 	listview shows either all lineShorts, or the filtered lineShorts; 
 	selecting them in listview makes them come appear in post-doc window. 
 	
(
h = History.new.lines_([
	[0, \me, "1+2"], 
	[1, \me, "3+5"], [1.234, \you, "q = q ? ();"], 
	[3, \her, "\"Herstory\".speak"]
]);
g = h.makeWin;
g.findDoc;
g.postDoc(2);
)


h.document;
	// how filtering works:
g.filters.postcs;
g.filterOff; 
g.filterOn; 
g.filtering; 
g.setKeyFilter(\all);
g.setKeyFilter(\me);
g.setStrFilter("");
g.setStrFilter("3");

	// internal state cached in gui:
g.filteredIndices;
g.filteredShorts; 

// to do: execute line on special key in listview; 
// window following? 



