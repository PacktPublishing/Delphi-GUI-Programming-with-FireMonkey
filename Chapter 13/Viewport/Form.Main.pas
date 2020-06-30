unit Form.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Viewport3D, FMX.Layouts, FMX.Controls.Presentation, System.Math.Vectors,
  FMX.Types3D, FMX.Controls3D, FMX.MaterialSources, FMX.Objects3D,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, FMX.ListBox;

type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    SettingsLayout: TLayout;
    Viewport3D1: TViewport3D;
    Label1: TLabel;
    DummyCameraAndLight: TDummy;
    Model3D1: TModel3D;
    Model3D1Mat01: TLightMaterialSource;
    Light1: TLight;
    DummyModel: TDummy;
    Camera1: TCamera;
    CameraRotationYTrackBar: TTrackBar;
    BindingsList1: TBindingsList;
    LinkControlToProperty1: TLinkControlToProperty;
    SettingsListBox: TListBox;
    CameraRotationYListBoxItem: TListBoxItem;
    Label2: TLabel;
    CameraRotationYLabel: TLabel;
    LightListBoxItem: TListBoxItem;
    Label3: TLabel;
    LightSwitch: TSwitch;
    LinkControlToProperty2: TLinkControlToProperty;
    procedure LinkControlToProperty1AssignedValue(Sender: TObject;
      AssignValueRec: TBindingAssignValueRec; const Value: TValue);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.LinkControlToProperty1AssignedValue(Sender: TObject;
  AssignValueRec: TBindingAssignValueRec; const Value: TValue);
begin
  CameraRotationYLabel.Text := Value.ToString;
end;

end.
