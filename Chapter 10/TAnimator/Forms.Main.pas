unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani;

type
  TMainForm = class(TForm)
    Button1: TButton;
    FloatAnimation1: TFloatAnimation;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.Button1Click(Sender: TObject);
begin
  TAnimator.AnimateFloat(
    Button1, 'Width'
  , Button1.Width * 1.25
  , 1
  , TAnimationType.&Out
  , TInterpolationType.Back
  );

  TAnimator.AnimateFloat(
    Button1, 'Height'
  , Button1.Height * 1.25
  , 1
  , TAnimationType.&Out
  , TInterpolationType.Back
  );


end;

end.
