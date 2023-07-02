unit frmKanBanBoardConfigure;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCPageControl, FMX.TMSFNCCustomControl, FMX.TMSFNCTabSet, FMX.Layouts,
  FMX.TMSFNCListBox, FMX.TMSFNCTableView;

type
  TfrmKanBanBoardConfig = class(TForm)
    pcBoardConfigure: TTMSFNCPageControl;
    TMSFNCPageControl1Page0: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page1: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page2: TTMSFNCPageControlContainer;
    lytBoardConfigure: TLayout;
    TMSFNCTableView1: TTMSFNCTableView;
    lbStatus: TTMSFNCListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKanBanBoardConfig: TfrmKanBanBoardConfig;

implementation

{$R *.fmx}

end.
