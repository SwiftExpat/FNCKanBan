program KanBanMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmKanBanMobileU in 'frmKanBanMobileU.pas' {frmKanBanMobile};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmKanBanMobile, frmKanBanMobile);
  Application.Run;
end.
