//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-02-2001
// Ultima modifica��o: 05-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitLocCR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, EMsgDlg, fcButton, fcImgBtn, StdCtrls,
  RackCtls, RXCtrls, fcLabel, LMDCustomControl, LMDCustomPanel, DB,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, DBGrids,
  RXDBCtrl, JvComponent, JvEnterTab;

type
  TFrmLocCReceber = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel1: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    RxLabel3: TRxLabel;
    RxLabel1: TRxLabel;
    LEDButton1: TLEDButton;
    RxLabel2: TRxLabel;
    RxLabel7: TRxLabel;
    LEDButton2: TLEDButton;
    Cmbcampo: TComboBox;
    EdtCampo: TEdit;
    EdtValor: TEdit;
    btnLocCR: TfcImageBtn;
    fclSair: TfcImageBtn;
    MsgDlg: TEvMsgDlg;
    RxDBGrid1: TRxDBGrid;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure fclSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtValorExit(Sender: TObject);
    procedure CmbcampoExit(Sender: TObject);
    procedure btnLocCRClick(Sender: TObject);
    procedure RxDBGrid1GetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure LEDButton1DblClick(Sender: TObject);
    procedure LEDButton2DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLocCReceber: TFrmLocCReceber;
          LocOpts : TlocateOptions;
      NumDocTab : String;
            Cor : boolean;
         vertipo:char;
implementation

uses unitDmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmLocCReceber.fclSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmLocCReceber.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmPrincipal.StatusTeclas(False,'');
  Action := caFree;
end;

procedure TFrmLocCReceber.EdtValorExit(Sender: TObject);
begin
  btnLocCR.Default:=true;
  btnLocCR.SetFocus;
end;

procedure TFrmLocCReceber.CmbcampoExit(Sender: TObject);
begin
  if cmbCampo.Text = 'Documento' Then
    edtCampo.Text:='NumDoc';
end;

procedure TFrmLocCReceber.btnLocCRClick(Sender: TObject);
begin
  btnLocCR.Default:= False;
  LocOpts:=[];
  if LEDButton1.StateOn then
    LocOpts:=LocOpts+[loPartialKey];
  if LEDButton2.StateOn then
    LocOpts:=LocOpts+[loCaseInsensitive];
  If not dmdados.tbCReceber.locate(edtCampo.Text,edtValor.text,LocOpts) Then
    ShowMessage ('N�o foi encontrado o valor ' + edtValor.text + ' para o campo '+ cmbCampo.text)
  else
    Begin
    cor := true;
    NumDocTab:=dmDados.tbCReceberNumDoc.Value;
    End;
   Cmbcampo.SetFocus;
end;

procedure TFrmLocCReceber.RxDBGrid1GetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
var
  doc : string;
begin
  doc :=(Sender as TrxDBGrid).DataSource.DataSet.FieldByName('NumDoc').value;
  if cor then
    If doc = NumDocTab Then
      background:=$00D2E2FF;
end;

procedure TFrmLocCReceber.LEDButton1DblClick(Sender: TObject);
begin
  if LEDButton1.StateOn then
    LEDButton1.StateOn:=False
  else
    LEDButton1.StateOn:=True;
end;

procedure TFrmLocCReceber.LEDButton2DblClick(Sender: TObject);
begin
if LEDButton2.StateOn then
    LEDButton2.StateOn:=False
  else
    LEDButton2.StateOn:=True;
end;

procedure TFrmLocCReceber.FormShow(Sender: TObject);
begin
  frmPrincipal.StatusTeclas(True,'[PageUp] A=ABC [PageDown] A=a [F2] Localizar [ESC] Sai');
  cmbCampo.ItemIndex:=0;
  cmbcampo.SetFocus;
  EdtCampo.Text:='NumDoc';
end;

procedure TFrmLocCReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    fclSair.Click;
  if Key=VK_PRIOR then
    LEDButton1DblClick(Sender);
  if Key=VK_NEXT then
    LEDButton2DblClick(Sender);
end;

end.
