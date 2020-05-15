unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, Frames.Element;

type
  TForm1 = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    ElementFrame1: TElementFrame;
    ElementFrame2: TElementFrame;
    ElementFrame3: TElementFrame;
    procedure Rectangle1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Rectangle1Click(Sender: TObject);
begin
  GridPanelLayout1.ControlCollection.AddControl(TCircle.Create(nil));
end;

end.
