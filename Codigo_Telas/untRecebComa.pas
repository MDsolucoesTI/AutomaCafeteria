//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 12-06-2007
// Ultima modifica��o: 20-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untRecebComa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RackCtls, fcButton, fcImgBtn, RXSplit, Grids,variants,
  DBGrids, Mask, DBCtrls, RXCtrls, SpeedBar, jpeg, EnhEdit,
  CurrEdit, ToolEdit, db, RxLookup, ComCtrls, RxDBComb, EFocCol, EExtenso,
  RxGrdCpt, fcImager, LMDControl, LMDBaseControl, LMDBaseGraphicButton,
  LMDCustomShapeButton, LMDShapeButton, RXDBCtrl, fcLabel, JvCheckBox,
  EGrad, JvComponent, JvTransBtn, JvPanel,
  JvTransparentPanel, JvDBSpinEdit, EMsgDlg, JvEnterTab;

type
  TfrmRecebComa = class(TForm)
    cbPagto: TPanel;
    Panel3: TPanel;
    PanelDinh: TPanel;
    PanelCheq: TPanel;
    RxLabel7: TRxLabel;
    dbNum: TDBEdit;
    RxLabel16: TRxLabel;
    RxLabel3: TRxLabel;
    RxLabel5: TRxLabel;
    RxLabel6: TRxLabel;
    RxLabel8: TRxLabel;
    edtValor: TCurrencyEdit;
    Panel4: TPanel;
    RxLabel1: TRxLabel;
    lblTroco: TRxLabel;
    edtVlTotal: TCurrencyEdit;
    edtCredito: TCurrencyEdit;
    edtTroco: TCurrencyEdit;
    dbNumCheq: TEdit;
    CheckPre: TCheckBox;
    dbLookBanc: TRxLookupEdit;
    dbBomPara: TDateEdit;
    dbAgencia: TEdit;
    RxLabel2: TRxLabel;
    dbNumConta: TEdit;
    RxLabel9: TRxLabel;
    fcLabel1: TfcLabel;
    ckDinheiro: TJvCheckBox;
    ckValeRefe: TJvCheckBox;
    ckContraVale: TJvCheckBox;
    ckVale: TJvCheckBox;
    ckCredito: TJvCheckBox;
    edtDinheiro: TCurrencyEdit;
    edtValeRefe: TCurrencyEdit;
    edtContraVale: TCurrencyEdit;
    edtVale: TCurrencyEdit;
    btnConfirmar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    JvTransparentPanel1: TJvTransparentPanel;
    PanelCont: TPanel;
    RxLabel4: TRxLabel;
    edCodCli: TDBEdit;
    dbCliente: TDBEdit;
    edtValorCli: TCurrencyEdit;
    RxLabel10: TRxLabel;
    btnDinheiro: TJvTransparentButton;
    btnCheque: TJvTransparentButton;
    btnCCliente: TJvTransparentButton;
    MsgDlg: TEvMsgDlg;
    BtnlocCli: TfcImageBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    ckValEletro: TJvCheckBox;
    edtValEletro: TCurrencyEdit;
    procedure SRColorButton4Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnChequeClick(Sender: TObject);
    procedure edtCreditoExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure CheckPreClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTickClick(Sender: TObject);
    procedure btnCClienteClick(Sender: TObject);
    procedure ckDinheiroClick(Sender: TObject);
    procedure ckValeRefeClick(Sender: TObject);
    procedure ckContraValeClick(Sender: TObject);
    procedure ckValeClick(Sender: TObject);
    procedure ckCreditoClick(Sender: TObject);
    procedure edtDinheiroExit(Sender: TObject);
    procedure edtValeRefeExit(Sender: TObject);
    procedure edtContraValeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDinheiroClick(Sender: TObject);
    procedure BtnlocCliClick(Sender: TObject);
    procedure edCodCliExit(Sender: TObject);
    procedure edtValeExit(Sender: TObject);
    procedure dbBomParaExit(Sender: TObject);
    procedure ckValEletroClick(Sender: TObject);
    procedure edtValEletroExit(Sender: TObject);
  private
    { Private declarations }
    cli          : longint  ;
    fDataVenda   : TDateTime;
    fCodigoVenda : integer  ;
    fCusto       : currency ;
    fVenda       : currency ;
  public
    { Public declarations }
    property Codcli      : longint   read cli          write cli         ;
    property DataVenda   : TDateTime read fDataVenda   write fDataVenda  ;
    property CodigoVenda : integer   read fCodigoVenda write fCodigoVenda;
    property Custo       : currency  read fCusto       write fCusto      ;
    property Venda       : currency  read fVenda       write fVenda      ;
  end;

var
  frmRecebComa : TfrmRecebComa;
  TipoPag      : String       ;
  Valor        : currency     ;

implementation

uses UnitDmdados, UnitPrincipal, UnitComanda, JvSpin, unitLocCliente;

{$R *.DFM}

procedure TfrmRecebComa.SRColorButton4Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRecebComa.btnCancelarClick(Sender: TObject);
begin
  frmComanda.Pago := False;
  MsgDlg.MsgWarning('COMANDA vai permanecer ABERTA');
  Close;
end;

procedure TfrmRecebComa.btnChequeClick(Sender: TObject);
begin
  PanelDinh.Visible := False;
  PanelCheq.Visible := True ;
  PanelCont.Visible := False;
  TipoPag := 'Che';
  dbLookBanc.SetFocus;
end;

procedure TfrmRecebComa.edtCreditoExit(Sender: TObject);
begin
  if Valor >= edtCredito.Value then
    begin
    edtTroco.Value   := Valor - edtCredito.Value    ;
    lblTroco.Caption := 'Troco'                  ;
    Valor            := edtTroco.Value           ;
    end
  else
    begin
    MsgDlg.MsgError('Valor acima do Troco|Redigitar!');
    edtCredito.SetFocus;
    end;
end;

procedure TfrmRecebComa.btnConfirmarClick(Sender: TObject);
var
  Dia      : Word     ;
  Mes      : Word     ;
  Ano      : Word     ;
  Cont     : Integer  ;
  Venc     : TDateTime;
begin
  frmComanda.Pago := True;
  dmdados.tbVendas.Last;
  CodigoVenda                   := dmdados.tbVendasCodVen.Value ;
  DataVendaAnt                  := dmdados.tbVendasDataVen.Value;
  Custo                         := 0                            ;
  dmdados.tbVendas.Append;
  dmdados.tbVendasDataVen.Value := Date                         ;
  //calcula o c�digo da venda
  if DataVendaAnt = date then
    dmdados.tbVendasCodVen.Value := CodigoVenda + 1
  else
    dmdados.tbVendasCodVen.Value := 1              ;
  CodigoVenda                   := dmdados.tbVendasCodVen.value ;
  DataVenda                     := dmdados.tbVendasDataVen.Value;
  dmdados.tbVendasHoraVen.Value := Time                         ;
  dmdados.tbVendasValor.Value   := Venda                        ;
  dmDados.tbVendasCodCli.Value  := CodCli                       ;
  dmDados.tbVendas.Post;
  for Cont:=0 to frmComanda.Componentcount-1 do
    if (frmComanda.Components[Cont] is TJvDBSpinEdit) then
        if (TJvDBSpinEdit(frmComanda.Components[Cont]).Tag <> 0) and
           (TJvDBSpinEdit(frmComanda.Components[Cont]).Value > 0) then
          begin
          dmDados.tbEstoque.RecNo:=TJvDBSpinEdit(frmComanda.Components[Cont]).Tag;
          dmdados.tbDetVendas.Append;
          dmdados.tbDetVendasCodVen.Value    := CodigoVenda                                     ;
          dmdados.tbDetVendasDataVen.Value   := DataVenda                                       ;
          dmDados.tbDetVendasCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value                  ;
          dmdados.tbDetVendasCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value              ;
          dmdados.tbDetVendasPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value               ;
          dmdados.tbDetVendasQuant.Value     := TJvDBSpinEdit(frmComanda.Components[Cont]).Value;
          dmDados.tbDetVendas.Post;
          {Atualiza o Estoque}
          if (dmDados.tbEstoqueComponente.Value = 'S') then
            begin
            dmDados.tbCompEsto.Filtered := False                                       ;
            dmDados.tbCompEsto.Filter   := '(CodEsto = '''+
                                            IntToStr(dmDados.tbEstoqueNada.Value)+''')';
            dmDados.tbCompEsto.Filtered := True                                        ;
            dmDados.tbCompEsto.First;
            while not (dmDados.tbCompEsto.Eof) do
              begin
              dmDados.tbEstoque.Locate('Nada', dmDados.tbCompEstoCodCom.Value,[]);
              dmdados.tbEstoque.edit;
              dmdados.tbEstoqueUltimaVenda.Value := DataVenda                          ;
              dmdados.tbEstoqueQuantidade.Value  := dmdados.tbEstoqueQuantidade.Value -
                                                    dmdados.tbDetVendasQuant.Value *
                                                    dmDados.tbCompEstoFator.Value      ;
              dmDados.tbEstoqueQtVenda.Value     := dmDados.tbEstoqueQtVenda.Value +
                                                    dmdados.tbDetVendasQuant.Value *
                                                    dmDados.tbCompEstoFator.Value      ;
              dmdados.tbEstoque.Post;
              dmDados.tbCompEsto.Next;
              end;
            end
          else
            begin
            dmdados.tbEstoque.edit;
            dmdados.tbEstoqueUltimaVenda.Value := DataVenda                            ;
            dmdados.tbEstoqueQuantidade.Value  := dmdados.tbEstoqueQuantidade.Value -
                                                  dmdados.tbDetVendasQuant.Value       ;
            dmDados.tbEstoqueQtVenda.Value     := dmDados.tbEstoqueQtVenda.Value +
                                                  dmdados.tbDetVendasQuant.Value       ;
            dmdados.tbEstoque.Post;
            end;
          {Calcula o Custo}
          Custo := Custo + (dmdados.tbDetVendasCustoUnit.Value * dmDados.tbDetVendasQuant.Value);
          end;
  if (dmDados.tbOutros.RecordCount > 0) then
    begin
    dmDados.tbOutros.First;
    while (not dmDados.tbOutros.Eof) do
      begin
      dmDados.tbEstoque.First;
      dmdados.tbEstoque.Locate('CodMerc',dmDados.tbOutrosCodProd.Value,[]);
      dmdados.tbDetVendas.Append;
      dmdados.tbDetVendasCodVen.Value    := CodigoVenda                                     ;
      dmdados.tbDetVendasDataVen.Value   := DataVenda                                       ;
      dmDados.tbDetVendasCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value                  ;
      dmdados.tbDetVendasCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value              ;
      dmdados.tbDetVendasPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value               ;
      dmdados.tbDetVendasQuant.Value     := dmDados.tbOutrosQuant.Value                     ;
      dmDados.tbDetVendas.Post;
      {Atualiza o Estoque}
      if (dmDados.tbEstoqueComponente.Value = 'S') then
        begin
        dmDados.tbCompEsto.Filtered := False                                       ;
        dmDados.tbCompEsto.Filter   := '(CodEsto = '''+
                                        IntToStr(dmDados.tbEstoqueNada.Value)+''')';
        dmDados.tbCompEsto.Filtered := True                                        ;
        dmDados.tbCompEsto.First;
        while not (dmDados.tbCompEsto.Eof) do
          begin
          dmDados.tbEstoque.Locate('Nada', dmDados.tbCompEstoCodCom.Value,[]);
          dmdados.tbEstoque.edit;
          dmdados.tbEstoqueUltimaVenda.Value := DataVenda                          ;
          dmdados.tbEstoqueQuantidade.Value  := dmdados.tbEstoqueQuantidade.Value -
                                                dmdados.tbDetVendasQuant.Value *
                                                dmDados.tbCompEstoFator.Value      ;
          dmDados.tbEstoqueQtVenda.Value     := dmDados.tbEstoqueQtVenda.Value +
                                                dmdados.tbDetVendasQuant.Value *
                                                dmDados.tbCompEstoFator.Value      ;
          dmdados.tbEstoque.Post;
          dmDados.tbCompEsto.Next;
          end;
        end
      else
        begin
        dmdados.tbEstoque.edit;
        dmdados.tbEstoqueUltimaVenda.Value := DataVenda                            ;
        dmdados.tbEstoqueQuantidade.Value  := dmdados.tbEstoqueQuantidade.Value -
                                              dmdados.tbDetVendasQuant.Value       ;
        dmDados.tbEstoqueQtVenda.Value     := dmDados.tbEstoqueQtVenda.Value +
                                              dmdados.tbDetVendasQuant.Value       ;
        dmdados.tbEstoque.Post;
        end;
      {Calcula o Custo}
      Custo := Custo + (dmdados.tbDetVendasCustoUnit.Value * dmDados.tbDetVendasQuant.Value);
      dmDados.tbOutros.Next;
      end;
    end;
  {liberada a venda, calcular faturamento }
  if Not(dmDados.tbFaturamento.Locate('DataVen',Date,[])) then
    dmdados.tbFaturamento.Append
  else
    dmDados.tbFaturamento.Edit;
  dmdados.tbFaturamentoDataVen.Value    := DataVenda                                    ;
  dmdados.tbFaturamentoTotalVenda.Value := dmdados.tbFaturamentoTotalVenda.Value + Venda;
  dmdados.tbFaturamentoTotalCusto.Value := dmdados.tbFaturamentoTotalCusto.Value + Custo;
  dmdados.tbFaturamento.Post;
  if (TipoPag = 'Din') then
    begin
    if (ckDinheiro.Checked) then
      begin
      dmdados.tbMovCaixa.Append;
      dmdados.tbMovCaixaDosNumero.Value   := 'Comanda n�: '+IntToStr(frmComanda.edtNumCart.Value);
      dmdados.tbMovCaixaDataMov.value     := DataVenda                                           ;
      dmdados.tbMovCaixaDataReg.value     := DataVenda                                           ;
      dmdados.TbMovCaixaHoraReg.Value     := time                                                ;
      dmdados.TbMovCaixaTipoOper.Value    := 'E'                                                 ;
      dmdados.tbMovCaixaCodDoc.Value      := '4'                                                 ;
      dmdados.TbMovCaixaComplHist.Value   := 'Vendas Diretas - Dinheiro'                         ;
      if (edtDinheiro.Value > edtVlTotal.Value) then
        dmdados.tbMovCaixaValor.Value := edtVlTotal.Value
      else
        dmdados.tbMovCaixaValor.Value := edtDinheiro.Value;
      dmdados.TbMovCaixa.Post;
      end;
    if (ckValEletro.Checked) then
      begin
      dmdados.tbMovCaixa.Append;
      dmdados.tbMovCaixaDosNumero.Value   := 'Comanda n�: '+IntToStr(frmComanda.edtNumCart.Value);
      dmdados.tbMovCaixaDataMov.value     := DataVenda                                           ;
      dmdados.tbMovCaixaDataReg.value     := DataVenda                                           ;
      dmdados.TbMovCaixaHoraReg.Value     := time                                                ;
      dmdados.TbMovCaixaTipoOper.Value    := 'E'                                                 ;
      dmdados.tbMovCaixaCodDoc.Value      := '4'                                                 ;
      dmdados.TbMovCaixaComplHist.Value   := 'Vendas Diretas - Vale Eletr�nico'                    ;
      dmdados.tbMovCaixaValor.Value       := edtValEletro.Value                                   ;
      dmdados.TbMovCaixa.Post;
      end;
    if (ckValeRefe.Checked) then
      begin
      dmdados.tbMovCaixa.Append;
      dmdados.tbMovCaixaDosNumero.Value   := 'Comanda n�: '+IntToStr(frmComanda.edtNumCart.Value);
      dmdados.tbMovCaixaDataMov.value     := DataVenda                                           ;
      dmdados.tbMovCaixaDataReg.value     := DataVenda                                           ;
      dmdados.TbMovCaixaHoraReg.Value     := time                                                ;
      dmdados.TbMovCaixaTipoOper.Value    := 'E'                                                 ;
      dmdados.tbMovCaixaCodDoc.Value      := '4'                                                 ;
      dmdados.TbMovCaixaComplHist.Value   := 'Vendas Diretas - Vale Refei��o'                    ;
      dmdados.tbMovCaixaValor.Value       := edtValeRefe.Value                                   ;
      dmdados.TbMovCaixa.Post;
      end;
    if (ckContraVale.Checked) then
      begin
      dmdados.tbMovCaixa.Append;
      dmdados.tbMovCaixaDosNumero.Value   := 'Comanda n�: '+IntToStr(frmComanda.edtNumCart.Value);
      dmdados.tbMovCaixaDataMov.value     := DataVenda                                           ;
      dmdados.tbMovCaixaDataReg.value     := DataVenda                                           ;
      dmdados.TbMovCaixaHoraReg.Value     := time                                                ;
      dmdados.TbMovCaixaTipoOper.Value    := 'E'                                                 ;
      dmdados.tbMovCaixaCodDoc.Value      := '4'                                                 ;
      dmdados.TbMovCaixaComplHist.Value   := 'Vendas Diretas - Contra Vale'                      ;
      dmdados.tbMovCaixaValor.Value       := edtContraVale.Value                                 ;
      dmdados.TbMovCaixa.Post;
      end;
    if (ckCredito.Checked) then
      begin
      dmdados.tbMovCaixa.Append;
      dmdados.tbMovCaixaDosNumero.Value   := 'Comanda n�: '+IntToStr(frmComanda.edtNumCart.Value);
      dmdados.tbMovCaixaDataMov.value     := DataVenda                                           ;
      dmdados.tbMovCaixaDataReg.value     := DataVenda                                           ;
      dmdados.TbMovCaixaHoraReg.Value     := time                                                ;
      dmdados.TbMovCaixaTipoOper.Value    := 'E'                                                 ;
      dmdados.tbMovCaixaCodDoc.Value      := '4'                                                 ;
      dmdados.TbMovCaixaComplHist.Value   := 'Cr�dito do Cliente: ' + edCodCli.Text              ;
      dmdados.tbMovCaixaValor.Value       := edtCredito.Value                                    ;
      dmDados.tbMovCaixa.Post;
      {Atualizar Conta Cliente}
      dmDados.tbContaCliente.Locate('Conta',edCodCli.Text,[]);
      dmDados.tbContaCliente.Edit;
      dmDados.tbContaClienteSaldo.Value   := dmDados.tbContaClienteSaldo.Value + edtCredito.Value;
      dmDados.tbContaClienteUltMov.Value  := DataVenda                                           ;
      dmDados.tbContaClienteHoraMov.Value := Time                                                ;
      dmDados.tbContaCliente.Post;
      end;
    if (ckVale.Checked) then
      begin
      dmdados.tbMovCaixa.Append;
      dmdados.tbMovCaixaDosNumero.Value   := 'Comanda n�: '+IntToStr(frmComanda.edtNumCart.Value);
      dmdados.tbMovCaixaDataMov.value     := DataVenda                                           ;
      dmdados.tbMovCaixaDataReg.value     := DataVenda                                           ;
      dmdados.TbMovCaixaHoraReg.Value     := time                                                ;
      dmdados.TbMovCaixaTipoOper.Value    := 'S'                                                 ;
      dmdados.tbMovCaixaCodDoc.Value      := '4'                                                 ;
      dmdados.TbMovCaixaComplHist.Value   := 'Emiss�o de Contra Vale'                            ;
      dmdados.tbMovCaixaValor.Value       := edtVale.Value                                       ;
      dmdados.TbMovCaixa.Post;
      end;
    {atualizar Caixa}
    dmdados.tbCaixa.Last;
    dmdados.tbCaixa.Edit;
    dmDados.tbCaixaRDin.Value           := dmDados.tbCaixaRDin.Value + (edtDinheiro.Value - edtTroco.Value);
    dmDados.tbCaixaRValeRefe.Value      := dmDados.tbCaixaRValeRefe.Value + edtValeRefe.Value              ;
    dmDados.tbCaixaRValEletro.Value     := dmDados.tbCaixaRValEletro.Value + edtValEletro.Value            ;
    dmDados.tbCaixaRConVale.Value       := dmDados.tbCaixaRConVale.Value + edtContraVale.Value             ;
    dmDados.tbCaixaSContra.Value        := dmDados.tbCaixaSContra.Value + edtVale.Value                    ;
    dmDados.tbCaixaSCredito.Value       := dmDados.tbCaixaSCredito.Value + edtCredito.Value                ;
    dmDados.tbCaixa.Post;
    end;
  if (TipoPag='Con') then
    begin
    {Determina a Data de Vencimento}
    DecodeDate(Now,Ano,Mes,Dia);
    Mes  := Mes + 1;
    if (Mes > 12) then
      begin
      Mes := 1      ;
      Ano := ano + 1;
      end;
    Venc := StrToDate('10/' + IntToStr(Mes) + '/' + IntToStr(Ano));
    {Atualiza Conta do Cliente}
    dmDados.tbContaCliente.Locate('Conta',edCodCli.Text,[]);
    dmDados.tbContaCliente.Edit;
    dmDados.tbContaClienteSaldo.Value   := dmDados.tbContaClienteSaldo.Value - edtValorCli.Value  ;
    dmDados.tbContaClienteUltMov.Value  := DataVenda                                              ;
    dmDados.tbContaClienteHoraMov.Value := Time                                                   ;
    dmDados.tbContaCliente.Post;
    {atualizar Caixa}
    dmdados.tbCaixa.Last;
    dmdados.tbCaixa.Edit;
    dmDados.tbCaixaRCCliente.Value      := dmDados.tbCaixaRCCliente.Value + edtVlTotal.Value      ;
    dmDados.tbCaixa.Post;
    {//Registrando no Contas Receber
    dmdados.tbCReceber.Append;
    dmdados.tbCReceberCodVen.Value      := dmDados.tbVendasCodVen.Value                           ;
    dmdados.tbCReceberCodDoc.Value      := '4'                                                    ;
    dmdados.tbCReceberNumDoc.Value      := DateToStr(Date) + '-' + dmdados.tbVendasCodVen.AsString;
    dmdados.tbCReceberCodCli.Value      := CodCli                                                 ;
    dmdados.tbCReceberDataVen.Value     := DataVenda                                              ;
    dmdados.tbCReceberDataEmis.Value    := DataVenda                                              ;
    dmdados.tbCReceberDataVenc.Value    := Venc                                                   ;
    dmdados.tbCReceberCompHist.Value    := 'Pedido realizado no dia ' + DateToStr(Date) +
                                           ' �s ' + TimeToStr(Time)                               ;
    dmdados.tbCReceberValor.Value       := Venda                                                  ;
    dmdados.tbCReceberPago.Value        :='ABERTO'                                                ;
    dmdados.tbCReceber.Post;}
    end;
  if (TipoPag='Che') then
    begin
    dmdados.tbCheque.Append;
    dmdados.tbChequeNumBanco.Value      := dbNum.Text                                          ;
    dmdados.tbChequeNomeBanco.Value     := dbLookBanc.Text                                     ;
    dmdados.tbChequeAgencia.Value       := dbAgencia.Text                                      ;
    dmdados.tbChequeCodCli.Value        := dmdados.tbCReceberCodCli.Value                      ;
    dmdados.tbChequeConta.Value         := dbNumConta.Text                                     ;
    dmdados.tbChequeValor.Value         := edtValor.Value                                      ;
    if (CheckPre.Checked) then
      begin
      dmdados.tbChequeVencimento.Value    := dbBomPara.Date                                       ;
      dmDados.tbChequePreDatado.Value     := 'S'                                                  ;
      end
    else
      begin
      dmdados.tbChequeVencimento.Value    := DataVenda                                            ;
      dmDados.tbChequePreDatado.Value     := 'N'                                                  ;
      end;
    dmdados.tbChequeStatus.Value        := 'ABERTO'                                            ;
    dmdados.tbChequeNumCheque.Value     := StrToFloat(dbNumCheq.Text)                          ;
    dmDados.tbCheque.Post;
    if (Not CheckPre.Checked) then
      begin
      dmdados.tbMovCaixa.Append;
      dmdados.tbMovCaixaDosNumero.Value   := 'Comanda n�: '+IntToStr(frmComanda.edtNumCart.Value);
      dmdados.tbMovCaixaDataMov.value     := DataVenda                                           ;
      dmdados.tbMovCaixaDataReg.value     := DataVenda                                           ;
      dmdados.TbMovCaixaHoraReg.Value     := time                                                ;
      dmdados.TbMovCaixaTipoOper.Value    := 'E'                                                 ;
      dmdados.tbMovCaixaCodDoc.Value      := '4'                                                 ;
      dmdados.TbMovCaixaComplHist.Value   := 'Vendas - Cheque n�'+dbNumCheq.Text                 ;
      dmdados.tbMovCaixaValor.Value       := edtValor.Value                                      ;
      dmDados.tbMovCaixa.Post;
      end;
    {atualizar Caixa}
    dmdados.tbCaixa.Last;
    dmdados.tbCaixa.Edit;
    dmDados.tbCaixaRCheque.Value        := dmDados.tbCaixaRCheque.Value + edtValor.Value        ;
    dmDados.tbCaixa.Post;
    end;
  Close;
end;

procedure TfrmRecebComa.CheckPreClick(Sender: TObject);
begin
  if CheckPre.Checked then
    dbBomPara.Enabled:=True;
end;

procedure TfrmRecebComa.FormShow(Sender: TObject);
begin
  if dmDados.TbMovConta.State = dsInactive then
    dmDados.TbMovConta.Open;
  if dmDados.tbMovCaixa.State = dsInactive then
    dmDados.tbMovCaixa.Open;
  if dmDados.tbCaixa.State = dsInactive then
    dmDados.tbCaixa.Open;
  if dmDados.tbContaCliente.State = dsInactive then
    dmDados.tbContaCliente.Open;
  if dmDados.TbCCorrente.State = dsInactive then
    dmDados.TbCCorrente.Open;
  if dmDados.tbBalCusto.State = dsInactive then
    dmDados.tbBalCusto.Open;
  if dmDados.tbCheque.State = dsInactive then
    dmDados.tbCheque.Open;
  if dmDados.tbCReceber.State = dsInactive then
    dmDados.tbCReceber.Open;
  edtVlTotal.Value      := frmComanda.Total;
  edtValor.Value        := frmComanda.Total;
  edtValorCli.Value     := frmComanda.Total;
  edtTroco.Value        := frmComanda.Total;
  lblTroco.Caption      := 'Falta'         ;
  TipoPag               := 'Din'           ;
  Valor                 := frmComanda.Total;
  edtCredito.Value      := 0               ;
  edtValeRefe.Value     := 0               ;
  edtDinheiro.Value     := 0               ;
  edtContraVale.Value   := 0               ;
  edtVale.Value         := 0               ;
  ckDinheiro.Checked    := False           ;
  ckValeRefe.Checked    := False           ;
  ckContraVale.Checked  := False           ;
  ckVale.Checked        := False           ;
  ckCredito.Checked     := False           ;
  edtDinheiro.Enabled   := False           ;
  edtCredito.Enabled    := False           ;
  edtValeRefe.Enabled   := False           ;
  edtContraVale.Enabled := False           ;
  edtVale.Enabled       := False           ;
  if (not dmDados.HabilitaTeclado) then
    dmDados.HabilitaTeclado := True;
end;

procedure TfrmRecebComa.btnTickClick(Sender: TObject);
begin
  PanelDinh.Visible:=False;
  PanelCheq.Visible:=False;
end;

procedure TfrmRecebComa.btnCClienteClick(Sender: TObject);
begin
  PanelDinh.Visible := False;
  PanelCheq.Visible := False;
  PanelCont.Visible := True ;
  TipoPag := 'Con';
  dmDados.tbComanda.Edit;
  edCodCli.SetFocus;
end;

procedure TfrmRecebComa.ckDinheiroClick(Sender: TObject);
begin
   if ckDinheiro.Checked then
    begin
    edtDinheiro.Enabled := True;
    edtDinheiro.SetFocus;
    end
   else
    begin
    Valor             := Valor + edtDinheiro.Value;
    edtDinheiro.Value := 0.00                     ;
    edtTroco.Value    := Valor                    ;
    lblTroco.Caption  := 'Falta'                  ;
    end;
end;

procedure TfrmRecebComa.ckValeRefeClick(Sender: TObject);
begin
  if ckValeRefe.Checked then
    begin
    edtValeRefe.Enabled := True;
    edtValeRefe.SetFocus;
    end
   else
    begin
    Valor             := Valor + edtValeRefe.Value;
    edtValeRefe.Value := 0.00                     ;
    edtTroco.Value    := Valor                    ;
    lblTroco.Caption  := 'Falta'                  ;
    end;
end;

procedure TfrmRecebComa.ckContraValeClick(Sender: TObject);
begin
  if ckContraVale.Checked then
    begin
    edtContraVale.Enabled := True;
    edtContraVale.SetFocus;
    end
   else
    begin
    Valor               := Valor + edtContraVale.Value;
    edtContraVale.Value := 0.00                       ;
    edtTroco.Value      := Valor                      ;
    lblTroco.Caption    := 'Falta'                    ;
    end;
end;

procedure TfrmRecebComa.ckValeClick(Sender: TObject);
begin
  if ckVale.Checked then
    begin
    edtVale.Enabled := True;
    edtVale.SetFocus;
    end;
end;

procedure TfrmRecebComa.ckCreditoClick(Sender: TObject);
begin
  if ckCredito.Checked then
    begin
    edtCredito.Enabled := True;
    edtCredito.SetFocus;
    end;
end;

procedure TfrmRecebComa.edtDinheiroExit(Sender: TObject);
begin
  if Valor > edtDinheiro.Value then
    begin
    edtTroco.Value   := Valor - edtDinheiro.Value;
    lblTroco.Caption := 'Falta'                  ;
    Valor            := edtTroco.Value           ;
    end
  else
    begin
    edtTroco.Value   := edtDinheiro.Value - Valor;
    lblTroco.Caption := 'Troco'                  ;
    Valor            := 0                        ;
    end;
end;

procedure TfrmRecebComa.edtValeRefeExit(Sender: TObject);
begin
  if (Valor > edtValeRefe.Value) then
    begin
    edtTroco.Value   := Valor - edtValeRefe.Value;
    lblTroco.Caption := 'Falta'                  ;
    Valor            := edtTroco.Value           ;
    end
  else
    if (Valor = edtValeRefe.Value) then
      begin
      edtTroco.Value   := edtValeRefe.Value - Valor;
      lblTroco.Caption := 'Troco'                  ;
      Valor            := edtTroco.Value           ;
      end
    else
      begin
      edtTroco.Value   := edtValeRefe.Value - Valor;
      lblTroco.Caption := 'Troco'                  ;
      Valor            := edtTroco.Value           ;
      edtVale.Value    := edtTroco.Value           ;
      ckVale.Checked   := True                     ;
      end;
end;

procedure TfrmRecebComa.edtContraValeExit(Sender: TObject);
begin
  if (Valor > edtContraVale.Value) then
    begin
    edtTroco.Value   := Valor - edtContraVale.Value;
    lblTroco.Caption := 'Falta'                    ;
    Valor            := edtTroco.Value             ;
    end
  else
    if (Valor = edtContraVale.Value) then
      begin
      edtTroco.Value   := edtContraVale.Value - Valor;
      lblTroco.Caption := 'Troco'                    ;
      Valor            := edtTroco.Value             ;
      end
    else
      begin
      edtTroco.Value   := edtContraVale.Value - Valor;
      lblTroco.Caption := 'Troco'                    ;
      Valor            := edtTroco.Value             ;
      edtVale.Value    := edtTroco.Value             ;
      ckVale.Checked   := True                       ;
      end;
end;

procedure TfrmRecebComa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case (key) of
    VK_END    : if (TipoPag = 'Din') then
                  begin
                  if (lblTroco.Caption = 'Troco') then
                    btnConfirmar.Click;
                  end
                else
                  btnConfirmar.Click;
    VK_ESCAPE : BtnCancelar.Click;
    VK_F2     : if (TipoPag = 'Con') then
                    BtnLocCli.Click;
    Ord('D')  : btnDinheiro.Click;
    Ord('C')  : btnCheque.Click;
    Ord('F')  : btnCCliente.Click;
    VK_F7     : begin
                if not(ckValEletro.Checked) then
                  begin
                  ckValEletro.Checked  := True ;
                  edtValEletro.Enabled := True ;
                  edtValEletro.SetFocus;
                  end
                else
                  begin
                  ckValEletro.Checked  := False;
                  edtValEletro.Enabled := False;
                  Panel3.SetFocus;
                  end;
                end;
    VK_F8     : begin
                if not(ckDinheiro.Checked) then
                  begin
                  ckDinheiro.Checked  := True ;
                  edtDinheiro.Enabled := True ;
                  edtDinheiro.SetFocus;
                  end
                else
                  begin
                  ckDinheiro.Checked  := False;
                  edtDinheiro.Enabled := False;
                  Panel3.SetFocus;
                  end;
                end;
    VK_F9     : begin
                if not(ckValeRefe.Checked) then
                  begin
                  ckValeRefe.Checked  := True ;
                  edtValeRefe.Enabled := True ;
                  edtValeRefe.SetFocus;
                  end
                else
                  begin
                  ckValeRefe.Checked  := False;
                  edtValeRefe.Enabled := False;
                  Panel3.SetFocus;
                  end;
                end;
    VK_F10    : begin
                if not(ckContraVale.Checked) then
                  begin
                  ckContraVale.Checked  := True ;
                  edtContraVale.Enabled := True ;
                  edtContraVale.SetFocus;
                  end
                else
                  begin
                  ckContraVale.Checked  := False;
                  edtContraVale.Enabled := False;
                  Panel3.SetFocus;
                  end;
                end;
    VK_F11    : begin
                if not(ckVale.Checked) then
                  begin
                  ckVale.Checked  := True ;
                  edtVale.Enabled := True ;
                  edtVale.SetFocus;
                  end
                else
                  begin
                  ckVale.Checked  := False;
                  edtVale.Enabled := False;
                  Panel3.SetFocus;
                  end;
                end;
    VK_F12    : begin
                if not(ckCredito.Checked) then
                  begin
                  ckCredito.Checked  := True ;
                  edtCredito.Enabled := True ;
                  edtCredito.SetFocus;
                  end
                else
                  begin
                  ckCredito.Checked  := False;
                  edtCredito.Enabled := False;
                  Panel3.SetFocus;
                  end;
                end;
  end;
end;

procedure TfrmRecebComa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRecebComa.btnDinheiroClick(Sender: TObject);
begin
  PanelDinh.Visible := True ;
  PanelCheq.Visible := False;
  PanelCont.Visible := False;
  TipoPag := 'Din';
end;

procedure TfrmRecebComa.BtnlocCliClick(Sender: TObject);
begin
  frmLocCliente := TfrmLocCliente.Create(application);
  frmLocCliente.Showmodal;
  edCodCli.Text := IntToStr(frmLocCliente.Resultado);
  frmLocCliente.Free;
end;

procedure TfrmRecebComa.edCodCliExit(Sender: TObject);
begin
  if edCodCli.Text <> '' then
    begin
    if (dmdados.tbCliente.Locate('CodCli',edcodCli.text,[])) then
      begin
      Codcli := StrToInt(edCodCli.Text);
      dmDados.tbComanda.Post;
      end
    else
      begin
      MsgDlg.MsgWarning('C�DIGO DO CLIENTE n�o cadastrado!');
      edCodCli.SetFocus;
      end;
    end
  else
    begin
    MsgDlg.MsgWarning('� obrigat�rio o C�DIGO DO CLIENTE');
    edCodCli.SetFocus;
    end
end;

procedure TfrmRecebComa.edtValeExit(Sender: TObject);
begin
  if Valor >= edtVale.Value then
    begin
    edtTroco.Value   := Valor - edtVale.Value    ;
    lblTroco.Caption := 'Troco'                  ;
    Valor            := edtTroco.Value           ;
    end
  else
    begin
    MsgDlg.MsgError('Valor acima do Troco|Redigitar!');
    edtVale.SetFocus;
    end;
end;

procedure TfrmRecebComa.dbBomParaExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TfrmRecebComa.ckValEletroClick(Sender: TObject);
begin
  if ckValEletro.Checked then
    begin
    edtValEletro.Enabled := True;
    edtValEletro.SetFocus;
    end
   else
    begin
    Valor              := Valor + edtValEletro.Value;
    edtValEletro.Value := 0.00                      ;
    edtTroco.Value     := Valor                     ;
    lblTroco.Caption   := 'Falta'                   ;
    end;
end;

procedure TfrmRecebComa.edtValEletroExit(Sender: TObject);
begin
  if (Valor > edtValEletro.Value) then
    begin
    edtTroco.Value   := Valor - edtValEletro.Value;
    lblTroco.Caption := 'Falta'                  ;
    Valor            := edtTroco.Value           ;
    end
  else
    if (Valor = edtValEletro.Value) then
      begin
      edtTroco.Value   := edtValEletro.Value - Valor;
      lblTroco.Caption := 'Troco'                  ;
      Valor            := edtTroco.Value           ;
      end
    else
      begin
      edtTroco.Value   := edtValEletro.Value - Valor;
      lblTroco.Caption := 'Troco'                  ;
      Valor            := edtTroco.Value           ;
      edtVale.Value    := edtTroco.Value           ;
      ckVale.Checked   := True                     ;
      end;
end;

end.
