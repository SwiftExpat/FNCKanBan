unit frmKanBanBoardConfigure;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCPageControl, FMX.TMSFNCCustomControl, FMX.TMSFNCTabSet, FMX.Layouts,
  FMX.TMSFNCListBox, FMX.TMSFNCTableView,
  Generics.Collections, frmKanBanItemDetail,
  dmKanBanClient, KanBanEntityTypes, KanBanEntityDictionary,
  Aurelius.Drivers.Interfaces, Aurelius.Engine.ObjectManager, Aurelius.Bind.Dataset, Aurelius.Bind.BaseDataset,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.TMSFNCEdit;

type
  TfrmKanBanBoardConfig = class(TForm)
    pcBoardConfigure: TTMSFNCPageControl;
    TMSFNCPageControl1Page0: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page1: TTMSFNCPageControlContainer;
    TMSFNCPageControl1Page2: TTMSFNCPageControlContainer;
    lytBoardConfigure: TLayout;
    tvItems: TTMSFNCTableView;
    lbStatus: TTMSFNCListBox;
    btnStatusDelete: TButton;
    pnlItemDetail: TPanel;
    edtStatusDisplay: TTMSFNCEdit;
    btnItemDelete: TButton;
    btnItemAdd: TButton;
    procedure btnStatusDeleteClick(Sender: TObject);
    procedure tvItemsBeforeItemShowDetailControl(Sender: TObject; AItem: TTMSFNCTableViewItem; ADetailControl: TControl;
      var AAllow: Boolean);
    procedure lbStatusItemSelected(Sender: TObject; AItem: TTMSFNCListBoxItem);
    procedure edtStatusDisplayChange(Sender: TObject);
    procedure btnItemAddClick(Sender: TObject);
    procedure btnItemDeleteClick(Sender: TObject);
    procedure tvItemsItemHideDetailControl(Sender: TObject; AItem: TTMSFNCTableViewItem; ADetailControl: TControl);
  strict private
    FManager: TObjectManager;
    FStatusList: TObjectList<TKanBanItemStatus>;
    FItemsList: TObjectList<TKanBanItem>;
    FItemDetail: TfrmKanbanItmDetail;
    function DefaultStatus: TKanBanItemStatus;
  public
    property Manager: TObjectManager read FManager write FManager;
    property StatusList: TObjectList<TKanBanItemStatus> read FStatusList write FStatusList;
    property ItemsList: TObjectList<TKanBanItem> read FItemsList write FItemsList;
    procedure LoadStatusList;
    procedure LoadItemsList;
  end;

var
  frmKanBanBoardConfig: TfrmKanBanBoardConfig;

implementation

{$R *.fmx}
{ TfrmKanBanBoardConfig }

procedure TfrmKanBanBoardConfig.btnItemAddClick(Sender: TObject);
var
  kbi: TKanBanItem;
  tvi: TTMSFNCTableViewItem;
begin
  kbi := TKanBanItem.Create;
  kbi.TaskTitle := 'New Task';
  kbi.TaskStatus := DefaultStatus;
  ItemsList.Add(kbi);
  FManager.Save(kbi);
  tvi := tvItems.AddItem(kbi.TaskTitle);
  tvi.DataObject := kbi;
  tvItems.SelectItem(tvi.Index);
end;

procedure TfrmKanBanBoardConfig.btnItemDeleteClick(Sender: TObject);
var
  kbi: TKanBanItem;
  tvi: TTMSFNCTableViewItem;
begin
  tvi := tvItems.SelectedItem;
  if (tvi.DataObject <> nil) and (tvi.DataObject is TKanBanItem) then
  begin
    kbi := TKanBanItem(tvi.DataObject);
    FManager.Remove(kbi);
    FItemsList.RemoveItem(kbi, TDirection.FromBeginning);
    kbi.Free; // need to remove from the object list as well, or nil is in the list.
    tvItems.RemoveItem(tvi);
  end;

end;

procedure TfrmKanBanBoardConfig.btnStatusDeleteClick(Sender: TObject);
var
  s: TKanBanItemStatus;
  lbi: TTMSFNCListBoxItem;
begin
  lbi := lbStatus.SelectedItem;
  if (lbi <> nil) and (lbi.DataObject <> nil) then
  begin
    if lbi.DataObject is TKanBanItemStatus then
    begin
      s := TKanBanItemStatus(lbi.DataObject);
      FManager.Remove(s);
      FStatusList.RemoveItem(s, TDirection.FromBeginning);
      s.Free; // need to remove from the object list as well, or nil is in the list.
      lbStatus.RemoveItem(lbi);
    end;
  end;
end;

function TfrmKanBanBoardConfig.DefaultStatus: TKanBanItemStatus;
var
  lbi: TTMSFNCListBoxItem;
begin
  lbi := lbStatus.Items[0];
  result := TKanBanItemStatus(lbi.DataObject);
end;

procedure TfrmKanBanBoardConfig.edtStatusDisplayChange(Sender: TObject);
var
  s: TKanBanItemStatus;
begin
  s := TKanBanItemStatus(lbStatus.SelectedItem.DataObject);
  s.StatusText := edtStatusDisplay.Text;
  FManager.Update(s);
  FManager.Flush;
  lbStatus.SelectedItem.Text := s.StatusText;
end;

procedure TfrmKanBanBoardConfig.lbStatusItemSelected(Sender: TObject; AItem: TTMSFNCListBoxItem);
begin
  edtStatusDisplay.Text := TKanBanItemStatus(AItem.DataObject).StatusText;
end;

procedure TfrmKanBanBoardConfig.LoadItemsList;
var
  itm: TKanBanItem;
  tvi: TTMSFNCTableViewItem;
begin
  tvItems.Items.Clear;
  tvItems.BeginUpdate;
  try
    for itm in ItemsList do
    begin
      tvi := tvItems.AddItem(itm.TaskTitle);
      tvi.DataObject := itm;
    end;
  finally
    tvItems.EndUpdate;
  end;
end;

procedure TfrmKanBanBoardConfig.LoadStatusList;
var
  s: TKanBanItemStatus;
  lbi: TTMSFNCListBoxItem;
begin
  lbStatus.Items.Clear;
  lbStatus.BeginUpdate;

  try
    for s in StatusList do
    begin
      lbi := lbStatus.AddItem(s.StatusText);
      lbi.DataObject := s;
    end;
  finally
    lbStatus.EndUpdate;
  end;

end;

procedure TfrmKanBanBoardConfig.tvItemsBeforeItemShowDetailControl(Sender: TObject; AItem: TTMSFNCTableViewItem;
  ADetailControl: TControl; var AAllow: Boolean);
begin
  if FItemDetail = nil then
  begin
    FItemDetail := TfrmKanbanItmDetail.Create(self);
    FItemDetail.StatusList := FStatusList;
  end;
  FItemDetail.KanBanItem := TKanBanItem(AItem.DataObject);
  FItemDetail.Layout1.Parent := pnlItemDetail;
end;

procedure TfrmKanBanBoardConfig.tvItemsItemHideDetailControl(Sender: TObject; AItem: TTMSFNCTableViewItem;
  ADetailControl: TControl);
var
  kbi: TKanBanItem;
begin
  kbi := TKanBanItem(AItem.DataObject);
  FManager.Update(kbi);
  AItem.Text := Kbi.TaskTitle;
end;

end.
