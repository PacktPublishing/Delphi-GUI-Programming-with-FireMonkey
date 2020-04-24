unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  SubjectStand, FrameStand,
  Frames.Home, Frames.Orders, Frames.OrderDetails;

type
  TMainForm = class(TForm)
    FrameStand1: TFrameStand;
    StandsBook: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FrameStand1BeforeStartAnimation(const ASender: TSubjectStand;
      const ASubjectInfo: TSubjectInfo; const AAnimation: TAnimation);
  private
  protected
    procedure UpdateViewToState;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses System.Messaging, StrUtils, AppState, Data.Main, IO.App;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TMessageManager.DefaultManager.SubscribeToMessage(
    TAppStateChanged
  , procedure(const Sender: TObject; const M: TMessage)
    begin
      UpdateViewToState;
    end
  );
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  case Key of
    vkHardwareBack, vkEscape:
      begin
        // custom handling of hardware back button
        Key := 0;
        KeyChar := #0;
        TMessageManager.DefaultManager.SendMessage(
          Self, TBackButtonPressed.Create
        );
      end;
  end;
end;

procedure TMainForm.FrameStand1BeforeStartAnimation(
  const ASender: TSubjectStand; const ASubjectInfo: TSubjectInfo;
  const AAnimation: TAnimation);
var
  LAni: TFloatAnimation;
begin
  if (ASubjectInfo.StandStyleName = 'slider') then
    if (AAnimation is TFloatAnimation) then
    begin
      LAni := TFloatAnimation(AAnimation);
      if LAni.StyleName = 'OnShow_SlideIn' then
        LAni.StartValue := ASubjectInfo.Stand.Width
      else if LAni.StyleName = 'OnHide_SlideOut' then
        LAni.StopValue := ASubjectInfo.Stand.Width;
    end;
end;

procedure TMainForm.UpdateViewToState;
begin
  case MainData.AppState of
    Home:
      begin
        FrameStand1.CloseAllExcept(THomeFrame);
        FrameStand1
          .GetFrameInfo<THomeFrame>
            .Show;
      end;
    Orders:
      begin
        FrameStand1.CloseAll(TOrderDetailsFrame);
        FrameStand1
          .GetFrameInfo<TOrdersFrame>(True, nil, 'fader')
            .Show;
      end;
    OrderDetail:
      begin
        FrameStand1
          .GetFrameInfo<TOrderDetailsFrame>(True, nil, 'slider')
            .Show;
      end;
  end;
end;

end.
