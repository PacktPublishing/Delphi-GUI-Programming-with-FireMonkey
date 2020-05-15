unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox;

type
  TMainForm = class(TForm)
    ShowMessageButton: TButton;
    ShowMessageCloseButton: TButton;
    ShowMessageContextButton: TButton;
    InputQueryButton: TButton;
    InputQueryContextButton: TButton;
    Label1: TLabel;
    ModeComboBox: TComboBox;
    OpenDialog1: TOpenDialog;
    OpenDialogButton: TButton;
    MsgDialogInfoButton: TButton;
    MsgDialogWarnButton: TButton;
    MsgDialogErrButton: TButton;
    MsgDialogConfButton: TButton;
    procedure ShowMessageButtonClick(Sender: TObject);
    procedure ShowMessageCloseButtonClick(Sender: TObject);
    procedure ShowMessageContextButtonClick(Sender: TObject);
    procedure InputQueryButtonClick(Sender: TObject);
    procedure ModeComboBoxChange(Sender: TObject);
    procedure InputQueryContextButtonClick(Sender: TObject);
    procedure OpenDialogButtonClick(Sender: TObject);
    procedure MsgDialogInfoButtonClick(Sender: TObject);
    procedure MsgDialogErrButtonClick(Sender: TObject);
    procedure MsgDialogConfButtonClick(Sender: TObject);
    procedure MsgDialogWarnButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowMessageCloseHandler(Sender: TObject; const AModalResult: TModalResult);
    procedure InputQueryCloseHandler(Sender: TObject; const AResult: TModalResult; const AValues: array of string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

uses FMX.DialogService;

procedure TMainForm.InputQueryContextButtonClick(Sender: TObject);
begin
  TDialogService.InputQuery(
    'My caption here'
  , ['First', 'Second', 'Third']
  , ['1', '2', '3']
  , InputQueryCloseHandler
  , InputQueryContextButton
  );
  InputQueryContextButton.Text := TimeToStr(Now);
end;

procedure TMainForm.InputQueryButtonClick(Sender: TObject);
begin
  TDialogService.InputQuery(
    'My caption here'
  , ['First']
  , ['Test']
  , procedure (const AResult: TModalResult; const AValues: array of string)
    begin
      if AResult = mrOk then
        TDialogService.ShowMessage(
          'Closes at ' + TimeToStr(Now) + sLineBreak
        + 'Values: ' + sLineBreak
        + string.Join(sLineBreak, AValues)
        );
    end
  );


//  TDialogService.InputQuery(
//    'My caption here'
//  , ['First', 'Second', 'Third']
//  , ['1', '2', '3']
//  , procedure (const AResult: TModalResult; const AValues: array of string)
//    begin
//      if AResult = mrOk then
//        TDialogService.ShowMessage(
//          'Closes at ' + TimeToStr(Now) + sLineBreak
//        + 'Values: ' + sLineBreak
//        + string.Join(sLineBreak, AValues)
//        );
//    end
//  );
  InputQueryButton.Text := TimeToStr(Now);
end;

procedure TMainForm.InputQueryCloseHandler(Sender: TObject;
  const AResult: TModalResult; const AValues: array of string);
var
  LContextBUtton: TButton;
begin
  LContextBUtton := Sender as TButton;

  if AResult = mrOk then
  begin
    TDialogService.ShowMessage(
      'Closes at ' + TimeToStr(Now) + sLineBreak
    + 'Context Button: ' + sLineBreak
    + ' - Name: ' + LContextButton.Name + slineBreak
    + ' - Text: ' + LContextButton.Text + sLineBreak
    + 'Values: ' + sLineBreak
    + string.Join(sLineBreak, AValues)
    );
  end;

end;

procedure TMainForm.ModeComboBoxChange(Sender: TObject);
begin
  case ModeComboBox.ItemIndex of
    0: TDialogService.PreferredMode := TDialogService.TPreferredMode.Platform;
    1: TDialogService.PreferredMode := TDialogService.TPreferredMode.Async;
    2: TDialogService.PreferredMode := TDialogService.TPreferredMode.Sync;
  end;
end;

procedure TMainForm.MsgDialogErrButtonClick(Sender: TObject);
begin
  TDialogService.MessageDialog(
    'This is an error message'
  , TMsgDlgType.mtError
  , [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0
  , procedure (const AResult: TModalResult)
    begin
      if AResult = mrOk then
        TDialogService.ShowMessage('OK: ' + TimeToStr(Now));
    end
  );
  MsgDialogErrButton.Text := TimeToStr(Now) + ' Err';
end;

procedure TMainForm.MsgDialogInfoButtonClick(Sender: TObject);
begin
  TDialogService.MessageDialog(
    'This is an information message'
  , TMsgDlgType.mtInformation
  , [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0
  , procedure (const AResult: TModalResult)
    begin
      if AResult = mrOk then
        TDialogService.ShowMessage('OK: ' + TimeToStr(Now));
    end
  );
  MsgDialogInfoButton.Text := TimeToStr(Now) + ' Info';
end;

procedure TMainForm.MsgDialogWarnButtonClick(Sender: TObject);
begin
  TDialogService.MessageDialog(
    'This is a warning message'
  , TMsgDlgType.mtWarning
  , [TMsgDlgBtn.mbOK, TMsgDlgBtn.mbRetry], TMsgDlgBtn.mbOK, 0
  , procedure (const AResult: TModalResult)
    begin
      case AResult of
           mrOk: TDialogService.ShowMessage('OK: ' + TimeToStr(Now));
        mrRetry: TDialogService.ShowMessage('Retry: ' + TimeToStr(Now));
      end;
    end
  );
  MsgDialogWarnButton.Text := TimeToStr(Now) + ' Warn';
end;

procedure TMainForm.MsgDialogConfButtonClick(Sender: TObject);
begin
  TDialogService.MessageDialog(
    'This is a confirmation message'
  , TMsgDlgType.mtConfirmation
  , [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0
  , procedure (const AResult: TModalResult)
    begin
      if AResult = mrYes then
        TDialogService.ShowMessage('Yes: ' + TimeToStr(Now));
    end
  );
  MsgDialogConfButton.Text := TimeToStr(Now) + ' Conf';
end;

procedure TMainForm.OpenDialogButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    TDialogService.ShowMessage(OpenDialog1.FileName);
  end;
end;

procedure TMainForm.ShowMessageButtonClick(Sender: TObject);
begin
  TDialogService.ShowMessage('Hello, world!');
  ShowMessageButton.Text := TimeToStr(Now);
end;

procedure TMainForm.ShowMessageCloseButtonClick(Sender: TObject);
begin
  TDialogService.ShowMessage(
    'Opens at ' + TimeToStr(Now)
  , procedure (const AModalResult: TModalResult)
    begin
      TDialogService.ShowMessage('Closes at ' + TimeToStr(Now));
    end
  );
  ShowMessageCloseButton.Text := TimeToStr(Now);
end;

procedure TMainForm.ShowMessageCloseHandler(Sender: TObject;
  const AModalResult: TModalResult);
var
  LContextButton: TButton;
begin
  LContextButton := Sender as TButton;
  TDialogService.ShowMessage(
    'Closes at ' + TimeToStr(Now) + sLineBreak
  + 'Context Button: ' + sLineBreak
  + ' - Name: ' + LContextButton.Name + slineBreak
  + ' - Text: ' + LContextButton.Text
  );
end;

procedure TMainForm.ShowMessageContextButtonClick(Sender: TObject);
begin
  TDialogService.ShowMessage(
   'Opens at ' + TimeToStr(Now)
  , ShowMessageCloseHandler
  , ShowMessageContextButton
  );
  ShowMessageContextButton.Text := TimeToStr(Now);
end;

end.
