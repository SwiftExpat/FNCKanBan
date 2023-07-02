program KanBanDesktop;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmKanBanDesktopU in 'frmKanBanDesktopU.pas' {frmKanBanDesktop},
  dmKanBanClient in '..\KanBanClientCommon\dmKanBanClient.pas' {dmKBClient: TDataModule},
  frmKanBanClientStatus in '..\KanBanClientCommon\frmKanBanClientStatus.pas' {frmKBClientStatus: TFrame},
  frmKanBanClientItemEdit in '..\KanBanClientCommon\frmKanBanClientItemEdit.pas' {frmKBClientItemEdit: TFrame},
  frmKanBanClientBoard in '..\KanBanClientCommon\frmKanBanClientBoard.pas' {frmKanBanBoard: TFrame},
  frmKanBanBoardConfigure in 'frmKanBanBoardConfigure.pas' {frmKanBanBoardConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmKanBanDesktop, frmKanBanDesktop);
  Application.CreateForm(TfrmKanBanBoardConfig, frmKanBanBoardConfig);
  Application.Run;
end.
