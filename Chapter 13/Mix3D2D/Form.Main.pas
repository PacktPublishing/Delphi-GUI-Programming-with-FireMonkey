unit Form.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, System.Math.Vectors, FMX.Objects3D, FMX.Controls3D,
  FMX.MaterialSources, FMX.Layers3D, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Layouts,
  FMX.ListBox, FMX.Colors, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TMainForm = class(TForm3D)
    DummyUI: TDummy;
    DeerModel: TModel3D;
    Light1: TLight;
    LightMaterialSource1: TLightMaterialSource;
    Layer3D1: TLayer3D;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ColorListBox1: TColorListBox;
    DummyModel: TDummy;
    Layer3D2: TLayer3D;
    ModelScaleTrackBar: TTrackBar;
    ModelRotationYTrackBar: TTrackBar;
    ModelRotationXTrackBar: TTrackBar;
    ModelRotationZTrackBar: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ProxyObject1: TProxyObject;
    CatModel: TModel3D;
    DogModel: TModel3D;
    procedure Form3DCreate(Sender: TObject);
    procedure ColorListBox1Change(Sender: TObject);
    procedure ModelScaleTrackBarChange(Sender: TObject);
    procedure ModelRotationYTrackBarChange(Sender: TObject);
    procedure ModelRotationZTrackBarChange(Sender: TObject);
    procedure ModelRotationXTrackBarChange(Sender: TObject);
  private
    procedure SetModel3DMaterial(const AMaterial: TMaterialSource; const AModel3D: TModel3D);
  protected
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses Data.Models, Utils.Messages;

procedure TMainForm.ColorListBox1Change(Sender: TObject);
begin
  LightMaterialSource1.Ambient := ColorListBox1.Color;
end;

procedure TMainForm.Form3DCreate(Sender: TObject);
begin
  TAnimalSelectedMsg.SubscribeTo(
    procedure(AName: string)
    begin
      if SameText(AName, 'cat') then
        ProxyObject1.SourceObject := CatModel
      else if SameText(AName, 'deer') then
        ProxyObject1.SourceObject := DeerModel
      else if SameText(AName, 'dog') then
        ProxyObject1.SourceObject := DogModel
      else
        ProxyObject1.SourceObject := nil;

      if Assigned(ProxyObject1.SourceObject) then
        SetModel3DMaterial(LightMaterialSource1, ProxyObject1.SourceObject as TModel3D);
    end
  );

  LinkListControlToField1.FillList; // force LB update
end;

procedure TMainForm.ModelRotationXTrackBarChange(Sender: TObject);
begin
  ProxyObject1.RotationAngle.X := ModelRotationXTrackBar.Value;
end;

procedure TMainForm.ModelRotationYTrackBarChange(Sender: TObject);
begin
  ProxyObject1.RotationAngle.Y := ModelRotationYTrackBar.Value;
end;

procedure TMainForm.ModelRotationZTrackBarChange(Sender: TObject);
begin
  ProxyObject1.RotationAngle.Z := ModelRotationZTrackBar.Value;
end;

procedure TMainForm.ModelScaleTrackBarChange(Sender: TObject);
begin
  ProxyObject1.Scale.X := ModelScaleTrackBar.Value;
  ProxyObject1.Scale.Y := ModelScaleTrackBar.Value;
  ProxyObject1.Scale.Z := ModelScaleTrackBar.Value;

end;

procedure TMainForm.SetModel3DMaterial(const AMaterial: TMaterialSource; const AModel3D: TModel3D);
var
  LMesh: TMesh;
begin
  for LMesh in AModel3D.MeshCollection do
    LMesh.MaterialSource := AMaterial;
end;

end.
