unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, FMX.Effects,
  FMX.Filter.Effects;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Image1: TImage;
    Image2: TImage;
    Layout3: TLayout;
    Label1: TLabel;
    Rectangle1: TRectangle;
    GlowEffect1: TGlowEffect;
    MonochromeEffect1: TMonochromeEffect;
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
