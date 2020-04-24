unit Frames.Orders;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  SubjectStand, FrameStand, Data.Orders, FMX.Controls.Presentation, FMX.Objects;

type
  TOrdersFrame = class(TFrame)
    OrdersListView: TListView;
    OrdersBSDB: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ToolBar1: TToolBar;
    TitleLabel: TLabel;
    BackButton: TButton;
    procedure OrdersListViewItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure BackButtonClick(Sender: TObject);
  private
  protected
  public
    [BeforeShow]
    procedure OnBeforeShow;
  end;

implementation

{$R *.fmx}

uses Data.Main;

{ TOrdersFrame }

procedure TOrdersFrame.BackButtonClick(Sender: TObject);
begin
  MainData.GoToHome;
end;

procedure TOrdersFrame.OnBeforeShow;
begin
  OrdersBSDB.DataSet := TOrdersData.Instance.OrdersTable;
end;

procedure TOrdersFrame.OrdersListViewItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  MainData.GoToOrderDetails;
end;

end.
