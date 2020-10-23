unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Stan.StorageBin,
  FireDAC.Comp.DataSet, FireDAC.Phys.SQLiteVDataSet, System.Rtti,
  FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FireDAC.Phys.SQLiteWrapper.Stat;

type
  TForm1 = class(TForm)
    DataConnection: TFDConnection;
    FDLocalSQL1: TFDLocalSQL;
    EmployeeQuery: TFDQuery;
    OrdersMemTable: TFDMemTable;
    LocalSQLConnection: TFDConnection;
    EmployeeWithOrdersQuery: TFDQuery;
    OrdersMemTableEMP_NO: TIntegerField;
    OrdersMemTableDescription: TStringField;
    OrdersMemTableQuantity: TIntegerField;
    OrdersMemTableUnitPrice: TCurrencyField;
    BSEmpWithOrdersQuery: TBindSourceDB;
    BindingsList1: TBindingsList;
    EmpWithOrdersListView: TListView;
    LinkListControlToField1: TLinkListControlToField;
    OrdersGrid: TGrid;
    BSOrdersMemTable: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    EmployeesListView: TListView;
    BSEmployeeQuery: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    procedure LocalSQLConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses IOUtils;

procedure TForm1.LocalSQLConnectionBeforeConnect(Sender: TObject);
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  LocalSQLConnection.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'MyDataBase.sdb');
{$ENDIF}
{$IF DEFINED(MSWINDOWS) or DEFINED(MACOS)}
  {$IFDEF DEBUG}
  LocalSQLConnection.Params.Values['Database'] := TPath.Combine(
    ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))) // parent folder of EXE
  , 'MyDataBase.sdb'
  );
  {$ELSE}
  LocalSQLConnection.Params.Values['Database'] := TPath.Combine(TPath.GetHomePath, 'MyDataBase.sdb');
  {$ENDIF}
{$ENDIF}
end;

end.
