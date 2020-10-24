unit Frames.Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.Effects, SubjectStand;

type
  THomeFrame = class(TFrame)
    OverlayImage: TImage;
    IconsLayout: TFlowLayout;
    ToolBar1: TToolBar;
    TitleLabel: TLabel;
    OrdersImage: TImage;
    GlowEffect: TInnerGlowEffect;
    Label1: TLabel;
    procedure OrdersImageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Data.Main;

procedure THomeFrame.OrdersImageClick(Sender: TObject);
begin
  GlowEffect.Enabled := True;
  TDelayedAction.Execute(100
  , procedure
    begin
      MainData.GoToOrders;
      GlowEffect.Enabled := False;
    end
  );
end;

end.
