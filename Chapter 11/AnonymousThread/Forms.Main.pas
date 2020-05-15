unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TMainForm = class(TForm)
    StartButton: TButton;
    TerminateButton: TButton;
    StatusLabel: TLabel;
    procedure StartButtonClick(Sender: TObject);
    procedure TerminateButtonClick(Sender: TObject);
  private
    { Private declarations }
    FThread: TThread;
    FTerminated: Boolean;
    FFinalCounter: Integer;
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
  if Assigned(FThread) then
    Exit;

  CodeSite.SendMsg('Anonymous thread creation');

  FTerminated := False;
  FThread := TThread.CreateAnonymousThread(
    procedure
    var
      LCounter: Integer;
    begin
      CodeSite.EnterMethod('Anonymous thread Execute');

      LCounter := 0;
      while not FTerminated do
      begin
        CodeSite.SendMsg('Anonymous thread DoSomething ');

        Sleep(1000);
        Inc(LCounter);

        TThread.Synchronize(nil
          , procedure
            begin
              CodeSite.SendMsg('TMainForm anonymous OnProgress handler');
              StatusLabel.Text := 'Running, counter = ' + LCounter.ToString;
            end
        );
      end;

      FFinalCounter := LCounter; // Sync needed

      CodeSite.ExitMethod('Anonymous thread Execute');
    end
  );


  FThread.OnTerminate := TerminateThreadHandler;

  CodeSite.SendMsg('Anonymous thread Start');
  FThread.Start;
  StatusLabel.Text := 'Started';
end;

procedure TMainForm.TerminateButtonClick(Sender: TObject);
begin
  if Assigned(FThread) and FThread.Started then
  begin
    // FThread.Terminate;
    FTerminated := True;
    CodeSite.SendMsg('Anonymous thread FTerminated set');
    StatusLabel.Text := 'Terminated, waiting completion...';
  end;
end;

procedure TMainForm.TerminateThreadHandler(Sender: TObject);
begin
  StatusLabel.Text := 'Completed, counter = ' + FFinalCounter.ToString;

  FThread := nil;
  CodeSite.SendMsg('TMainForm.TerminateThreadHandler');
end;

end.
