unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Ani, FMX.Layouts,
  FMX.ListBox, System.Rtti, FMX.Edit;

type
  TMainForm = class(TForm)
    HorzAnimation: TFloatAnimation;
    Rectangle1: TRectangle;
    Circle1: TCircle;
    VertAnimation: TFloatAnimation;
    ExecuteButton: TButton;
    ToolsLayout: TLayout;
    PlaygroundLayout: TLayout;
    InterpolationComboBox: TComboBox;
    DurationEdit: TEdit;
    HorzLabel: TLabel;
    VertLine33: TLine;
    VertLine66: TLine;
    HorzLine66: TLine;
    HorzLine33: TLine;
    PinLayout: TLayout;
    OriginLabel: TLabel;
    DestinationLabel: TLabel;
    AnimationTypeComboBox: TComboBox;
    DurationLabel: TLabel;
    FrameRateEdit: TEdit;
    FrameRateLabel: TLabel;
    TitleLabel: TLabel;
    procedure ExecuteButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HorzAnimationFinish(Sender: TObject);
    procedure HorzAnimationProcess(Sender: TObject);
  private
    FLastSnapshot: Double;
    procedure CloneCircleAt(const AX, AY: Double; const ANewSize: Double = -1; const ANewOpacity: Double = -1);
    procedure ResetSnapshots;
    procedure TakeSnapshot;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}



procedure TMainForm.CloneCircleAt(const AX, AY: Double; const ANewSize: Double = -1; const ANewOpacity: Double = -1);
var
  LNewCircle: TCircle;
  LSource: TCircle;
begin
  LSource := Circle1;

  LNewCircle := LSource.Clone(Self) as TCircle;
  LNewCircle.Parent := Rectangle1;
  if ANewSize <> -1 then
  begin
    LNewCircle.Width := ANewSize;
    LNewCircle.Height := ANewSize;
  end;

  if ANewOpacity <> -1 then
    LNewCircle.Opacity := ANewOpacity;

  LNewCircle.Align := TAlignLayout.None;
  LNewCircle.Position.X := AX - (LNewCircle.Width / 2);
  LNewCircle.Position.Y := AY - (LNewCircle.Height / 2);
end;

procedure TMainForm.ExecuteButtonClick(Sender: TObject);
begin
  HorzAnimation.Stop;
  VertAnimation.Stop;

  TAnimation.AniFrameRate := StrToIntDef(FrameRateEdit.Text, 60);

  VertAnimation.Interpolation := TRttiEnumerationType.GetValue<TInterpolationType>(
    InterpolationComboBox.Items[InterpolationComboBox.ItemIndex]
  );
  VertAnimation.AnimationType := TRttiEnumerationType.GetValue<TAnimationType>(
    AnimationTypeComboBox.Items[AnimationTypeComboBox.ItemIndex]
  );
  VertAnimation.Duration := StrToFloatDef(DurationEdit.Text, 1);
  HorzAnimation.Duration := VertAnimation.Duration;

  TitleLabel.Text := InterpolationComboBox.Items[InterpolationComboBox.ItemIndex];
  case VertAnimation.AnimationType of
    TAnimationType.In: TitleLabel.Text := '< ' + TitleLabel.Text + '';
    TAnimationType.Out: TitleLabel.Text := '' + TitleLabel.Text + ' >';
    TAnimationType.InOut: TitleLabel.Text := '< ' + TitleLabel.Text + ' >';
  end;

  ResetSnapshots;
  HorzAnimation.Start;
  VertAnimation.Start;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  LInterpolationType: TRttiEnumerationType;
  LAnimationTypeType: TRttiEnumerationType;
begin
  LInterpolationType := TRttiContext.Create.GetType(TypeInfo(TInterpolationType)) as TRttiEnumerationType;
  LAnimationTypeType := TRttiContext.Create.GetType(TypeInfo(TAnimationType)) as TRttiEnumerationType;

  InterpolationComboBox.Items.Clear;
  InterpolationComboBox.Items.AddStrings(LInterpolationType.GetNames);
  InterpolationComboBox.ItemIndex := 1; // Quadratic by default

  AnimationTypeComboBox.Items.Clear;
  AnimationTypeComboBox.Items.AddStrings(LAnimationTypeType.GetNames);
  AnimationTypeComboBox.ItemIndex := 0;
end;

procedure TMainForm.HorzAnimationFinish(Sender: TObject);
begin
  HorzLabel.Text := '';
end;

procedure TMainForm.HorzAnimationProcess(Sender: TObject);
begin
  HorzLabel.Text := Format('X: %.3f, Y: %.3f, t: %.3f'
    , [PinLayout.Position.X, PinLayout.Position.Y, HorzAnimation.CurrentTime]);

  if ((HorzAnimation.CurrentTime - FLastSnapshot) > (HorzAnimation.Duration / TAnimation.AniFrameRate)) then
    TakeSnapshot;
end;

procedure TMainForm.ResetSnapshots;
begin
  FLastSnapshot := -1;

  for var LChild in Rectangle1.Children.ToArray do
    if (LChild is TCircle) and (LChild <> Circle1) then
      LChild.Free;
end;

procedure TMainForm.TakeSnapshot;
begin
  FLastSnapshot := HorzAnimation.CurrentTime;
  CloneCircleAt(PinLayout.Position.X, PinLayout.Position.Y, 4,
    HorzAnimation.CurrentTime / HorzAnimation.Duration);
end;

end.
