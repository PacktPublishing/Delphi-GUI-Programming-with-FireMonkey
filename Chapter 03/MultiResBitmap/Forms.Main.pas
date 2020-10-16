unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ExtCtrls, FMX.Controls.Presentation, FMX.StdCtrls, FMX.MultiResBitmap,
  FMX.ScrollBox, FMX.Memo, FMX.ImgList, System.ImageList;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    Glyph1: TGlyph;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
