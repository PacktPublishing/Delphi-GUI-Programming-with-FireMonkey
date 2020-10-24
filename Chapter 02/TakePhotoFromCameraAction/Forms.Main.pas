unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, System.Actions,
  FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ToolBar1: TToolBar;
    Image1: TImage;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses RTTI, System.Permissions, FMX.DialogService;

procedure TForm1.FormCreate(Sender: TObject);
begin
{$IFDEF ANDROID}
  // interactive permission grant request (Android 8+)
  // Also remember to set "Secure File Sharing" to True in Project - Options - Entitlement List

  PermissionsService.RequestPermissions(
    [
      'android.permission.CAMERA'
    , 'android.permission.READ_EXTERNAL_STORAGE'
    , 'android.permission.WRITE_EXTERNAL_STORAGE'
    ]
  , procedure (const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
    var LIndex: Integer;
    begin
      for LIndex := 0 to Length(AGrantResults)-1 do
      begin
        if AGrantResults[LIndex] <> TPermissionStatus.Granted then
          TDialogService.ShowMessage('Permission ' + APermissions[LIndex] + ' is required');
      end;
    end
  );
{$ENDIF}
end;

procedure TForm1.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
  Image1.Bitmap.Assign(Image);
end;

end.
