//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-03-2001
// Ultima modifica��o: 15-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitRecebCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvTransBtn, StdCtrls, Mask, DBCtrls, Grids, DB,
  DBGrids, RXDBCtrl, JvLabel, ExtCtrls, EMsgDlg, fcLabel, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  fcButton, fcImgBtn, JvToolEdit, JvCurrEdit, JvDBCtrl, CurrEdit, ToolEdit,
  RXCtrls, LMDControl, LMDBaseControl, LMDBaseGraphicControl, LMDBaseShape,
  LMDShapeControl, BaseGrid, AdvGrid, JvPanel, JvTransparentPanel,
  JvEnterTab;

type
  TFrmRecebCli = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    MsgDlg: TEvMsgDlg;
    LMDBackPanel1: TLMDBackPanel;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    btnLocCli: TfcImageBtn;
    Panel3: TLMDBackPanel;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    btnReceb: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    dbGridReceb: TRxDBGrid;
    RxLabel13: TRxLabel;
    LMDShapeControl1: TLMDShapeControl;
    RxLabel1: TRxLabel;
    dbObs: TDBMemo;
    RxLabel4: TRxLabel;
    dbDtReceb: TDBDateEdit;
    RxLabel8: TRxLabel;
    RxLabel9: TRxLabel;
    RxLabel10: TRxLabel;
    RxLabel12: TRxLabel;
    edtCodCli: TEdit;
    dbNome: TDBEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    dbValor: TRxDBCalcEdit;
    dbDesc: TRxDBCalcEdit;
    dbJuros: TRxDBCalcEdit;
    dbVlReceb: TRxDBCalcEdit;
    JvTransparentPanel1: TJvTransparentPanel;
    procedure btnSairClick(Sender: TObject);
    procedure dbDescExit(Sender: TObject);
    procedure dbJurosExit(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnRecebClick(Sender: TObject);
    procedure btnLocCliClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxDBCalcEdit1Exit(Sender: TObject);
  private
    { Private declarations }
    fOutraJan : Boolean;
  public
    { Public declarations }
    property OutraJan : Boolean read fOutraJan write fOutraJan;
  end;

var
  FrmRecebCli : TFrmRecebCli;
  NovoItem    : Boolean     ;

implementation

uses unitDmDados, UnitTipoReceb, unitLocCliente, UnitPrincipal,
  untRecebComa, UnitTroco;

{$R *.dfm}

procedure TFrmRecebCli.btnSairClick(Sender: TObject);
begin
  if (dmdados.tbCReceber.State=dsEdit)or(dmdados.tbCReceber.State=dsInsert) then
    dmDados.tbCReceber.Cancel;
  Close;
end;

procedure TFrmRecebCli.dbDescExit(Sender: TObject);
begin
  dmDados.tbCReceberValorPago.Value:=dmDados.tbCReceberValor.Value-StrToFloat(dbDesc.Text);
end;

procedure TFrmRecebCli.dbJurosExit(Sender: TObject);
begin
  dmDados.tbCReceberValorPago.Value:=dmDados.tbCReceberValor.Value-StrToFloat(dbJuros.Text);
end;

procedure TFrmRecebCli.btnPrimeiroClick(Sender: TObject);
begin
  dmdados.tbCReceber.First;
  btnPrimeiro.Enabled:=False;
  btnAnterior.Enabled:=False;
  btnProximo.Enabled:=True;
  btnUltimo.Enabled:=True;
  dmDados.vTabStt:=True;
end;

procedure TFrmRecebCli.btnAnteriorClick(Sender: TObject);
begin
  dmdados.tbCreceber.Prior;
  btnProximo.Enabled:=True;
  btnUltimo.Enabled:=True;
  if dmdados.TbCreceber.bof then
    begin
    btnPrimeiro.Enabled:=False;
    btnAnterior.Enabled:=False;
    end;
  dmDados.vTabStt:=True;
end;

procedure TFrmRecebCli.btnProximoClick(Sender: TObject);
begin
  dmdados.tbCReceber.next;
  btnPrimeiro.Enabled:=True;
  btnAnterior.Enabled:=True;
  if dmdados.tbCReceber.Eof then
    begin
    btnProximo.Enabled:=False;
    btnUltimo.Enabled:=False;
    end;
  dmDados.vTabStt:=True;
end;

procedure TFrmRecebCli.btnUltimoClick(Sender: TObject);
begin
  dmdados.tbCReceber.Last;
  btnPrimeiro.Enabled:=True;
  btnAnterior.Enabled:=True;
  btnProximo.Enabled:=False;
  btnUltimo.Enabled:=False;
  dmDados.vTabStt:=True;
end;

procedure TFrmRecebCli.btnGravarClick(Sender: TObject);
Var
  NumDoc     : string   ;
  CodDoc     : string   ;
  CodHist    : string   ;
  CompHist   : string   ;
  CodcCusto  : string   ;
  Portador   : string   ;
  NumBanco   : string   ;
  CodCli     : integer  ;
  DataEmis   : TDateTime;
  DataVenc   : TDateTime;
  MultaDia   : TDateTime;
  DescDia    : TDateTime;
  JurosDia   : TDateTime;
  Valor      : Real     ;
  ValorMulta : Real     ;
  PercMulta  : Real     ;
  ValorDesc  : Real     ;
  PercDesc   : Real     ;
  ValorJuros : Real     ;
  PercJuros  : Real     ;
begin
  FrmTroco:=TFrmTroco.create(application);
  FrmTroco.showmodal;
  if (frmTroco.PagoStt = 'S') then
    begin
    if (frmTroco.Parcial = 'N') then
      begin
      dmDados.tbCReceberPago.Value     := 'PAGO'           ;
      dmDados.tbCReceberTipoPago.Value := 'Pagamento Total';
      dmdados.tbCReceber.Post;
      if (dmDados.tbCliente.Locate('CodCli', dmDados.tbCReceberCodCli.Value,[])) then
        begin
        dmDados.tbCliente.Edit;
        dmDados.tbClienteStatus.Value := 'L';
        dmDados.tbCliente.Post;
        end;
      end
    else
      begin
      //amazena valores do t�tulo em vari�veis
      NumDoc     := dmDados.tbCReceberNumDoc.Value                 ;
      CodDoc     := dmDados.tbCReceberCodDoc.Value                 ;
      CodCli     := dmDados.tbCReceberCodCli.Value                 ;
      DataEmis   := dmDados.tbCReceberDataEmis.Value               ;
      DataVenc   := dmDados.tbCReceberDataVenc.Value               ;
      CodHist    := dmDados.tbCReceberCodHist.Value                ;
      CompHist   := dmDados.tbCReceberCompHist.Value               ;
      Valor      := dmDados.tbCReceberValor.Value - FrmTroco.VlPago;
      MultaDia   := dmDados.tbCReceberMultaDia.Value               ;
      ValorMulta := dmDados.tbCReceberValorMulta.Value             ;
      PercMulta  := dmDados.tbCReceberPercMulta.Value              ;
      DescDia    := dmDados.tbCReceberDescDia.Value                ;
      ValorDesc  := dmDados.tbCReceberValorDesc.Value              ;
      PercDesc   := dmDados.tbCReceberPercDesc.Value               ;
      JurosDia   := dmDados.tbCReceberJurosDia.Value               ;
      ValorJuros := dmDados.tbCReceberValorJuros.Value             ;
      PercJuros  := dmDados.tbCReceberPercJuros.Value              ;
      CodCCusto  := dmDados.tbCReceberCodCCusto.Value              ;
      Portador   := dmDados.tbCReceberPortador.Value               ;
      NumBanco   := dmDados.tbCReceberNumBanco.Value               ;
      //Grava t�tulo pago
      dmDados.tbCReceberDataPaga.Value  := Date;
      dmDados.tbCReceberValorPago.Value := FrmTroco.VlPago    ;
      dmDados.tbCReceberPago.Value      := 'PAGO'             ;
      dmDados.tbCReceberTipoPago.Value  := 'Pagamento Parcial';
      dmdados.tbCReceber.Post;
      //Registra o novo t�tulo com o saldo a pagar
      dmDados.tbCReceber.Append;
      dmdados.tbCReceberPago.Value       := 'ABERTO'                   ;
      dmDados.tbCReceberCompHist.Value   := CompHist+'- Valor Residual';
      dmDados.tbCReceberNumDoc.Value     := NumDoc                     ;
      dmDados.tbCReceberCodDoc.Value     := CodDoc                     ;
      dmDados.tbCReceberCodCli.Value     := CodCli                     ;
      dmDados.tbCReceberDataEmis.Value   := DataEmis                   ;
      dmDados.tbCReceberDataVenc.Value   := DataVenc                   ;
      dmDados.tbCReceberCodHist.Value    := CodHist                    ;
      dmDados.tbCReceberValor.Value      := Valor                      ;
      dmDados.tbCReceberMultaDia.Value   := MultaDia                   ;
      dmDados.tbCReceberValorMulta.Value := ValorMulta                 ;
      dmDados.tbCReceberPercMulta.Value  := PercMulta                  ;
      dmDados.tbCReceberDescDia.Value    := DescDia                    ;
      dmDados.tbCReceberValorDesc.Value  := ValorDesc                  ;
      dmDados.tbCReceberPercDesc.Value   := PercDesc                   ;
      dmDados.tbCReceberJurosDia.Value   := JurosDia                   ;
      dmDados.tbCReceberValorJuros.Value := ValorJuros                 ;
      dmDados.tbCReceberPercJuros.Value  := PercJuros                  ;
      dmDados.tbCReceberCodCCusto.Value  := CodCCusto                  ;
      dmDados.tbCReceberPortador.Value   := Portador                   ;
      dmDados.tbCReceberNumBanco.Value   := NumBanco                   ;
      dmDados.tbCReceber.Post;
      end;
    dmdados.vTabStt:=True;
    frmTroco.Free;
    edtCodCli.Enabled   := True ;
    btnLocCli.Enabled   := True ;
    dbNome.Enabled      := True ;
    btnGravar.enabled   := False;
    BtnCancelar.Enabled := False;
    BtnPrimeiro.Enabled := True ;
    BtnAnterior.Enabled := True ;
    Btnproximo.Enabled  := True ;
    BtnUltimo.Enabled   := True ;
    btnReceb.Enabled    := True ;
    {desabilitando os objetos}
    dbDtReceb.Enabled   := False;
    dbValor.Enabled     := False;
    dbDesc.Enabled      := False;
    dbJuros.Enabled     := False;
    dbVlReceb.Enabled   := False;
    edtCodCli.SetFocus;
    end
  else
    frmTroco.Free;
end;

procedure TFrmRecebCli.btnCancelarClick(Sender: TObject);
begin
  dmdados.vTabStt:=True;
  dmdados.tbCReceber.cancel;
  BtnGravar.enabled := false;
  BtnCancelar.Enabled := false;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  Btnproximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  btnReceb.Enabled:=True;
  {desabilitando os objetos}
  edtCodCli.Enabled:=False;
  btnLocCli.Enabled:=False;
  dbNome.Enabled:=False;
  dbGridReceb.Enabled:=False;
  dbObs.Enabled:=False;
  dbValor.Enabled  := False;
  dbDtReceb.Enabled:=False;
  dbDesc.Enabled:=False;
  dbJuros.Enabled:=False;
  dbVlReceb.Enabled:=False;
  Panel3.SetFocus;
end;

procedure TFrmRecebCli.btnRecebClick(Sender: TObject);
Var
  VlAtual, Multa, Juros, Desco, VlDesc, VlMu, VlJu,PJu: Real;
  DtVen, DtDesc, DtMu, DtJu, DtPg: TDateTime;
  PDesc, Pmu : Real;
  Dias:longint;
begin
  if dmDados.tbCReceberPago.Value='PAGO' then
    MsgDlg.MsgInformation('T�tulo j� est� PAGO')
  else
    begin
    dmdados.tbCReceber.Edit;
    dmDados.vTabStt:=False;
    {habilitando os bot�es}
    BtnGravar.Enabled := True;
    BtnCancelar.Enabled:=True;
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    btnReceb.Enabled:=False;
    {habilitando os componentes}
    edtCodCli.Enabled:=False;
    btnLocCli.Enabled:=False;
    dbNome.Enabled:=False;
    dbGridReceb.Enabled:=False;
    dbObs.Enabled:=True;
    dbDtReceb.Enabled:=True;
    dbValor.Enabled  := True;
    dbDesc.Enabled:=True;
    dbJuros.Enabled:=True;
    dbVlReceb.Enabled:=True;
    Multa:= 0;
    Juros:= 0;
    Desco:=0;
    VlAtual := Dmdados.tbCReceberValor.Value;
    DtVen   := Dmdados.tbCReceberDataVenc.Value;
    DtPg    := dbDtReceb.Date;
    DtDesc  := dmdados.tbCReceberDescDia.Value;
    DtMu    := Dmdados.tbCReceberMultaDia.Value;
    DtJu    := Dmdados.tbCReceberJurosDia.Value;
    VlDesc  := Dmdados.tbCReceberValorDesc.Value;
    VlMu    := Dmdados.tbCReceberValorMulta.Value;
    VlJu    := Dmdados.tbCReceberValorJuros.Value;
    Pdesc   := Dmdados.tbCReceberPercDesc.value;
    Pmu     := Dmdados.tbCReceberPercMulta.value;
    Pju     := Dmdados.tbCReceberPercJuros.Value;
    if Dtpg < DtVen then
      if Dtpg <= DtDesc then
        if PDesc > 0 then
          Desco:=VlAtual*(PDesc/100)
        else
      	  Desco:= VlDesc;
    if Dtpg > DtVen then
      begin
      if Dtpg >= DtMu then
        if Pmu > 0 then
          Multa:= VlAtual*(Pmu/100)
        else
          Multa:= VlMu;
      if Dtpg >= DtJu then
        begin
        Dias:= trunc(Dtpg - DtVen);
        if Pju >0 then
          Juros:= (VlAtual*(Pju/100))*dias
        else
          Juros:= VlJu*dias;
        end;
      end;
    VlAtual:= VlAtual-Desco+Multa+Juros;
    dmDados.tbCReceberDescPago.Value:=Desco;
    dmDados.tbCReceberMuJuPago.Value:=Multa+Juros;
    Dmdados.tbCReceberValorPago.Value:= VlAtual;
    end;
end;

procedure TFrmRecebCli.btnLocCliClick(Sender: TObject);
begin
  frmLocCliente:=tfrmLocCliente.Create(application);
  frmLocCliente.ShowModal;
  edtCodCli.Text := IntToStr(FrmLocCliente.Resultado);
  frmloccliente.Free;
end;

procedure TFrmRecebCli.edtCodCliExit(Sender: TObject);
begin
  if edtCodCli.Text <> '' then
    begin
    if (dmDados.tbCliente.Locate('CodCli',edtCodCli.Text,[])) then
      begin
      dmDados.tbCReceber.Filtered := False;
      dmDados.tbCReceber.Filter := '(Pago = '''+'ABERTO'+''') and (CodCli = '''+
                                   edtCodCli.Text + ''' )';
      dmDados.tbCReceber.Filtered := True ;
      dmDados.tbCReceber.First;
      btnReceb.Enabled := True;
      end
    else
      begin
      MsgDlg.MsgWarning('C�DIGO DO CLIENTE n�o cadastrado!');
      edtCodCli.SetFocus;
      end;
    end
  else
    begin
    MsgDlg.MsgWarning('� obrigat�rio o C�DIGO DO CLIENTE');
    edtCodCli.SetFocus;
    end
end;

procedure TFrmRecebCli.FormActivate(Sender: TObject);
begin
  FrmPrincipal.StatusTeclas(True,'[F2] Localizar [F7] Recebimento [End] Confirmar  [Esc] Cancelar ou Sair');
  dmDados.tbCliente.Open;
  dmDados.tbCReceber.Open;
  dmDados.tbCheque.Open;
  dmDados.tbCaixa.Open;
  dmDados.tbMovCaixa.Open;
  dmDados.TbMovConta.Open;
  dmDados.TbCCorrente.Open;
  dmDados.tbBanco.Open;
  if (not dmdados.HabilitaTeclado) then
    dmdados.HabilitaTeclado := True;
  dmDados.vTabStt := True ;
  NovoItem        := False;
end;

procedure TFrmRecebCli.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.tbCReceber.Filtered := False;
  if (not OutraJan) then
    begin
    dmDados.tbCReceber.Close;
    dmDados.tbCliente.Close;
    dmDados.tbCheque.Close;
    dmDados.tbCaixa.Close;
    dmDados.tbMovCaixa.Close;
    dmDados.TbMovConta.Close;
    dmDados.TbCCorrente.Close;
    dmDados.tbBanco.Close;
    dmdados.HabilitaTeclado := False;
    Action := Cafree;
    end;
end;

procedure TFrmRecebCli.FormCreate(Sender: TObject);
begin
  OutraJan := False;
end;

procedure TFrmRecebCli.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (dmdados.HabilitaTeclado) then
    case (key) of
      // Teclas de a��o na tabela
      VK_End    : if not(dmDados.vTabStt) then BtnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
      VK_F7     : btnReceb.Click;
      VK_F2     : btnLocCli.Click;
    end;
end;

procedure TFrmRecebCli.RxDBCalcEdit1Exit(Sender: TObject);
begin
  dmDados.tbCReceberValorPago.Value:=dmDados.tbCReceberValor.Value-StrToFloat(dbJuros.Text);
end;

end.
