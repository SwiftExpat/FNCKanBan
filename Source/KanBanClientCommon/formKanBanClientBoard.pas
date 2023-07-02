unit formKanBanClientBoard;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCToolBar, FMX.Controls.Presentation, FMX.StdCtrls, FMX.TMSFNCCustomControl,
  FMX.TMSFNCCustomScrollControl, FMX.TMSFNCKanbanBoard, FMX.Layouts,
  Generics.Collections, frmKanBanBoardConfigure,
  dmKanBanClient, KanBanEntityTypes, KanBanEntityDictionary,
  Aurelius.Drivers.Interfaces, Aurelius.Engine.ObjectManager;

type
  TfrmKanBanBoard = class(TForm)
    lytBoard: TLayout;
    KbBoard: TTMSFNCKanbanBoard;
    pnlConfigure: TPanel;
    tbBoard: TTMSFNCToolBar;
    tbBtnConfigure: TTMSFNCToolBarButton;
    pnlDetail: TPanel;
    TMSFNCToolBar1: TTMSFNCToolBar;
    tbBtnDetailClose: TTMSFNCToolBarButton;
    procedure KbBoardItemDblClick(Sender: TObject; AColumn: TTMSFNCKanbanBoardColumn; AItem: TTMSFNCKanbanBoardItem);
    procedure tbBtnConfigureClick(Sender: TObject);
    procedure tbBtnDetailCloseClick(Sender: TObject);
  strict private
    FManager: TObjectManager;
    procedure InitManager;
    procedure InitDSColumns;
    procedure LoadColumns;
    procedure LoadColumn(AColumnStatus: TKanBanItemStatus);
  private
    FStatusList: TObjectList<TKanBanItemStatus>;
    FItemsList: TObjectList<TKanBanItem>;
    FBoardConfig: TfrmKanBanBoardConfig;
    procedure FocusPanel(APanel: TPanel);
  public
    procedure LoadBoard;
  end;

var
  frmKanBanBoard: TfrmKanBanBoard;

implementation

{$R *.fmx}
{ TfrmKanBanBoard }

procedure TfrmKanBanBoard.FocusPanel(APanel: TPanel);
begin
  APanel.BeginUpdate;
  try
    APanel.Width := self.Width - 20;
    APanel.Height := self.Height - tbBoard.Height - 20;
    APanel.Position.X := 10;
    APanel.Position.Y := tbBoard.Height + 10;
  finally
    APanel.EndUpdate;
  end;
end;

procedure TfrmKanBanBoard.InitDSColumns;
begin
  FManager.Clear;
  FStatusList := FManager.Find<TKanBanItemStatus>.List;
  FItemsList := FManager.Find<TKanBanItem>.List;
end;

procedure TfrmKanBanBoard.InitManager;
begin
  if FManager = nil then
    FManager := TObjectManager.Create(dmKBClient.Echo.Pool.GetConnection);
end;

procedure TfrmKanBanBoard.KbBoardItemDblClick(Sender: TObject; AColumn: TTMSFNCKanbanBoardColumn;
  AItem: TTMSFNCKanbanBoardItem);
begin
  pnlDetail.Visible := true;
  // FocusPanel(pnlDetail);
end;

procedure TfrmKanBanBoard.LoadBoard;
begin
  pnlConfigure.Visible := false;
  pnlDetail.Visible := false;
  InitManager;
  InitDSColumns;
  LoadColumns;
end;

procedure TfrmKanBanBoard.LoadColumn(AColumnStatus: TKanBanItemStatus);
var
  col: TTMSFNCKanbanBoardColumn;
  itm: TTMSFNCKanbanBoardItem;
  dbItm: TKanBanItem;
begin
  col := KbBoard.Columns.Add;
  col.UseDefaultAppearance := true;
  col.HeaderText := AColumnStatus.StatusText;
  col.DataObject := AColumnStatus;
  for dbItm in FItemsList do
  begin
    if dbItm.TaskStatus.Equals(AColumnStatus) then
    begin
      itm := col.AddItem(dbItm.TaskTitle);
      itm.Text := dbItm.TaskText;
      itm.Title := dbItm.TaskTitle;
    end;
  end;
end;

procedure TfrmKanBanBoard.LoadColumns;
var
  col: TKanBanItemStatus;
begin
  KbBoard.Columns.Clear;
  KbBoard.BeginUpdate;
  try
    for col in FStatusList do
      LoadColumn(col);
  finally
    KbBoard.EndUpdate;
  end;
end;

procedure TfrmKanBanBoard.tbBtnConfigureClick(Sender: TObject);
begin
  if pnlConfigure.Visible then
  begin
    pnlConfigure.Visible := false;
    exit;
  end;
  pnlConfigure.Visible := true;
  FocusPanel(pnlConfigure);
  if FBoardConfig = nil then
    FBoardConfig := TfrmKanBanBoardConfig.Create(self);
  FBoardConfig.Manager := FManager;
  FBoardConfig.StatusList := FStatusList;
  FBoardConfig.ItemsList := FItemsList;
  FBoardConfig.LoadStatusList;
  FBoardConfig.LoadItemsList;
  if not FBoardConfig.lytBoardConfigure.Parent.Equals(pnlConfigure) then
    FBoardConfig.lytBoardConfigure.Parent := pnlConfigure;
end;

procedure TfrmKanBanBoard.tbBtnDetailCloseClick(Sender: TObject);
begin
  pnlDetail.Visible := false;
end;

end.
