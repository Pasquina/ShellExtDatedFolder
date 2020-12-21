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
  private
    { Private declarations }
  public
    procedure DropFiles (var Msg: TWmDropFiles);
      message wm_DropFiles;
    procedure CopyData (var Msg: TWmCopyData);
      message wm_CopyData;
  end;

var
  ToDoFileForm: TToDoFileForm;

implementation

{$R *.DFM}

uses
  ShellApi;

procedure TToDoFileForm.FormCreate(Sender: TObject);
begin
  // eventually create the table
  if not FileExists (cdsTodo.FileName) then
    cdsTodo.CreateDataset;
  // activate the table
  cdsTodo.Open;
  // accept dragging to the form
  DragAcceptFiles (Handle, True);
end;

procedure TToDoFileForm.DropFiles(var Msg: TWmDropFiles);
var
  nFiles, I: Integer;
  Filename: string;
begin
  // get the number of dropped files
  nFiles := DragQueryFile (Msg.Drop, $FFFFFFFF, nil, 0);
  // for each file
  try
    for I := 0 to nFiles - 1 do
    begin
      // allocate memory
      SetLength (Filename, 80);
      // read the file name
      DragQueryFile (Msg.Drop, I, PChar (Filename), 80);
      // normalize file
      Filename := PChar (Filename);
      // add a new record
      cdsTodo.InsertRecord ([Filename, '']);
    end;
  finally
    DragFinish (Msg.Drop);
  end;
  // open the (last) record in edit mode
  cdsTodo.Edit;
  // move the input focus to the memo
  DBMemo1.SetFocus;
end;

procedure TToDoFileForm.CopyData(var Msg: TWmCopyData);
var
  Filename: string;
begin
  // restore the window if minimized
  if IsIconic (Application.Handle) then
    Application.Restore;

  // extract the filename from the data
  Filename := Copy (
    PChar (Msg.CopyDataStruct.lpData),
    1, Msg.CopyDataStruct.cbData div 2);
  // insert a new record
  cdsTodo.Insert;
  // set up the file name
  cdsTodo.FieldByName ('Filename').AsString := Filename;
  // move the input focus to the memo
  DBMemo1.SetFocus;
end;

end.
