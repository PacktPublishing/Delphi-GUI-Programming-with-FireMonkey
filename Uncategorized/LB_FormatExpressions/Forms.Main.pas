unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.Components, Data.Bind.DBScope, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, FMX.ListView, FMX.Controls.Presentation, FMX.Edit,
  FMX.StdCtrls, Data.Bind.Controls, FMX.Objects, FMX.Layouts, Fmx.Bind.Navigator;

type
  TMainForm = class(TForm)
    EmployeeData: TFDMemTable;
    EmployeeBindSourceDB: TBindSourceDB;
    BindNavigator1: TBindNavigator;
    Text1: TText;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    Edit1: TEdit;
    LinkControlToField1: TLinkControlToField;
    Text2: TText;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    Text3: TText;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    Text4: TText;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    Text5: TText;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    TrackBar1: TTrackBar;
    LinkControlToField2: TLinkControlToField;
    Text6: TText;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    TrackBar2: TTrackBar;
    LinkControlToField3: TLinkControlToField;
    LinkPropertyToFieldMax: TLinkPropertyToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

end.
