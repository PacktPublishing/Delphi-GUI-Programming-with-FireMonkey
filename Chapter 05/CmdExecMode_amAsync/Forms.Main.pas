unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FMX.Controls.Presentation, FMX.StdCtrls, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.FMXUI.Async,
  FireDAC.Comp.UI, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  System.Diagnostics;

type
  TMainForm = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    GetDataButton: TButton;
    Memo1: TMemo;
    procedure GetDataButtonClick(Sender: TObject);
    procedure FDQuery1AfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FStopWatch: TStopwatch;
    procedure Log(const AMsg: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.GetDataButtonClick(Sender: TObject);
begin
  FDQuery1.Close;
  Log('Opening query');
  FDQuery1.Open();
  Log('Waiting...');
end;

procedure TMainForm.FDQuery1AfterOpen(DataSet: TDataSet);
begin
  Log('Data available');
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FStopWatch := TStopwatch.StartNew;
end;

procedure TMainForm.Log(const AMsg: string);
begin
  FStopWatch.Stop;
  Memo1.Lines.Add(
    TimeToStr(Now) + ': '
    + AMsg
    + ' (' + FStopWatch.ElapsedMilliseconds.ToString + ' ms)');
  FStopWatch := TStopwatch.StartNew;
end;

end.
