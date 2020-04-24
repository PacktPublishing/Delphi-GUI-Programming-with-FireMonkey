unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    StyleBook1: TStyleBook;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  FMX.Styles;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  TStyleManager.EnumStyleResources(
    procedure (const AResourceName: string; const APlatform: TOSPlatform)
    begin
      memo1.Lines.add(AResourceName);
    end
  );
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TStyleManager.TrySetStyleFromResource(Edit1.Text);
end;

end.
