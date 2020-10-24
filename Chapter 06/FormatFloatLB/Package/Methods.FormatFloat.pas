unit Methods.FormatFloat;

interface

uses
  SysUtils;

implementation

uses
  System.Bindings.Methods,
  System.Bindings.EvalProtocol;

function FormatFloatInvokable: IInvokable;
begin
  Result := MakeInvokable(
    function (Args: TArray<IValue>): IValue
    var
      LFormatSettings: TFormatSettings;
      LFormattedString: string;
      LFormatString: string;
      LLocale: string;
    begin
      // 1 - Input recognition and validation
      if Length(Args) < 2 then
        raise EEvaluatorError.Create('FormatFloat: two parameters expected');
      if not Args[0].GetValue.TryAsType<string>(LFormatString) then
        raise EEvaluatorError.Create('FormatString: bad parameter');

      LFormatSettings := FormatSettings;
      if (Length(Args) > 2) and (Args[2] <> nil) then
      begin
        if not Args[2].GetValue.TryAsType<string>(LLocale) then
          raise EEvaluatorError.Create('Locale: bad parameter');
        LFormatSettings := TFormatSettings.Create(LLocale);
      end;

      // 2 - Actual call to the wrapped function
      LFormattedString := FormatFloat(LFormatString,
      Args[1].GetValue.AsExtended, LFormatSettings);

      // 3 - Result value boxing
      Exit(TValueWrapper.Create(LFormattedString));
    end
  );
end;

initialization
  // 4 - Registration of the method
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
        FormatFloatInvokable
      , 'FormatFloat', 'FormatFloat', '', True
      , 'SysUtils.FormatFloat wrapper. FormatFloat(FormatString, FloatValue [, Locale])'
      , nil
    )
  );

finalization
// 5 - De-registration of the method
  TBindingMethodsFactory.UnRegisterMethod('FormatFloat');

end.
