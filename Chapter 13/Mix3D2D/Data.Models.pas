unit Data.Models;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin;

type
  TModelsData = class(TDataModule)
    AnimalsTable: TFDMemTable;
    AnimalsTableName: TStringField;
    AnimalsDataSource: TDataSource;
    procedure AnimalsDataSourceDataChange(Sender: TObject; Field: TField);
  private
  public
  end;

var
  ModelsData: TModelsData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  IOUtils, Utils.Messages;

{ TModelsData }

procedure TModelsData.AnimalsDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  TAnimalSelectedMsg.CreateAndSend(AnimalsTableName.Value);
end;

end.
