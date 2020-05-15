unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, System.Threading;

type
  TMainForm = class(TForm)
    StartButton: TButton;
    TerminateButton: TButton;
    StatusLabel: TLabel;
    procedure StartButtonClick(Sender: TObject);
    procedure TerminateButtonClick(Sender: TObject);
  private
    { Private declarations }
    FTask: ITask;
    FFinalCounter: Integer;
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
  if Assigned(FTask) then
    Exit;

  FTask := TTask.Run(
    procedure
    var
      LCounter: Integer;
    begin
      CodeSite.EnterMethod('TTask Execute');

      LCounter := 0;
      while FTask.Status = TTaskStatus.Running do
      begin
        CodeSite.SendMsg('TTask DoSomething ');

        Sleep(1000);
        Inc(LCounter);

        // OnProgress equivalent
        TThread.Synchronize(nil
          , procedure
            begin
              CodeSite.SendMsg('TMainForm anonymous OnProgress handler');
              StatusLabel.Text := 'Running, counter = ' + LCounter.ToString;
            end
        );
      end;
      CodeSite.ExitMethod('TTask Execute');

      // OnTerminate equivalent
      TThread.Synchronize(nil
        , procedure
          begin
            FFinalCounter := LCounter;
            StatusLabel.Text := 'Completed, counter = ' + FFinalCounter.ToString;
            FTask := nil;
          end
      );
    end
  );
  CodeSite.SendMsg('TTask defined');
  StatusLabel.Text := 'Started';
end;

procedure TMainForm.TerminateButtonClick(Sender: TObject);
begin
  if Assigned(FTask) then
  begin
    FTask.Cancel;
    CodeSite.SendMsg('TTask cancellation requested');
    StatusLabel.Text := 'Cancelled, waiting completion...';
  end;
end;

end.
