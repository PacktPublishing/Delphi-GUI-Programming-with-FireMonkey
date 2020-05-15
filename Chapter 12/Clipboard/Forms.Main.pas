unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Actions, FMX.ActnList
, FMX.Clipboard
;

type
  TMainForm = class(TForm)
    PasteTextButton: TButton;
    PasteImage: TImage;
    PasteMemo: TMemo;
    PasteLayout: TLayout;
    Layout1: TLayout;
    CopyImage: TImage;
    CopyMemo: TMemo;
    CopyTextButton: TButton;
    Button1: TButton;
    PasteGraphicButton: TButton;
    ActionList1: TActionList;
    CopyTextAction: TAction;
    CopyGraphicAction: TAction;
    PasteTextAction: TAction;
    PasteGraphicAction: TAction;
    ClearPasteImageLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CopyTextActionUpdate(Sender: TObject);
    procedure CopyGraphicActionUpdate(Sender: TObject);
    procedure PasteTextActionUpdate(Sender: TObject);
    procedure PasteGraphicActionUpdate(Sender: TObject);
    procedure PasteTextActionExecute(Sender: TObject);
    procedure PasteGraphicActionExecute(Sender: TObject);
    procedure CopyTextActionExecute(Sender: TObject);
    procedure CopyGraphicActionExecute(Sender: TObject);
    procedure ClearPasteImageLabelClick(Sender: TObject);
  private
    FClipboardService: IFMXExtendedClipboardService;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

uses FMX.Platform, FMX.Surfaces;

procedure TMainForm.ClearPasteImageLabelClick(Sender: TObject);
begin
  PasteImage.Bitmap.Assign(nil);
end;

procedure TMainForm.CopyGraphicActionExecute(Sender: TObject);
var
  LBS: TBitmapSurface;
begin
  LBS := TBitmapSurface.Create();
  try
    LBS.Assign(CopyImage.Bitmap);
    FClipboardService.SetImage(LBS);
  finally
    LBS.Free;
  end;
end;

procedure TMainForm.CopyGraphicActionUpdate(Sender: TObject);
begin
  {$IFDEF ANDROID} // clipboard does not support images
  CopyGraphicAction.Enabled := False;
  {$ELSE}
  CopyGraphicAction.Enabled := Assigned(CopyImage.Bitmap);
  {$IFEND}
end;

procedure TMainForm.CopyTextActionExecute(Sender: TObject);
begin
  FClipboardService.SetText(CopyMemo.Text);
end;

procedure TMainForm.CopyTextActionUpdate(Sender: TObject);
begin
  CopyTextAction.Enabled := not CopyMemo.Text.IsEmpty;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if not TPlatformServices.Current.SupportsPlatformService(
    IFMXExtendedClipboardService, FClipboardService)
  then
    raise ENotSupportedException.Create('Clipboard not supported on this platform!');
end;

procedure TMainForm.PasteGraphicActionExecute(Sender: TObject);
begin
  PasteImage.Bitmap.Assign(FClipboardService.GetImage);
end;

procedure TMainForm.PasteGraphicActionUpdate(Sender: TObject);
begin
  PasteGraphicAction.Enabled := FClipboardService.HasImage;
end;

procedure TMainForm.PasteTextActionExecute(Sender: TObject);
begin
  PasteMemo.Text := FClipboardService.GetText;
end;

procedure TMainForm.PasteTextActionUpdate(Sender: TObject);
begin
  PasteTextAction.Enabled := FClipboardService.HasText;
end;

end.
