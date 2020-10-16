program MultiResBitmap2Project;

uses
  System.StartUpCopy,
  FMX.Forms,
  Forms.Main in 'Forms.Main.pas' {Form1},
  Forms.Image64 in 'Forms.Image64.pas' {Form2},
  Forms.Image512 in 'Forms.Image512.pas' {Form3},
  Forms.Image256 in 'Forms.Image256.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
