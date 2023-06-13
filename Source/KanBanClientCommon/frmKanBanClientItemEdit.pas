unit frmKanBanClientItemEdit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  dmKanBanClient, KanBanEntityTypes, KanBanEntityDictionary,
  Aurelius.Drivers.Interfaces, Aurelius.Engine.ObjectManager, Aurelius.Bind.Dataset, Aurelius.Bind.BaseDataset,
  FMX.Controls.Presentation, FMX.Edit, FMX.TMSFNCEdit, FMX.Layouts, FMX.TMSFNCTypes, FMX.TMSFNCUtils,
  FMX.TMSFNCGraphics, FMX.TMSFNCGraphicsTypes, Data.DB, FMX.TMSFNCCustomControl, FMX.TMSFNCCustomPicker,
  FMX.TMSFNCComboBox, Data.Bind.Controls, Data.Bind.Components, Data.Bind.DBScope, Fmx.Bind.Navigator;

type
  TfrmKBClientItemEdit = class(TFrame)
    btnNewItem: TButton;
    Panel1: TPanel;
    GridPanelLayout1: TGridPanelLayout;
    lblTitle: TLabel;
    edtTitle: TTMSFNCEdit;
    lblDescription: TLabel;
    TMSFNCEdit2: TTMSFNCEdit;
    lblStatus: TLabel;
    TMSFNCComboBox1: TTMSFNCComboBox;
    lblUser: TLabel;
    TMSFNCComboBox2: TTMSFNCComboBox;
    adsItems: TAureliusDataset;
    btnLoad: TButton;
    BindNavigator1: TBindNavigator;
    BindSourceDB1: TBindSourceDB;
    procedure btnNewItemClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
  private
    FManager: TObjectManager;
    FPrefix : string;
    procedure InitManager;
  public
    procedure NewItem;
    procedure AssignPreFix(APrefix:string);
  end;

implementation

{$R *.fmx}
{ TfrmKBClientItemEdit }

procedure TfrmKBClientItemEdit.AssignPreFix(APrefix:string);
begin
  FPrefix:= APrefix;
end;

procedure TfrmKBClientItemEdit.btnLoadClick(Sender: TObject);
begin
  InitManager;
  adsItems.Close;
  adsItems.Manager := FManager;
  FManager.Clear;
  adsItems.SetSourceCriteria(FManager.Find<TKanBanItem>);
  adsItems.Open;
end;

procedure TfrmKBClientItemEdit.btnNewItemClick(Sender: TObject);
begin
  NewItem;
end;

procedure TfrmKBClientItemEdit.InitManager;
begin
  if FManager = nil then
    FManager := TObjectManager.Create(dmKBClient.Echo.Pool.GetConnection);

end;

procedure TfrmKBClientItemEdit.NewItem;
var
  kbi: TKanBanItem;
  s: TKanBanItemStatus;
  u: TKanBanUser;
begin
  InitManager;
  s := TKanBanItemStatus.Create;
  s.StatusText := 'New';
  FManager.Save(s);
  u := TKanBanUser.Create;
  u.UserName := FPrefix + 'usr';
  FManager.Save(u);
  kbi := TKanBanItem.Create;
  kbi.TaskTitle :=  FPrefix +'test task';
  kbi.TaskText :=  FPrefix + 'lets do some work';
  kbi.TaskStatus := s;
  kbi.AssignedUser := u;
  FManager.Save(kbi);
  FManager.Flush;
end;

end.
