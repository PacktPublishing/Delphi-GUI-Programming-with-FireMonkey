unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TMainForm = class(TForm)
    SynchronizeButton: TButton;
    QueueButton: TButton;
    procedure SynchronizeButtonClick(Sender: TObject);
    procedure QueueButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses CodeSiteLogging;

procedure TMainForm.QueueButtonClick(Sender: TObject);
begin
  CodeSite.SendMsg('QUEUE example');
  CodeSite.SendMsg('UI: Launching Worker...');

  TThread.CreateAnonymousThread(
    procedure
    var
      LCounter: Integer;
    begin
      CodeSite.SendMsg('Worker: starting...');
      LCounter := 0;

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      TThread.Queue(nil
      , procedure
        begin
          CodeSite.SendMsg('Gray code: starting...');
          Sleep(1500);
          CodeSite.SendMsg('Gray code: completed');
        end
      );

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      CodeSite.SendMsg('Worker: completed');
    end
  ).Start;

  CodeSite.SendMsg('UI: Worker launched');
end;

procedure TMainForm.SynchronizeButtonClick(Sender: TObject);
begin
  CodeSite.SendMsg('SYNCHRONIZE example');
  CodeSite.SendMsg('UI: Launching Worker...');

  TThread.CreateAnonymousThread(
    procedure
    var
      LCounter: Integer;
    begin
      CodeSite.SendMsg('Worker: starting...');
      LCounter := 0;

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      TThread.Synchronize(nil
      , procedure
        begin
          CodeSite.SendMsg('Gray code: starting...');
          Sleep(1500);
          CodeSite.SendMsg('Gray code: completed');
        end
      );

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      Sleep(1000);
      Inc(LCounter);
      CodeSite.SendMsg('Counter: ' + LCounter.ToString);

      CodeSite.SendMsg('Worker: completed');
    end
  ).Start;

  CodeSite.SendMsg('UI: Worker launched');
end;

end.
