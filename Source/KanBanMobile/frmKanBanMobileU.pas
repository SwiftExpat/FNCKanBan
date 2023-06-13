unit frmKanBanMobileU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCPageControl, FMX.TMSFNCTabSet, FMX.TMSFNCCustomControl,
  FMX.TMSFNCCustomScrollControl, FMX.TMSFNCKanbanBoard, frmKanBanClientStatus,frmKanBanClientItemEdit,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmKanBanMobile = class(TForm)
    TMSFNCKanbanBoard1: TTMSFNCKanbanBoard;
    pcMain: TTMSFNCPageControl;
    TMSFNCPageControl1Page0: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page1: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page2: TTMSFNCPageControlContainer;
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
  frmKanBanMobile: TfrmKanBanMobile;

implementation

{$R *.fmx}
uses FMX.SERTTK.Marshal;

procedure TfrmKanBanMobile.Button1Click(Sender: TObject);
begin
    TSERTTKMarshalAPI.ShowMarshal;
end;

procedure TfrmKanBanMobile.FormCreate(Sender: TObject);
begin
  FKanBanStatus := TfrmKBClientStatus.Create(self);
  FKanBanStatus.Parent := pcMain.PageContainers[2];
  FKanBanStatus.DeclareClient('MobileClient');
  FKanBanItemEdit := TfrmKBClientItemEdit.Create(self);
  FKanBanItemEdit.Parent := pcMain.PageContainers[1];
  FKanBanItemEdit.AssignPrefix( 'Mobile ');
end;

end.
