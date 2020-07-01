unit Utils.Messages;

interface

uses Classes, SysUtils, System.Messaging;

type
  TAnimalSelectedMsg = class(TMessage<string>)
  public
    class procedure CreateAndSend(const AValue: string);
    class procedure SubscribeTo(const AHandler: TProc<string>); overload;
  end;



implementation

{ TMyMessage }

class procedure TAnimalSelectedMsg.CreateAndSend(const AValue: string);
begin
  TMessageManager.DefaultManager.SendMessage(nil, TAnimalSelectedMsg.Create(AValue));
end;

class procedure TAnimalSelectedMsg.SubscribeTo(const AHandler: TProc<string>);
begin
  if not Assigned(AHandler) then
    Exit;

  TMessageManager.DefaultManager.SubscribeToMessage(Self
  , procedure(const Sender: TObject; const M: TMessage)
    begin
      AHandler(TAnimalSelectedMsg(M).Value);
    end
  );
end;

end.
