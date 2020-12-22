unit ToDoForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, StdCtrls, DBCtrls, ExtCtrls, DBClient;

type
  TToDoFileForm = class(TForm)
    Splitter1: TSplitter;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    DBMemo1: TDBMemo;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    cdsTodo: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure cdsTodoBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    function GetToDoFileName: String;
    procedure DropFiles(var AWmDropFiles: TWmDropFiles); message wm_DropFiles;
    procedure CopyData(var Msg: TWmCopyData); message wm_CopyData;
  public
  end;

var
  ToDoFileForm: TToDoFileForm;

implementation

{$R *.DFM}

uses
  ShellApi, System.IOUtils;

{ Form Creation Opens/Creates the Client Dataset. This should not be created in the same directory as the .exe! }

procedure TToDoFileForm.FormCreate(Sender: TObject);
begin
  cdsTodo.Open;                                       // Open the ToDoDataset
  DragAcceptFiles(Handle, True);                      // Inform the Shell we accept File Drops
end;

{ Set up the Client Dataset Save/Restore mechanism before continuing }

function TToDoFileForm.GetToDoFileName: String;
const
  LVendorName: String = 'Embarcadero';                // Vendor of code
  LAppName: String = 'ToDoList';                      // application name
  LDatabaseFileName: String = 'ToDoList.cds';         // file name
var
  LPath: String;                                      // Path to Client Dataset File
begin
  Result := '';                                       // make sure we don't have a path and file yet
  LPath := TPath.Combine(TPath.Combine(TPath.GetCachePath, LVendorName), LAppName); // create the path
  if ForceDirectories(LPath) then                     // make certain the directories exist
    Result := TPath.Combine(LPath, LDatabaseFileName) // return the full path and filename
  else
  begin
    ShowMessage('Unable to create' + sLineBreak + LPath + sLineBreak + 'Execution cannot continue.');
    Application.Terminate;                            // must terminate if can't save the database
  end;
end;

{ Handle one or more files being dropped directly on the ToDoFIle form  }

procedure TToDoFileForm.DropFiles(var AWmDropFiles: TWmDropFiles);
var
  LFileCount: Integer;
  LIx: Integer;
  Filename: string;
begin
  awmdROPfILES.
  LFileCount := DragQueryFile(AWmDropFiles.Drop, $FFFFFFFF, nil, 0);  // get file count
  try
    for LIx := 0 to LFileCount - 1 do
    begin
      // allocate memory
      SetLength(Filename, 80);
      // read the file name
      DragQueryFile(AWmDropFiles.Drop, LIx, PChar(Filename), 80);
      // normalize file
      Filename := PChar(Filename);
      // add a new record
      cdsTodo.InsertRecord([Filename, '']);
    end;
  finally
    DragFinish(AWmDropFiles.Drop);
  end;
  // open the (last) record in edit mode
  cdsTodo.Edit;
  // move the input focus to the memo
  DBMemo1.SetFocus;
end;

{ Initialize the external file save mechanism }

procedure TToDoFileForm.cdsTodoBeforeOpen(DataSet: TDataSet);
begin
  TClientDataSet(DataSet).Filename := GetToDoFileName; // set the database external file name
end;

{ Message Handler for "Send To" functionality from context menu }

procedure TToDoFileForm.CopyData(var Msg: TWmCopyData);
var
  Filename: string;
begin
  // restore the window if minimized
  if IsIconic(Application.Handle) then
    Application.Restore;

  // extract the filename from the data
  Filename := Copy(PChar(Msg.CopyDataStruct.lpData), 1, Msg.CopyDataStruct.cbData div 2);
  // insert a new record
  cdsTodo.Insert;
  // set up the file name
  cdsTodo.FieldByName('Filename').AsString := Filename;
  // move the input focus to the memo
  DBMemo1.SetFocus;
end;

end.
