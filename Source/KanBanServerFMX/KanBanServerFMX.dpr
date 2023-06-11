program KanBanServerFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmKanBanServerU in 'frmKanBanServerU.pas' {frmKanBanServer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmKanBanServer, frmKanBanServer);
  Application.Run;
end.
