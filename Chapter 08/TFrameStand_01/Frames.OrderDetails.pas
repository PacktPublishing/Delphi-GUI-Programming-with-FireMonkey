unit Frames.OrderDetails;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, SubjectStand, FrameStand, Frames.Orders;

type
  TOrderDetailsFrame = class(TFrame)
    ToolBar1: TToolBar;
    ListBox1: TListBox;
    TitleLabel: TLabel;
    OrderBSDB: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    BackButton: TButton;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    SaleDateLabel: TLabel;
    ShipDateLabel: TLabel;
    CustomerCompanyLabel: TLabel;
    CustomerBSDB: TBindSourceDB;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    procedure BackButtonClick(Sender: TObject);
  private
  protected
  public
    [BeforeShow]
    procedure BeforeShow;
  end;

implementation

{$R *.fmx}

uses Data.Orders, Data.Main;

{ TOrderDetailsFrame }

procedure TOrderDetailsFrame.BackButtonClick(Sender: TObject);
begin
  MainData.GoToOrders;
end;

procedure TOrderDetailsFrame.BeforeShow;
begin
  OrderBSDB.DataSet := TOrdersData.Instance.OrdersTable;
end;

end.
