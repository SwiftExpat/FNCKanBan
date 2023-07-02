unit dmKanBanClient;

interface

uses
  System.SysUtils, System.Classes,
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.Base,
  Echo.Main;

const
  URI_Remote_Node = 'http://localhost:2001/tms/echokb';

type
  TKanBanClientMessage = procedure(AMessage: string) of object;

  TdmKBClient = class(TDataModule)
  strict private
    FClientMsg: TKanBanClientMessage;
  private
    FEcho: TEcho;
    FDBName: string;
    procedure UpdateDBStructure;
    procedure InitialSetup;
    procedure SetupNodes;
    function CreateConnection(const ADBName: string): IDBConnection;
    procedure LogMsg(AMessage: string);
  public
    constructor Create(AOwner: TComponent; const ADBName: string; const AServerDBName: string = ''); reintroduce;
    destructor Destroy; override;
    procedure Push;
    procedure Pull;
    property DBName: string read FDBName;
    property Echo: TEcho read FEcho;
    property OnClientMessage: TKanBanClientMessage read FClientMsg write FClientMsg;
  end;

var
  dmKBClient: TdmKBClient;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  System.IOUtils,
  Aurelius.Engine.DatabaseManager,
  Aurelius.Drivers.SQLite,
  Aurelius.Mapping.Explorer,
  Aurelius.Sql.SQLite,
  Aurelius.Schema.SQLite,
  KanBanEntityTypes,
  Echo.Entities,
  EchoUtilTypes;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TdmKBClient }

constructor TdmKBClient.Create(AOwner: TComponent; const ADBName, AServerDBName: string);
begin
  FDBName := ADBName;

  FEcho := TEcho.Create(TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := CreateConnection(ADBName);
    end));

  InitialSetup;
end;

function TdmKBClient.CreateConnection(const ADBName: string): IDBConnection;
var
  FileName: string;
begin
  // Refers to a SQLite database in the same directory as the executable,
  // with the name given by "DBName"
  FileName := TPath.ChangeExtension(ADBName, '.db');
  FileName := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), FileName);
  Result := TSQLiteNativeConnectionAdapter.Create(FileName);
end;

destructor TdmKBClient.Destroy;
begin
  FEcho.Free;
  inherited;
end;

procedure TdmKBClient.InitialSetup;
begin
  // Update database structure if needed.
  UpdateDBStructure;

  // Setup replication nodes
  SetupNodes;

end;

procedure TdmKBClient.LogMsg(AMessage: string);
begin
  if Assigned(FClientMsg) then
    FClientMsg(AMessage);

end;

procedure TdmKBClient.Pull;
begin
  // Route all changes to the nodes that should receive changes
  FEcho.GetRemoteNode(URI_Remote_Node).Pull;

  // process on client
  FEcho.BatchLoad;
  FEcho.Route(
    procedure(Log: TEchoLog; Node: TEchoNode; var Route: boolean)
    begin
      if Log.OriginNode <> nil then
        LogMsg(Log.OriginNode.Id + ' changed entity ' + Log.EntityClass)
      else
        LogMsg('changed entity ' + Log.EntityClass);
      LogMsg(EchoLogOperations[Log.Operation] + ' sent to ' + Node.Id);
    end);

end;

procedure TdmKBClient.Push;
begin
  // Route all changes to the nodes that should receive changes
  FEcho.Route(
    procedure(Log: TEchoLog; Node: TEchoNode; var Route: boolean)
    begin
      if Log.OriginNode <> nil then
        LogMsg(Log.OriginNode.Id + ' changed entity ' + Log.EntityClass)
      else
        LogMsg('changed entity ' + Log.EntityClass);
      LogMsg(EchoLogOperations[Log.Operation] + ' sent to ' + Node.Id);
    end);

  // Send changes to server node
  FEcho.GetRemoteNode(URI_Remote_Node).Push;
end;

procedure TdmKBClient.SetupNodes;
var
  NodeManager: IEchoNodeManager;
begin
  { First thing TMS Echo requires is to define the SelfNode. Each database
    in the TMS Echo replication system is known as a "node" and must be
    identified. So if the SelfNode of this database is not defined yet, we must do it }

  // Get the NodeManager instance
  NodeManager := FEcho.GetNodeManager;

  // If SelfNode is already defined, no need to define it again
  if NodeManager.SelfNode = nil then
  begin

    // SelfNode is not defined, so let's create a Node instance with the name
    // specified by the DBName property ("client1", "client2", "server" in the case
    // of our demo application. It can be any string value, it just needs
    // to be unique among all other databases being replicated.
    NodeManager.CreateNode(DBName);

    // Now define this newly created node as the SelfNode
    NodeManager.DefineSelfNode(DBName);
  end;

  try
    // Register this node at the server, if this is a client module
    FEcho.GetRemoteNode(URI_Remote_Node).RegisterNode;
  except
    on E: Exception do
      LogMsg('Error in Setup Remote' + E.Message);
  end;
end;

procedure TdmKBClient.UpdateDBStructure;
var
  DB: TDatabaseManager;
  Conn: IDBConnection;
begin
  Conn := FEcho.Pool.GetConnection;

  // Create regular tables and fields of the application
  DB := TDatabaseManager.Create(Conn);
  try
    DB.UpdateDatabase;
  finally
    DB.Free;
  end;

  // Create tables and fields for TMS Echo usage
  DB := TDatabaseManager.Create(Conn, TEcho.Explorer);
  try
    DB.UpdateDatabase;
  finally
    DB.Free;
  end;

end;

end.
