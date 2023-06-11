unit frmKanBanDesktopU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCCustomScrollControl, FMX.TMSFNCKanbanBoard, FMX.TMSFNCPageControl,
  FMX.TMSFNCCustomControl, FMX.TMSFNCTabSet;

type
  TfrmKanBanDesktop = class(TForm)
    TMSFNCPageControl1: TTMSFNCPageControl;
    TMSFNCPageControl1Page0: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page1: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page2: TTMSFNCPageControlContainer;
    TMSFNCKanbanBoard1: TTMSFNCKanbanBoard;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKanBanDesktop: TfrmKanBanDesktop;

implementation

{$R *.fmx}

end.
