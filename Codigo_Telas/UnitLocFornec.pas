//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-02-2001
// Ultima modifica��o: 05-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitLocFornec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EMsgDlg, fcButton, fcImgBtn, StdCtrls, Grids, DBGrids, RXDBCtrl,
  RackCtls, RXCtrls, fcLabel, LMDCustomControl, LMDCustomPanel,  DBTables, DB,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel;

type
  TFrmLocFornec = class(TForm)
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
    GridFornec: TRxDBGrid;
    EdtCampo: TEdit;
    EdtValor: TEdit;
    btnLocFornec: TfcImageBtn;
    btnSair: TfcImageBtn;
    MsgDlg: TEvMsgDlg;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdtValorExit(Sender: TObject);
    procedure CmbcampoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LEDButton1DblClick(Sender: TObject);
    procedure LEDButton2DblClick(Sender: TObject);
    procedure GridFornecGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure btnSairClick(Sender: TObject);
    procedure btnLocFornecClick(Sender: TObject);
  private
    { Private declarations }
     fresultado : longint;
        nomeCli : string;
        rest    : string;
        fcpf    : string;
        fcnpj   : string;
  public
    { Public declarations }
     Property Resultado:longint Read Fresultado Write Fresultado;
     Property Nome : string Read  NomeCli Write NomeCli;
     Property CPF : string read fcpf write fcpf;
     Property CNPJ: string read fcnpj write fcnpj;
  end;

var
  FrmLocFornec: TFrmLocFornec;
  LocOpts : TLocateOptions;
  cor,PorNome,PorCod,PorCPF,PorCNPJ : boolean;
  NomeTab, CpfTab, CnpjTab : String;
  CodTab : LongInt;
  VerTipo : Char;

implementation

uses UnitPrincipal, unitDmDados;

{$R *.dfm}

procedure TFrmLocFornec.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmLocFornec.EdtValorExit(Sender: TObject);
begin
  btnLocFornec.Default:= True;
  btnLocFornec.SetFocus;
end;

procedure TFrmLocFornec.CmbcampoExit(Sender: TObject);
begin
  PorNome:=False;
  PorCod:=False;
  PorCPF:= False;
  PorCNPJ:= False;
  if cmbCampo.Text = 'C�digo' Then
    Begin
    VerTipo:='I';
    PorCod:=True;
    edtCampo.Text:='CodFor';
    End
  Else if cmbcampo.text = 'Fornecedor' then
    Begin
    VerTipo:='K';
    PorNome:=True;
    edtCampo.Text:='Nome';
    End
  Else if cmbcampo.text = 'CPF' then
    Begin
    VerTipo:='K';
    PorCpf:=True;
    edtCampo.Text:='CPF';
    End
  Else if cmbcampo.text = 'CNPJ' then
    Begin
    VerTipo:='K';
    Porcnpj:=True;
    edtCampo.Text:='CNPJ';
    End;
end;

procedure TFrmLocFornec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    btnSair.Click;
  if Key=VK_PRIOR then
    LEDButton1DblClick(Sender);
  if Key=VK_NEXT then
    LEDButton2DblClick(Sender);
  if Key=VK_F10 then
    btnLocFornec.Click;
  end;

procedure TFrmLocFornec.FormShow(Sender: TObject);
begin
  frmPrincipal.StatusTeclas(True,'[PageUp] A=ABC [PageDown] A=a [F10] Localizar [ESC] Sai');
  Cmbcampo.ItemIndex:=0;
  Cmbcampo.SetFocus;
  EdtCampo.Text:='CodFor';
  vertipo:='I';
end;

procedure TFrmLocFornec.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmPrincipal.StatusTeclas(False,'');
end;

procedure TFrmLocFornec.LEDButton1DblClick(Sender: TObject);
begin
  if LEDButton1.StateOn then
    LEDButton1.StateOn:=False
  else
    LEDButton1.StateOn:=True;
end;

procedure TFrmLocFornec.LEDButton2DblClick(Sender: TObject);
begin
if LEDButton2.StateOn then
    LEDButton2.StateOn:=False
  else
    LEDButton2.StateOn:=True;
end;

procedure TFrmLocFornec.GridFornecGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
var
  NOME, CPF, CNPJ  : string;
  CODIGO : longInt;
begin
  NOME := (Sender as TrxDBGrid).DataSource.DataSet.FieldByName('Nome').asString;
  CODIGO :=(Sender as TrxDBGrid).DataSource.DataSet.FieldByName('CodFor').asInteger;
  CPF :=(Sender as TrxDBGrid).DataSource.DataSet.FieldByName('cpf').asString;
  CNPJ   :=(Sender as TrxDBGrid).DataSource.DataSet.FieldByName('cnpj').asString;
  if cor then
    begin
    If PorNome Then
      If NOME = NomeTab Then
        background:=$00D2E2FF;
    If PorCod Then
      If CODIGO = CodTab Then
        background:=$00D2E2FF;
    If PorCpf Then
      If CPF = cPFTab Then
        background:=$00D2E2FF;
    If PorCnpj Then
      If CNPJ = CNPJTab Then
        background:=$00D2E2FF;
    end;
end;

procedure TFrmLocFornec.btnSairClick(Sender: TObject);
begin
  resultado:=dmdados.tbfornecedorCodFor.Value;
  nome:=dmdados.tbfornecedorNome.Value;
  CPF:=dmdados.tbfornecedorCPF.value;
  CNPJ:=dmdados.tbfornecedorCNPJ.value;
  Close;
end;

procedure TFrmLocFornec.btnLocFornecClick(Sender: TObject);
begin
{verificando se dado digitado corresponde ao tipo}
  if (vertipo='I') and (StrToIntDef(edtvalor.text,-1)= -1) then
    begin
    ShowMessage('Valor digitado deve ser num�rico');
    edtvalor.SetFocus;
    abort;
    end;
  btnLocFornec.Default:= False;
  LocOpts:=[];
  if LEDButton1.StateOn then
    LocOpts:=LocOpts+[loPartialKey];
  if LEDButton2.StateOn then
    LocOpts:=LocOpts+[loCaseInsensitive];
  If not dmdados.tbfornecedor.locate(EdtCampo.Text,edtValor.text,LocOpts) Then
    begin
    ShowMessage ('N�o foi encontrado o valor ' + edtValor.text + ' para o campo '+ cmbCampo.text);
    end
  else
    Begin
    cor := true;
    If PorNome Then
      NomeTab:=dmDados.tbfornecedorNome.Value;
    If PorCod Then
      CodTab:=dmDados.tbfornecedorCodFor.Value;
    If PorCpf Then
      CpfTab:=dmDados.tbfornecedorCpf.Value;
    If PorCnpj Then
      CnpjTab:=dmDados.tbfornecedorCnpj.Value;
    End;
  Cmbcampo.SetFocus;
end;

end.
