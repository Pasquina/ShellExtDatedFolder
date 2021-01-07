unit ZNewFolder_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 98336 $
// File generated on 1/5/2021 4:37:52 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\VydarenyM\Documents\Projects\Commercial\ShellExtDatedFolder\ZNewFolder\ZNewFolder (1)
// LIBID: {B4858F50-FEFE-4037-B0B7-A1027BFFF174}
// LCID: 0
// Helpfile:
// HelpString: Create new dated folder.
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ZNewFolderMajorVersion = 1;
  ZNewFolderMinorVersion = 0;

  LIBID_ZNewFolder: TGUID = '{B4858F50-FEFE-4037-B0B7-A1027BFFF174}';

  IID_IZNewFolderExt: TGUID = '{224FB712-C39F-4241-9ED4-24A711B34386}';
  CLASS_ZNewFolderExt: TGUID = '{E6F0C924-9787-4EAD-8967-7498B83F7EF7}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IZNewFolderExt = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  ZNewFolderExt = IZNewFolderExt;


// *********************************************************************//
// Interface: IZNewFolderExt
// Flags:     (256) OleAutomation
// GUID:      {224FB712-C39F-4241-9ED4-24A711B34386}
// *********************************************************************//
  IZNewFolderExt = interface(IUnknown)
    ['{224FB712-C39F-4241-9ED4-24A711B34386}']
  end;

// *********************************************************************//
// The Class CoZNewFolderExt provides a Create and CreateRemote method to
// create instances of the default interface IZNewFolderExt exposed by
// the CoClass ZNewFolderExt. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoZNewFolderExt = class
    class function Create: IZNewFolderExt;
    class function CreateRemote(const MachineName: string): IZNewFolderExt;
  end;

implementation

uses System.Win.ComObj;

class function CoZNewFolderExt.Create: IZNewFolderExt;
begin
  Result := CreateComObject(CLASS_ZNewFolderExt) as IZNewFolderExt;
end;

class function CoZNewFolderExt.CreateRemote(const MachineName: string): IZNewFolderExt;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ZNewFolderExt) as IZNewFolderExt;
end;

end.

