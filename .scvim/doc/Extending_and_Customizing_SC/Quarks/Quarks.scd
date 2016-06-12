Quarks						package manager

SC supports extensions to its class library, documentation, and server UGen plugins. These extensions are stored in subfolders of Platform.userExtensionDir – for more info see Using-Extensions.

A Quark is a more formalized kind of extension folder. It can be shared with others and can be easily installed or uninstalled using the Quarks package manager. The package manager has a directory of "quarkfiles" which describe the quarks and how to install them automatically for you.

There is a shared library of these packages on SourceForge http://quarks.sourceforge.net offering a variety of useful extra capabilities for SC.



There are two standard ways to obtain this shared Quarks library.

Method 1: Downloaded binary

If you have downloaded the full binary of SC then you already have them in the Optional Extras folder of the SC download.
If so, move the 'quarks' folder into this directory:

// execute this code to post the directory path
Platform.userAppSupportDir

(note: do not place it inside Extensions. If you place all of them inside extensions, then they will all be in the compile path. )

The Quarks package manager will now be able to install and uninstall individual Quark packages.  It does so by making a symlink in the Extensions/quarks/ folder, pointing back to the quark's source code which stays in the User App Support directory.


(
// manage Quarks packages from a gui
Quarks.gui
)

(note: do not turn everything on.  start slowly)

Some Quarks depend on other Quarks and will automatically install the other ones they need.  

Conflicts of classes and package dependencies are always a possibility, so be aware that you may "break" your SC so that it cannot compile what has been placed in its compile path.  

If this happens, simply open this folder:
Platform.userExtensionDir
and delete the symlinks inside the quarks folder.  (Remember: these symlinks point back to the actual quarks sitting harmlessly in your app support directory)


Method 2: Getting Quarks from the SVN repository

The other way to obtain the Quarks library is to checkout a copy using Subversion (SVN).  SC is fully integrated with SVN and can checkout single quarks or update them whenever developers make changes.  This is a wonderful thing since you can complain about a broken knob, somebody in Belgium will fix it and a few hours later its working for you.

You will need the subversion client software installed ( http://subversion.tigris.org ). To check whether you already have it, type "svn help" in a terminal window.

If you have previously installed the quarks library from the binary download, you should move or delete that folder now.

The Quarks class and the quarks gui manager will be executing subversion commands.

On Mac, those commands will launch in a terminal window. The first time you run a SourceForge quarks svn command you will be asked whether to accept the SSL certificate for SourceForge.  Press 'p' to accept it permanently.


The DIRECTORY

The quarks folder contains a folder called DIRECTORY filled with quarkfiles xxxxxxxxy.quark
These file describe the quark, the developer and note any dependencies.  You can update the directory without downloading all of the quarks.

The following command will make sure you have an up-to-date directory listing (you can run this whether or not it's your first time using quarks):

Quarks.updateDirectory


// list all quarks in the repository
Quarks.repos.quarks

Note that checking out or updating the directory touches only the list of quarks. It does not check out or update any code or help files that belong to a quark. If you want to get the latest code for an individual quark, use the instructions in the next section. To checkout or update the entire Quarks repository:

Quarks.checkoutAll; // NB: most users don't want ALL quarks, so getting them all might be a waste of disk space!
Quarks.update;

Individual Quarks can be updated by providing the name to the update method:

Quarks.update("testquark"); // much better use of your hard disk. (NB this assumes you already have installed "testquark")


Checking out and Installing a Quark

Either launch the package manager to install/uninstall individual Quarks:

Quarks.gui

which we hope is somewhat self explanatory.  (and steadily improving)

...or use the "checkout" command directly:

// checks it out from svn
Quarks.checkout("testquark");

// this installs it
Quarks.install("testquark");

This symlinks the quark's sourcecode folder into your Extensions directory.  The source code itself stays in the quarks folder, but the symlink is in your Extensions directory (and thus in SC's compile path).

After a quark is installed you must recompile the language. Installing simply places the code into SC's compile path.  You must then recompile.

Then you can use it:

TestQuark.sayHello

Uninstall

You can of course uninstall quarks if you decide you don't need them:

Quarks.uninstall("testquark");


// list those installed
Quarks.installed

Dependencies

Note: Quarks may specify other quarks that they are dependent on.  Quarks.install will also attempt to install those other quarks that the desired quark depends upon, if not already installed. You can prevent this if neccessary by passing false as the second argument to Quarks.install.

Quarks.install( "somequark", includeDependencies: false )

Similarly the install command will attempt to download quarks if you don't already have them locally. You can prevent this using the allowCheckout argument:

Quarks.install( "somequark", checkoutIfNeeded: false )




// list those in the repository that you could checkout
Quarks.repos.quarks

// list those that you have checked out and could now install
Quarks.local.quarks



Check out all available Quarks
 
Quarks.checkoutAll

This downloads all of them into {Application Support Directory}/quarks but does not yet install them into your class library.

It can be particularly helpful because you won't in future need to have an internet connection to install the quarks: they are already downloaded even if not installed.

// post those checked out
Quarks.checkedOut

// post those checked out with a description
Quarks.listCheckedOut

// post all available with a description
Quarks.listAvailable


Standard SVN tools

The Quarks class interface mirrors the familar svn commands while substituting in the correct paths.

Quarks.update( "testquark" )
Quarks.update // updates all

Quarks.status( "testquark" )
Quarks.status // status of all

You may also use any standard SVN tools which is probably easier especially for add and commit.

The principal repository is located at:

https://quarks.svn.sourceforge.net/svnroot/quarks


Creating a Quark

Adding a Quark requires using standard SVN tools (command line or SVNX)

Create your folder in {Application Support}/quarks/ 
(we'll assume it's called quarkname)

Place your classes in this folder.

Place a quark file called quarkname.quark into {Application Support}/quarks/DIRECTORY
(see [Quark] for the format)

You can now install, re-compile, test and uninstall install the quark from your local system without having added it into the public repository.

You can use quarks for your own private purposes to install and uninstall packages of classes.

To add it into the public repository:

You will need a (free) SourceForge account to publish a quark to the subversion repository. You will  need to be familiar with the basics of svn.  

You also need the account to be added to the "quarks" project - contact one of the admins listed at http://sourceforge.net/projects/quarks to do that. 

Once you're authorised:

In a shell go to {Application Support}/quarks/  and  execute :

svn add quarkname

svn add DIRECTORY/quarkname.quark

svn commit -m "adding quarkname" quarkname
svn commit -m "adding directory entry for quarkname" DIRECTORY/quarkname.quark

Be careful to commit only changes to your own quark and to the directory entry you have added.



Local Repository Example

Besides the public repos at sourceforge you can use any other subversion host including a repository running on your local machine.  Running a local repository is surprisingly easy.   This is useful in that you get version control and an easy way to manage package installation.

For obvious reasons you need to have a running subversion system somewhere in order to use this feature.
Nevertheless it is possible to use alreadily existing subversion quarks directories (as the SonEnvir one).

1.	Create a directory in svn-repos (e.g. quarks-<yourname/id/institution>).
	!This name has to be unique across all Quark repositories you will ever check out!

	Create a dir within it called "DIRECTORY" containing quark files.

2.	Fill repos with your work 
	
3.	Now use Quarks to make it accessible in SC (shown at hand of the existing and 
	publicly available SonEnvir quarks):

	~qSonEnvir = Quarks(
		reposPath: "https://svn.sonenvir.at/repos/SonEnvir/trunk/src/quarks-sonenvir", 
		localPath: Platform.userAppSupportDir ++ "/quarks-sonenvir"
	);
	
	~qSonEnvir.checkoutAll;
	// or, if alreadily checked out at the appropriate place:
	~qSonEnvir.update;

4.	now install your quarks:

	// post all checked out
	~qSonEnvir.listCheckedOut;

	// or post all available with a description
	~qSonEnvir.listAvailable


	~qSonEnvir.install("sonenvir-testquark");
	~qSonEnvir.isInstalled("sonenvir-testquark");

	~qSonEnvir.listInstalled

5.	recompile
6.	test
	
	SonEnvirTestQuark.sayHello
	
	~qSonEnvir = Quarks(
		reposPath: "https://svn.sonenvir.at/repos/SonEnvir/trunk/src/quarks-sonenvir", 
		localPath: Platform.userAppSupportDir ++ "/quarks-sonenvir"
	);

[...]
 
N.	remove what you're don't need
	~qSonEnvir.uninstall("sonenvir-testquark")
	
	// recompile
	SonEnvirTestQuark.sayHello
	// -> error
	
	
M.	update

	~qSonEnvir.updateDirectory
	~qSonEnvir.update
	
	
	


