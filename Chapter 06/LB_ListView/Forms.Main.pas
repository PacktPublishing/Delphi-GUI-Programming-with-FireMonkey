unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.ListView,
  System.ImageList, FMX.ImgList;

type
  TMainForm = class(TForm)
    EmployeeData: TFDMemTable;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ListView2: TListView;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
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

uses DateUtils;

procedure TMainForm.FormCreate(Sender: TObject);
var
  LItem: TListViewItem;
begin
  ListView2.BeginUpdate;
  try
    ListView2.Items.Clear;
    EmployeeData.First;
    while not EmployeeData.Eof do
    begin
      LItem := ListView2.Items.Add;
      LItem.Text := EmployeeData.FieldByName('LastName').AsString;

      EmployeeData.Next;
    end;

  finally
    ListView2.EndUpdate;
  end;
end;

procedure TMainForm.LinkListControlToField1FillingListItem(Sender: TObject;
  const AEditor: IBindListEditorItem);
var
  LTextObject: TListItemText;
  LItem: TListViewItem;
begin
  LItem := AEditor.CurrentObject as TListViewItem;
  LTextObject := LItem.Objects.FindDrawable('HireDateText') as TListItemText;
  if Assigned(LTextObject) then
    if YearOf(EmployeeData.FieldByName('HireDate').AsDateTime) < 1990 then
    begin
      LTextObject.TextColor := TAlphaColorRec.Red;
    end
    else
    begin
      LTextObject.TextColor := TAlphaColorRec.Null;
    end;
end;

end.
