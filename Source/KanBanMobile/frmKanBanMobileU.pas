unit frmKanBanMobileU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCPageControl, FMX.TMSFNCTabSet, FMX.TMSFNCCustomControl,
  FMX.TMSFNCCustomScrollControl, FMX.TMSFNCKanbanBoard, frameKanBanClientStatus, frmKanBanClientItemEdit,
  FMX.Controls.Presentation, FMX.StdCtrls, formKanBanClientBoard;

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
    procedure FormShow(Sender: TObject);
  private
    FKanBanStatus: TfrmKBClientStatus;
    FKanBanItemEdit: TfrmKBClientItemEdit;
    FKanBanBoard: TfrmKanBanBoard;
    FLoaded: Boolean;
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
  FKanBanItemEdit.AssignPrefix('Mobile ');

  FKanBanBoard := TfrmKanBanBoard.Create(self);
  FKanBanBoard.lytBoard.Parent := pcMain.PageContainers[0];
end;

procedure TfrmKanBanMobile.FormShow(Sender: TObject);
begin
  if not FLoaded then
  begin
    FKanBanBoard.LoadBoard;
    FLoaded := true;
  end;
end;

end.
