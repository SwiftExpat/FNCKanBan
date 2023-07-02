unit frmKanBanClientStatus;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.TMSFNCTypes, FMX.TMSFNCUtils,
  FMX.TMSFNCGraphics, FMX.TMSFNCGraphicsTypes, FMX.TMSFNCToolBar, FMX.TMSFNCCustomControl, FMX.TMSFNCStatusBar,
  dmKanBanClient, FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, Echo.Listeners;

type
  TfrmKBClientStatus = class(TFrame)
    sbClientStatus: TTMSFNCStatusBar;
    TMSFNCToolBar1: TTMSFNCToolBar;
    btnClientConnect: TTMSFNCToolBarButton;
    btnClientDisconnect: TTMSFNCToolBarButton;
    Memo1: TMemo;
    tmrSynchronize: TTimer;
    procedure btnClientConnectClick(Sender: TObject);
    procedure tmrSynchronizeTimer(Sender: TObject);
  private
    FEchoSubscriber: TEchoEventSubscriber;
    // FManager: TObjectManager;
    FClientName: string;
    procedure ConnectClient;
    procedure LogMsg(AMessage: string);
  public
    procedure DeclareClient(AClientName: string);
  end;

implementation

{$R *.fmx}

procedure TfrmKBClientStatus.btnClientConnectClick(Sender: TObject);
begin
  ConnectClient;
end;

procedure TfrmKBClientStatus.ConnectClient;
begin
  try
    FEchoSubscriber := TEchoEventSubscriber.Create;
    FEchoSubscriber.SubscribeListeners;
    LogMsg('Begin Echo connection');
    dmKBClient := TdmKBClient.Create(Application, FClientName);
    dmKBClient.OnClientMessage := LogMsg;
    tmrSynchronize.Enabled := true;
    LogMsg('Echo connected');
    // FManager := TObjectManager.Create(FDMKanBanClient.Echo.Pool.GetConnection);
  except
    on E: Exception do
      LogMsg('Error Connecting' + E.Message);
  end;
end;

procedure TfrmKBClientStatus.DeclareClient(AClientName: string);
begin
  Memo1.Lines.Clear;
  FClientName := AClientName;
  sbClientStatus.Panels.Items[0].Text := FClientName;
  LogMsg('Client Declared as ' + FClientName);
  ConnectClient;
end;

procedure TfrmKBClientStatus.LogMsg(AMessage: string);
begin
  Memo1.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now) + ' : ' + AMessage);
end;

procedure TfrmKBClientStatus.tmrSynchronizeTimer(Sender: TObject);
begin
  try
    dmKBClient.Push;
    LogMsg('Push executed');
    dmKBClient.Pull;
    LogMsg('Pull executed');
  except
    on E: Exception do
      LogMsg('Error in Timer' + E.Message);
  end;
end;

end.
