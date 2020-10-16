unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.ImageList, FMX.ImgList;

type
  TForm1 = class(TForm)
    SpButtonLeft: TSpeedButton;
    SpButtonMiddle: TSpeedButton;
    SpButtonRight: TSpeedButton;
    SpButton1: TSpeedButton;
    SpBtnImgLeft: TSpeedButton;
    SpBtnImgMiddle: TSpeedButton;
    SpBtnImgRight: TSpeedButton;
    ImageList1: TImageList;
    SpButton2: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
