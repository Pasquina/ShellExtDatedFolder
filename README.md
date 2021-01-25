# ShellExtDatedFolder
**A Delphi Windows Explorer Context Menu Extension to Create Dated Folders**

## Licensing

The code is licensed under the MIT license, a copy of which is included in the project and also in the source code. Copyright ©2020 –2021 by Milan Vydareny.

## Blog Post

There is an accompanying Blog Post for this project at [Delphi Chops](https://delphichops.blogspot.com/2021/01/a-delphi-windows-explorer-context-menu.html "Delphi Chops—ShellExtDatedFolder"). The Markdown source for the Blog Post as well as a PDF version of the same content is contained in the project `Docs` folder. 

## Obtaining the Source Code

The project source code can be downloaded as a .zip file or cloned as a Git project from [`ShellExtDatedFolder`](https://github.com/Pasquina/ShellExtDatedFolder.git "Project ShellExtDatedFolder"). (GitHub)


## Objectives
1. Learn how to develop COM Servers (which is what MS Shell Extensions are)
2. Learn the specific requirements for various Explorer extensions, especially Context Menu Extensions
3. Study and dissect the Marco Cantu and Embarcadero examples
4. Learn a little about the C++ implementation of this
5. Develop a `Windows Explorer` Context Menu Extension that creates a new folder named using the current system date. This is a convenience and accuracy improvement for the user who needs to repeatedly create such folders as a means of organizing quantities of individual files by date.

## Overview Steps
1. Establish repo.
2. Download existing Marco Cantu and Embarcadro examples.
3. Restructure the project libraries to facilitate analysis.
3. Perform code analysis. Code analysis consists of two major activities:
	- Read existing code and research all unknown APIs, structures and related Microsoft documentation.
	- Comment the existing code. Commenting code strengthens understanding and cements what was learned from research. By commenting, I mean, almost every line and in the case of complex operations, paragraphs of comments associated with the methods, classes or other parts of the code.
4.  Using what was learned during the code analysis, implement a Context Menu that creates a folder named using the current date.

## The ShellExtDatedFolder Project Group
All projects in the project group are Delphi projects, produced with RAD Studio Enterprise 10.4.

All code is heavily commented. This enables the code to be used as a learning tool.

All code is contained in this project group. There is one project in the project group:
### ZNewFolder Project

The project builds a COM .dll that populates a Shell Context Menu Extension with a single additional menu item, `Zilch Dated Folder`. When the user selects the item, that is only displayed when a right mouse click is made in a folder background or folder tree folder, a new folder is created within the selected folder named `Zilch-yyyy-mm-dd` where `yyyy-mm-dd` is replaced by the current system date.
#### Implementation
Implementation is in accordance with Windows Shell requirements, using Windows APIs and structure definitions that have been translated to appropriate Delphi code. The APIs and type definitions are provided as a part of RAD Studio.
#### Registration
An additional class, `TZNewFolderExtFactory`, was also added that descends from `TComObjectFactory`. This permits the extension of the `UpdateRegistry` procedure to include three addtional System Registry keys to support Context Menu Extensions.

#### Installation

In all cases, installation may require elevated authorization. Running as `Administrator`, either when using the `cmd` window or the installation file should be sufficient to achieve correct installation.

Installation can be manually achieved by copying the ZNewFolder.dll to an appropriate folder and then using RegSvr32.exe (a Microsoft program) to register the COM server. The registration process handles all necessary System Registry modifications. RegSvr32 can also be used to uninstall the Com server using the -u switch. To install using this method you must first compile the project to obtain the COM Server .dll having the correct bitness. (See **Important Caveats** below.)

Also included is an installation file created using `DeployMaster`, an inexpensive installation package builder available from the [`DeployMaster` website](http://deploymaster.com "Deploymaster Website"). `Deploymaster` also provides an uninstall function. The installer is in the `Installer` folder. It will install either the 32-bit or 64-bit version as appropriate. (But see **Important Caveats** below for additional information.) 

## Important Caveats

### Bitness

If you are running a 32-bit Shell, you must register and use the 32-bit version of the Com server. On a 64-bit system you must register and use the 64-bit version.

The `DeployMaster` installation program contains both versions and will correctly choose and install the correct version after examining the bitness of the installation system.

### Target Systems

The existing code has only been tested on a 64-bit Windows 10 Pro system, version 2009, released October 2020 and code-named 20H2. The installation program will also allow installation on Windows 7 and windows 8 machines, both 32-bit and 64-bit, as well as a variety of Windows servers, but since the code has never been tested on those configurations it is not known if it will function correctly.


  