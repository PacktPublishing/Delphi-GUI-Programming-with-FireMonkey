unit Threads.Simple;

interface

uses
  System.Classes, System.SysUtils;

type
  TSimpleThread = class(TThread)
  private
    FCounter: Integer;
    FOnProgress: TThreadProcedure;
  protected
    procedure DoSomething;

    procedure Execute; override;
    procedure TerminatedSet; override;
  public
    procedure AfterConstruction; override;
    destructor Destroy; override;

    property Counter: Integer read FCounter;
    property OnProgress: TThreadProcedure read FOnProgress write FOnProgress;
  end;

implementation

uses
  CodeSiteLogging;

{ TSimpleThread }

procedure TSimpleThread.AfterConstruction;
begin
  inherited;
  CodeSite.SendMsg('TSimpleThread.AfterConstruction');
end;

destructor TSimpleThread.Destroy;
begin
  inherited;
  CodeSite.SendMsg('TSimpleThread.Destroy');
end;

procedure TSimpleThread.DoSomething;
begin
  CodeSite.SendMsg('TSimpleThread.DoSomething ');

  Sleep(1000);
  Inc(FCounter);

  if Assigned(OnProgress) then
    Synchronize(FOnProgress);
end;

procedure TSimpleThread.Execute;
begin
  CodeSite.EnterMethod('TSimpleThread.Execute');
  FCounter := 0;
  while not Terminated do
    DoSomething;
  CodeSite.ExitMethod('TSimpleThread.Execute');
end;

procedure TSimpleThread.TerminatedSet;
begin
  inherited;
  CodeSite.SendMsg('TSimpleThread.TerminatedSet');
end;

end.
