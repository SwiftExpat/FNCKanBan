unit frmKanBanDesktopU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCCustomScrollControl, FMX.TMSFNCKanbanBoard, FMX.TMSFNCPageControl,
  FMX.TMSFNCCustomControl, FMX.TMSFNCTabSet, dmKanBanClient, frmKanBanClientStatus, frmKanBanClientItemEdit,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmKanBanDesktop = class(TForm)
    pcMain: TTMSFNCPageControl;
    TMSFNCPageControl1Page0: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page1: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page2: TTMSFNCPageControlContainer;
    TMSFNCKanbanBoard1: TTMSFNCKanbanBoard;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FKanBanStatus: TfrmKBClientStatus;
    FKanBanItemEdit: TfrmKBClientItemEdit;
  public
    { Public declarations }
  end;

var
  frmKanBanDesktop: TfrmKanBanDesktop;

implementation

{$R *.fmx}

uses FMX.SERTTK.Marshal;

procedure TfrmKanBanDesktop.Button1Click(Sender: TObject);
begin
    TSERTTKMarshalAPI.ShowMarshal;
end;

procedure TfrmKanBanDesktop.FormCreate(Sender: TObject);
begin
  FKanBanStatus := TfrmKBClientStatus.Create(self);
  FKanBanStatus.Parent := pcMain.PageContainers[2];
  FKanBanStatus.DeclareClient('DTClient');

  FKanBanItemEdit := TfrmKBClientItemEdit.Create(self);
  FKanBanItemEdit.Parent := pcMain.PageContainers[1];
  FKanBanItemEdit.AssignPrefix( 'Desktop ');
end;

end.
