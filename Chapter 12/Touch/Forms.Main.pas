unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Gestures,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TMainForm = class(TForm)
    Circle1: TCircle;
    Circle2: TCircle;
    Circle3: TCircle;
    Circle4: TCircle;
    Circle5: TCircle;
    Circle6: TCircle;
    Circle7: TCircle;
    Circle8: TCircle;
    Circle9: TCircle;
    Circle10: TCircle;
    ActionLabel: TLabel;
    DownCounterLabel: TLabel;
    procedure FormTouch(Sender: TObject; const Touches: TTouches;
      const Action: TTouchAction);
    procedure FormCreate(Sender: TObject);
  private
    FCircles: TArray<TCircle>;
    FDownCounter: Integer;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses System.Rtti;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCircles := [
    Circle1, Circle2, Circle3, Circle4, Circle5
  , Circle6, Circle7, Circle8, Circle9, Circle10
  ];
  FDownCounter := 0;
end;

procedure TMainForm.FormTouch(Sender: TObject; const Touches: TTouches;
  const Action: TTouchAction);
var
  LIndex: Integer;
  LTouchLocation: TPointF;
  LCircle: TCircle;
begin
  if Length(Touches) > 10 then
    Exit;

  for LIndex := 0 to Length(Touches)-1 do
  begin
    if Action in [TTouchAction.Down, TTouchAction.Move] then
    begin
      LCircle := FCircles[LIndex];
      LTouchLocation := Touches[LIndex].Location;

      LTouchLocation.Offset(-LCircle.Width / 2, -LCircle.Height / 2);
      LCircle.Position.Point := LTouchLocation;
    end;
  end;

  ActionLabel.Text := TRttiEnumerationType.GetName<TTouchAction>(Action);

  case Action of
    TTouchAction.None: ;
    TTouchAction.Up: Dec(FDownCounter);
    TTouchAction.Down: Inc(FDownCounter);
    TTouchAction.Move: ;
    TTouchAction.Cancel: FDownCounter := 0;
  end;

  DownCounterLabel.Text := 'Down: ' + FDownCounter.ToString;
end;

end.
