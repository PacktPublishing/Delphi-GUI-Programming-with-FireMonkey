unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.ImageList,
  FMX.ImgList, Data.Bind.Components, Data.Bind.DBScope, FMX.ListView, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TForm1 = class(TForm)
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    ImageList1: TImageList;
    Button1: TButton;
    ListView1: TListView;
    LinkListControlToField3: TLinkListControlToField;
    procedure LinkListControlToField1FillingListItem(Sender: TObject;
      const AEditor: IBindListEditorItem);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses CodeSiteLogging;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ListView1.EditMode := not ListView1.EditMode;
end;

procedure TForm1.LinkListControlToField1FillingListItem(Sender: TObject;
  const AEditor: IBindListEditorItem);
var
  LBindSource: TBindSourceDB;
  LItem: TListViewItem;
  LDataSet: TDataSet;
begin
  LItem := AEditor.CurrentObject as TListViewItem;
  LBindSource := LinkListControlToField3.DataSource as TBindSourceDB;
  LDataSet := LBindSource.DataSet;

//  CodeSite.SendMsg(
//    LItem.ClassName + ' - ' + LinkListControlToField3.DataSource.ClassName + sLineBreak
//  + LBindSource.DataSet.FieldByName('Common_Name').AsString + sLineBreak
//  );

  if LDataSet.FieldByName('Common_Name').AsString.StartsWith('G') then
  begin
    if LItem.ImageIndex <> 0 then
      LItem.ImageIndex := 0;
  end
  else
  begin
    if LItem.ImageIndex <> 1 then
      LItem.ImageIndex := 1;
  end;


end;

end.
