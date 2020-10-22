unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, Data.Bind.Components, Data.Bind.ObjectScope, Data.Bind.GenData,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, FMX.Controls.Presentation, FMX.StdCtrls, Generics.Collections,
  Data.Bind.Controls, FMX.Layouts, Fmx.Bind.Navigator;

type
  TForm1 = class(TForm)
    AdapterBindSource1: TAdapterBindSource;
    ListView1: TListView;
    Label1: TLabel;
    Label2: TLabel;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    AdapterBindSource2: TAdapterBindSource;
    LinkListControlToField1: TLinkListControlToField;
    BindNavigator1: TBindNavigator;
    procedure AdapterBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure AdapterBindSource2CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPersona = class
  private
    FCognome: string;
    FNome: string;
  published
    property Nome: string read FNome write FNome;
    property Cognome: string read FCognome write FCognome;

    class function Andrea: TPersona;
    class function Pippo: TPersona;
    class function Tutti: TList<TPersona>;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.AdapterBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
//  ABindSourceAdapter := TObjectBindSourceAdapter<TPersona>.Create(nil, TPersona.Andrea);
  ABindSourceAdapter := TListBindSourceAdapter<TPersona>.Create(nil, TPersona.Tutti);

end;

procedure TForm1.AdapterBindSource2CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := TListBindSourceAdapter<TPersona>.Create(nil, TPersona.Tutti);
end;

{ TPersona }

class function TPersona.Andrea: TPersona;
begin
  Result := TPersona.Create;

  Result.Nome := 'Andrea';
  Result.Cognome := 'Magni';
end;

class function TPersona.Pippo: TPersona;
begin
  Result := TPersona.Create;
  Result.Nome := 'Pippo';
  Result.Cognome := 'De Pippis';
end;

class function TPersona.Tutti: TList<TPersona>;
begin
  Result := TList<TPersona>.Create;
  Result.Add(Andrea);
  Result.Add(Pippo);
end;

end.
