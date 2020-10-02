unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.MultiView, FMX.Controls.Presentation, FMX.ListBox,
  System.ImageList, FMX.ImgList, FMX.Edit;

type
  TMainForm = class(TForm)
    TopToolBar: TToolBar;
    MasterButton: TButton;
    MultiView1: TMultiView;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ImageList1: TImageList;
    StyleBook1: TStyleBook;
    DetailLayout: TLayout;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

end.
