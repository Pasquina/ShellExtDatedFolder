unit pZNewFolderExt;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, WinAPI.ShlObj, ShellAPI, ZNewFolder_TLB, StdVcl,
  System.SysUtils, System.IOUtils, ANSIStrings, Registry;

type
  TZNewFolderExt = class(TTypedComObject, IZNewFolderExt, IContextMenu, IShellExtInit)
  private
    FSelectedFile: String;
    FIDCmdDatedFolder: UInt;
    FObjectCount: Integer;
    FN_hkeyProgID: HKEY;
    FN_pidlFolder: PIDLIST_ABSOLUTE;
    FN_lpdObj: IDataObject;
    procedure SetSelectedFile(const Value: String);
    procedure SetIDCmdDatedFolder(const Value: UInt);
    procedure SetObjectCount(const Value: Integer);
    procedure SetN_hkeyProgID(const Value: HKEY);
    procedure SetN_lpdObj(const Value: IDataObject);
    procedure SetN_pidlFolder(const Value: PIDLIST_ABSOLUTE);
  protected
    property N_pidlFolder: PIDLIST_ABSOLUTE read FN_pidlFolder write SetN_pidlFolder;
    property N_lpdObj: IDataObject read FN_lpdObj write SetN_lpdObj;
    property N_hkeyProgID: HKEY read FN_hkeyProgID write SetN_hkeyProgID;
    property ObjectCount: Integer read FObjectCount write SetObjectCount;
    property SelectedFile: String read FSelectedFile write SetSelectedFile;
    property IDCmdDatedFolder: UInt read FIDCmdDatedFolder write SetIDCmdDatedFolder;
    // function IShellExtInit.Initialize = InitializeLocal;
    function Initialize(pidlFolder: PItemIDList; lpdobj: IDataObject; hkeyProgID: HKEY): HRESULT; reintroduce; stdcall;
    function QueryContextMenu(Menu: HMENU; indexMenu: UInt; idCmdFirst: UInt; idCmdLast: UInt; uFlags: UInt)
      : HRESULT; stdcall;
    function GetCommandString(idCmd: UInt_PTR; uType: UInt; pReserved: PUInt; pszName: LPSTR; cchMax: UInt)
      : HRESULT; stdcall;
    function InvokeCommand(var lpici: TCMInvokeCommandInfo): HRESULT; stdcall;

  end;

  { Extend the REGSVR routines to include context menu Registry entries }

  TZNewFolderExtFactory = class(TComObjectFactory)
  public
    procedure UpdateRegistry(Register: Boolean); override;
  end;

implementation

uses ComServ, Dialogs;

{ TZNewFolderExt }

{ Return the help string for the selected menu item. }

function TZNewFolderExt.GetCommandString(idCmd: UInt_PTR; uType: UInt; pReserved: PUInt; pszName: LPSTR;
  cchMax: UInt): HRESULT;
const
  LHelpMsgW: String = 'Create New Dated Folder';
  LHelpMsgA: ANSIString = 'Create New Dated Folder';
begin

  { Test for supported command. }

  if idCmd <> IDCmdDatedFolder then
    Exit(E_InvalidArg);                      // exit if command not supported

  { Determine information to return }

  case uType of
    GCS_HELPTEXTA:                           // request is for ANSI help text
      begin
        System.ANSIStrings.StrLCopy(pszName, @LHelpMsgA, cchMax); // return ANSI help text up to max allowed
        Result := SEVERITY_SUCCESS;          // help text returned successfully
      end;
    GCS_HELPTEXTW:                           // request is for wide string help text
      begin
        System.SysUtils.StrLCopy(LPWSTR(pszName), @LHelpMsgW, cchMax); // return wide string help text up to max allowed
        Result := SEVERITY_SUCCESS;          // request for wide string help text succeeded
      end;
  else
    Result := E_InvalidArg;                  // request type not supported
  end;
end;

{ Initialization saves the parameters provided by the shell for later use. }

function TZNewFolderExt.Initialize(pidlFolder: PItemIDList; lpdobj: IDataObject; hkeyProgID: HKEY): HRESULT;
const
  LFilenameMax: Integer = 2000;              // maximum character count for returned path/file name
var
  LFileName: String;                         // local variable to receive string from API
begin

  IDCmdDatedFolder := High(UInt);            // Indicate no menu item ID assigned yet
  Result := E_FAIL;                          // initialize default result

  { Multiple invocations are possible. Clean house first to return resources. }

  CoTaskMemFree(N_pidlFolder);               // return idlFolder (if null, function does nothing)
  N_pidlFolder := nil;                       // mark not assigned

  if Assigned(N_lpdObj) then                 // if data object assigned
    N_lpdObj._Release();                     // decrement the reference count

  if N_hkeyProgID <> 0 then                  // if the Prog ID key is there
  begin
    RegCloseKey(N_hkeyProgID);               // close the key first
    N_hkeyProgID := 0;                       // mark key not assigned
  end;

  { Now save the input values for later use }

  SetLength(LFileName, LFilenameMax);        // set buffer length
  SHGetPathFromIDListEx(pidlFolder, PChar(LFileName), LFilenameMax, GPFIDL_DEFAULT); // obtain path/name
  SelectedFile := PChar(LFileName);          // save path/name as property

  { Note: lpdobj is not captured. It represents the folder contents, that we aren't interested in. }

  { Note: hKeyProgID is not required or used so to avoid the overhead of opening a key
    it is simply ignored in this code. }

  Result := NOERROR;                         // success
end;

function TZNewFolderExt.InvokeCommand(var lpici: TCMInvokeCommandInfo): HRESULT;
var
  LFormatSettings: TFormatSettings;          // to make this thread safe
  LDateStamp: String;                        // formatted datestamp
  LDirectory: String;                        // final directory string
  LResult: LongBool;                         // more defnition fuckery; 0 ordinality is false anything else is true
begin
  LFormatSettings := TFormatSettings.Create; // obtain local copy of format settings
  LDateStamp := FormatDateTime('yyyy-mm-dd', Now(), LFormatSettings); // format current date
  LDirectory := TPath.Combine(SelectedFile, 'Zilch-' + LDateStamp); // build the completed directory name
  LResult := CreateDirectory(PWideChar(LDirectory), Nil); // create the directory
  if LResult <> False then                   // aggravatingly the return from CreateDirectory
    Result := SEVERITY_SUCCESS               // is not compatible with the return
  else                                       // expected by this method
    Result := SEVERITY_ERROR;                // this makes the translation
end;

{ This simply adds a menu item to the context menu. The user may select the item to invoke the desired behavior. }

function TZNewFolderExt.QueryContextMenu(Menu: HMENU; indexMenu, idCmdFirst, idCmdLast, uFlags: UInt): HRESULT;
begin

  { Note there are two things working here:
    1.  The indexMenu has the POSITION at which the menu item can be inserted into the menu. It is a zero-based item
    position.
    2.  The idCmdFirst and idCmdLast control the assignment of an IDENTIFIER to the menu item. This NOT the same as
    the POSITION, and has no relationship with it. IDENTIFIER OFFSETS should be stashed for later use by the system.
  }

  if SelectedFile = '' then
    Exit(NOERROR);

  IDCmdDatedFolder := idCmdFirst - idCmdFirst; // stash the command ID OFFSET for later reference
  if InsertMenu(Menu, indexMenu, MF_STRING or MF_BYPOSITION, idCmdFirst, 'Zilch Dated Folder') then
    Result := MAKERESULT(SEVERITY_SUCCESS, 0, idCmdFirst - idCmdFirst + 1) // return success and command id offset
  else
    Result := HRESULT(SEVERITY_ERROR);         // return error

end;

procedure TZNewFolderExt.SetIDCmdDatedFolder(const Value: UInt);
begin
  FIDCmdDatedFolder := Value;
end;

procedure TZNewFolderExt.SetN_hkeyProgID(const Value: HKEY);
begin
  FN_hkeyProgID := Value;
end;

procedure TZNewFolderExt.SetN_lpdObj(const Value: IDataObject);
begin
  FN_lpdObj := Value;
end;

procedure TZNewFolderExt.SetN_pidlFolder(const Value: PIDLIST_ABSOLUTE);
begin
  FN_pidlFolder := Value;
end;

procedure TZNewFolderExt.SetObjectCount(const Value: Integer);
begin
  FObjectCount := Value;
end;

procedure TZNewFolderExt.SetSelectedFile(const Value: String);
begin
  FSelectedFile := Value;
end;

{ TZNewFolderExtFactory }

{ Besides the Registry entries requirerd by COM, Shell menu extensions require some
  additional entries that control the display of menu items and invocation of the COM
  interfaced routines. TZNewFolderExtFactory descends from TCOMObjectFactory to add
  the necessary code to update the Registry. It starts off by invoking the parent
  method to take care of routine COM registration and then registers three new
  keys for the Context Menu operations.
}

procedure TZNewFolderExtFactory.UpdateRegistry(Register: Boolean);
var
  LRegistry: TRegistry; // system registry access
begin
  inherited;            // do the routine Registry stuff for COM

  LRegistry := TRegistry.Create;
  try
    LRegistry.RootKey := HKEY_CLASSES_ROOT;
    if Register then    // boolean value set by REGSVR32 parameter
    begin               // register new keys and values
      if LRegistry.OpenKey('\Directory\shellex\ContextMenuHandlers\ZilchFolder', True) then
        LRegistry.WriteString('', GUIDToString(CLASS_ZNewFolderExt));
      if LRegistry.OpenKey('\Directory\Background\shellex\ContextMenuHandlers\ZilchFolder', True) then
        LRegistry.WriteString('', GUIDToString(CLASS_ZNewFolderExt));
      if LRegistry.OpenKey('\Folder\shellex\ContextMenuHandlers\ZilchFolder', True) then
        LRegistry.WriteString('', GUIDToString(CLASS_ZNewFolderExt));
    end
    else                // unregister requested in REGSVR32
    begin               // remove context menu keys and values
      if LRegistry.OpenKey('\Directory\shellex\ContextMenuHandlers\ZilchFolder', False) then
        LRegistry.DeleteKey('\Directory\shellex\ContextMenuHandlers\ZilchFolder');
      if LRegistry.OpenKey('\Directory\Background\shellex\ContextMenuHandlers\ZilchFolder', False) then
        LRegistry.DeleteKey('\Directory\Background\shellex\ContextMenuHandlers\ZilchFolder');
      if LRegistry.OpenKey('\Folder\shellex\ContextMenuHandlers\ZilchFolder', False) then
        LRegistry.DeleteKey('\Folder\shellex\ContextMenuHandlers\ZilchFolder');
    end;
  finally
    LRegistry.CloseKey;
    LRegistry.Free;
  end;

end;

initialization

TZNewFolderExtFactory.Create(ComServer, TZNewFolderExt, CLASS_ZNewFolderExt, 'ZNewFolderExt',
  'Create Zilch Dated Folder', ciMultiInstance, tmApartment);

end.
