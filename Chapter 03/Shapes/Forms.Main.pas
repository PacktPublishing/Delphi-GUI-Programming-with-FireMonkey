unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  System.ImageList, FMX.ImgList;

type
  TMainForm = class(TForm)
    Circle1: TCircle;
    Ellipse1: TEllipse;
    Rectangle1: TRectangle;
    RoundRect1: TRoundRect;
    Arc1: TArc;
    Pie1: TPie;
    Line1: TLine;
    Circle2: TCircle;
    Image1: TImage;
    Glyph1: TGlyph;
    ImageList1: TImageList;
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
