unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.ListView, Data.Bind.GenData,
  Fmx.Bind.GenData, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.ImageList, FMX.ImgList,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Edit;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    ContactsPBS: TPrototypeBindSource;
    ImageList1: TImageList;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    StyleBook1: TStyleBook;
    Memo1: TMemo;
    Edit1: TEdit;
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListView1ButtonClick(const Sender: TObject;
      const AItem: TListItem; const AObject: TListItemSimpleControl);
    procedure LinkListControlToField1FillingListItem(Sender: TObject;
      const AEditor: IBindListEditorItem);
    procedure ListView1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
  private
    { Private declarations }
    procedure Log(const AMsg: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.LinkListControlToField1FillingListItem(Sender: TObject;
  const AEditor: IBindListEditorItem);
var
  LItem: TListViewItem;
  LImage: TListItemImage;
begin
  LItem := AEditor.CurrentObject as TListViewItem;
  if Assigned(LItem) then
  begin
    LImage := LItem.Objects.FindDrawable('Image6') as TListItemImage;
    if Assigned(LImage) then
      LImage.ImageIndex := AEditor.CurrentIndex mod 7;
  end;

end;

procedure TForm1.ListView1ButtonClick(const Sender: TObject;
  const AItem: TListItem; const AObject: TListItemSimpleControl);
begin
  Log('ButtonClick ' + (AObject as TListItemTextButton).Text);
end;

procedure TForm1.ListView1Click(Sender: TObject);
var
  LMsg: string;
begin
  LMsg := 'Click';
  if Assigned(ListView1.Selected) then
    LMsg := LMsg + ' ' + (ListView1.Selected as TListViewItem).Text;
  Log(LMsg);
end;

procedure TForm1.ListView1DblClick(Sender: TObject);
begin
  Log('DblClick');
end;

procedure TForm1.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  Log('ItemClick ' + AItem.Text);
end;

procedure TForm1.ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
  const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
var
  LMsg: string;
begin
  LMsg := 'ItemClickEx ' + ItemIndex.ToString;
  if Assigned(ItemObject) then
    LMsg := LMsg + ' ' + ItemObject.ClassName;
  Log(LMsg);
end;

procedure TForm1.ListView1UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  LButton: TListItemTextButton;

begin
//  (AEditor.CurrentObject as TListViewItem).Objects.TextButton.Visible := Odd(AEditor.CurrentIndex);
  if Assigned(AItem.Objects.TextButton) then
    AItem.Objects.TextButton.Visible := Odd(AItem.Index);

  LButton := AItem.Objects.FindObjectT<TListItemTextButton>(ListView1.ItemAppearanceObjects.ItemObjects.TextButton.Name);
  if Assigned(LButton) then
    LButton.Visible := Odd(AItem.Index);
end;

procedure TForm1.Log(const AMsg: string);
begin
  Memo1.Lines.Insert(0, AMsg);
end;

end.
