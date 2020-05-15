unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, Threads.Simple;

type
  TMainForm = class(TForm)
    StartButton: TButton;
    StatusLabel: TLabel;
    TerminateButton: TButton;
    procedure StartButtonClick(Sender: TObject);
    procedure TerminateButtonClick(Sender: TObject);
  private
    { Private declarations }
    FThread: TSimpleThread;
    procedure TerminateThreadHandler(Sender: TObject);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses CodeSiteLogging;

procedure TMainForm.StartButtonClick(Sender: TObject);
begin
  if not Assigned(FThread) then
  begin
    CodeSite.SendMsg('TSimpleThread creation');
    FThread := TSimpleThread.Create(True);
    FThread.FreeOnTerminate := True;
    FThread.OnTerminate := TerminateThreadHandler;
    FThread.OnProgress :=
      procedure
      begin
        CodeSite.SendMsg('TMainForm anonymous OnProgress handler');
        StatusLabel.Text := 'Running, counter = ' + FThread.Counter.ToString;
      end;

    CodeSite.SendMsg('TSimpleThread.Start');
    FThread.Start;

    StatusLabel.Text := 'Started';
  end;
end;

procedure TMainForm.TerminateButtonClick(Sender: TObject);
begin
  if Assigned(FThread) and FThread.Started then
  begin
    FThread.Terminate;
    StatusLabel.Text := 'Terminated, waiting completion...';
  end;
end;

procedure TMainForm.TerminateThreadHandler(Sender: TObject);
begin
  StatusLabel.Text := 'Completed, counter = ' + FThread.Counter.ToString;

  FThread := nil;
  CodeSite.SendMsg('TMainForm.TerminateThreadHandler');
end;

end.
