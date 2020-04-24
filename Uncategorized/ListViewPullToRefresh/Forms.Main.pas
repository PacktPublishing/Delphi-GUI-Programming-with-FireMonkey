unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.DB, Data.Bind.Components, Data.Bind.DBScope,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListView,
  FireDAC.Stan.StorageBin, Data.Bind.GenData, Data.Bind.ObjectScope, Generics.Collections,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TMainForm = class(TForm)
    ListView1: TListView;
    AdapterBindSource1: TAdapterBindSource;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    AddButton: TButton;
    Timer1: TTimer;
    ToggleButton: TButton;
    ClearButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure AdapterBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure ListView1PullRefresh(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure ToggleButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
  public type
    TMyEvent = class
    private
        FWho: string;
        FWhat: Integer;
        FWhen: TDateTime;
    protected
    public
      constructor Create(const AWho: string; const AWhat: Integer); virtual;
      property What: Integer read FWhat write FWhat;
      property Who: string read FWho write FWho;
      property When: TDateTime read FWhen write FWhen;
    end;
  private
    FEvents: TObjectList<TMyEvent>;
    function GetEvents: TObjectList<TMyEvent>;
  public
    procedure RefreshList;
    procedure AddAndRefreshList(const AEvent: TMyEvent);
    property Events: TObjectList<TMyEvent> read GetEvents;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  Generics.Defaults, Math;

procedure TMainForm.AdapterBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := TListBindSourceAdapter<TMyEvent>.Create(nil, Events, False);
end;

procedure TMainForm.AddAndRefreshList(const AEvent: TMyEvent);
begin
  Events.Add( AEvent );
  RefreshList;
end;

procedure TMainForm.AddButtonClick(Sender: TObject);
begin
  AddAndRefreshList( TMyEvent.Create('Andrea', Random(100)) );
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
  Events.Clear;
  RefreshList;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize;
end;

function TMainForm.GetEvents: TObjectList<TMyEvent>;
begin
  if not Assigned(FEvents) then
    FEvents := TObjectList<TMyEvent>.Create(
      TComparer<TMyEvent>.Construct(
        function (const A,B: TMyEvent): Integer
        begin
          Result := CompareValue(A.What, B.What);
        end
      )
    );
  Result := FEvents;
end;

procedure TMainForm.ListView1PullRefresh(Sender: TObject);
var
  LEvent: TMyEvent;
begin
  for LEvent in Events do
    LEvent.What := LEvent.What + Random(50);

  RefreshList;
end;

procedure TMainForm.RefreshList;
begin
  Events.Sort;
  LinkListControlToField1.FillList;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  AddAndRefreshList( TMyEvent.Create('Timer', Random(100)) );
end;

procedure TMainForm.ToggleButtonClick(Sender: TObject);
begin
  Timer1.Enabled := ToggleButton.IsPressed;
end;

{ TForm1.TMyEvent }

constructor TMainForm.TMyEvent.Create(const AWho: string; const AWhat: Integer);
begin
  inherited Create;
  FWho := AWho;
  FWhat := AWhat;
  FWhen := Now;
end;

end.
