/////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-02-2001
// Ultima modifica��o: 05-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit unitLocCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CurrEdit, RXDBCtrl, ToolEdit, RXSplit, fcButton, fcImgBtn, Grids,
  DBGrids, StdCtrls, DBCtrls, Mask, ExtCtrls, RXCtrls, RackCtls, jpeg, DBTables, DB,
  EnhEdit, LMDCustomComponent, LMDCustomHint, LMDCustomShapeHint,
  LMDShapeHint, EFocCol, RxGrdCpt, fcImager, EMsgDlg, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  fcLabel, EGrad, JvLabel, JvComponent, JvEnterTab;

type
  TFrmLocCliente = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    Cmbcampo: TComboBox;
    RxDBGrid1: TRxDBGrid;
    EdtCampo: TEdit;
    EdtValor: TEdit;
    LEDButton1: TLEDButton;
    RxLabel2: TRxLabel;
    RxLabel7: TRxLabel;
    LEDButton2: TLEDButton;
    fclLocCli: TfcImageBtn;
    fclSair: TfcImageBtn;
    fcLabel1: TfcLabel;
    JvLabel13: TJvLabel;
    JvLabel1: TJvLabel;
    MsgDlg: TEvMsgDlg;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure EdtValorExit(Sender: TObject);
    procedure fclSairClick(Sender: TObject);
    procedure CmbcampoExit(Sender: TObject);
    procedure fclLocCliClick(Sender: TObject);
    procedure RxDBGrid1GetCellParams(Sender: TObject; Field: TField;
              AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LEDButton1DblClick(Sender: TObject);
    procedure LEDButton2DblClick(Sender: TObject);

  private
    { Private declarations }
     fresultado : longint;
     nomeCli    : string ;
     rest       : string ;
     fcpf       : string ;
  public
    { Public declarations }
     Property Resultado : longint Read Fresultado Write Fresultado;
     Property Nome      : string  Read NomeCli    Write NomeCli   ;
     Property Restricao : string  Read rest       Write rest      ;
     Property CPF       : string  Read fcpf       write fcpf      ;
  end;

var
  FrmLocCliente : TFrmLocCliente;
  LocOpts       : TLocateOptions;
  cor,PorNome,PorCod,PorCPF: boolean;
  NomeTab, CpfTab : String;
  CodTab : LongInt;
  VerTipo : Char;

implementation

uses UnitDmdados, UnitPrincipal;

{$R *.DFM}

procedure TFrmLocCliente.EdtValorExit(Sender: TObject);
begin
  fclLocCli.Default:= True;
  fclLocCli.SetFocus;
end;

procedure TFrmLocCliente.fclSairClick(Sender: TObject);
begin
  resultado:=dmdados.tbClienteCodCli.Value;
  nome:=dmdados.tbClienteNome.Value;
  restricao:=dmdados.tbLibCreditoRestricao.Value;
  CPF:=dmdados.tbClienteCPF.value;
  Close;
end;

procedure TFrmLocCliente.CmbcampoExit(Sender: TObject);
begin
  PorNome:=False;
  PorCod:=False;
  PorCPF:= False;
  if cmbCampo.Text = 'C�digo' Then
    Begin
    VerTipo:='I';
    PorCod:=True;
    edtCampo.Text:='CodCli';
    End
  Else if cmbcampo.text = 'Cliente' then
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
    End;
end;

procedure TFrmLocCliente.fclLocCliClick(Sender: TObject);
begin
{verificando se dado digitado corresponde ao tipo}
  if (vertipo='I') and (StrToIntDef(edtvalor.text,-1)= -1) then
    begin
    MsgDlg.MsgError('Valor digitado deve ser num�rico');
    edtvalor.SetFocus;
    abort;
    end;
  fclLocCli.Default:= False;
  LocOpts:=[];
  if LEDButton1.StateOn then
    LocOpts:=LocOpts+[loPartialKey];
  if LEDButton2.StateOn then
    LocOpts:=LocOpts+[loCaseInsensitive];
  If not dmdados.tbCliente.locate(EdtCampo.Text,edtValor.text,LocOpts) Then
    begin
    MsgDlg.MsgInformation('N�o foi encontrado o valor ' + edtValor.text + ' para o campo '+ cmbCampo.text);
    end
  else
    Begin
    cor := true;
    If PorNome Then
      NomeTab:=dmDados.tbClienteNome.Value;
    If PorCod Then
      CodTab:=dmDados.tbClienteCodCli.Value;
    If PorCpf Then
      CpfTab:=dmDados.tbClienteCpf.Value;
    end;
  Cmbcampo.SetFocus;
end;

procedure TFrmLocCliente.RxDBGrid1GetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
var
  NOME, CPF : string;
  CODIGO : longInt;
begin
  NOME := (Sender as TrxDBGrid).DataSource.DataSet.FieldByName('Nome').asString;
  CODIGO :=(Sender as TrxDBGrid).DataSource.DataSet.FieldByName('CodCli').asInteger;
  CPF :=(Sender as TrxDBGrid).DataSource.DataSet.FieldByName('cpf').asString;
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
    end;
end;

procedure TFrmLocCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    fclSair.Click;
  if Key=VK_PRIOR then
    LEDButton1DblClick(Sender);
  if Key=VK_NEXT then
    LEDButton2DblClick(Sender);
  if Key=VK_F10 then
    fclLocCli.Click;
  end;

procedure TFrmLocCliente.FormShow(Sender: TObject);
begin
  FrmPrincipal.StatusTeclas(True,'[PageUp] A=ABC [PageDown] A=a [F10] Localizar [ESC] Sai');
end;

procedure TFrmLocCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmPrincipal.StatusTeclas(False,'');
end;

procedure TFrmLocCliente.LEDButton1DblClick(Sender: TObject);
begin
  if LEDButton1.StateOn then
    LEDButton1.StateOn:=False
  else
    LEDButton1.StateOn:=True;
end;

procedure TFrmLocCliente.LEDButton2DblClick(Sender: TObject);
begin
if LEDButton2.StateOn then
    LEDButton2.StateOn:=False
  else
    LEDButton2.StateOn:=True;
end;

end.
