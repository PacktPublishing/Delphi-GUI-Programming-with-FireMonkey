unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, Data.Bind.ObjectScope,
  Data.Bind.GenData, Data.Bind.DBXScope;

type
  TForm1 = class(TForm)
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    AdapterBindSource1: TAdapterBindSource;
    PrototypeBindSource1: TPrototypeBindSource;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    ListView1: TListView;
    BindingsList1: TBindingsList;
    Edit1: TEdit;
    LinkListControlToField1: TLinkListControlToField;
    ParamsAdapter1: TParamsAdapter;
    procedure Edit1ChangeTracking(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.Bindings.Helper;


procedure TForm1.Edit1ChangeTracking(Sender: TObject);
begin
  TBindings.Notify(Sender);
  LinkListControlToField1.FillList;
end;

end.
