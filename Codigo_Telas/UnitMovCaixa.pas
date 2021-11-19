//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-02-2001
// Ultima modifica��o: 09-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitMovCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LMDCustomComponent, LMDCustomHint, LMDCustomShapeHint,
  LMDShapeHint, StdCtrls, Grids, DBGrids, SpeedBar, jpeg, ExtCtrls,
  RackCtls, Mask, DBCtrls, RXCtrls, CurrEdit, RXDBCtrl, ToolEdit, RxDBComb,
  RxLookup, DB, DBTables, DbUtils, RxGrdCpt, RXSplit, fcButton, fcImgBtn,
  fcImager, JvComponent, JvTransBtn, fcLabel, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  EMsgDlg, JvEnterTab;

type
  TFrmMovCaixa = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    Panel3: TLMDBackPanel;
    btnSair: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnAlterar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    LMDBackPanel3: TLMDBackPanel;
    dbCod: TDBEdit;
    cmbCcorr: TRxDBLookupCombo;
    dbBanco: TDBEdit;
    cmbTipoOp: TRxDBComboBox;
    RxLabel6: TRxLabel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel3: TRxLabel;
    cmbLkHist: TRxDBLookupCombo;
    dbNumDoc: TDBEdit;
    dbValor: TRxDBCalcEdit;
    RxLabel4: TRxLabel;
    RxLabel5: TRxLabel;
    RxLabel7: TRxLabel;
    dbComplHist: TDBEdit;
    dbDataMov: TDBDateEdit;
    dbData: TDBDateEdit;
    RxLabel8: TRxLabel;
    RxLabel9: TRxLabel;
    RxLabel10: TRxLabel;
    DBGridBanco: TDBGrid;
    MsgDlg: TEvMsgDlg;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure cmbCcorrExit(Sender: TObject);
    procedure cmbTipoOpExit(Sender: TObject);
    procedure cmbLkHistExit(Sender: TObject);
    procedure dbNumDocExit(Sender: TObject);
    procedure dbValorExit(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbDataMovExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMovCaixa: TFrmMovCaixa;
  NovoItem: Boolean;

implementation

uses unitDmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmMovCaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmDados.tbBanco.Close;
  dmDados.tbHistorico.Close;
  dmDados.TbMovConta.Close;
  FrmPrincipal.StatusTeclas(False,'');
  Action := Cafree;
end;

procedure TFrmMovCaixa.BtnSairClick(Sender: TObject);
begin
  if (dmDados.TbMovConta.State=dsEdit) or (dmDados.TbMovConta.State=dsInsert) then
    dmDados.TbMovConta.Cancel;
  Close;
end;

procedure TFrmMovCaixa.cmbCcorrExit(Sender: TObject);
begin
  if NovoItem then
    if cmbCcorr.Text = '' then
      begin
      MsgDlg.MsgWarning('� obrigat�rio a CONTA CORRENTE');
      cmbCcorr.SetFocus;
      end;
end;

procedure TFrmMovCaixa.cmbTipoOpExit(Sender: TObject);
begin
  if NovoItem then
    if cmbTipoOp.Text = '' then
      begin
      MsgDlg.MsgWarning('� obrigat�rio o Tipo de Opera��o!');
      cmbTipoOp.SetFocus;
      end;
end;

procedure TFrmMovCaixa.cmbLkHistExit(Sender: TObject);
begin
  if NovoItem then
    if cmbLkHist.Text = '' then
      begin
      MsgDlg.MsgWarning('� obrigat�rio o Hist�rico');
      cmbLkHist.SetFocus;
      end;
end;

procedure TFrmMovCaixa.dbNumDocExit(Sender: TObject);
begin
  if NovoItem then
    if dbNumDoc.Text = '' then
      begin
      MsgDlg.MsgWarning('� obrigat�rio o N.� DO DOCUMENTO!');
      dbNumDoc.SetFocus;
      end;
end;

procedure TFrmMovCaixa.dbValorExit(Sender: TObject);
begin
  if NovoItem then
    if dbValor.Text = '' then
      begin
      MsgDlg.MsgWarning('� obrigat�rio o VALOR!');
      dbValor.SetFocus;
      end;
end;

procedure TFrmMovCaixa.BtnPrimeiroClick(Sender: TObject);
begin
  dmdados.TbMovConta.First;
  Btnprimeiro.Enabled :=False;
  BtnAnterior.Enabled :=False;
  BtnProximo.Enabled  :=True ;
  BtnUltimo.Enabled   :=True ;
end;

procedure TFrmMovCaixa.BtnAnteriorClick(Sender: TObject);
begin
  dmdados.TbMovConta.Prior;
  BtnProximo.Enabled := True;
  BtnUltimo.Enabled  := True;
  If dmdados.TbMovConta.bof Then
  Begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
  End;
end;

procedure TFrmMovCaixa.BtnProximoClick(Sender: TObject);
begin
  dmdados.TbMovConta.Next;
  BtnPrimeiro.Enabled := True;
  BtnAnterior.Enabled := True;
  If dmdados.TbMovConta.Eof Then
  Begin
    BtnProximo.Enabled := False;
    BtnUltimo.Enabled  := False;
  End;
end;

procedure TFrmMovCaixa.BtnUltimoClick(Sender: TObject);
begin
  dmdados.TbMovConta.Last;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  BtnProximo.Enabled  := False;
  BtnUltimo.Enabled   := False;
end;

procedure TFrmMovCaixa.BtnNovoClick(Sender: TObject);
begin
  dmdados.TbMovConta.append;
  dmdados.TbMovContaHoraReg.Value := Time;
  NovoItem            := True ;
  dmdados.vTabStt     := False;
  btnGravar.Enabled   := True ;
  BtnCancelar.Enabled := True ;
  BtnAlterar.Enabled  := False;
  BtnDeletar.Enabled  := False;
  BtnNovo.Enabled     := False;
  {Habilitando os Componentes}
  dbDataMov.Enabled   := True ;
  cmbCCorr.Enabled    := True ;
  cmbTipoOp.Enabled   := True ;
  cmbLkHist.Enabled   := True ;
  dbComplHist.Enabled := True ;
  dbNumDoc.Enabled    := True ;
  dbValor.Enabled     := True ;
  cmbCCorr.SetFocus;
end;

procedure TFrmMovCaixa.BtnCancelarClick(Sender: TObject);
begin
  dmDados.TbMovConta.Cancel;
  NovoItem            := False;
  dmdados.vTabStt     := True ;
  btnGravar.Enabled   := False;
  BtnCancelar.Enabled := False;
  BtnAlterar.Enabled  := True ;
  BtnDeletar.Enabled  := True ;
  BtnNovo.Enabled     := True ;
  //Desabilitando os componentes
  cmbCCorr.Enabled    := False;
  cmbTipoOp.Enabled   := False;
  cmbLkHist.Enabled   := False;
  dbComplHist.Enabled := False;
  dbNumDoc.Enabled    := False;
  dbValor.Enabled     := False;
  dbDataMov.Enabled   := False;
  Panel3.SetFocus;
end;

procedure TFrmMovCaixa.BtnAlterarClick(Sender: TObject);
begin
  if dmdados.TbMovConta.RecordCount = 0 then
    MsgDlg.MsgInformation('Tabela vazia')
  else
    begin
    dmDados.TbMovConta.Edit;
    NovoItem            := True ;
    dmdados.vTabStt     := False;
    {Habilitando os Bot�es}
    btnGravar.Enabled   := True ;
    BtnCancelar.Enabled := True ;
    BtnAlterar.Enabled  := False;
    BtnDeletar.Enabled  := False;
    BtnNovo.Enabled     := False;
    {Habilitando os Componentes}
    cmbCCorr.Enabled    := True ;
    cmbTipoOp.Enabled   := True ;
    cmbLkHist.Enabled   := True ;
    dbComplHist.Enabled := True ;
    dbNumDoc.Enabled    := True ;
    dbValor.Enabled     := True ;
    dbDataMov.Enabled   := True ;
    cmbCCorr.SetFocus;
    end;
end;

procedure TFrmMovCaixa.BtnDeletarClick(Sender: TObject);
begin
  if dmdados.TbMovConta.RecordCount = 0 then
    ShowMessage('Tabela vazia')
  else
    if MsgDlg.MsgConfirmation('Tem certeza que deseja exluir esse registro?') = id_yes then
      dmDados.TbMovConta.Delete
    else
      dmDados.TbMovConta.Cancel;
end;

procedure TFrmMovCaixa.btnGravarClick(Sender: TObject);
Var
  Campos : String ;
  Vazio  : Boolean;
  Gravar : Boolean;
  Flag   : Boolean;
  x      : Integer;
  Tabela : TTable ;
begin
  Campos              :=''                              ;
  Gravar              :=True                            ;
  Vazio               :=False                           ;
  Tabela              := TTable.Create(Application)     ;
  Tabela.DatabaseName := dmDados.TbMovConta.DatabaseName;
  Tabela.TableName    := dmDados.TbMovConta.TableName   ;
  Tabela.Open;
  //Campos que n�o podem estar vazios
  if dbNumDoc.Text = '' then
    begin
    if Length(Campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'Numero';
    Gravar := False          ;
    Vazio  := True           ;
    end;
  if cmbCcorr.Text = '' then
    begin
    if Length(Campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'CC';
    Gravar := False      ;
    Vazio  := True       ;
    end;
  if cmbLkHist.Text = '' then
    begin
    if Length(Campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'Historico';
    Gravar := False             ;
    Vazio  := True              ;
    end;
  //Campo Monet�rio que n�o pode estar vazio
  if dbValor.Text = '' then
    begin
    if Length(Campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'Valor';
    Gravar := False         ;
    Vazio  := True          ;
    end;
  //Campos com uso de Combo
  if cmbTipoOp.Text = '' then
    begin
    if Length(Campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'';
    Gravar := False;
    Vazio  := True;
    end
  else
    begin
    Flag:=True;
    for x:=0 to cmbTipoOp.Items.Count-1 do
      if cmbTipoOp.Text = cmbTipoOp.Items[x] then
        Flag := False;
    if Flag then
      begin
      MsgDlg.MsgError('Valor do Tipo de Opera��o inv�lido!');
      Gravar := False;
      end;
    end;
    if (dbDataMov.text <> '  /  /    ') then
      try StrToDate(dbDataMov.text)
        except on EConvertError do
        begin
          MsgDlg.MsgError('Data Inv�lida');
          Gravar := False;
        end;
      end;
  if Gravar Then
    begin
    dmDados.TbMovConta.Post;
    //Atualiza o saldo do c.corrente
    dmdados.TbCCorrente.Locate('Conta',cmbCcorr.Text,[]);
    dmdados.TbCCorrente.Edit;
    if cmbTipoOp.Text = 'E' then
      dmdados.TbCCorrenteSaldo.Value := dmdados.TbCCorrenteSaldo.Value+dbValor.Value
    else
      dmdados.TbCCorrenteSaldo.Value := dmdados.TbCCorrenteSaldo.Value-dbValor.Value;
    dmdados.TbCCorrenteUltMov.Value  := dmdados.TbMovContaDataMov.Value             ;
    dmDados.TbCCorrenteHoraMov.Value := Now                                         ;
    dmdados.TbCCorrente.Post;
    //desabilita bot�es
    NovoItem            := False;
    dmdados.vTabStt     := True ;
    BtnGravar.Enabled   := False;
    BtnCancelar.Enabled := False;
    BtnNovo.Enabled     := True ;
    BtnPrimeiro.Enabled := True ;
    BtnAnterior.Enabled := True ;
    BtnProximo.Enabled  := True ;
    BtnUltimo.Enabled   := True ;
    BtnAlterar.Enabled  := True ;
    Btndeletar.Enabled  := True ;
    {desabilitando os componentes}
    dbDataMov.Enabled   := False;
    cmbCCorr.Enabled    := False;
    cmbTipoOp.Enabled   := False;
    cmbLkHist.Enabled   := False;
    dbComplHist.Enabled := False;
    dbNumDoc.Enabled    := False;
    dbValor.Enabled     := False;
    Panel3.SetFocus;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    end
  else
    begin
    if Vazio then
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
    cmbCcorr.SetFocus;
    end;
  Tabela.Free;
end;

procedure TFrmMovCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_Insert : if (dmDados.vTabStt) then BtnNovo.Click;
      VK_Home   : if (dmDados.vTabStt) then BtnAlterar.Click;
      VK_Delete : if (dmDados.vTabStt) then BtnDeletar.Click;
      VK_End    : if not(dmDados.vTabStt) then btnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
    end;
end;

procedure TFrmMovCaixa.dbDataMovExit(Sender: TObject);
begin
  if (dbDataMov.text <> '  /  /    ') then
    try StrToDate(dbDataMov.text)
      except on EConvertError do
        begin
        MsgDlg.MsgWarning('Data Inv�lida');
        dbDataMov.SetFocus;
        end;
    end;
  Panel3.SetFocus;
end;

procedure TFrmMovCaixa.FormActivate(Sender: TObject);
begin
  dmDados.TbMovConta.Open;
  dmDados.tbHistorico.Open;
  dmDados.tbBanco.Open;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [Esc] Cancelar ou Sair');
  if dmdados.TbMovConta.RecordCount = 0 then
    begin
    Btnprimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    BtnProximo.Enabled  := False;
    BtnUltimo.Enabled   := False;
    btnGravar.Enabled   := False;
    btnAlterar.Enabled  := False;
    btnCancelar.Enabled := False;
    btnDeletar.Enabled  := False;
    end;
end;

end.
