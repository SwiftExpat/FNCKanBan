unit frmKanBanItemDetail;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.TMSFNCTypes, FMX.TMSFNCUtils,
  FMX.TMSFNCGraphics, FMX.TMSFNCGraphicsTypes, FMX.TMSFNCCustomControl, FMX.TMSFNCCustomPicker, FMX.TMSFNCComboBox,
  FMX.Edit, FMX.TMSFNCEdit, FMX.Controls.Presentation, FMX.StdCtrls,
  Generics.Collections,
  dmKanBanClient, KanBanEntityTypes, KanBanEntityDictionary,
  Aurelius.Drivers.Interfaces, Aurelius.Engine.ObjectManager;

type
  TfrmKanbanItmDetail = class(TForm)
    Layout1: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    lblTitle: TLabel;
    edtTitle: TTMSFNCEdit;
    lblDescription: TLabel;
    edtDescription: TTMSFNCEdit;
    lblStatus: TLabel;
    cbItemStatus: TTMSFNCComboBox;
    lblUser: TLabel;
    TMSFNCComboBox2: TTMSFNCComboBox;
    procedure edtTitleChange(Sender: TObject);
    procedure edtDescriptionChange(Sender: TObject);
    procedure cbItemStatusItemSelected(Sender: TObject; AText: string; AItemIndex: Integer);
  strict private
    FStatusList: TObjectList<TKanBanItemStatus>;
    FKanBanItem: TKanBanItem;
  private
    procedure KanBanItemSet(const Value: TKanBanItem);
    procedure StatusListSet(const Value: TObjectList<TKanBanItemStatus>);
  public
    property StatusList: TObjectList<TKanBanItemStatus> read FStatusList write StatusListSet;
    property KanBanItem: TKanBanItem read FKanBanItem write KanBanItemSet;
  end;

var
  frmKanbanItmDetail: TfrmKanbanItmDetail;

implementation

{$R *.fmx}
{ TfrmKanbanItmDetail }

procedure TfrmKanbanItmDetail.cbItemStatusItemSelected(Sender: TObject; AText: string; AItemIndex: Integer);
begin
  KanBanItem.TaskStatus := TKanBanItemStatus(cbItemStatus.Items.Objects[AItemIndex]);
end;

procedure TfrmKanbanItmDetail.edtDescriptionChange(Sender: TObject);
begin
  KanBanItem.TaskText := edtDescription.Text;
end;

procedure TfrmKanbanItmDetail.edtTitleChange(Sender: TObject);
begin
  FKanBanItem.TaskTitle := edtTitle.Text;
end;

procedure TfrmKanbanItmDetail.KanBanItemSet(const Value: TKanBanItem);
var
  statusIDX: Integer;
begin
  FKanBanItem := Value;
  edtTitle.Text := KanBanItem.TaskTitle;
  edtDescription.Text := KanBanItem.TaskText;
  cbItemStatus.Items.Find(KanBanItem.TaskStatus.StatusText, statusIDX);
  cbItemStatus.ItemIndex := statusIDX;
end;

procedure TfrmKanbanItmDetail.StatusListSet(const Value: TObjectList<TKanBanItemStatus>);
var
  s: TKanBanItemStatus;
begin
  FStatusList := Value;
  cbItemStatus.Items.Clear;
  for s in StatusList do
  begin
    cbItemStatus.Items.AddObject(s.StatusText, s);
  end;

end;

end.
