unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Threading,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    WaitButton: TButton;
    SynchronousWaitButton: TButton;
    AsynchronousWaitButton: TButton;
    ShootAndReportButton: TButton;
    FutureButton: TButton;
    JoinButton: TButton;
    procedure WaitButtonClick(Sender: TObject);
    procedure SynchronousWaitButtonClick(Sender: TObject);
    procedure AsynchronousWaitButtonClick(Sender: TObject);
    procedure ShootAndReportButtonClick(Sender: TObject);
    procedure FutureButtonClick(Sender: TObject);
    procedure JoinButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  CodeSiteLogging, Rtti;

procedure Log(const AMsg: string);
begin
  CodeSite.SendMsg(AMsg);
end;


procedure TForm1.AsynchronousWaitButtonClick(Sender: TObject);
var
  LTask: ITask;
begin
  Log('Button clicked');

  LTask := TTask.Run(
    procedure
    begin
      Log('Task start');
      Sleep(5000);
      Log('Task end');
    end
  );

  TTask.Run(
    procedure
    var
      LCompleted: Boolean;
    begin
      LCompleted := LTask.Wait(10);
      while not LCompleted do
      begin
        Log('Waiting, task status: ' + TRttiEnumerationType.GetName<TTaskStatus>(LTask.Status));
        LCompleted := LTask.Wait(500);
      end;
      Log('Completed');
    end
  );
end;

procedure TForm1.JoinButtonClick(Sender: TObject);
var
  LTask: ITask;
begin
  CodeSite.SendMsg('Join - begin');
  LTask := TParallel.Join([
    procedure
    begin
      CodeSite.SendMsg('Task 1 - begin');
      Sleep(1000);
      CodeSite.SendMsg('Task 1 - end');
    end
  , procedure
    begin
      CodeSite.SendMsg('Task 2 - begin');
      Sleep(5000);
      CodeSite.SendMsg('Task 2 - end');
    end
  , procedure
    begin
      CodeSite.SendMsg('Task 3 - begin');
      Sleep(3000);
      CodeSite.SendMsg('Task 3 - end');
    end
  ]);
  CodeSite.SendMsg('Join - end');
end;

procedure TForm1.FutureButtonClick(Sender: TObject);
var
  LFuture: IFuture<Integer>;
begin
  LFuture := TTask.Future<Integer>(
    function : Integer
    begin
      Sleep(5000);
      Result := 42;
    end
  );

  ShowMessage(LFuture.Value.ToString);
end;

procedure TForm1.ShootAndReportButtonClick(Sender: TObject);
begin
  Log('Button clicked');
  TTask.Run(
    procedure
    begin
      Log('Task start');
      Sleep(5000);
      Log('Task end');

      TThread.Synchronize(nil
        , procedure
          begin
            Log('Completed');
            ShowMessage('Completed');
          end
      );
    end
  );
end;

procedure TForm1.SynchronousWaitButtonClick(Sender: TObject);
var
  LTask: ITask;
  LCompleted: Boolean;
begin
  Log('Button clicked');

  LTask := TTask.Run(
    procedure
    begin
      Log('Task start');
      Sleep(5000);
      Log('Task end');
    end
  );

  LCompleted := LTask.Wait(10);
  while not LCompleted do
  begin
    Log('Waiting, task status: ' + TRttiEnumerationType.GetName<TTaskStatus>(LTask.Status));
    LCompleted := LTask.Wait(500);
  end;
  Log('Completed');
end;

procedure TForm1.WaitButtonClick(Sender: TObject);
var
  LTask: ITask;
begin
  Log('Button clicked');

  LTask := TTask.Run(
    procedure
    begin
      Log('Task start');
      Sleep(5000);
      Log('Task end');
    end
  );

  LTask.Wait();
  Log('Completed');
end;

end.
