unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TreeView, FMX.Layouts,
  System.ImageList, FMX.ImgList, Radiant.Shapes, FMX.Objects;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    TreeViewItem1: TTreeViewItem;
    TreeViewItem2: TTreeViewItem;
    TreeViewItem3: TTreeViewItem;
    TreeViewItem4: TTreeViewItem;
    TreeViewItem5: TTreeViewItem;
    TreeViewItem6: TTreeViewItem;
    TreeViewItem7: TTreeViewItem;
    TreeViewItem8: TTreeViewItem;
    TreeViewItem9: TTreeViewItem;
    TreeViewItem10: TTreeViewItem;
    TreeViewItem11: TTreeViewItem;
    ImageList1: TImageList;
    btnZeroOffset: TButton;
    TreeViewItem12: TTreeViewItem;
    TreeViewItem13: TTreeViewItem;
    TreeViewItem14: TTreeViewItem;
    Switch1: TSwitch;
    StyleBook1: TStyleBook;
    RadiantMarker1: TRadiantMarker;
    RadiantStar1: TRadiantStar;
    RadiantStar2: TRadiantStar;
    RadiantStar3: TRadiantStar;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    procedure TreeView1Click(Sender: TObject);
    procedure btnZeroOffsetClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPerson = record
    Name: string;
    Surname: string;
    DateOfBirth: TDate;
    function Age: Integer;
    function ToString: string;

    class function Andrea: TPerson; static;
  end;

  TMyTreeViewItem = class(TTreeViewItem)
  private
    FPerson: TPerson;
  protected
    procedure SetPerson(const Value: TPerson);
  public
    property Person: TPerson read FPerson write SetPerson;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses DateUtils;

procedure TForm1.btnZeroOffsetClick(Sender: TObject);
begin
  TreeViewItem1.CustomChildrenOffset := 0;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  LItem: TMyTreeViewItem;
begin
  LItem := TMyTreeViewItem.Create(TreeView1);
  try
    LItem.Person := TPerson.Andrea;
    TreeViewItem1.AddObject(LItem);
  except
    LItem.Free;
    raise;
  end;
end;

procedure TForm1.TreeView1Click(Sender: TObject);
var
  LItem: TTreeViewItem;
  LChild: TTreeViewItem;
  LChildIndex: Integer;
  LText: string;
begin
  LItem := TreeView1.Selected;
  LText := LItem.Text
      + ' - I ' + LItem.Index.ToString
      + ' - GI ' + LItem.GlobalIndex.ToString
      + ' - L ' + LItem.Level.ToString;

  for LChildIndex := 0 to LItem.Count-1 do
  begin
    LChild := LItem.Items[LChildIndex];
    if LText <> '' then
      LText := LText + sLineBreak;

    LText := LText
      + ' -> ' + LChild.Text
      + ' - P ' + LChild.Parent.ClassName
      + ' - I ' + LChild.Index.ToString
      + ' - GI ' + LChild.GlobalIndex.ToString
      + ' - L ' + LChild.Level.ToString;
  end;

  ShowMessage(LText);
end;

{ TMyTreeViewItem }

procedure TMyTreeViewItem.SetPerson(const Value: TPerson);
begin
  FPerson := Value;
  Text := Person.ToString;
end;

{ TPerson }

function TPerson.Age: Integer;
begin
  Result := -1;
  if DateOfBirth > 0 then
    Result := YearsBetween(DateOfBirth, Now);
end;

class function TPerson.Andrea: TPerson;
begin
  Result.Name := 'Andrea';
  Result.Surname := 'Magni';
  Result.DateOfBirth := EncodeDate(1982, 05, 24);
end;

function TPerson.ToString: string;
begin
  Result := string.join(' ', [Name, Surname]);
  if Age > 0 then
    Result := Result + Format(' (%d)', [Age]);
end;

end.
