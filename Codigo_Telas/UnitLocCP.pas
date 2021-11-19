//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-02-2001
// Ultima modifica��o: 05-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitLocCP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EMsgDlg, fcButton, fcImgBtn, StdCtrls, Grids, DBGrids, RXDBCtrl,
  RackCtls, RXCtrls, fcLabel, LMDCustomControl, LMDCustomPanel, DB,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, BaseGrid,
  AdvGrid;

type
  TFrmLocCPagar = class(TForm)
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
    btnLocCP: TfcImageBtn;
    fclSair: TfcImageBtn;
    RxDBGrid1: TRxDBGrid;
    MsgDlg: TEvMsgDlg;
    procedure fclSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtValorExit(Sender: TObject);
    procedure CmbcampoExit(Sender: TObject);
    procedure btnLocCPClick(Sender: TObject);
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
  FrmLocCPagar: TFrmLocCPagar;
      LocOpts : TlocateOptions;
    NumDocTab : String;
          Cor : boolean;
      vertipo : char;
implementation

uses unitDmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmLocCPagar.fclSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmLocCPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmPrincipal.StatusTeclas(False,'');
  Action := caFree;
end;

procedure TFrmLocCPagar.EdtValorExit(Sender: TObject);
begin
  btnLocCP.Default:=true;
  btnLocCP.SetFocus;
end;

procedure TFrmLocCPagar.CmbcampoExit(Sender: TObject);
begin
  if cmbCampo.Text = 'Documento' then
    edtCampo.Text:='NumDoc';
end;

procedure TFrmLocCPagar.btnLocCPClick(Sender: TObject);
begin
  if (vertipo='I') and (StrToIntDef(edtvalor.text,-1)= -1) then
    begin
    MsgDlg.MsgError('Valor digitado deve ser num�rico');
    edtvalor.SetFocus;
    abort;
    end;
  btnLocCP.Default:= False;
  LocOpts:=[];
  if LEDButton1.StateOn then LocOpts:=LocOpts+[loPartialKey];
  if LEDButton2.StateOn then LocOpts:=LocOpts+[loCaseInsensitive];
  if not dmdados.tbCpagar.locate(edtCampo.Text, edtValor.text,LocOpts) then
    MsgDlg.MsgWarning('N�o foi encontrado o valor ' + edtValor.text + ' para o campo '+ cmbCampo.text)
  else
    begin
    cor := true;
    NumDocTab:=dmDados.tbCpagarNumDoc.Value;
    end;
  Cmbcampo.SetFocus;
end;

procedure TFrmLocCPagar.RxDBGrid1GetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
var
  doc : string;
begin
  doc :=(Sender as TrxDBGrid).DataSource.DataSet.FieldByName('NumDoc').asString;
  if cor then
    if doc = NumDocTab then
     background:=$00D2E2FF;
end;

procedure TFrmLocCPagar.LEDButton1DblClick(Sender: TObject);
begin
  if LEDButton1.StateOn then
    LEDButton1.StateOn:=False
  else
    LEDButton1.StateOn:=True;
end;

procedure TFrmLocCPagar.LEDButton2DblClick(Sender: TObject);
begin
  if LEDButton2.StateOn then
    LEDButton2.StateOn:=False
  else
    LEDButton2.StateOn:=True;
end;

procedure TFrmLocCPagar.FormShow(Sender: TObject);
begin
  frmPrincipal.StatusTeclas(True,'[PageUp] A=ABC [PageDown] A=a [F2] Localizar [Esc] Sai');
  cmbcampo.ItemIndex:=0;
  cmbcampo.SetFocus;
  EdtCampo.Text:='NumDoc';
  vertipo:='k';
end;

procedure TFrmLocCPagar.FormKeyDown(Sender: TObject; var Key: Word;
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
