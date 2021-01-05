# ShellExtDatedFolder
**A Windows Explorer Extension to Create Dated Folders From the Context Menu**
## Objectives
1. Learn how to develop COM Servers (which is what MS Shell Extenstions are)
2. Learn the specific requirements for various Explorer plugins
3. Study and disect the Marco Cantu and Embarcadero examples
4. Learn a little about the C++ implementation of this

## First Steps
1. Establish repo.
2. Move existing Cantu and Embarcadro examples into the Repo.
3. Restructure the project libraries to something sensible and easy to maintain.
	- Put individual projects in their own directories.
	- If the project group has mixed language (e.g., Delphi and C++) remove the main .gitignore file from the project group and put separate .gitignore files into each individual project folder, tailored to its contents.
3. Begin the code analysis. Code analysis consists of two major activities:
	- Comment the existing code. This will generally require some serious research as code from Embarcadero source is usually opaque and difficult to follow. But commenting it will require deep understanding and serious research. By commenting, I mean, almost every line and in the case of complex operations, paragraphs of comments associated with the methods, classes or other parts of the code.
	- Fix and improve the code. Nearly all of Embarcadero's examples are trivially constructed and generally not very well thought out. Don't hesitate to refactor, rearrange, and in general improve the crap you find to something better. Be sure to document what you do, again either with comments or here in the ReadMe.

## The ShellExtDatedFolder Project

All code is contained in this project group. There are four projects in the project group. These are:

**JumpListDelphiProj**

**JumpListCppProj**

**ToDoFileDelphi**

This is a normal VCL application that maintains a list of files that the user specifies. Information saved consists of:

-	The full path and file name of the file.
-	Optional user-entered comments about each file.

 Files are specified in either of two ways:

-	The desired file is added when the user drags and drops the file on the application.
-	The user can add a particular file using a Shell Extension that adds a "Sent To" option to the file's context menu.

The file list is maintained in a Client DataSet that is saved in the user's AppData directory.

The user must first launch the application to enable it to receive files for indexing in the ToDo dataset.

**ToDoShllDelphi**

This is a Shell Extension .dll that inserts a "Send To" item in the context menu for a file. It allows the user to send the file to the running ToDoFileDelphi application for indexing. Oddly, the sample doesn't seem to include a host application to use for testing. Most of my sources indicate a Host is required. More research needed.

##Things to Note##

Some things represent the possibility for learning in the code. Here are some things to pay attention to:

**ToDoFileDelphi**

-	The Message Handling procedures `DropFiles` and `CopyData` are used to accept files from the user, either by `DragAndDrop` or by `SendTo`. They should be understood.
-	The whole UI has been reworked using some different techniques from the original. The fundamental objective was to make it responsive as much as possible by using `TGridPanel`, `TFlowPanel`, and `TPanel` components that are nested and arranged so that objects flow when the main form is resized.
-	The Windows Message `MW_DRAGQUERYFILE` is used to obtain information about the dropped files. Take a look at how it's used. It canreturn the number of files, the length of each filename and the actual filename for every file in the list.
-	The Windows Shell API `DragFinish` should be understood. It releases resources from the Drag and Drop operation.
-	Restoring the focus to the application after the Drag and Drop is tricky. After a lot of trial and error I had to use two `Application` procedures, `Restore` and `BringtoFront` followed by `Form` `SetFocus` and `SetActiveControl`. It's not documented anywhere I could find. Just here.
-	The Windows Message `CopyData` is used to receive the `SendTo` context menu item and should be understood.  

## Improvements To Original Code ##

Besides fixing the customary naming conventions and refactoring to create more readable and maintainable code, here are some of the things done:

**ToDoFileDelphi**

-	Windows Message handler methods moved to `Private` Declarations.
-	Method Function `GetToDoFileName` added that performs the following
	-	Returns the full path and file name for the Client DataSet used to store the ToDoList data.
	-	Forces the directories for the Client DataSet storage to ensure they exist. This is done before the file is opened to avoid being unable to find the desired directory after effort has been expended on adding entries.
	-	Uses constants as a part of the function to determine the location and name of the external storage for the Client DataSet.
-	Added a `BeforeOpen` event handler to the Client DataSet to apply the external file name to the Client DataSet Component properties
-	Created the Client DataSet prior to compilation to avoid unnecessary run-time complications.
-	Changed the Client DataSet field definitions so that the `Filename` field was long enough to accommodate even more than `MAX_PATH`, the standard Windows specification. Windows 10 has removed that limitation, but not without making some changes to the Registry. See [Maximum Path Length Limitation
](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation "Microsoft Developer Information") for details.
