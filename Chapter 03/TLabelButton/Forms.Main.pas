unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TMainForm = class(TForm)
    Label1: TLabel;
    StyleBook1: TStyleBook;
    Label2: TLabel;
    Label3: TLabel;
    procedure Label2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label1ApplyStyleLookup(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.Label1ApplyStyleLookup(Sender: TObject);
var
  LText: TFmxObject;
begin
  LText := (Sender as TFMXObject).FindStyleResource('text');
  if (LText is TButton) then
    TButton(LText).OnClick := (Sender as TLabel).OnClick;
end;

procedure TMainForm.Label1Click(Sender: TObject);
begin
  ShowMessage('First label');
end;

procedure TMainForm.Label2Click(Sender: TObject);
begin
  ShowMessage('Second label');
end;

procedure TMainForm.Label3Click(Sender: TObject);
begin
  Label3.Text := TimeToStr(Now);
end;

end.
