program ProjectMix3D2D;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.Main in 'Form.Main.pas' {MainForm},
  Data.Models in 'Data.Models.pas' {ModelsData: TDataModule},
  Utils.Messages in 'Utils.Messages.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TModelsData, ModelsData);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
