//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 29-04-2007
// Ultima modifica��o: 23-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitTipoReceb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RackCtls, fcButton, fcImgBtn, RXSplit, Grids,variants,
  DBGrids, Mask, DBCtrls, RXCtrls, SpeedBar, jpeg, SRColBtn, EnhEdit,
  CurrEdit, ToolEdit, db, RxLookup, ComCtrls, RxDBComb, EFocCol, EExtenso,
  RxGrdCpt, fcImager, LMDControl, LMDBaseControl, LMDBaseGraphicButton,
  LMDCustomShapeButton, LMDShapeButton, RXDBCtrl, fcLabel, JvComponent,
  JvEnterTab, JvTransBtn;

type
  TFrmTipoReceb = class(TForm)
    cbPagto: TPanel;
    Panel3: TPanel;
    btnDinheiro: TLMDShapeButton;
    btnCheque: TLMDShapeButton;
    btnCartao: TLMDShapeButton;
    PanelDinh: TPanel;
    btnDeposito: TLMDShapeButton;
    PanelCheq: TPanel;
    dbNum: TDBEdit;
    edtValor: TCurrencyEdit;
    PanelCartao: TPanel;
    vlConvenio: TCurrencyEdit;
    Panel4: TPanel;
    PanelFrente: TPanel;
    PanelDep: TPanel;
    lookCC: TRxLookupEdit;
    dbBanco: TDBEdit;
    edtVlReceb: TCurrencyEdit;
    edtVlTotal: TCurrencyEdit;
    VlPago: TCurrencyEdit;
    Troco: TCurrencyEdit;
    lkConvenio: TRxLookupEdit;
    dbNumCheq: TEdit;
    CheckPre: TCheckBox;
    dbLookBanc: TRxLookupEdit;
    dbBomPara: TDateEdit;
    dbAgencia: TEdit;
    dbNumConta: TEdit;
    fcLabel1: TfcLabel;
    RxLabel1: TRxLabel;
    RxLabel4: TRxLabel;
    RxLabel15: TRxLabel;
    RxLabel10: TRxLabel;
    RxLabel14: TRxLabel;
    RxLabel8: TRxLabel;
    RxLabel7: TRxLabel;
    RxLabel16: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel9: TRxLabel;
    RxLabel3: TRxLabel;
    RxLabel5: TRxLabel;
    RxLabel6: TRxLabel;
    RxLabel13: TRxLabel;
    RxLabel11: TRxLabel;
    RxLabel12: TRxLabel;
    JvEnterAsTab1: TJvEnterAsTab;
    btnConfirmar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    procedure SRColorButton4Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDepositoClick(Sender: TObject);
    procedure btnDinheiroClick(Sender: TObject);
    procedure btnChequeClick(Sender: TObject);
    procedure btnCartaoClick(Sender: TObject);
    procedure VlPagoExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure CheckPreClick(Sender: TObject);
    procedure RecDin;
    procedure RecCon;
  private
    { Private declarations }
    fPagoStt:char;
  public
    { Public declarations }
    Property PagoStt:char Read fPagoStt Write fPagoStt;
  end;

var
  FrmTipoReceb: TFrmTipoReceb;
  TipoPag : String;
  iPerc,Resto : real;
  ano,mes,dia : word;
  mesCusto,anoCusto,Custo : string;
implementation

uses UnitDmdados, unitCreceber, UnitPrincipal, UnitBaixaLoteCR,
  UnitRecebCli;

{$R *.DFM}

procedure TFrmTipoReceb.SRColorButton4Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmTipoReceb.btnCancelarClick(Sender: TObject);
begin
  PagoStt:='N';
  Close;
end;

procedure TFrmTipoReceb.btnDepositoClick(Sender: TObject);
begin
  PanelFrente.Visible:=False;
  PanelDinh.Visible:=False;
  PanelCheq.Visible:=False;
  PanelCartao.Visible:=False;
  PanelDep.Visible:=True;
  TipoPag:='Dep';
  edtVlReceb.Value:=FrmCReceber.dbVlReceb.Value;
  lookCC.SetFocus;
end;

procedure TFrmTipoReceb.btnDinheiroClick(Sender: TObject);
begin
  PanelFrente.Visible:=False;
  PanelDinh.Visible:=True;
  PanelCheq.Visible:=False;
  PanelCartao.Visible:=False;
  PanelDep.Visible:=False;
  TipoPag:='Din'; 
  edtVlTotal.Value:=FrmCReceber.dbVlReceb.Value;
  VlPago.SetFocus;
end;

procedure TFrmTipoReceb.btnChequeClick(Sender: TObject);
begin
  PanelFrente.Visible:=False;
  PanelDinh.Visible:=False;
  PanelCheq.Visible:=True;
  PanelCartao.Visible:=False;
  PanelDep.Visible:=False;
  TipoPag:='Che';
  edtValor.Value:=FrmCReceber.dbVlReceb.Value;
  dbLookBanc.SetFocus;
end;

procedure TFrmTipoReceb.btnCartaoClick(Sender: TObject);
begin
  PanelFrente.Visible:=False;
  PanelDinh.Visible:=False;
  PanelCheq.Visible:=False;
  PanelCartao.Visible:=True;
  PanelDep.Visible:=False;
  TipoPag:='Con';
  vlConvenio.Value:=FrmCReceber.dbVlReceb.Value;
  lkConvenio.SetFocus
end;

procedure TFrmTipoReceb.VlPagoExit(Sender: TObject);
begin
  Troco.Value:=VlPago.Value-edtVlTotal.Value;
end;

procedure TFrmTipoReceb.btnConfirmarClick(Sender: TObject);
begin
  PagoStt:='S';
  if TipoPag='Din' then
    RecDin; //pagamento padr�o
  if TipoPag='Con' then
    RecCon; //pagamento padr�o
  if TipoPag='Che' then
    begin
    //registrar o movimento de Cheque
    dmdados.tbCheque.Append;
    dmdados.tbChequeNumBanco.Value:=dbNum.Text;
    dmdados.tbChequeNomeBanco.Value:=dbLookBanc.Text;
    dmdados.tbChequeAgencia.Value:=dbAgencia.Text;
    dmdados.tbChequeCodCli.Value:=dmdados.tbCReceberCodCli.Value;
    dmdados.tbChequeConta.Value:=dbNumConta.Text;
    dmdados.tbChequeValor.Value:=FrmCReceber.dbVlReceb.Value;
    if CheckPre.Checked then
      begin
      dmdados.tbChequeVencimento.Value:=dbBomPara.Date;
      dmDados.tbChequePreDatado.Value:='S';
      end
    else
      begin
      dmdados.tbChequeVencimento.Value:=FrmCReceber.dbDtReceb.Date;
      dmDados.tbChequePreDatado.Value:='N';
      end;
    dmdados.tbChequeStatus.Value:='ABERTO';
    dmdados.tbChequeNumCheque.Value:=StrToFloat(dbNumCheq.Text);
    dmDados.tbCheque.Post;
    if Not CheckPre.Checked then
      begin
      {Lan�amento Caixa Empresa}
      dmdados.TbMovConta.Append;
      dmdados.TbMovContaDosNumero.Value:=dmdados.tbCReceberNumDoc.Value;
      dmdados.TbMovContaConta.Value:='000000000000001';
      dmdados.TbMovContaDataMov.Value:=FrmCReceber.dbDtReceb.Date;
      dmdados.tbMovContaDataReg.value:=date;
      dmdados.TbMovContaHoraReg.Value:=time;
      dmdados.TbMovContaTipoOper.Value:='E';
      dmdados.TbMovContaCodHist.Value:=dmdados.tbCReceberCodHist.Value;
      dmdados.TbMovContaCodDoc.Value:=dmdados.tbCReceberCodDoc.Value;
      dmdados.TbMovContaComplHist.Value:='Recebimento em Cheque n� '+dbNumCheq.Text;
      dmdados.TbMovContaValor.Value:=FrmCReceber.dbVlReceb.Value;
      dmdados.TbMovConta.Post;
      {Lan�amento Caixa Diario}
      if (dmDados.TbParametroFrente.Value = 'S') then
        begin
        dmdados.tbMovCaixa.Append;
        dmdados.tbMovCaixaDosNumero.Value:=dmdados.tbCReceberNumDoc.Value;
        dmdados.tbMovCaixaDataMov.Value:=FrmCReceber.dbDtReceb.Date;
        dmdados.tbMovCaixaDataReg.value:=date;
        dmdados.tbMovCaixaHoraReg.Value:=time;
        dmdados.tbMovCaixaTipoOper.Value:='E';
        dmdados.tbMovCaixaCodHist.Value:=dmdados.tbCReceberCodHist.Value;
        dmdados.tbMovCaixaCodDoc.Value:=dmdados.tbCReceberCodDoc.Value;
        dmdados.tbMovCaixaComplHist.Value:='Recebimento em Cheque n� '+dbNumCheq.Text;
        dmdados.tbMovCaixaValor.Value:=frmCReceber.dbVlReceb.Value;
        dmdados.tbMovCaixa.Post;
        {atualizar Caixa}
        dmDados.tbCaixa.Last;
        dmdados.tbCaixa.Edit;
        dmdados.tbCaixaRFiado.Value:=dmdados.tbCaixaRFiado.Value+FrmCReceber.dbVlReceb.Value;
        dmdados.tbCaixa.Post;
        end;
      {atualizar conta corrente}
      if dmdados.TbCCorrente.Locate('Conta','000000000000001',[]) then
        begin
        dmdados.TbCCorrente.Edit;
        dmdados.TbCCorrenteSaldo.Value:=dmDados.TbCCorrenteSaldo.Value+FrmCReceber.dbVlReceb.Value;
        dmdados.tbccorrenteUltMov.value:=date;
        dmdados.TbCCorrente.post;
        end;
      end;
    end;
  if TipoPag='Dep' then
    begin
    dmdados.TbMovConta.Append;
    dmdados.TbMovContaDosNumero.Value:=dmdados.tbCReceberNumDoc.Value;
    dmdados.TbMovContaConta.Value:=lookCC.Text;
    dmdados.TbMovContaDataMov.Value:=FrmCReceber.dbDtReceb.Date;
    dmdados.tbMovContaDataReg.value:=date;
    dmdados.TbMovContaHoraReg.Value:=time;
    dmdados.TbMovContaTipoOper.Value:='E';
    dmdados.TbMovContaCodHist.Value:=dmdados.tbCReceberCodHist.Value;
    dmdados.TbMovContaCodDoc.Value:=dmdados.tbCReceberCodDoc.Value;
    dmdados.TbMovContaComplHist.Value:='Recebimento por Deposito';
    dmdados.TbMovContaValor.Value:=FrmCReceber.dbVlReceb.Value;
    dmdados.TbMovConta.Post;
    {atualizar conta corrente}
    if dmdados.TbCCorrente.Locate('Conta',LookCC.Text,[]) then
      begin
      dmdados.TbCCorrente.Edit;
      dmdados.TbCCorrenteSaldo.Value:=dmDados.TbCCorrenteSaldo.Value+FrmCReceber.dbVlReceb.Value;
      dmdados.tbccorrenteUltMov.value:=date;
      dmdados.TbCCorrente.post;
      end;
    end;
  Close;
end;

procedure TFrmTipoReceb.CheckPreClick(Sender: TObject);
begin
  if CheckPre.Checked then
    dbBomPara.Enabled:=True;
end;

procedure TFrmTipoReceb.RecDin;
begin
  {Lan�amento Caixa Empresa}
  dmdados.TbMovConta.Append;
  dmdados.TbMovContaDosNumero.Value:=dmdados.tbCReceberNumDoc.Value;
  dmdados.TbMovContaConta.Value:='000000000000001';
  dmdados.TbMovContaDataMov.Value:=FrmCReceber.dbDtReceb.Date;
  dmdados.tbMovContaDataReg.value:=date;
  dmdados.TbMovContaHoraReg.Value:=time;
  dmdados.TbMovContaTipoOper.Value:='E';
  dmdados.TbMovContaCodHist.Value:=dmdados.tbCReceberCodHist.Value;
  dmdados.TbMovContaCodDoc.Value:=dmdados.tbCReceberCodDoc.Value;
  dmdados.TbMovContaComplHist.Value:=dmDados.tbCReceberCompHist.Value;
  dmdados.TbMovContaValor.Value:=FrmCReceber.dbVlReceb.Value;
  dmdados.TbMovConta.Post;
  {Lan�amento do Caixa Diario}
  if (dmDados.TbParametroFrente.Value = 'S') then
    begin
    dmdados.tbMovCaixa.Append;
    dmdados.tbMovCaixaDosNumero.Value:=dmdados.tbCReceberNumDoc.Value;
    dmdados.tbMovCaixaDataMov.Value:=FrmCReceber.dbDtReceb.Date;
    dmdados.tbMovCaixaDataReg.value:=date;
    dmdados.tbMovCaixaHoraReg.Value:=time;
    dmdados.tbMovCaixaTipoOper.Value:='E';
    dmdados.tbMovCaixaCodHist.Value:=dmdados.tbCReceberCodHist.Value;
    dmdados.tbMovCaixaCodDoc.Value:=dmdados.tbCReceberCodDoc.Value;
    dmdados.tbMovCaixaComplHist.Value:=dmDados.tbCReceberCompHist.Value;
    dmdados.tbMovCaixaValor.Value:=frmCReceber.dbVlReceb.Value;
    dmdados.tbMovCaixa.Post;
    {atualizar Caixa}
    dmDados.tbCaixa.Last;
    dmdados.tbCaixa.Edit;
    dmdados.tbCaixaRFiado.Value:=dmdados.tbCaixaRFiado.Value+FrmCReceber.dbVlReceb.Value;
    dmdados.tbCaixa.Post;
    end;
  {atualizar conta corrente}
  if dmdados.TbCCorrente.Locate('Conta','000000000000001',[]) then
    begin
    dmdados.TbCCorrente.Edit;
    dmdados.TbCCorrenteSaldo.Value:=dmDados.TbCCorrenteSaldo.Value+FrmCReceber.dbVlReceb.Value;
    dmdados.tbccorrenteUltMov.value:=date;
    dmdados.TbCCorrente.post;
    end;
end;

procedure TFrmTipoReceb.RecCon;
begin
  dmdados.TbMovConta.Append;
  dmdados.TbMovContaDosNumero.Value:=dmdados.tbCReceberNumDoc.Value;
  dmdados.TbMovContaConta.Value:='000000000000001';
  dmdados.TbMovContaDataMov.Value:=FrmCReceber.dbDtReceb.Date;
  dmdados.tbMovContaDataReg.value:=date;
  dmdados.TbMovContaHoraReg.Value:=time;
  dmdados.TbMovContaTipoOper.Value:='E';
  dmdados.TbMovContaCodHist.Value:=dmdados.tbCReceberCodHist.Value;
  dmdados.TbMovContaCodDoc.Value:=dmdados.tbCReceberCodDoc.Value;
  dmdados.TbMovContaComplHist.Value:=dmDados.tbConvenioDescricao.Value;
  dmdados.TbMovContaValor.Value:=FrmCReceber.dbVlReceb.Value;
  dmdados.TbMovConta.Post;
  {atualizar conta corrente}
  if dmdados.TbCCorrente.Locate('Conta','000000000000001',[]) then
    begin
    dmdados.TbCCorrente.Edit;
    dmdados.TbCCorrenteSaldo.Value:=dmDados.TbCCorrenteSaldo.Value+FrmCReceber.dbVlReceb.Value;
    dmdados.tbccorrenteUltMov.value:=date;
    dmdados.TbCCorrente.post;
    end;
    {Lan�amento do Caixa Diario}
  if (dmDados.TbParametroFrente.Value = 'S') then
    begin
    dmdados.tbMovCaixa.Append;
    dmdados.tbMovCaixaDosNumero.Value:=dmdados.tbCReceberNumDoc.Value;
    dmdados.tbMovCaixaDataMov.Value:=FrmCReceber.dbDtReceb.Date;
    dmdados.tbMovCaixaDataReg.value:=date;
    dmdados.tbMovCaixaHoraReg.Value:=time;
    dmdados.tbMovCaixaTipoOper.Value:='E';
    dmdados.tbMovCaixaCodHist.Value:=dmdados.tbCReceberCodHist.Value;
    dmdados.tbMovCaixaCodDoc.Value:=dmdados.tbCReceberCodDoc.Value;
    dmdados.tbMovCaixaComplHist.Value:=dmDados.tbCReceberCompHist.Value;
    dmdados.tbMovCaixaValor.Value:=frmCReceber.dbVlReceb.Value;
    dmdados.tbMovCaixa.Post;
    {atualizar Caixa}
    dmDados.tbCaixa.Last;
    dmdados.tbCaixa.Edit;
    dmdados.tbCaixaRFiado.Value:=dmdados.tbCaixaRFiado.Value+FrmCReceber.dbVlReceb.Value;
    dmdados.tbCaixa.Post;
    end;
end;

end.
