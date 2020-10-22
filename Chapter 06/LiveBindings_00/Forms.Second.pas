unit Forms.Second;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, System.Bindings.Helper,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TForm2 = class(TForm)
    Text1: TText;
    BindingsList1: TBindingsList;
    Button1: TButton;
    CheckBox1: TCheckBox;
    LinkControlToPropertyEnabled: TLinkControlToProperty;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation


{$R *.fmx}

end.
