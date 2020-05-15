unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FloatAnimation1: TFloatAnimation;
    Timer1: TTimer;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FloatAnimation1Process(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
  private
    FStartedAt: TDateTime;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses DateUtils;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FloatAnimation1.Start;
  FStartedAt := Now;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FloatAnimation1.Pause := not FloatAnimation1.Pause;
  Memo1.Lines.Add(TimeToStr(Now) + ': ' + 'Pause = ' + BoolToStr(FloatAnimation1.Pause, True));
end;

procedure TForm1.FloatAnimation1Finish(Sender: TObject);
begin
  Memo1.Lines.Add(TimeToStr(Now) + ': ' + 'Finish');
end;

procedure TForm1.FloatAnimation1Process(Sender: TObject);
begin
  Caption :=
    'C: ' + FormatFloat('0.000', FloatAnimation1.CurrentTime) +
    ' N: ' + FormatFloat('0.000', FloatAnimation1.NormalizedTime);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  var LStr := '';
  if FloatAnimation1.Enabled then
    LStr := LStr + 'E';

  if FloatAnimation1.Running then
    LStr := LStr + 'R';

  if FloatAnimation1.Inverse then
    LStr := LStr + 'I';

  Button1.Text := LStr + ' ' + MilliSecondsBetween(FStartedAt, Now).ToString + 'ms';
end;

end.
