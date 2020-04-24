unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, Data.Bind.GenData, Fmx.Bind.GenData, Data.Bind.Components,
  Data.Bind.ObjectScope, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.ImageList, FMX.ImgList;

type
  TMainForm = class(TForm)
    ListView1: TListView;
    ContactsPBS: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ImageList1: TImageList;
    procedure LinkListControlToField1FillingListItem(Sender: TObject;
      const AEditor: IBindListEditorItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.LinkListControlToField1FillingListItem(Sender: TObject;
  const AEditor: IBindListEditorItem);
begin
  (AEditor.CurrentObject as TListViewItem).ImageIndex := 1;
end;

end.
