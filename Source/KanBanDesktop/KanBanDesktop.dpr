program KanBanDesktop;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmKanBanDesktopU in 'frmKanBanDesktopU.pas' {frmKanBanDesktop},
  dmKanBanClient in '..\KanBanClientCommon\dmKanBanClient.pas' {dmKBClient: TDataModule},
  frmKanBanClientStatus in '..\KanBanClientCommon\frmKanBanClientStatus.pas' {frmKBClientStatus: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmKanBanDesktop, frmKanBanDesktop);
  Application.Run;
end.
