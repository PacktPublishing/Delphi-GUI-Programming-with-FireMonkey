unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, System.ImageList, FMX.ImgList, FMX.Grid,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.StdCtrls;

type
  TMainForm = class(TForm)
    Grid1: TGrid;
    DescriptionColumn: TStringColumn;
    ProgressColumn: TProgressColumn;
    ImageList1: TImageList;
    RatingColumn: TGlyphColumn;
    bUpdate: TButton;
    PopupColumn1: TPopupColumn;
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure FormCreate(Sender: TObject);
    procedure bUpdateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  CodeSiteLogging;

procedure TMainForm.bUpdateClick(Sender: TObject);
begin
  Grid1.Model.Columns[1].UpdateCell(1);
//  Grid1.Model.DataChanged(1, 1);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize;
  CodeSite.Clear;
end;

procedure TMainForm.Grid1GetValue(Sender: TObject; const ACol, ARow: Integer;
  var Value: TValue);
begin
  case ACol of
    0: Value := 'Task n. ' + (ARow + 1).ToString;
    1: Value := Random(100);
    2: if Random(100) >= 50 then Value := 2 else Value := 3;
    3: Value := 'One';
  end;

  CodeSite.SendFmtMsg('Providing data for (%d, %d): %s', [ACol, ARow, Value.ToString]);
end;

end.
