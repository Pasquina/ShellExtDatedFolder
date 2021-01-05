unit pZNewFolderExt;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, ShlObj, ShellAPI, ZNewFolder_TLB, StdVcl,
  System.SysUtils, ANSIStrings, Registry;

type
  TZNewFolderExt = class(TTypedComObject, IZNewFolderExt, IContextMenu, IShellExtInit)
  private
    FSelectedFile: String;
    FIDCmdDatedFolder: UInt;
    procedure SetSelectedFile(const Value: String);
    procedure SetIDCmdDatedFolder(const Value: UInt);
  protected
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

  TZNewFolderExtFactory = class (TComObjectFactory)
  public
    procedure UpdateRegistry (Register: Boolean); override;
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
        System.AnsiStrings.StrLCopy(pszName, @LHelpMsgA, cchMax); // return ANSI help text up to max allowed
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

{ Initialization obtains the name of the parent folder into which the new folder
  will be placed. }

function TZNewFolderExt.Initialize(pidlFolder: PItemIDList; lpdobj: IDataObject; hkeyProgID: HKEY): HRESULT;

var
  LStgMedium: TStgMedium;
  LFormatEtc: TFormatEtc;                    // structure describing generalized clipboard format
  LResult: HRESULT;                          // local result storage a la MS APIs
  LFileNameLength: Cardinal;                 // character count of current file name plus null character
begin
  IDCmdDatedFolder := High(UInt);            // Indicate no ID assigned yet
  Result := E_FAIL;                          // initialize default result

  if not Assigned(lpdobj) then               // is data object assigned
    Exit(E_FAIL);                            // not assigned; init fails

  { Initializing the FormatEtc structure is required in order to convert the IDataObject content to
    a format usable by DragQueryFile to extract individual file names. }

  with LFormatEtc do                         // set up clipboard format
  begin
    cfFormat := CF_HDROP;                    // predefined format can be used as input to DragQueryFile
    ptd := nil;                              // pointer to target device not required in this case
    dwAspect := DVASPECT_CONTENT;            // representation of an object to be displayed inside a container
    lindex := -1;                            // currently not used and must be -1
    tymed := TYMED_HGLOBAL;                  // specifies global memory handle for data transfer
  end;

  { Now transform the DataObject to a Storage LStgMedium structure }

  LResult := lpdobj.GetData(LFormatEtc, LStgMedium);

  if Failed(LResult) then                    // test for successful conversion
    Exit(E_FAIL);                            // exit if conversion failed

  { A maximum of one object is supported. Greater than that is a fail. }

  if DragQueryFile(LStgMedium.hGlobal, High(Cardinal), nil, 0) <> 1 then // return value is number of objects
    Exit(E_FAIL);                            // exit if anything except 1 file returned

  LFileNameLength := DragQueryFile(LStgMedium.hGlobal, 0, nil, 0) + 1; // get filename length
  SetLength(FSelectedFile, LFileNameLength); // allocate space to receive name
  DragQueryFile(LStgMedium.hGlobal, 0, PChar(FSelectedFile), LFileNameLength); // return the name

  ReleaseStgMedium(LStgMedium);              // release resources not needed

  Result := NOERROR;                         // success
end;

function TZNewFolderExt.InvokeCommand(var lpici: TCMInvokeCommandInfo): HRESULT;
begin
  ShowMessage(SelectedFile);
  Result := NOERROR;
end;

{ This simply adds a menu item to the context menu. The user may select the item to invoke the desired behavior. }

function TZNewFolderExt.QueryContextMenu(Menu: HMENU; indexMenu, idCmdFirst, idCmdLast, uFlags: UInt): HRESULT;
begin
  if InsertMenu(Menu, indexMenu, MF_STRING or MF_BYPOSITION, idCmdFirst, 'Zilch Dated Folder') then
    Result := MAKERESULT(SEVERITY_SUCCESS, 0, idCmdFirst - idCmdFirst + 1) // return success and new offset
  else
    Result := HRESULT(SEVERITY_ERROR); // return error
end;

procedure TZNewFolderExt.SetIDCmdDatedFolder(const Value: UInt);
begin
  FIDCmdDatedFolder := Value;
end;

procedure TZNewFolderExt.SetSelectedFile(const Value: String);
begin
  FSelectedFile := Value;
end;

{ TZNewFolderExtFactory }

procedure TZNewFolderExtFactory.UpdateRegistry(Register: Boolean);
var
  LRegistry: TRegistry; // system registry access
begin
  inherited;

  LRegistry := TRegistry.Create;
  try
    LRegistry.RootKey := HKEY_CLASSES_ROOT;
    if Register then
    begin
      if LRegistry.OpenKey('\Directory\shellex\ContextMenuHandlers\ZilchFolder', True) then
        LRegistry.WriteString('', GUIDToString(CLASS_ZNewFolderExt));
      if LRegistry.OpenKey('\Directory\Background\shellex\ContextMenuHandlers\ZilchFolder', True) then
        LRegistry.WriteString('', GUIDToString(CLASS_ZNewFolderExt));
    end
    else
    begin
      if LRegistry.OpenKey('\Directory\shellex\ContextMenuHandlers\ZilchFolder', False) then
        LRegistry.DeleteKey('\Directory\shellex\ContextMenuHandlers\ZilchFolder');
      if LRegistry.OpenKey('\Directory\Background\shellex\ContextMenuHandlers\ZilchFolder', False) then
        LRegistry.DeleteKey('\Directory\Background\shellex\ContextMenuHandlers\ZilchFolder');
    end;
  finally
    LRegistry.CloseKey;
    LRegistry.Free;
  end;

end;

initialization

TZNewFolderExtFactory.Create(ComServer, TZNewFolderExt, Class_ZNewFolderExt,
  'ZNewFolderExt', 'Create Zilch Dated Folder', ciMultiInstance, tmApartment);

end.
