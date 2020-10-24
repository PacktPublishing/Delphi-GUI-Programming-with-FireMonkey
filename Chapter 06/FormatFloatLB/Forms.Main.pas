unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.GenData, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  FMX.Controls.Presentation, FMX.StdCtrls, Data.Bind.ObjectScope,
  Data.Bind.Controls, FMX.Layouts, Fmx.Bind.Navigator,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView,
  Methods.FormatFloat // important to register the FormatFloat LB method at runtime
;

type
  TForm1 = class(TForm)
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    ListView1: TListView;
    LinkListControlToField2: TLinkListControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
    // Self.Owner.Owner.Owner.FormFormatFloat()
    function FormFormatFloat(const AFormat: string; const AValue: Extended; const ALocale: string): string;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TForm1 }

function TForm1.FormFormatFloat(const AFormat: string; const AValue: Extended;
  const ALocale: string): string;
var
  LFormatSettings: TFormatSettings;
begin
  LFormatSettings := FormatSettings;
  if not ALocale.IsEmpty then
    LFormatSettings := TFormatSettings.Create(ALocale);
  Result := FormatFloat(AFormat, AValue, LFormatSettings);
end;

end.
