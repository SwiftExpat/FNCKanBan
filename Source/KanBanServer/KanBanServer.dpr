program KanBanServer;

uses
  Vcl.Forms,
  dmKanBanServerU in 'dmKanBanServerU.pas' {ServerContainer: TDataModule},
  frmKanBanServerU in 'frmKanBanServerU.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
