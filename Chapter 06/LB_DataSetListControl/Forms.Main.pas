unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.Components, Data.Bind.DBScope, FMX.Objects, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox, Data.Bind.Controls,
  FMX.Layouts, Fmx.Bind.Navigator, FMX.StdCtrls;

type
  TMainForm = class(TForm)
    EmployeeData: TFDMemTable;
    EmployeeBindSourceDB: TBindSourceDB;
    Text1: TText;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    Text2: TText;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    Edit1: TEdit;
    LinkControlToField1: TLinkControlToField;
    ComboBox1: TComboBox;
    BindNavigator1: TBindNavigator;
    Label1: TLabel;
    LinkFillControlToPropertyText: TLinkFillControlToProperty;
    Label2: TLabel;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    Edit2: TEdit;
    ComboBox2: TComboBox;
    Label3: TLabel;
    LinkFillControlToPropertyText2: TLinkFillControlToProperty;
    Label4: TLabel;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    Label5: TLabel;
    LinkPropertyToFieldText5: TLinkPropertyToField;
  private
    { Private declarations }
    FCounter0: Integer;
    FCounter1: Integer;
    function GetCounter0: Integer;
    function GetCounter1: Integer;
  public
    { Public declarations }
    property Counter0: Integer read GetCounter0;
    property Counter1: Integer read GetCounter1;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses System.Bindings.Helper, System.Bindings.Methods,
  System.Bindings.EvalProtocol;

{ TMainForm }

function MyFormatInvokable: IInvokable;
begin
  Result := MakeInvokable(
    function (Args: TArray<IValue>): IValue
    var
      LFormatString: string;
      LFormattedString: string;
    begin
      if Length(Args) < 2 then
        raise EEvaluatorError.Create('MyFormat: two or more parameters expected');

      if not Args[0].GetValue.TryAsType<string>(LFormatString) then
        raise EEvaluatorError.Create('FormatString: bad parameter');

      LFormattedString := Format(LFormatString, [Args[1].GetValue.AsExtended]);

      Exit(TValueWrapper.Create(LFormattedString));
    end
  );
end;

function TMainForm.GetCounter0: Integer;
begin
  Inc(FCounter0);
  Result := FCounter0;
end;

function TMainForm.GetCounter1: Integer;
begin
  Inc(FCounter1);
  Result := FCounter1;
end;

initialization
 TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MyFormatInvokable
    , 'MyFormat', 'MyFormat', '', True, 'SysUtils.Format wrapper', nil
    )
  );


end.
