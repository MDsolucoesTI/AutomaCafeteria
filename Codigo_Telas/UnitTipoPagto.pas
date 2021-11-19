///////////////////////////////////////////////////////////////////////////
// Cria��o...........: 07-05-2007
// Ultima modifica��o: 21-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitTipoPagto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fcButton, fcImgBtn, RxGrdCpt, ExtCtrls, ToolEdit, RXDBCtrl,
  StdCtrls, DBCtrls, CurrEdit, Mask, RxLookup, RXCtrls, LMDControl,
  LMDBaseControl, LMDBaseGraphicButton, LMDCustomShapeButton,
  LMDShapeButton, jpeg, fcImager, fcLabel, JvComponent, JvTransBtn,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, JvPanel, JvTransparentPanel,
  JvEnterTab;

type
  TFrmTipoPgto = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel1: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    PanelCheq: TPanel;
    edtValor: TCurrencyEdit;
    dbNum: TDBEdit;
    dbNumCheq: TEdit;
    CheckPre: TCheckBox;
    dbBomPara: TDateEdit;
    dbNumConta: TRxLookupEdit;
    dbAgencia: TDBEdit;
    PanelDinh: TPanel;
    edtVlTotal: TCurrencyEdit;
    VlPago: TCurrencyEdit;
    edtTroco: TCurrencyEdit;
    btnDinheiro: TLMDShapeButton;
    btnCheque: TLMDShapeButton;
    PanelFrente: TPanel;
    Panel3: TLMDBackPanel;
    btnConfirmar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    RxLabel1: TRxLabel;
    RxLabel4: TRxLabel;
    RxLabel10: TRxLabel;
    RxLabel11: TRxLabel;
    RxLabel8: TRxLabel;
    RxLabel12: TRxLabel;
    RxLabel13: TRxLabel;
    RxLabel14: TRxLabel;
    RxLabel15: TRxLabel;
    RxLabel17: TRxLabel;
    RxLabel18: TRxLabel;
    dbLookBanc: TDBEdit;
    JvTransparentPanel1: TJvTransparentPanel;
    JvTransparentPanel2: TJvTransparentPanel;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure btnSairClick(Sender: TObject);
    procedure btnDinheiroClick(Sender: TObject);
    procedure btnChequeClick(Sender: TObject);
    procedure VlPagoExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure CheckPreClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    fPagoStt:string;
  public
    { Public declarations }
    Property PagoStt:string Read fPagoStt Write fPagoStt;
  end;

var
  FrmTipoPgto: TFrmTipoPgto;
  TipoPag : String;

implementation

uses unitCpagar, unitdmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmTipoPgto.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmTipoPgto.btnDinheiroClick(Sender: TObject);
begin
  PanelFrente.Visible:=False;
  PanelDinh.Visible:=True;
  PanelCheq.Visible:=False;
  TipoPag:='Din';
  edtVlTotal.Value:=frmCpagar.dbVlPago.Value;
  VlPago.SetFocus;
end;

procedure TFrmTipoPgto.btnChequeClick(Sender: TObject);
begin
  PanelFrente.Visible:=False;
  PanelDinh.Visible:=False;
  PanelCheq.Visible:=True;
  TipoPag:='Che';
  edtValor.Value:=frmCpagar.dbVlPago.Value;
  dbNumConta.SetFocus;
end;

procedure TFrmTipoPgto.VlPagoExit(Sender: TObject);
begin
  edtTroco.Value:=VlPago.Value-edtVlTotal.Value;
  Panel3.SetFocus;
end;

procedure TFrmTipoPgto.btnCancelarClick(Sender: TObject);
begin
  PagoStt:='N';
  Close;
end;

procedure TFrmTipoPgto.btnConfirmarClick(Sender: TObject);
var
  ano,mes,dia : word;
  mesCusto,anoCusto,Custo : string;
begin
  PagoStt:='S';
  if TipoPag='Din' then
    begin
    dmDados.TbMovConta.Append;
    dmDados.TbMovContaDosNumero.Value := dmDados.tbCPagarNumDoc.Value  ;
    dmDados.TbMovContaConta.Value     := '000000000000001'             ;
    dmDados.TbMovContaDataMov.Value   := FrmCPagar.dbDtPgto.Date       ;
    dmDados.tbMovContaDataReg.value   := Date                          ;
    dmDados.TbMovContaHoraReg.Value   := Time                          ;
    dmDados.TbMovContaTipoOper.Value  := 'S'                           ;
    dmDados.TbMovContaCodHist.Value   := dmDados.tbCPagarCodHist.Value ;
    dmDados.TbMovContaCodDoc.Value    := dmDados.tbCPagarCodDoc.Value  ;
    dmDados.TbMovContaComplHist.Value := dmDados.tbCPagarCompHist.Value;
    dmDados.TbMovContaValor.Value     := FrmCPagar.dbVlPago.Value      ;
    dmDados.TbMovConta.Post;
    {atualizar conta corrente}
    if dmDados.TbCCorrente.Locate('Conta','000000000000001',[]) then
      begin
      dmDados.TbCCorrente.Edit;
      dmDados.TbCCorrenteSaldo.Value  := dmDados.TbCCorrenteSaldo.Value -
                                         FrmCPagar.dbVlPago.Value       ;
      dmDados.tbccorrenteUltMov.value := Date                           ;
      dmDados.TbCCorrente.post;
      end;
    {Lan�amento do Caixa Diario}
    if (dmDados.TbParametroFrente.Value = 'S') then
      begin
      dmDados.tbMovCaixa.Append;
      dmDados.tbMovCaixaDosNumero.Value := dmDados.tbCPagarNumDoc.Value  ;
      dmDados.tbMovCaixaDataMov.Value   := FrmCPagar.dbDtPgto.Date       ;
      dmDados.tbMovCaixaDataReg.value   := Date                          ;
      dmDados.tbMovCaixaHoraReg.Value   := Time                          ;
      dmDados.tbMovCaixaTipoOper.Value  := 'S'                           ;
      dmDados.tbMovCaixaCodHist.Value   := dmDados.tbCPagarCodHist.Value ;
      dmDados.tbMovCaixaCodDoc.Value    := dmDados.tbCPagarCodDoc.Value  ;
      dmDados.tbMovCaixaComplHist.Value := dmDados.tbCPagarCompHist.Value;
      dmDados.tbMovCaixaValor.Value     := FrmCPagar.dbVlPago.Value      ;
      dmDados.tbMovCaixa.Post;
      {atualizar conta corrente}
      dmDados.tbCaixa.Last;
      dmDados.tbCaixa.Edit;
      dmDados.tbCaixaPagto.Value        := dmDados.tbCaixaPagto.Value +
                                           FrmCPagar.dbVlPago.Value      ;
      dmDados.tbCaixa.Post;
      end;
    end;
  if TipoPag='Che' then
    begin
    if CheckPre.Checked then
      begin
      dmDados.tbChequePro.Append;
      dmDados.tbChequeProConta.Value      := dbNumConta.Text             ;
      dmDados.tbChequeProCodFor.Value     := dmDados.tbCPagarCodFor.Value;
      dmDados.tbChequeProValor.Value      := FrmCPagar.dbVlPago.Value    ;
      dmDados.tbChequeProVencimento.Value := dbBomPara.Date              ;
      dmDados.tbChequeProPreDatado.Value  := 'S'                         ;
      dmDados.tbChequeProStatus.Value     := 'ABERTO'                    ;
      dmDados.tbChequeProNumCheque.Value  := StrToFloat(dbNumCheq.Text)  ;
      dmDados.tbChequePro.Post;
      end;
    if Not CheckPre.Checked then
      begin
      dmDados.TbMovConta.Append;
      dmDados.TbMovContaDosNumero.Value := dmDados.tbCPagarNumDoc.Value            ;
      dmDados.TbMovContaConta.Value     := dbNumConta.Text                         ;
      dmDados.TbMovContaDataMov.Value   := FrmCPagar.dbDtPgto.Date                 ;
      dmDados.tbMovContaDataReg.value   := Date                                    ;
      dmDados.TbMovContaHoraReg.Value   := Time                                    ;
      dmDados.TbMovContaTipoOper.Value  := 'S'                                     ;
      dmDados.TbMovContaCodHist.Value   := dmDados.tbCPagarCodHist.Value           ;
      dmDados.TbMovContaCodDoc.Value    := dmDados.tbCPagarCodDoc.Value            ;
      dmDados.TbMovContaComplHist.Value := 'Pagamento em Cheque n� '+dbNumCheq.Text;
      dmDados.TbMovContaValor.Value     := FrmCPagar.dbVlPago.Value                ;
      dmDados.TbMovConta.Post;
      {atualizar conta corrente}
      if dmDados.TbCCorrente.Locate('Conta',dbNumConta.Text,[]) then
        begin
        dmDados.TbCCorrente.Edit;
        dmDados.TbCCorrenteSaldo.Value  := dmDados.TbCCorrenteSaldo.Value -
                                           FrmCPagar.dbVlPago.Value       ;
        dmDados.tbccorrenteUltMov.value := Date;
        dmDados.TbCCorrente.post;
        end;
      {Lan�amento do Caixa Diario}
      if (dmDados.TbParametroFrente.Value = 'S') then
        begin
        dmDados.tbMovCaixa.Append;
        dmDados.tbMovCaixaDosNumero.Value := dmDados.tbCPagarNumDoc.Value            ;
        dmDados.tbMovCaixaDataMov.Value   := FrmCPagar.dbDtPgto.Date                 ;
        dmDados.tbMovCaixaDataReg.value   := Date                                    ;
        dmDados.tbMovCaixaHoraReg.Value   := Time                                    ;
        dmDados.tbMovCaixaTipoOper.Value  := 'S'                                     ;
        dmDados.tbMovCaixaCodHist.Value   := dmDados.tbCPagarCodHist.Value           ;
        dmDados.tbMovCaixaCodDoc.Value    := dmDados.tbCPagarCodDoc.Value            ;
        dmDados.tbMovCaixaComplHist.Value := 'Pagamento em Cheque n� '+dbNumCheq.Text;
        dmDados.tbMovCaixaValor.Value     := FrmCPagar.dbVlPago.Value                ;
        dmDados.tbMovCaixa.Post;
        {atualizar conta corrente}
        dmDados.tbCaixa.Last;
        dmDados.tbCaixa.Edit;
        dmDados.tbCaixaPagto.Value        := dmDados.tbCaixaPagto.Value +
                                             FrmCPagar.dbVlPago.Value      ;
        dmDados.tbCaixa.Post;
        end;
      end;
    end;
  Close;
end;

procedure TFrmTipoPgto.CheckPreClick(Sender: TObject);
begin
  if CheckPre.Checked then
    dbBomPara.Enabled:=True;
end;

procedure TFrmTipoPgto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case (key) of
    VK_END    : if (TipoPag = 'Din') then
                  begin
                  if (edtTroco.Value <> edtVlTotal.Value) then
                    btnConfirmar.Click;
                  end
                else
                  btnConfirmar.Click;
    VK_ESCAPE : BtnCancelar.Click;
    Ord('D')  : btnDinheiro.Click;
    Ord('C')  : btnCheque.Click;
  end;
end;

procedure TFrmTipoPgto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmTipoPgto.FormActivate(Sender: TObject);
begin
  FrmPrincipal.StatusTeclas(True,'[End] Gravar [Esc] Cancelar ou Sair');
  dmDados.HabilitaTeclado := True;

end;

end.
