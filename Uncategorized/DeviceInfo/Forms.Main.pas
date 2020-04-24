unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.MultiView, FMX.StdCtrls, FMX.Objects;

type
  TForm1 = class(TForm)
    MultiView1: TMultiView;
    Button1: TButton;
    Panel1: TPanel;
    Image1: TImage;
    ToolBar1: TToolBar;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses FMX.BehaviorManager, System.Devices, Rtti;

procedure TForm1.FormCreate(Sender: TObject);

  function DeviceToStr(const ADevice: TDeviceInfo): string;
  begin
    Result := TRttiEnumerationType.GetName<TDeviceInfo.TDeviceClass>(ADevice.DeviceClass)
    + ' P: ' + TRttiEnumerationType.GetName<TOSVersion.TPlatform>(ADevice.Platform)
    + ' AR: ' + ADevice.AspectRatio.ToString
    + ' PPI: ' + ADevice.PixelsPerInch.ToString
    + ' SCR: ' + ADevice.MaxPhysicalScreenSize.Width.ToString + 'x' + ADevice.MaxPhysicalScreenSize.Height.ToString
    + ' DC: ' + ADevice.ID;
  end;
var
  LIndex: Integer;
begin
  Caption := '';

  for LIndex := 0 to TDeviceInfo.ThisDevice.DeviceCount - 1 do
    Caption := Caption + '| (' + LIndex.ToString + ') ' + DeviceToStr(TDeviceInfo.ThisDevice.Devices[LIndex]);
end;

end.
