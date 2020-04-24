unit Data.Orders;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TOrdersData = class(TDataModule)
    OrdersTable: TFDMemTable;
    CustomersTable: TFDMemTable;
  private
    class var _Instance: TOrdersData;
  protected
  public
    class function Instance: TOrdersData;
    class procedure Finalize;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TOrdersData }

class procedure TOrdersData.Finalize;
begin
  if Assigned(_Instance) then
    FreeAndNil(_Instance);
end;

class function TOrdersData.Instance: TOrdersData;
begin
  if not Assigned(_Instance) then
    _Instance := TOrdersData.Create(nil);
  Result := _Instance;
end;

end.
