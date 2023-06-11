unit frmKanBanMobileU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCPageControl, FMX.TMSFNCTabSet, FMX.TMSFNCCustomControl,
  FMX.TMSFNCCustomScrollControl, FMX.TMSFNCKanbanBoard, frmKanBanClientStatus;

type
  TfrmKanBanMobile = class(TForm)
    TMSFNCKanbanBoard1: TTMSFNCKanbanBoard;
    pcMain: TTMSFNCPageControl;
    TMSFNCPageControl1Page0: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page1: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page2: TTMSFNCPageControlContainer;
    procedure FormCreate(Sender: TObject);
  private
    FKanBanStatus: TfrmKBClientStatus;
  public
    { Public declarations }
  end;

var
  frmKanBanMobile: TfrmKanBanMobile;

implementation

{$R *.fmx}

procedure TfrmKanBanMobile.FormCreate(Sender: TObject);
begin
  FKanBanStatus := TfrmKBClientStatus.Create(self);
  FKanBanStatus.Parent := pcMain.PageContainers[2];
  FKanBanStatus.DeclareClient('MobileClient');
end;

end.
