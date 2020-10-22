unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, System.Bindings.Helper, Forms.Second;

type
  TForm1 = class(TForm)
    BindingsList1: TBindingsList;
    BindExpression1: TBindExpression;
    Edit1: TEdit;
    Button1: TButton;
    procedure Edit1ChangeTracking(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Edit1ChangeTracking(Sender: TObject);
begin
  BindingsList1.Notify(Sender, 'Text');
end;

end.
