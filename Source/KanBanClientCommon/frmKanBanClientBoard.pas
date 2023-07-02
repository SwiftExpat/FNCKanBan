unit frmKanBanClientBoard;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.TMSFNCTypes, FMX.TMSFNCUtils,
  FMX.TMSFNCGraphics, FMX.TMSFNCGraphicsTypes, FMX.TMSFNCCustomControl, FMX.TMSFNCCustomScrollControl,
  FMX.TMSFNCKanbanBoard, Generics.Collections, frmKanBanBoardConfigure,
  dmKanBanClient, KanBanEntityTypes, KanBanEntityDictionary,
  Aurelius.Drivers.Interfaces, Aurelius.Engine.ObjectManager, Aurelius.Bind.Dataset, Aurelius.Bind.BaseDataset, Data.DB,
  FMX.Layouts, FMX.TMSFNCToolBar, FMX.Controls.Presentation;

type
  TfrmKanBanBoard = class(TFrame)
    KbBoard: TTMSFNCKanbanBoard;
    adsColumns: TAureliusDataset;
    lytBoard: TLayout;
    tbBoard: TTMSFNCToolBar;
    tbBtnConfigure: TTMSFNCToolBarButton;
    pnlConfigure: TPanel;
    procedure tbBtnConfigureClick(Sender: TObject);
  strict private
    FManager: TObjectManager;
    procedure InitManager;
    procedure InitDSColumns;
    procedure LoadColumns;
    procedure LoadColumn(AColumnStatus: TKanBanItemStatus);
  private
    FStatusList: TObjectList<TKanBanItemStatus>;
    FItemsList: TObjectList<TKanBanItem>;
  public
    procedure LoadBoard;
  end;

implementation

{$R *.fmx}
{ TFrame1 }

procedure TfrmKanBanBoard.InitDSColumns;
begin
  adsColumns.Close;
  adsColumns.Manager := FManager;
  FManager.Clear;
  adsColumns.SetSourceCriteria(FManager.Find<TKanBanItemStatus>);
  adsColumns.Open;
  FStatusList := FManager.Find<TKanBanItemStatus>.List;
  FItemsList := FManager.Find<TKanBanItem>.List;
end;

procedure TfrmKanBanBoard.InitManager;
begin
  if FManager = nil then
    FManager := TObjectManager.Create(dmKBClient.Echo.Pool.GetConnection);
end;

procedure TfrmKanBanBoard.LoadBoard;
begin
  pnlConfigure.Visible := false;
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
    pnlConfigure.Visible := false
  else
  begin
    pnlConfigure.Visible := true;
    pnlConfigure.BeginUpdate;
    pnlConfigure.Width := self.Width - 20;
    pnlConfigure.Height := self.Height - tbBoard.Height - 20;
    pnlConfigure.Position.X := 10;
    pnlConfigure.Position.Y := tbBoard.Height + 10;
    pnlConfigure.EndUpdate;
  end;
end;

end.
