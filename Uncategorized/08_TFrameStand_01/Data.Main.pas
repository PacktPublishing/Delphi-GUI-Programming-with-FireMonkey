unit Data.Main;

interface

uses
  System.SysUtils, System.Classes,
  AppState;

type
  TMainData = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FAppState: TAppState;
  protected
    procedure SetAppState(const ANewAppState: TAppState);
  public
    procedure GoToHome;
    procedure GoToOrders;
    procedure GoToOrderDetails;

    property AppState: TAppState read FAppState;
  end;

var
  MainData: TMainData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses System.Messaging, IO.App, FMX.Forms;

procedure TMainData.DataModuleCreate(Sender: TObject);
begin
  SetAppState(Home);

  TMessageManager.DefaultManager.SubscribeToMessage(
    TBackButtonPressed
  , procedure(const Sender: TObject; const M: TMessage)
    begin
      case AppState of
        Home: Application.MainForm.Close;
        else
          SetAppState(Home);
      end;

    end
  );
end;

procedure TMainData.GoToHome;
begin
  SetAppState(Home);
end;

procedure TMainData.GoToOrderDetails;
begin
  SetAppState(OrderDetail);
end;

procedure TMainData.GoToOrders;
begin
  SetAppState(Orders);
end;

procedure TMainData.SetAppState(const ANewAppState: TAppState);
begin
  FAppState := ANewAppState;
  TMessageManager.DefaultManager.SendMessage(
    Self, TAppStateChanged.Create
  );
end;

end.
