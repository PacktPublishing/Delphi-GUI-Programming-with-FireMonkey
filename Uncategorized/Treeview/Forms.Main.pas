unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TreeView,
  System.ImageList, FMX.ImgList, FMX.Layouts;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    ImageList1: TImageList;
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
    TreeViewItem12: TTreeViewItem;
    StyleBook1: TStyleBook;
    procedure TreeViewItem10ApplyStyleLookup(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.TreeViewItem10ApplyStyleLookup(Sender: TObject);
var
  LItem: TTreeViewItem;
  LGlyph: TGlyph;
begin
  LItem := (Sender as TTreeViewItem);
  if not Assigned(LItem) then Exit;
  LGlyph := LItem.FindStyleResource('extraglyph') as TGlyph;
  if not Assigned(LGlyph) then Exit;
  if LGlyph.Images <> LItem.Images then
    LGlyph.Images := LItem.Images;
  if LGlyph.ImageIndex <> LItem.ImageIndex then
    LGlyph.ImageIndex := LItem.ImageIndex;
end;

end.
