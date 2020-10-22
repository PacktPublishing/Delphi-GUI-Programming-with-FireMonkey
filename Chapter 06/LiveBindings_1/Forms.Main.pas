unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Layouts, FMX.ListBox,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.DBScope, FMX.Objects, DateUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FDMemTable1: TFDMemTable;
    FDMemTable1ID: TIntegerField;
    FDMemTable1Description: TStringField;
    FDMemTable1Price: TCurrencyField;
    FDMemTable1StartDate: TDateField;
    FDMemTable1EndDate: TDateField;
    FDMemTable1Category: TStringField;
    Rectangle1: TRectangle;
    Circle1: TCircle;
    Rectangle2: TRectangle;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.Rtti
, System.Bindings.EvalSys
, System.Bindings.EvalProtocol
, System.Bindings.Evaluator
//, System.Bindings.Helper
, System.Bindings.ObjEval
, System.Bindings.Methods
;

type
  TPerson = class
  private
    FName: string;
    FSurname: string;
    FDateOfBirth: TDateTime;
  public
    constructor Create(const AName: string; const ASurname: string; const ADateOfBirth: TDate);
    function Age: Integer;

    function GetDescription(const AExpression: string): string;

    property Name: string read FName;
    property Surname: string read FSurname;
    property DateOfBirth: TDateTime read FDateOfBirth;
  end;

{ TPerson }

function TPerson.Age: Integer;
begin
  Result := YearsBetween(Now, DateOfBirth);
end;

constructor TPerson.Create(const AName, ASurname: string;
  const ADateOfBirth: TDate);
begin
  inherited Create;
  FName := AName;
  FSurname := ASurname;
  FDateOfBirth := ADateOfBirth;
end;

function TPerson.GetDescription(const AExpression: string): string;
var
  LScope: IScope;
  LExpr: ICompiledBinding;
  LResult: TValue;
  LDictScope: TDictionaryScope;
  LArea: Extended;
begin
  LDictScope := TDictionaryScope.Create;
  LDictScope.Map.Add('subject', WrapObject(Self));

  LScope := TNestedScope.Create(BasicOperators, LDictScope);

  LExpr := Compile(AExpression, LScope);


  Result := LExpr.Evaluate(LScope, nil, nil).GetValue.ToString;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  LAndrea: TPerson;
begin
  LAndrea := TPerson.Create('Andrea', 'Magni', EncodeDate(1982, 5, 24));
  try
    ShowMessage(LAndrea.GetDescription(Edit1.Text));
  finally
    LAndrea.Free;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LScope: IScope;
  LExpr: ICompiledBinding;
  LDictScope: TDictionaryScope;
begin
  LDictScope := TDictionaryScope.Create;
  LDictScope.Map.Add('firstNumber', TValueWrapper.Create(2));
  LDictScope.Map.Add('secondNumber', TValueWrapper.Create(2));

  LScope := TNestedScope.Create(BasicOperators, LDictScope);

  LExpr := Compile('firstNumber + secondNumber', LScope);

  ShowMessage(LExpr.Evaluate(LScope, nil, nil).GetValue.ToString);
end;

function SquareInvokable: IInvokable;
begin
  Result := MakeInvokable(
    function (Args: TArray<IValue>): IValue
    var
      LX: Extended;
    begin
      if Length(Args) <> 1 then
        raise EEvaluatorError.Create('Square: only one parameter expected');

      if not Args[0].GetValue.TryAsType<Extended>(LX) then
        raise EEvaluatorError.Create('Square: bad parameter');
      Exit(TValueWrapper.Create(Sqr(LX)));
    end
  );
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  LScope: IScope;
  LExpr: ICompiledBinding;
  LDictScope: TDictionaryScope;
begin
  LDictScope := TDictionaryScope.Create;
  LDictScope.Map.Add('radius', TValueWrapper.Create(2));

  LScope := TNestedScope.Create(BasicOperators, BasicConstants);
  LScope := TNestedScope.Create(LScope, LDictScope);

  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      SquareInvokable
    , 'Square', 'Square', '', True, 'Square(X) returns X * X', nil
    )
  );

  LScope := TNestedScope.Create(LScope, TBindingMethodsFactory.GetMethodScope);

  LExpr := Compile('Pi*Square(radius)', LScope);

  ShowMessage(LExpr.Evaluate(LScope, nil, nil).GetValue.ToString);
end;

end.
