unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.Objects, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.MultiResBitmap;

type
  TForm1 = class(TForm)
    Glyph1: TGlyph;
    Image1: TImage;
    ImageList1: TImageList;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button3: TButton;
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Image1Resized(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPrevItemIndex: Integer;
    FCount: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
   Windows;

procedure TForm1.Button1Click(Sender: TObject);
var
  LBounds: TRect;
begin
  LBounds := Bounds;
  LBounds.Inflate(10, 0);
  Bounds := LBounds;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LScale: Double;
  LItem: TCustomBitmapItem;
  LBitmap: FMX.Graphics.TBitmap;
  LCurrentWidth: Integer;
  LReplace: Boolean;
  LStandardItem: TCustomBitmapItem;
  LScaleStr: string;
begin
  LScale := TCustomBitmapItem.ScaleOfBitmap(
    TSize.Create(Image1.MultiResBitmap.Width, Image1.MultiResBitmap.Height)
//    TSize.Create(256, 256)
  , Image1.Size.Size.Round
  );

  Label1.Text := 'Scale: ' + LScale.ToString;

  if GetAsyncKeyState(VK_LSHIFT)<0 then
  begin
    LScaleStr := LScale.ToString;
    InputQuery('Scale', 'Input scale', LScaleStr );
    LScale := StrToFloat(LScaleStr);
  end;

  LItem := Image1.MultiResBitmap.ItemByScale(LScale, False, True);


  if GetAsyncKeyState(VK_RSHIFT)<0 then
  begin
    LItem := Image1.MultiResBitmap.Items[0];
  end;

  if Assigned(LItem) then
  begin
    Label2.Text := 'Item.Index: ' + LItem.Index.ToString + ' Scale: ' + LItem.Scale.ToString;
    LReplace := LItem.Index <> FPrevItemIndex;
(*
    if Assigned(Image1.Bitmap) then
    begin
      LCurrentWidth := Image1.Bitmap.Image.Width;
      Label3.Text := 'Current: ' + LCurrentWidth.ToString + ' New: ' + LItem.Width.ToString;
      LReplace := True or (LCurrentWidth <> LItem.Width);
    end;
*)
    Label2.Text := Label2.Text + ' Replace:' + LReplace.ToString(TUseBoolStrs.True);

    if LReplace then
    begin
      FPrevItemIndex := LItem.Index;
      Inc(FCount);
      LBitmap := LItem.CreateBitmap;
      try
        Image1.Bitmap.Assign(LBitmap);
      finally
        LBitmap.Free;
      end;
    end;
  end
  else
    Label2.Text := 'Item.Index: N/A';


  Label3.Text := 'PrevIndex: ' + FPrevItemIndex.ToString + ' Count: ' + FCount.ToString;

//  Image1.Bitmap.Assign( ImageList1.Bitmap(Image1.Size.Size, 0) );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FPrevItemIndex := -1;
  FCount := 0;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Caption := 'Glyph1: ' + Glyph1.Scene.GetSceneScale.ToString(TFloatFormat.ffFixed, 15, 4)
    + ' Image1: ' + Image1.Scene.GetSceneScale.ToString(TFloatFormat.ffFixed, 15, 4);
end;

procedure TForm1.Image1Resized(Sender: TObject);
begin
  Button2Click(nil);
end;

end.
