unit KanBanEntityTypes;

interface

uses System.Classes, System.Sysutils, Aurelius.Mapping.Attributes;

type
  TKanBanItem = class;

  /// <summary>Assigned to and last mod by </summary>
  /// <remarks> /\/\ </remarks>
  /// <returns> /\/\ </returns>
  [Entity]
  [Automapping]
  TKanBanUser = class
  strict private
    FId: TGuid;
    FUserName: string;
  public
    property Id: TGuid read FId;
    property UserName: string read FUserName write FUserName;
  end;

  TKanBanItemAttachments = class
  public
    AttachedByUser: TKanBanUser;
    Item: TKanBanItem;
    CreateDate: TDateTime;
    AttachmentID: TGuid;
  end;

  /// <summary>Assigned user should be notified of a change to the item </summary>
  /// <remarks>Conflict, Assigned user has modifications, but someone one else modified it. </remarks>
  /// <returns> /\/\ </returns>
  TKanBanItemNotifications = class
  public
    ModifiedByUser: TKanBanUser;
    Item: TKanBanItem;
    CreateDate: TDateTime;
    ViewedDate: TDateTime;
  end;

  [Entity]
  [Automapping]
  TKanBanItemAuditEntry = class
  strict private
    FId: TGuid;
    FAuditDate: TDateTime;
    FItem: TKanBanItem;
  public
    // property ModifiedByUser: TKanBanUser;
    property Item: TKanBanItem read FItem write FItem;
    property AuditDate: TDateTime read FAuditDate;
    property Id: TGuid read FId;
    constructor Create;
  end;

  [Entity]
  [Automapping]
  TKanBanItemStatus = class
  strict private
    FId: TGuid;
    FStatusText: string;
  public
    property Id: TGuid read FId;
    property StatusText: string read FStatusText write FStatusText;
  end;

  [Entity]
  [Automapping]
  TKanBanItem = class
  strict private
    FId: TGuid;
    FTaskTitle: string;
    FTaskText: string;
    FTaskStatus: TKanBanItemStatus;
    FTaskPriority: integer;
    FTaskColor: cardinal;
    FAssignedUser: TKanBanUser;
  public
    property Id: TGuid read FId;
    property TaskTitle: string read FTaskTitle write FTaskTitle;
    property TaskText: string read FTaskText write FTaskText;
    property TaskStatus: TKanBanItemStatus read FTaskStatus write FTaskStatus;
    property TaskPriority: integer read FTaskPriority write FTaskPriority;
    property TaskColor: cardinal read FTaskColor write FTaskColor;
    property AssignedUser: TKanBanUser read FAssignedUser write FAssignedUser;
    // nullable?
  end;

implementation

{ TKanBanItemAuditEntry }

constructor TKanBanItemAuditEntry.Create;
begin
  FAuditDate := now;
end;

initialization

RegisterEntity(TKanBanUser);
RegisterEntity(TKanBanItemStatus);
RegisterEntity(TKanBanItem);
RegisterEntity(TKanBanItemAuditEntry);

end.
