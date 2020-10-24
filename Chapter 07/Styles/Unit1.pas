unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Effects, FMX.Ani;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StyleBook1: TStyleBook;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    StyleBook2: TStyleBook;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

// BEWARE: you can install CoralCrystal and CopperDark FMX styles from Embarcadero GetIt
// the project also relies on Jet FMX style as it is included in the project's resources
// to showcase runtime loading of styles from resources.
// Also check paths of loaded file resources are correct (according to Delphi version,
// for example) and also check the DPR file as there is a TStyleManager call there.

implementation

{$R *.fmx}

uses FMX.Styles;

procedure TForm1.Button1Click(Sender: TObject);
var
  LDescriptor: TStyleDescription;
begin
  LDescriptor := TStyleManager.FindStyleDescriptor(Self);
  if Assigned(LDescriptor) then
    ShowMessage(LDescriptor.ToString);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TStyleManager.SetStyleFromFile('C:\Users\Public\Documents\Embarcadero\Studio\21.0\Styles\Win\CoralCrystal.Win.Style');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  TStyleManager.TrySetStyleFromResource('MYSTYLE');
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  LStyle: TFmxObject;
begin
  LStyle := TStyleManager.ActiveStyle(nil).FindStyleResource('buttonstyle');
  ShowMessage(LStyle.ChildrenCount.ToString);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  LFileStream: TFileStream;
begin
  ForceDirectories('c:\temp\');
  LFileStream := TFileStream.Create('C:\temp\win10.stylebin', fmCreate or fmOpenReadWrite);
  try
    TStyleStreaming.SaveToStream(
      TStyleManager.ActiveStyle(nil), LFileStream, TStyleformat.Binary
    );
  finally
    LFileStream.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  TStyleStreaming.LoadFromResource(HInstance, 'MYSTYLE', RT_RCDATA);
end;

end.
