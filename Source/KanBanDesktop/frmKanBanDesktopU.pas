unit frmKanBanDesktopU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCCustomScrollControl, FMX.TMSFNCKanbanBoard, FMX.TMSFNCPageControl,
  FMX.TMSFNCCustomControl, FMX.TMSFNCTabSet, dmKanBanClient, frmKanBanClientStatus;

type
  TfrmKanBanDesktop = class(TForm)
    pcMain: TTMSFNCPageControl;
    TMSFNCPageControl1Page0: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page1: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page2: TTMSFNCPageControlContainer;
    TMSFNCKanbanBoard1: TTMSFNCKanbanBoard;
    procedure FormCreate(Sender: TObject);
  private
    FKanBanStatus: TfrmKBClientStatus;
  public
    { Public declarations }
  end;

var
  frmKanBanDesktop: TfrmKanBanDesktop;

implementation

{$R *.fmx}

procedure TfrmKanBanDesktop.FormCreate(Sender: TObject);
begin
  FKanBanStatus := TfrmKBClientStatus.Create(self);
  FKanBanStatus.Parent := pcMain.PageContainers[2];
    FKanBanStatus.DeclareClient( 'DTClient');

end;

end.
