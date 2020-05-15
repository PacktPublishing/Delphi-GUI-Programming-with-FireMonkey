unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Ani, FMX.Layouts, FMX.Edit;

type
  TMainForm = class(TForm)
    XTrackBar: TTrackBar;
    YTrackBar: TTrackBar;
    Rectangle1: TRectangle;
    DestinationLabel: TLabel;
    OriginLabel: TLabel;
    VertLine66: TLine;
    VertLine33: TLine;
    HorzLine66: TLine;
    HorzLine33: TLine;
    PinLayout: TLayout;
    Circle1: TCircle;
    HorzLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    InterpolationGroupBox: TGroupBox;
    LinearIntRadioButton: TRadioButton;
    QuadraticIntRadioButton: TRadioButton;
    StepButton: TButton;
    AutoCheckBox: TCheckBox;
    AutomaticTimer: TTimer;
    procedure XTrackBarChange(Sender: TObject);
    procedure StepButtonClick(Sender: TObject);
    procedure AutoCheckBoxClick(Sender: TObject);
    procedure AutomaticTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}


procedure TMainForm.AutoCheckBoxClick(Sender: TObject);
begin
  AutomaticTimer.Enabled := False;
  if AutoCheckBox.IsChecked then
  begin
    XTrackBar.Value := 0.0;
    AutomaticTimer.Enabled := True;
  end;
end;

procedure TMainForm.AutomaticTimerTimer(Sender: TObject);
begin
  if XTrackBar.Value < XTrackBar.Max - 1 then
    XTrackBar.Value := XTrackBar.Value + 1
  else
  begin
    XTrackBar.Value := XTrackBar.Max;
    AutomaticTimer.Enabled := False;
    AutoCheckBox.IsChecked := False;
  end;
end;

procedure TMainForm.StepButtonClick(Sender: TObject);
begin
  XTrackBar.Value := XTrackBar.Value + 1;
end;

procedure TMainForm.XTrackBarChange(Sender: TObject);
const MAX = 300;
var
  LX, LY: Single;
begin
  LX := XTrackBar.Value;

  if LinearIntRadioButton.IsChecked then
    LY := MAX - InterpolateLinear(LX, 0, 1, MAX) * MAX
  else if QuadraticIntRadioButton.IsChecked then
    LY := MAX - InterpolateQuad(LX, 0, 1, MAX, TAnimationType.&In) * MAX;

  PinLayout.Position.X := LX-1;
  PinLayout.Position.Y := LY-1;

  YTrackBar.Value := MAX - LY;

  HorzLabel.Text := Format('X: %.3f, Y: %.3f', [LX, MAX - LY]);
end;

end.
