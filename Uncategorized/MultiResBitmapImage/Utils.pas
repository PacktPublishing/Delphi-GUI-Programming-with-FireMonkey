unit Utils;

interface

uses
  Classes, SysUtils, Types, System.Devices
, FMX.Types, FMX.Objects, FMX.Forms, FMX.Controls
, FMX.Platform, FMX.BehaviorManager
;

type
  TDeviceAndPlatformInfo = record
    &Platform: TOSPlatform;
    DisplayMetrics: TDeviceDisplayMetrics;
    DeviceClass: TDeviceInfo.TDeviceClass;
    Name: string;

    function ToString: string;
  end;

  TSizeHelper = record helper for TSize
    function ToString: string;
  end;

function GetDeviceAndPlatformInfo: TDeviceAndPlatformInfo;

implementation

uses
  Rtti
;


function GetDeviceAndPlatformInfo: TDeviceAndPlatformInfo;
var
  LDeviceInfo: IDeviceBehavior;
  LContext: TForm;
  LScene: IScene;
  LName: string;
begin
  LContext := Application.MainForm as TForm;
  if TBehaviorServices.Current.SupportsBehaviorService(IDeviceBehavior, LDeviceInfo, LContext) then
  begin
    Result.Platform := LDeviceInfo.GetOSPlatform(LContext);
    Result.DisplayMetrics := LDeviceInfo.GetDisplayMetrics(LContext);
    Result.DeviceClass := LDeviceInfo.GetDeviceClass(LContext);

    LName := '';
    LDeviceInfo.GetName(LContext, LName);
    Result.Name := LName;
  end;
end;

{ TDeviceAndPlatformInfo }

function TDeviceAndPlatformInfo.ToString: string;
begin
  Result := string.join(' - ', [
    TRttiEnumerationType.GetName<TOSPlatform>(Platform)
  , TRttiEnumerationType.GetName<TDeviceInfo.TDeviceClass>(DeviceClass)
  , Name
  ])
  + sLineBreak
  + string.join(' - ', [
    'Screen Phys: ' + DisplayMetrics.PhysicalScreenSize.ToString
  , 'Log: ' + DisplayMetrics.LogicalScreenSize.ToString
  , 'Aspect: ' + DisplayMetrics.AspectRatio.ToString(TFloatFormat.ffFixed, 15, 3)
  , 'ppi: ' + DisplayMetrics.PixelsPerInch.ToString
  , 'Scale: ' + DisplayMetrics.ScreenScale.ToString(TFloatFormat.ffFixed, 15, 3)
  , 'FontScale: ' + DisplayMetrics.FontScale.ToString(TFloatFormat.ffFixed, 15, 3)
  ]);
end;


{ TSizeHelper }

function TSizeHelper.ToString: string;
begin
  Result := Format('(%d, %d)', [cx, cy]);
end;

end.
