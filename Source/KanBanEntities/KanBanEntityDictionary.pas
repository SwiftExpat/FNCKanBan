unit KanBanEntityDictionary;

interface

uses
  Aurelius.Dictionary.Classes, 
  Aurelius.Linq;

type
  TKanBanItemDictionary = class;
  TKanBanItemAuditEntryDictionary = class;
  TKanBanItemStatusDictionary = class;
  TKanBanUserDictionary = class;
  
  IKanBanItemDictionary = interface;
  
  IKanBanItemAuditEntryDictionary = interface;
  
  IKanBanItemStatusDictionary = interface;
  
  IKanBanUserDictionary = interface;
  
  IKanBanItemDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function TaskTitle: TLinqProjection;
    function TaskText: TLinqProjection;
    function TaskPriority: TLinqProjection;
    function TaskColor: TLinqProjection;
    function TaskStatus: IKanBanItemStatusDictionary;
    function AssignedUser: IKanBanUserDictionary;
  end;
  
  IKanBanItemAuditEntryDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function AuditDate: TLinqProjection;
    function Item: IKanBanItemDictionary;
  end;
  
  IKanBanItemStatusDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function StatusText: TLinqProjection;
  end;
  
  IKanBanUserDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function UserName: TLinqProjection;
  end;
  
  TKanBanItemDictionary = class(TAureliusEntityDictionary, IKanBanItemDictionary)
  public
    function Id: TLinqProjection;
    function TaskTitle: TLinqProjection;
    function TaskText: TLinqProjection;
    function TaskPriority: TLinqProjection;
    function TaskColor: TLinqProjection;
    function TaskStatus: IKanBanItemStatusDictionary;
    function AssignedUser: IKanBanUserDictionary;
  end;
  
  TKanBanItemAuditEntryDictionary = class(TAureliusEntityDictionary, IKanBanItemAuditEntryDictionary)
  public
    function Id: TLinqProjection;
    function AuditDate: TLinqProjection;
    function Item: IKanBanItemDictionary;
  end;
  
  TKanBanItemStatusDictionary = class(TAureliusEntityDictionary, IKanBanItemStatusDictionary)
  public
    function Id: TLinqProjection;
    function StatusText: TLinqProjection;
  end;
  
  TKanBanUserDictionary = class(TAureliusEntityDictionary, IKanBanUserDictionary)
  public
    function Id: TLinqProjection;
    function UserName: TLinqProjection;
  end;
  
  IDefaultDictionary = interface(IAureliusDictionary)
    function KanBanItem: IKanBanItemDictionary;
    function KanBanItemAuditEntry: IKanBanItemAuditEntryDictionary;
    function KanBanItemStatus: IKanBanItemStatusDictionary;
    function KanBanUser: IKanBanUserDictionary;
  end;
  
  TDefaultDictionary = class(TAureliusDictionary, IDefaultDictionary)
  public
    function KanBanItem: IKanBanItemDictionary;
    function KanBanItemAuditEntry: IKanBanItemAuditEntryDictionary;
    function KanBanItemStatus: IKanBanItemStatusDictionary;
    function KanBanUser: IKanBanUserDictionary;
  end;
  
function Dic: IDefaultDictionary;

implementation

var
  __Dic: IDefaultDictionary;

function Dic: IDefaultDictionary;
begin
  if __Dic = nil then __Dic := TDefaultDictionary.Create;
  result := __Dic;
end;

{ TKanBanItemDictionary }

function TKanBanItemDictionary.Id: TLinqProjection;
begin
  Result := Prop('Id');
end;

function TKanBanItemDictionary.TaskTitle: TLinqProjection;
begin
  Result := Prop('TaskTitle');
end;

function TKanBanItemDictionary.TaskText: TLinqProjection;
begin
  Result := Prop('TaskText');
end;

function TKanBanItemDictionary.TaskPriority: TLinqProjection;
begin
  Result := Prop('TaskPriority');
end;

function TKanBanItemDictionary.TaskColor: TLinqProjection;
begin
  Result := Prop('TaskColor');
end;

function TKanBanItemDictionary.TaskStatus: IKanBanItemStatusDictionary;
begin
  Result := TKanBanItemStatusDictionary.Create(PropName('TaskStatus'));
end;

function TKanBanItemDictionary.AssignedUser: IKanBanUserDictionary;
begin
  Result := TKanBanUserDictionary.Create(PropName('AssignedUser'));
end;

{ TKanBanItemAuditEntryDictionary }

function TKanBanItemAuditEntryDictionary.Id: TLinqProjection;
begin
  Result := Prop('Id');
end;

function TKanBanItemAuditEntryDictionary.AuditDate: TLinqProjection;
begin
  Result := Prop('AuditDate');
end;

function TKanBanItemAuditEntryDictionary.Item: IKanBanItemDictionary;
begin
  Result := TKanBanItemDictionary.Create(PropName('Item'));
end;

{ TKanBanItemStatusDictionary }

function TKanBanItemStatusDictionary.Id: TLinqProjection;
begin
  Result := Prop('Id');
end;

function TKanBanItemStatusDictionary.StatusText: TLinqProjection;
begin
  Result := Prop('StatusText');
end;

{ TKanBanUserDictionary }

function TKanBanUserDictionary.Id: TLinqProjection;
begin
  Result := Prop('Id');
end;

function TKanBanUserDictionary.UserName: TLinqProjection;
begin
  Result := Prop('UserName');
end;

{ TDefaultDictionary }

function TDefaultDictionary.KanBanItem: IKanBanItemDictionary;
begin
  Result := TKanBanItemDictionary.Create;
end;

function TDefaultDictionary.KanBanItemAuditEntry: IKanBanItemAuditEntryDictionary;
begin
  Result := TKanBanItemAuditEntryDictionary.Create;
end;

function TDefaultDictionary.KanBanItemStatus: IKanBanItemStatusDictionary;
begin
  Result := TKanBanItemStatusDictionary.Create;
end;

function TDefaultDictionary.KanBanUser: IKanBanUserDictionary;
begin
  Result := TKanBanUserDictionary.Create;
end;

end.
