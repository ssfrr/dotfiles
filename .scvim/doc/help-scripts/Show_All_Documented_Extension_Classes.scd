// trolls the help extension help directories and compiles a doc with links

var path, doc, result, headingIndices, headingFont, excluded, addFunc;
var underlineStarts, underlineRanges, titleString, thirdParty, thirdPartyIndex;
var extensions, extensionsIndex, extensionFunc, extensionsRoots, extensionsFolders;
var undoc, undocIndex;

path = PathName.new("Help/");

headingIndices = List.new;

titleString = "A Generated List of all Documented Extension Classes";
undoc = "*Show All Undocumented Classes";

result = titleString ++ Char.nl ++ Char.nl ++ "Below is an automatically generated list of all documented extension classes (i.e. those whose class and help files are in /Library/Application Support/SuperCollider/Extensions or ~/Library/Application Support/SuperCollider/Extensions), sorted by directory.\n\nFor a list of undocumented classes click here:" + Char.tab;

undocIndex = result.size;

result = result ++ undoc ++ Char.nl ++ Char.nl;

// put included third party libraries at the end
excluded = [PathName("Help/crucial"), PathName("Help/JITLib")];

// this func trolls the directory and harvests the descriptions
addFunc = {|folderPathName|
	var classFiles, heading, currentFile, currentFileString, temp;
	classFiles = "";	
	
	folderPathName.files.do({|item|
		var nameString, nameIndex, end;
		nameString = item.fileName.split($.).at(0);
		if(nameString.asSymbol.asClass.notNil, { 
			currentFile = File(item.fullPath, "r");
			currentFileString = currentFile.readAllString;
			// fix accent acute (remove it)
			currentFileString.findAll("\'8").reverseDo({ |i|
				currentFileString = currentFileString.copyFromStart(i-2) ++
					currentFileString.copyToEnd(i+2);
			});
			currentFile.close;
			// strip RTF gunk
			currentFileString = currentFileString.stripRTF;
			nameIndex = currentFileString.find(nameString);
			if(nameIndex.notNil, {
				currentFileString = currentFileString.drop(nameIndex);
				end = currentFileString.find("\n");
				if( end.notNil, {
					end = end - 1;
					currentFileString = currentFileString.copyFromStart(end);
				});
				// remove tab stops
				currentFileString = currentFileString.reject({|item|item == $\t});
				// remove commas, hyphens, and spaces
				while({(currentFileString[nameString.size] == $,) || 
					(currentFileString[nameString.size] == $ ) || 
					(currentFileString[nameString.size] == $-)},
					{currentFileString = currentFileString.copyFromStart(nameString.size -1) ++
						currentFileString.copyToEnd(nameString.size + 1);
					}
				);
				if(currentFileString.size > nameString.size, {
					currentFileString = currentFileString.insert(nameString.size, "\t");
				});}, 
				{	 
				currentFileString = nameString; 
				}
			);
			// add square brackets
			currentFileString = currentFileString.insert(nameString.size, "]");
			currentFileString = currentFileString.insert(0, "[");
			
			classFiles = classFiles ++ Char.tab ++ currentFileString ++ Char.nl;
		});
	});
	if(classFiles.size > 0, {
		//heading = folderPathName.fileName;
		heading = folderPathName.fullPath;
		headingIndices.add([result.size, heading.size]);
		
		result = result ++ heading ++ Char.nl ++ Char.nl ++ classFiles ++ Char.nl;
	});
	folderPathName.foldersWithoutCVS.do({|folder| 
		if(excluded.detect({|item| item.fileName == folder.fileName; }).isNil, 
			{addFunc.value(folder);}
		); 
	});
};

//addFunc.value(path);

// Check for Extensions Folders and add if they exist

extensionsRoots = [PathName("/Library/Application Support/SuperCollider/Extensions"), 
	PathName("~/Library/Application Support/SuperCollider/Extensions")];

extensionsRoots.any({|item| item.pathMatch.size > 0 }).if({
	
	extensionsFolders = List.new;
	extensionFunc = { |path|
		path.folders.do({|item| 
			item.fullPath.containsi("help").if({ extensionsFolders.add(item)},{ 
				extensionFunc.value(item);});
		});
	};
	
	extensionsRoots.do({|item| extensionFunc.value(item); });
	result = result ++ "\n\n";	
//	result = result ++ "\n------------------------\n\n";
//	extensions = "Extensions:";
//	extensionsIndex = result.size;
//	result = result ++ extensions + Char.nl + Char.nl;
	extensionsFolders.do({|item| addFunc.value(item);});
		
});

// Third Party Libraries
//result = result ++ "\n------------------------\n\n";
//
//thirdParty = "Included Third Party Libraries:";
//thirdPartyIndex = result.size;
//
//result = result ++ thirdParty + Char.nl + Char.nl;
//
//excluded.do({|item| addFunc.value(item); result = result ++ "\n------------\n\n";});

//doc = Document.new("Documented Classes");

// this sets basic tab stops and line spacing
doc = Document.open(File.getcwd ++ "/" ++ "Help/help-scripts/tab-template.rtf");

doc.title = "Documented Extension Classes";

// set the fonts
doc.setFont(Font("Helvetica", 12));
doc.string = result;

doc.setFont(Font("Helvetica-Bold", 18), 0, titleString.size);

//doc.setFont(Font("Helvetica-Bold", 16), thirdPartyIndex, thirdParty.size);

extensionsIndex.notNil.if({
	doc.setFont(Font("Helvetica-Bold", 16), extensionsIndex, extensions.size);
});

headingFont = Font("Helvetica-Bold", 14);
headingIndices.do({|item| doc.setFont(headingFont, *item)});

// find the underlines for help links. Apparently faster than storing them above.
underlineStarts = doc.string.findAll("[").reverse + 1;
underlineRanges = doc.string.findAll("]").reverse - underlineStarts;

underlineStarts.do({|item, i| doc.selectRange(item, underlineRanges[i]); doc.underlineSelection;});

doc.selectRange(undocIndex, undoc.size); 
doc.underlineSelection;

doc.selectRange(0,0);
doc.editable_(false);

// keeps window title as it should be!
doc.mouseDownAction = { {doc.title = "Documented Classes";}.defer(0.00001) };

{doc.removeUndo;}.defer(0.001);


