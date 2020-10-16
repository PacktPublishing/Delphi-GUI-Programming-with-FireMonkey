unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList;

type
  TMainForm = class(TForm)
    Glyph1: TGlyph;
    ImageList1: TImageList;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.FormResize(Sender: TObject);
begin
  Caption := ClientRect.Width.ToString + 'x' + ClientRect.Height.ToString;
end;

end.
