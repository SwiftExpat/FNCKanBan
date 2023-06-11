unit frmKanBanServerU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCPageControl, FMX.TMSFNCTabSet, FMX.TMSFNCStatusBar, FMX.TMSFNCCustomControl,
  FMX.TMSFNCToolBar, FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  Aurelius.Drivers.Interfaces,
  Aurelius.Engine.DatabaseManager,
  Aurelius.SQL.SQLite,
  Aurelius.Schema.SQLite,
  Aurelius.Drivers.SQLite,
  XData.Server.Module,
  Sparkle.HttpSys.Server,
  Sparkle.HttpServer.Context,
  Sparkle.HttpServer.Module,
  Sparkle.Sys.Timer,
  Echo.Server, Echo.Main;

type
  TfrmKanBanServer = class(TForm)
    TMSFNCToolBar1: TTMSFNCToolBar;
    sbMain: TTMSFNCStatusBar;
    TMSFNCPageControl1: TTMSFNCPageControl;
    TMSFNCPageControl1Page0: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page1: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page2: TTMSFNCPageControlContainer;
    Memo1: TMemo;
    btnServerStart: TTMSFNCToolBarButton;
    btnServerStop: TTMSFNCToolBarButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnServerStopClick(Sender: TObject);
    procedure btnServerStartClick(Sender: TObject);
  strict private
    SparkleServer: THttpSysServer;
    Echo: TEcho;
    Timer: TSparkleTimer;
    class function CreateConnection: IDBConnection;
    class function CreateFactory: IDBConnectionFactory;
    class function CreatePool(APoolSize: Integer): IDBConnectionPool;
  private
    procedure ButtonUpdate;
    procedure InternalStartServer;
    procedure LogMessage(AMessage: string);
    procedure StatusMessage(AMessage: string);
    procedure StartServer;
    procedure StopServer;
  public
    { Public declarations }
  end;

var
  frmKanBanServer: TfrmKanBanServer;

implementation

uses
  XData.Aurelius.ConnectionPool,
  Aurelius.Drivers.Base,
    KanBanEntityTypes;

{$R *.fmx}
{ TfrmKanBanServer }

procedure TfrmKanBanServer.btnServerStartClick(Sender: TObject);
begin
  StartServer;
  ButtonUpdate
end;

procedure TfrmKanBanServer.btnServerStopClick(Sender: TObject);
begin
  StopServer;
  ButtonUpdate
end;

procedure TfrmKanBanServer.ButtonUpdate;
begin
  if SparkleServer <> nil then
    btnServerStart.Enabled := not SparkleServer.IsRunning
  else
    btnServerStart.Enabled := true;
  btnServerStop.Enabled := not btnServerStart.Enabled;
end;

class function TfrmKanBanServer.CreateConnection: IDBConnection;
begin
  Result := TSQLiteNativeConnectionAdapter.Create('server.db');
end;

class function TfrmKanBanServer.CreateFactory: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := CreateConnection;
    end);
end;

class function TfrmKanBanServer.CreatePool(APoolSize: Integer): IDBConnectionPool;
begin
  Result := TDBConnectionPool.Create(APoolSize, CreateFactory);
end;

procedure TfrmKanBanServer.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
  StartServer;
  ButtonUpdate;
end;

procedure TfrmKanBanServer.FormDestroy(Sender: TObject);
begin
  StopServer;
end;

procedure TfrmKanBanServer.InternalStartServer;
var
  EchoModule: TEchoServerModule;
  Pool: IDBConnectionPool;
  NodeManager: IEchoNodeManager;
  Conn: IDBConnection;
begin
  if Assigned(SparkleServer) then
    Exit;

  SparkleServer := THttpSysServer.Create;

  // Module := TXDataServerModule.Create(
  // 'http://+:2001/tms/xdata',
  // TSQLiteSQLiteConnection.CreatePool(20)
  // );
  // SparkleServer.AddModule(Module);

  // Echo Server
  Pool := CreatePool(1);
  EchoModule := TEchoServerModule.Create('http://+:2001/tms/echo', Pool);
  SparkleServer.AddModule(EchoModule);

  Echo := TEcho.Create(Pool);

  // Create regular tables and fields of the application
  Conn := Echo.Pool.GetConnection;
  TDatabaseManager.Update(Conn);
  // Create tables and fields for TMS Echo usage
  TDatabaseManager.Update(Conn, TEcho.Explorer);
  Conn := nil; // Free reference

  // Get the NodeManager instance
  NodeManager := Echo.GetNodeManager;

  // If SelfNode is already defined, no need to define it again
  if NodeManager.SelfNode = nil then
  begin
    // SelfNode is not defined, so let's create a Node instance with the name
    // specified by the DBName property ("client1", "client2", "server" in the case
    // of our demo application. It can be any string value, it just needs
    // to be unique among all other databases being replicated.
    NodeManager.CreateNode('server');

    // Now define this newly created node as the SelfNode
    NodeManager.DefineSelfNode('server');
  end;

  Timer := TSparkleTimer.Create(
    procedure(Echo: TObject)
    begin
      TEcho(Echo).BatchLoad;
      TEcho(Echo).Route;
    end, Echo, 2000, TTimerType.Periodic);

  SparkleServer.Start;
end;

procedure TfrmKanBanServer.LogMessage(AMessage: string);
begin
  Memo1.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now) + ' : ' + AMessage);
end;

procedure TfrmKanBanServer.StartServer;
begin
  StatusMessage('Server Starting');
  InternalStartServer;
  StatusMessage('Server Started');
end;

procedure TfrmKanBanServer.StatusMessage(AMessage: string);
begin
  sbMain.Panels.Items[0].Text := AMessage;
  LogMessage(AMessage);
end;

procedure TfrmKanBanServer.StopServer;
begin
  StatusMessage('Server Stopping');
  FreeAndNil(SparkleServer);
  FreeAndNil(Echo);
  FreeAndNil(Timer);
  StatusMessage('Server Stopped');

end;

end.
