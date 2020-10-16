unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation, FMX.ScrollBox,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, Data.Bind.GenData,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.ObjectScope;

type
  TMainForm = class(TForm)
    Grid1: TGrid;
    StringGrid1: TStringGrid;
    StringColumn1: TStringColumn;
    FloatColumn1: TFloatColumn;
    ProgressColumn1: TProgressColumn;
    GlyphColumn1: TGlyphColumn;
    ImageList1: TImageList;
    Button1: TButton;
    Column1: TColumn;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkGridToDataSourcePrototypeBindSource1: TLinkGridToDataSource;
    Grid2: TGrid;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    StyleBook1: TStyleBook;
    Grid3: TGrid;
    Column2: TColumn;
    procedure FormCreate(Sender: TObject);
    procedure GlyphColumn1GetImageIndex(Column: TColumn; const Value: TValue;
      var ImageIndex: TImageIndex);
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.Button1Click(Sender: TObject);
begin
  StringGrid1.Cells[3,1] := '2';
  ShowMessage(StringGrid1.Cells[1,1]);
  StringGrid1.Cells[1,90] := 'Andrea';
end;

type TColumnHack=class(TColumn);

procedure TMainForm.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0,0] := 'Andrea';
  StringGrid1.Cells[1,0] := '1234,50';
  StringGrid1.Cells[2,0] := '75';
  StringGrid1.Cells[3,0] := 'A1';
end;

procedure TMainForm.GlyphColumn1GetImageIndex(Column: TColumn;
  const Value: TValue; var ImageIndex: TImageIndex);
begin
  if Value.AsString = 'A1' then
    ImageIndex := 3;
end;

procedure TMainForm.Grid1GetValue(Sender: TObject; const ACol, ARow: Integer;
  var Value: TValue);
begin
  case ACol of
    0: Value := 'Andrea';
    1: Value := '1234,50';
    2: Value := 75;
    3: Value := 'A1';
  end;
end;

end.
