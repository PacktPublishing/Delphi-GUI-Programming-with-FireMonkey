unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Messaging,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo;

type

  TEventX = class(TMessageBase);
  TEventXY = class(TEventX);
  TWarningMessage = class(TMessage<string>);
  TErrorMessage = class(TMessage<string>);
  TCounterMessage = class(TMessage<Integer>);

  TRandomMessage = class(TMessage<Integer>)
  public
    const DEFAULT_RANGE = 100;
    constructor CreateNewRandom(const ARange: Integer = DEFAULT_RANGE);
    class procedure GenerateAndSend(const ARange: Integer = DEFAULT_RANGE;
      const ASender: TObject = nil; const AManager: TMessageManager = nil);

    type TRandomMessageListener = reference to procedure (
      const ASender: TObject; const AMessage: TRandomMessage);
    class function SubscribeTo(const AListener: TRandomMessageListener;
      const AManager: TMessageManager = nil): Integer;
  end;

  TFirstMessage = TMessage<Integer>;
  TSecondMessage = TMessage<Integer>;

  TMainForm = class(TForm)
    EventXButton: TButton;
    LogMemo: TMemo;
    FirstMessageButton: TButton;
    SecondMessageButton: TButton;
    CounterMessageButton: TButton;
    RandomMessageButton: TButton;
    EventXYButton: TButton;
    procedure EventXButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FirstMessageButtonClick(Sender: TObject);
    procedure SecondMessageButtonClick(Sender: TObject);
    procedure CounterMessageButtonClick(Sender: TObject);
    procedure RandomMessageButtonClick(Sender: TObject);
    procedure EventXYButtonClick(Sender: TObject);
  private
    FCounter: Integer;
    procedure Log(const AMsg: string);
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.CounterMessageButtonClick(Sender: TObject);
begin
  Inc(FCounter);
  TMessageManager.DefaultManager.SendMessage(Self, TCounterMessage.Create(FCounter));
end;

procedure TMainForm.EventXButtonClick(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self, TEventX.Create);
end;

procedure TMainForm.EventXYButtonClick(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self, TEventXY.Create);
end;

procedure TMainForm.FirstMessageButtonClick(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self, TFirstMessage.Create(100));
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCounter := 0;
  Randomize;

  TMessageManager.DefaultManager.SubscribeToMessage(TEventX
    , procedure(const Sender: TObject; const M: TMessage)
      begin
        Log('EventX happened');
      end
  );

  TMessageManager.DefaultManager.SubscribeToMessage(TEventXY
    , procedure(const Sender: TObject; const M: TMessage)
      begin
        Log('EventXY happened');
      end
  );

  TMessageManager.DefaultManager.SubscribeToMessage(TFirstMessage
    , procedure(const Sender: TObject; const M: TMessage)
      begin
        Log(M.ClassName + ' received: ' + (M as TFirstMessage).Value.ToString);
      end
  );

  TMessageManager.DefaultManager.SubscribeToMessage(TSecondMessage
    , procedure(const Sender: TObject; const M: TMessage)
      begin
        Log(M.ClassName + ' received: ' + (M as TSecondMessage).Value.ToString);
      end
  );

  TMessageManager.DefaultManager.SubscribeToMessage(TCounterMessage
    , procedure(const Sender: TObject; const M: TMessage)
      begin
        Log(M.ClassName + ' received: ' + (M as TCounterMessage).Value.ToString);
      end
  );

  TMessageManager.DefaultManager.SubscribeToMessage(TRandomMessage
    , procedure(const Sender: TObject; const M: TMessage)
      begin
        Log(M.ClassName + ' received: ' + (M as TRandomMessage).Value.ToString);
      end
  );

  TRandomMessage.SubscribeTo(
    procedure(const Sender: TObject; const M: TRandomMessage)
    begin
      Log(M.ClassName + ' received: ' + M.Value.ToString);
    end
  );
end;

procedure TMainForm.Log(const AMsg: string);
begin
  LogMemo.Lines.Add(TimeToStr(Now) + ': ' + AMsg);
end;

procedure TMainForm.RandomMessageButtonClick(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self, TRandomMessage.Create(Random(100)));
  TMessageManager.DefaultManager.SendMessage(Self, TRandomMessage.CreateNewRandom);
  TRandomMessage.GenerateAndSend();
end;

procedure TMainForm.SecondMessageButtonClick(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self, TSecondMessage.Create(200));
end;

{ TRandomMessage }

constructor TRandomMessage.CreateNewRandom(const ARange: Integer);
begin
  inherited Create(Random(ARange));
end;

class procedure TRandomMessage.GenerateAndSend(const ARange: Integer;
  const ASender: TObject; const AManager: TMessageManager);
var
  LManager: TMessageManager;
  LMessage: TRandomMessage;
begin
  LMessage := TRandomMessage.CreateNewRandom(ARange);
  LManager := AManager;
  if not Assigned(LManager) then
    LManager := TMessageManager.DefaultManager;

  if Assigned(LManager) then
    LManager.SendMessage(ASender, LMessage);
end;

class function TRandomMessage.SubscribeTo(
  const AListener: TRandomMessageListener;
  const AManager: TMessageManager = nil): Integer;
var
  LManager: TMessageManager;
begin
  LManager := AManager;
  if not Assigned(LManager) then
    LManager := TMessageManager.DefaultManager;

  Result := -1;
  if Assigned(LManager) then
    Result := LManager.SubscribeToMessage(TRandomMessage
      , procedure (const ASender: TObject; const AMsg: TMessageBase)
        begin
          if Assigned(AListener) then
            AListener(ASender, AMsg as TRandomMessage);
        end
    );
end;

end.
