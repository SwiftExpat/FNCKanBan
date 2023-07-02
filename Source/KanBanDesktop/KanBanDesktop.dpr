program KanBanDesktop;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmKanBanDesktopU in 'frmKanBanDesktopU.pas' {frmKanBanDesktop},
  dmKanBanClient in '..\KanBanClientCommon\dmKanBanClient.pas' {dmKBClient: TDataModule},
  frameKanBanClientStatus in '..\KanBanClientCommon\frameKanBanClientStatus.pas' {frmKBClientStatus: TFrame},
  frmKanBanClientItemEdit in '..\KanBanClientCommon\frmKanBanClientItemEdit.pas' {frmKBClientItemEdit: TFrame},
  frmKanBanBoardConfigure in '..\KanBanClientCommon\frmKanBanBoardConfigure.pas' {frmKanBanBoardConfig},
  frmKanBanItemDetail in '..\KanBanClientCommon\frmKanBanItemDetail.pas' {frmKanbanItmDetail},
  formKanBanClientBoard in '..\KanBanClientCommon\formKanBanClientBoard.pas' {frmKanBanBoard};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmKanBanDesktop, frmKanBanDesktop);
  Application.Run;
end.
