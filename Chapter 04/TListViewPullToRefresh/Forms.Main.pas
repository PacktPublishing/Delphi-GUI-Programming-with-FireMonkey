unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.ListView, FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, FMX.StdCtrls;

type
  TMainForm = class(TForm)
    ListView1: TListView;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    Memo1: TMemo;
    AniIndicator1: TAniIndicator;
    procedure ListView1PullRefresh(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshData;
    function CopyDataSetThreadSafe(const ASource: TFDMemTable): TFDMemTable;
    procedure SynchronizeIfNeeded(const AProc: TProc);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses System.Threading;

function TMainForm.CopyDataSetThreadSafe(const ASource: TFDMemTable): TFDMemTable;
begin
  Result := TFDMemTable.Create(nil);
  try
    Result.Data := ASource.Data;
  except on E: Exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

procedure TMainForm.ListView1PullRefresh(Sender: TObject);
begin
  Memo1.Lines.Add(TimeToStr(NOW) + ': Refresh request');

  // on Windows platform TListview does not provide a visual feedback
  // for the ongoing PullToRefresh operation, so I added a TAniIndicator for the
  // purpose
  AniIndicator1.Enabled := True;

  TTask.Run(
    procedure
    begin
      RefreshData;

      SynchronizeIfNeeded(
        procedure
        begin
          ListView1.StopPullRefresh;
          AniIndicator1.Enabled := False;
          Memo1.Lines.Add(TimeToStr(NOW) + ': Refresh completed!');
        end
      );
    end
  );

end;

procedure TMainForm.RefreshData;
var
  LBuffer: TFDMemTable;
begin
  // - FDMemTable1 has data bindings to UI
  // - a local copy (Buffer) of data is safer to manipulate in a secondary thread context
  // - I am altering data (refreshing them, fetching them, whatever) in the background ,
  //   using the buffer copy I created
  // - at the end, I copy back data from the buffer to the actual dataset (UI data binding)

  var LSource := FDMemTable1;

  SynchronizeIfNeeded(
    procedure
    begin
      LBuffer := CopyDataSetThreadSafe(LSource);
    end
  );

  try
    Sleep(1000 + Random(1000)); // duration: 1s to 2s

    // data manipulation here
    LBuffer.First;
    while not LBuffer.Eof do
    begin
      LBuffer.Edit;
      LBuffer.FieldByName('LastName').AsString := LBuffer.FieldByName('LastName').AsString + 'X';
      LBuffer.Post;

      LBuffer.Next;
    end;

    // copy of data to the actual dataset
    SynchronizeIfNeeded(
      procedure
      begin
        var B := LSource.Bookmark;
        LSource.Active := False;
        LSource.Data := LBuffer.Data;
        LSource.Bookmark := B;
      end
    );
  finally
    LBuffer.Free;
  end;
end;

procedure TMainForm.SynchronizeIfNeeded(const AProc: TProc);
begin
  if TThread.CurrentThread.ThreadID <> MainThreadID then
    TThread.Synchronize(nil, TThreadProcedure(AProc))
  else
    AProc();
end;

end.
