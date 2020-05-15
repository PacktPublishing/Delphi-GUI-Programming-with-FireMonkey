unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TMainForm = class(TForm)
    PathAnimation1: TPathAnimation;
    Button1: TButton;
    procedure PathAnimation1Process(Sender: TObject);
  private
    { Private declarations }
    FDotPosition: TPointF;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.PathAnimation1Process(Sender: TObject);
const CircleSize = 5;
begin
  if FDotPosition.Distance(Button1.Position.Point) > CircleSize then
  begin
    FDotPosition := Button1.Position.Point;
    var LDot := TCircle.Create(Self);
    try
      LDot.Parent := MainForm;
      LDot.Height := CircleSize;
      LDot.Width := CircleSize;
      LDot.Position.Point := FDotPosition;
      LDot.Position.Point.Offset(-CircleSize/2,-CircleSize/2);
    except
      LDOt.Free;
    end;
  end;
end;

end.
