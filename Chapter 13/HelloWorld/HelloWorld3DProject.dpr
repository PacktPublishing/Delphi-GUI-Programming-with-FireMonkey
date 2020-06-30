program HelloWorld3DProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Types,
  Form.Main in 'Form.Main.pas' {MainForm};

{$R *.res}

begin
  GlobalUseMetal := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
