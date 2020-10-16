unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects, FMX.Filter.Effects, FMX.Ani;

type
  TMainForm = class(TForm)
    Text2: TText;
    ShadowEffect2: TShadowEffect;
    Text3: TText;
    ReflectionEffect1: TReflectionEffect;
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
