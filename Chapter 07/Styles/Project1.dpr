program Project1;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Styles,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

begin
  TStyleManager.SetStyleFromFile('C:\Users\Public\Documents\Embarcadero\Studio\20.0\Styles\Win\CoralCrystal.Win.Style');
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
