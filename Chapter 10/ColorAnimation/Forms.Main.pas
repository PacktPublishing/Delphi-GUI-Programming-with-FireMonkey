unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Objects, FMX.Colors, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    ColorAnimation1: TColorAnimation;
    ColorPanel1: TColorPanel;
    ColorBox1: TColorBox;
    Memo1: TMemo;
    ColorKeyAnimation1: TColorKeyAnimation;
    procedure ColorAnimation1Process(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure ColorKeyAnimation1Process(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.ColorAnimation1Process(Sender: TObject);
var
  LCurrentColor: TAlphaColor;
begin
  LCurrentColor := Rectangle2.Fill.Color;
//  Memo1.Lines.Add(
//    Format('%d,%d,%d', [
//      TAlphaColorRec(LCurrentColor).R, TAlphaColorRec(LCurrentColor).G, TAlphaColorRec(LCurrentColor).B]
//    )
//  );
end;

procedure TForm1.ColorKeyAnimation1Process(Sender: TObject);
var
  LCurrentColor: TAlphaColor;
begin
  LCurrentColor := Rectangle3.Fill.Color;

  Memo1.Lines.Add(
    Format('%d,%d,%d', [
      TAlphaColorRec(LCurrentColor).R, TAlphaColorRec(LCurrentColor).G, TAlphaColorRec(LCurrentColor).B]
    )
  );
end;

procedure TForm1.Rectangle2Click(Sender: TObject);
begin
  ColorAnimation1.Start;
end;

end.
