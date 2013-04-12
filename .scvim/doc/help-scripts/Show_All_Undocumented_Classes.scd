// Generates a list of all classes for which there are no help files.

var paths, doc, result, addFunc;
var titleString, infoString;
var documentedClasses, undocumentedClasses, classesStartIndex;
var documented, documentedIndex;

paths = [PathName("Help/"), PathName("/Library/Application Support/SuperCollider/Extensions"), 
	PathName("~/Library/Application Support/SuperCollider/Extensions")];

titleString = "A Generated List of all Undocumented Classes";

infoString = "Below is an alphabetical list of all classes which have no help files. This includes classes from CRUCIAL-LIBRARY, JITLib, and other third party libraries you may have installed. Note that many of these are either private classes not intended for direct use, abstract superclasses (such as Clock), or currently non-functioning or vestigial classes (such as the image synthesis classes from SC3d5). Nevertheless this is a good place to look for undocumented functionality. Note that some of these classes are covered in overviews, tutorials, etc.\n\nClicking on any of the Class Names below will open a Class Browser. For a list of documented classes click here:\n\n";

result = titleString ++ Char.nl ++ Char.nl ++ infoString;

documented = "*Show All Documented Classes";
documentedIndex = result.size;

result = result ++ documented ++ Char.nl ++ Char.nl;

documentedClasses = List.new;

// compile list of documented classes and compare with master class list
// WAY faster than searching for individual files
addFunc = {|folderPathName|
	folderPathName.fullPath.containsi("help").if({	
		folderPathName.files.do({|item|
			var nameString;
			nameString = item.fileName.split($.).at(0);
			if(nameString.asSymbol.asClass.notNil, { 
				documentedClasses.add(nameString.asSymbol.asClass);
			});
		});
	});

	folderPathName.foldersWithoutCVS.do({|folder| 
		addFunc.value(folder);
	});
};

paths.do(addFunc);

undocumentedClasses = Class.allClasses.difference(documentedClasses);

classesStartIndex = result.size;

undocumentedClasses.do({|item| 
	var name;
	name = item.name;
	// weed out metaclasses
	name.isMetaClassName.not.if({ 
		result = result ++ Char.nl ++ name.asString; 
	});
});

result = result ++ Char.nl;

doc = Document.new("Undocumented Classes");
//doc = Document.open("Help/help-scripts/tab-template.rtf");
//doc.title = "Undocumented Classes";

doc.setFont(Font("Helvetica", 12));
doc.string = result;

doc.setFont(Font("Helvetica-Bold", 18), 0, titleString.size);

doc.selectRange(documentedIndex, documented.size); 
doc.underlineSelection;

// Click on name opens class browser
doc.mouseDownAction = { arg document;
	var line;
	line = document.currentLine;
	if((document.selectionStart > classesStartIndex) && (line.size > 0), {
		(line ++ ".browse").interpret
	});
 };
 
doc.selectRange(0,0);
doc.editable_(false);
{doc.removeUndo;}.defer(0.1);


