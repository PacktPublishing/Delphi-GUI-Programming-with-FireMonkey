unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.ListView, Data.Bind.GenData,
  Fmx.Bind.GenData, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.ImageList, FMX.ImgList;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    ContactsPBS: TPrototypeBindSource;
    ImageList1: TImageList;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListView1ButtonClick(const Sender: TObject;
      const AItem: TListItem; const AObject: TListItemSimpleControl);
    procedure LinkListControlToField1FillingListItem(Sender: TObject;
      const AEditor: IBindListEditorItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.LinkListControlToField1FillingListItem(Sender: TObject;
  const AEditor: IBindListEditorItem);
//var
//  LItem: TListViewItem;
//  LImage: TListItemImage;
begin
//  LItem := AEditor.CurrentObject as TListViewItem;
//  if Assigned(LItem) then
//  begin
//    LImage := LItem.Objects.FindDrawable('Image6') as TListItemImage;
//    if Assigned(LImage) then
//      LImage.ImageIndex := AEditor.CurrentIndex mod 7;
//  end;
//
end;

procedure TForm1.ListView1ButtonClick(const Sender: TObject;
  const AItem: TListItem; const AObject: TListItemSimpleControl);
begin
  ShowMessage('Button! ' + AObject.ClassName + ' ' + AItem.ClassName);
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

end.
