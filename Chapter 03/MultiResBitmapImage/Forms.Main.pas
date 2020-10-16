unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation
;

type
  TMainForm = class(TForm)
    Image1: TImage;
    DeviceLabel: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  Utils;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DeviceLabel.Text := GetDeviceAndPlatformInfo.ToString;
end;

end.
