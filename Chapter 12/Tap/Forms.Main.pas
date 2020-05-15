unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TMainForm = class(TForm)
    Circle1: TCircle;
    procedure FormTap(Sender: TObject; const Point: TPointF);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.FormTap(Sender: TObject; const Point: TPointF);
var
  LNewCircle: TCircle;
  LNewPos: TPointF;
begin
  LNewCircle := Circle1.Clone(Self) as TCircle;
  AddObject(LNewCircle);

  LNewPos := Point;
  LNewPos.Offset(-LNewCircle.Width / 2, -LNewCircle.Height / 2);
  LNewCircle.Position.Point := LNewPos;
end;

end.
