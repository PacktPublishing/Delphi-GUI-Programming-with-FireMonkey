unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.Gestures, FMX.Objects, FMX.ImgList, System.ImageList,
  FMX.StdCtrls, FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    PrevAction: TAction;
    NextAction: TAction;
    ImageList1: TImageList;
    FrameGlyph: TGlyph;
    FrameRectangle: TRectangle;
    ToolBar1: TToolBar;
    PrevButton: TButton;
    NextButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure PrevActionExecute(Sender: TObject);
    procedure NextActionExecute(Sender: TObject);
    procedure PrevActionUpdate(Sender: TObject);
    procedure NextActionUpdate(Sender: TObject);
    procedure FrameGlyphGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TMainForm.FormCreate(Sender: TObject);
//var
//  LCenter: TPointF;
begin
//  LCenter := PointF(Width / 2, Height / 2);
//  Circle1.Position.Point :=
end;

procedure TMainForm.FrameGlyphGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  LHorzPos: Single;
  LNormPos: Single;
  LImageIndex: Integer;
  LMaxIndex: Integer;
begin
  if EventInfo.GestureID = igiPan then
  begin
    LMaxIndex := FrameGlyph.Images.Count-1;
    LHorzPos := EventInfo.Location.X - FrameRectangle.Margins.Left;
    LNormPos := LHorzPos / FrameRectangle.Width;
    LImageIndex := Round(LNormPos * LMaxIndex);

    if LImageIndex < 0 then LImageIndex := 0
    else if LImageIndex > LMaxIndex then
      LImageIndex := LMaxIndex;
    FrameGlyph.ImageIndex := LImageIndex;
  end;

end;

procedure TMainForm.NextActionExecute(Sender: TObject);
begin
  FrameGlyph.ImageIndex := FrameGlyph.ImageIndex + 1;
end;

procedure TMainForm.NextActionUpdate(Sender: TObject);
begin
  NextAction.Enabled := FrameGlyph.ImageIndex < FrameGlyph.Images.Count - 1;
end;

procedure TMainForm.PrevActionExecute(Sender: TObject);
begin
  FrameGlyph.ImageIndex := FrameGlyph.ImageIndex - 1;
end;

procedure TMainForm.PrevActionUpdate(Sender: TObject);
begin
  PrevAction.Enabled := FrameGlyph.ImageIndex > 0;
end;

end.
