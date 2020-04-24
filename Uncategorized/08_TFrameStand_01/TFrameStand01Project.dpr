program TFrameStand01Project;

uses
  System.StartUpCopy,
  FMX.Forms,
  Forms.Main in 'Forms.Main.pas' {MainForm},
  Data.Main in 'Data.Main.pas' {MainData: TDataModule},
  AppState in 'AppState.pas',
  Frames.Home in 'Frames.Home.pas' {HomeFrame: TFrame},
  Frames.Orders in 'Frames.Orders.pas' {OrdersFrame: TFrame},
  Data.Orders in 'Data.Orders.pas' {OrdersData: TDataModule},
  Frames.OrderDetails in 'Frames.OrderDetails.pas' {OrderDetailsFrame: TFrame},
  IO.App in 'IO.App.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TMainData, MainData);
  Application.Run;
  TOrdersData.Finalize;
end.
