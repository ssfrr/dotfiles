Modifying the Standalone Template for your own App

If you do not have or use Apple Developer tools, the easiest way to create an SC-based 
standalone application is to modify an existing SC standalone: 

1 - Obtain the compiled 'Standalone Template.app' for the desired version of SC3, 
	e.g. SC3.3.1, and make a copy of it for modification.
	
2 - Renaming 
	* In the Finder, rename the copy of 'Standalone Template.app' to e.g. YourApp.app
	* Alt-click on YourApp.app, and select 'Show package contents':
		Ths opens the folder inside the app.
	* Open the file Contents/Info.plist (with PropertyListEditor if you have it, or any text editor), 
	* in the section: 
		...
		<key>CFBundleName</key>
		<string>Standalone Template</string>
		...
	replace 'Standalone Template' with YourApp

	For safety, keep  a copy of the file Info.plist. around.

2 - Credits
	In Resources/English.lproj/Credits.rtf, add credits for all contributors to YourApp.

3 - The top Help file
	Edit Resources/Help/Help.html to inform users about YourApp.
	
4 - Adding resources, extensions, etc etc
	Put any soundfiles you intend to use in /Contents/Resources/sounds
	Put any extra UGen plugin libraries your app requires in (e.g. Kloink.scx) in Resources/plugins
	Put any classes for YourApp in Resources/SCClassLibrary

5 - Modifying the startup file 
	in Resources/SCClassLibrary/, modify the file modifyStartup.sc
	to do anything your app needs, such as boot the server.
	Then, call the class(es) and/or execute the script(s) that start(s) YourApp.
	See the section Adding your own behavior in Creating-Standalone-Applications!

6 - Start YourApp and test that it works. Adjusting scripts will usually require 
	modifications of file paths, and you may have forgotten classes! 
	You can recompile, edit scripts, add classes, as in SC3 itself.
	
7 - When your app works as desired - Share and Enjoy!



