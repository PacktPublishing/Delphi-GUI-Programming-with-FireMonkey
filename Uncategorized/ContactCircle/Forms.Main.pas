unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Radiant.Shapes,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ImgList,
  System.ImageList, FMX.Effects, FMX.Layouts;

type
  TMainForm = class(TForm)
    TopToolBar: TToolBar;
    ProfileCircle: TCircle;
    Label1: TLabel;
    ShadowEffect1: TShadowEffect;
    NameSurnameLabel: TLabel;
    CountryLabel: TLabel;
    ImageList1: TImageList;
    LangLabel: TLabel;
    FlowLayout1: TFlowLayout;
    Glyph1: TGlyph;
    Glyph2: TGlyph;
    Glyph3: TGlyph;
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
