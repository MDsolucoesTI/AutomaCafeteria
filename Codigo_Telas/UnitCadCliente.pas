//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 13-01-2001
// Ultima modifica��o: 26-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatSplitterUnit, ToolEdit, RXDBCtrl, DBCtrls, EDBZero,
  StdCtrls, RxDBComb, Mask, RxGrdCpt, fcButton, fcImgBtn, VerCNPJ, VerCPF,
  RXCtrls, ExtCtrls, DbTables, DB, ShellApi, jpeg, fcImager, EMsgDlg,
  EUserAcs, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDSimplePanel, LMDCustomParentPanel, LMDBackPanel, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDCustomLabelFill, LMDLabelFill, JvComponent, JvTransBtn, EGrad,
  RxLookup, LMDCustomGroupBox, LMDGroupBox, fcLabel, JvPanel,
  JvTransparentPanel, JvLabel;

type
  TFrmCadCliente = class(TForm)
    Panel3: TLMDBackPanel;
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnLocalizar: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnAlterar: TJvTransparentButton;
    fcLabel1: TfcLabel;
    dbCod: TDBEdit;
    dbNome: TDBEdit;
    DbTel: TDBEdit;
    DbCel: TDBEdit;
    dbeCPF: TDBEdit;
    dbeEnd: TDBEdit;
    dbeBairro: TDBEdit;
    dbCep: TDBEdit;
    cmbUf: TDBComboBox;
    dbeNum: TEvDBZeroEdit;
    JvTransparentPanel1: TJvTransparentPanel;
    DbCompl: TDBEdit;
    dbDataCad: TDBDateEdit;
    dbTel2: TDBEdit;
    MsgDlg: TEvMsgDlg;
    dbCidade: TDBEdit;
    dbObs: TDBMemo;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel7: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel10: TJvLabel;
    JvLabel11: TJvLabel;
    JvLabel12: TJvLabel;
    JvLabel13: TJvLabel;
    JvLabel14: TJvLabel;
    JvLabel15: TJvLabel;
    dbAtivo: TDBComboBox;
    UserAccess: TEvUserAccess;
    lblAtivo: TJvLabel;
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbNomeExit(Sender: TObject);
    procedure DBEcpfExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dbObsExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fOutraJan : Boolean;
  public
    { Public declarations }
    property OutraJan : Boolean read fOutraJan write fOutraJan;
  end;

var
  FrmCadCliente : TFrmCadCliente;
  NovoItem      : Boolean       ;

implementation

uses unitDmDados, unitLocCliente, unitLibCredito, UnitPrincipal, untDepende,
  UnitObs, UnitCidade;

{$R *.dfm}

procedure TFrmCadCliente.btnLocalizarClick(Sender: TObject);
begin
  FrmLocCliente := TFrmLocCliente.Create(Application);
  FrmLocCliente.showmodal;
  FrmLocCliente.Free;
end;

procedure TFrmCadCliente.btnPrimeiroClick(Sender: TObject);
begin
  dmdados.tbCliente.First;
  Btnprimeiro.Enabled := False;
  BtnAnterior.Enabled := False;
  BtnProximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
end;

procedure TFrmCadCliente.btnAnteriorClick(Sender: TObject);
begin
  dmdados.tbCliente.Prior;
  BtnProximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
  If dmdados.TbCliente.bof Then
  Begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
  End;
end;

procedure TFrmCadCliente.btnProximoClick(Sender: TObject);
begin
 dmdados.tbCliente.Next;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  If dmdados.TbCliente.Eof Then
  Begin
    BtnProximo.Enabled := False;
    BtnUltimo.Enabled  := False;
  End;
end;

procedure TFrmCadCliente.btnUltimoClick(Sender: TObject);
begin
  dmdados.tbCliente.Last;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  BtnProximo.Enabled  := False;
  BtnUltimo.Enabled   := False;
end;

procedure TFrmCadCliente.btnNovoClick(Sender: TObject);
begin
  dmdados.tbCliente.Append;
  NovoItem             := True ;
  {habilitando os bot�es}
  BtnGravar.Enabled    := True ;
  BtnCancelar.Enabled  := True ;
  BtnNovo.Enabled      := False;
  BtnPrimeiro.Enabled  := False;
  BtnAnterior.Enabled  := False;
  BtnProximo.Enabled   := False;
  BtnUltimo.Enabled    := False;
  BtnAlterar.Enabled   := False;
  btnDeletar.Enabled   := False;
  BtnLocalizar.Enabled := False;
  {habilitando os componentes}
  DbNome.Enabled       := True ;
  DbTel.Enabled        := True ;
  DbTel2.Enabled       := True ;
  dbcel.Enabled        := True ;
  dbecpf.Enabled       := True ;
  dbeEnd.Enabled       := True ;
  dbenum.Enabled       := True ;
  Dbcompl.Enabled      := True ;
  DbeBairro.Enabled    := True ;
  dbCidade.Enabled     := True ;
  dbcep.Enabled        := True ;
  cmbUF.Enabled        := True ;
  dbAtivo.Enabled      := True ;
  dbDataCad.Enabled    := True ;
  dbObs.Enabled        := True ;
  dmDados.vTabStt      := False;
  dmDados.tbClienteCep.Value    := '11600000'     ;
  dmDados.tbClienteCidade.Value := 'S�O SEBASTI�O';
  cmbUf.Text                    := 'SP'           ;
  dbAtivo.Text                  := 'SIM'          ;
  dbNome.setfocus;
end;

procedure TFrmCadCliente.btnGravarClick(Sender: TObject);
Var
  Campos : String ;
  Vazio  : Boolean;
  Gravar : Boolean;
  Flag   : Boolean;
  x      : Integer;
begin
  Campos := ''   ;
  Gravar := True ;
  Vazio  := False;
  if (dbNome.Text = '') then
    begin
    if (Length(Campos) > 0) then
      Campos := Campos + ', ';
    Campos := 'Nome';
    Gravar := False ;
    Vazio  := True  ;
    end;
  if (Gravar) then
    begin
    dmDados.tbClienteStatus.Value       := 'L'                             ;
    dmDados.tbCliente.Post;
    dmDados.tbContaCliente.Append;
    dmDados.tbContaClienteConta.Value   := dmDados.tbClienteCodCli.AsString;
    dmDados.tbContaClienteSaldo.Value   := 0                               ;
    dmDados.tbContaClienteDataCad.Value := Date                            ;
    dmDados.tbContaClienteUltMov.Value  := Date                            ;
    dmDados.tbContaClienteHoraMov.Value := Time                            ;
    dmDados.tbContaCliente.Post;
    NovoItem             := False;
    dmDados.vTabStt      := True ;
    BtnGravar.enabled    := False;
    BtnCancelar.Enabled  := False;
    BtnNovo.Enabled      := True ;
    BtnPrimeiro.Enabled  := True ;
    BtnAnterior.Enabled  := True ;
    BtnProximo.Enabled   := True ;
    BtnUltimo.Enabled    := True ;
    if ((frmPrincipal.Acesso=1) or (frmPrincipal.Acesso=2)) then
      BtnAlterar.Enabled := True;
    if (frmPrincipal.Acesso=1) then
      Btndeletar.Enabled := True;
    BtnLocalizar.Enabled := True;
    {desabilitando os componentes}
    DbNome.Enabled       := False;
    DbTel.Enabled        := False;
    DbTel2.Enabled       := False;
    dbcel.Enabled        := False;
    dbecpf.Enabled       := False;
    dbeEnd.Enabled       := False;
    dbenum.Enabled       := False;
    Dbcompl.Enabled      := False;
    DbeBairro.Enabled    := False;
    dbCidade.Enabled     := False;
    dbcep.Enabled        := False;
    cmbUF.Enabled        := False;
    dbObs.Enabled        := False;
    dbAtivo.Enabled      := False;
    dbDataCad.Enabled    := False;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    Panel3.SetFocus;
    end
  else
    begin
    if (Vazio) then
      begin
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
      dbnome.Enabled := True;
      dbNome.SetFocus;
      end;
    end;
end;

procedure TFrmCadCliente.btnCancelarClick(Sender: TObject);
begin
  dmdados.tbCliente.Cancel;
  NovoItem:= False;
  BtnGravar.enabled   := False;
  BtnCancelar.Enabled := False;
  BtnNovo.Enabled     := True ;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  Btnproximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
  if ((frmPrincipal.Acesso=1) or (frmPrincipal.Acesso=2)) then
    BtnAlterar.Enabled := True ;
  if (frmPrincipal.Acesso=1) then
    Btndeletar.Enabled := True ;
  BtnLocalizar.Enabled := True ;
  {desabilitando os componentes}
  DbNome.Enabled       := False;
  DbTel.Enabled        := False;
  DbTel2.Enabled       := False;
  dbcel.Enabled        := False;
  dbecpf.Enabled       := False;
  dbeEnd.Enabled       := False;
  dbenum.Enabled       := False;
  Dbcompl.Enabled      := False;
  DbeBairro.Enabled    := False;
  dbCidade.Enabled     := False;
  dbcep.Enabled        := False;
  cmbUF.Enabled        := False;
  dbObs.Enabled        := False;
  dbAtivo.Enabled      := False;
  dbDataCad.Enabled    := False;
  dmDados.vTabStt      := True ;
  Panel3.SetFocus;
end;

procedure TFrmCadCliente.btnAlterarClick(Sender: TObject);
begin
  if (dmdados.tbCliente.RecordCount = 0) then
    MsgDlg.MsgError('Tabela vazia')
  else
    begin
    dmDados.tbCliente.Edit;
    NovoItem := True;
    {habilitando os bot�es}
    BtnCancelar.enabled  := True ;
    BtnGravar.Enabled    := True ;
    BtnNovo.Enabled      := False;
    BtnPrimeiro.Enabled  := False;
    BtnAnterior.Enabled  := False;
    BtnProximo.Enabled   := False;
    BtnUltimo.Enabled    := False;
    BtnAlterar.Enabled   := False;
    Btndeletar.Enabled   := False;
    BtnLocalizar.Enabled := False;
    {habilitando os componentes}
    dbNome.Enabled       := True ;
    DbTel.Enabled        := True ;
    dbcel.Enabled        := True ;
    dbecpf.Enabled       := True ;
    dbeEnd.Enabled       := True ;
    dbenum.Enabled       := True ;
    Dbcompl.Enabled      := True ;
    DbeBairro.Enabled    := True ;
    dbCidade.Enabled     := True ;
    dbcep.Enabled        := True ;
    cmbUF.Enabled        := True ;
    dbObs.Enabled        := True ;
    dbAtivo.Enabled      := True ;
    dbDataCad.Enabled    := True ;
    dmDados.vTabStt      := False;      
    dbNome.SetFocus;
    end;
end;

procedure TFrmCadCliente.btnDeletarClick(Sender: TObject);
var
  Flag : Boolean;
begin
  Flag := False;
  if (dmDados.tbCliente.RecordCount = 0) then
    MsgDlg.MsgError('Tabela vazia')
  else
    if MsgDlg.MsgConfirmation('Tem certeza que deseja excluir este registro?') = id_yes then
      begin
      if dmDados.tbVendas.Locate('CodCli',dmDados.tbClienteCodCli.Value,[]) then
        Flag := True;
      if dmDados.tbCReceber.Locate('CodCli',dmDados.tbClienteCodCli.Value,[]) then
        Flag := True;
      if dmDados.tbDepende.Locate('CodCli',dmDados.tbClienteCodCli.Value,[]) then
        Flag := True;
      if dmDados.tbLibCredito.Locate('CodCli',dmDados.tbClienteCodCli.Value,[]) then
        Flag := True;
      if (Flag) then
        MsgDlg.MsgInformation('Cliente ativo, ou com registro de opera��es anteriores, n�o pode ser exclu�do !!!')
      else
        dmdados.TbCliente.Delete;
      end
    else
      dmdados.TbCliente.cancel;
end;

procedure TFrmCadCliente.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadCliente.dbNomeExit(Sender: TObject);
begin
  if NovoItem then
    if dbNome.Text= '' then
      begin
      MsgDlg.MsgWarning('� obrigat�rio o Nome');
      dbNome.SetFocus;
      end;
end;

procedure TFrmCadCliente.DBEcpfExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.TbCliente.DatabaseName;
  Tabela.TableName    := dmDados.TbCliente.TableName   ;
  Tabela.IndexName    := dmdados.tbCliente.IndexName   ;
  Tabela.Open;
  if (NovoItem) then
    if dbeCPF.Text = '           ' then
      begin
      MsgDlg.MsgWarning('� necess�rio Informar o CPF');
      dbeCPF.setfocus;
      end
  else
    if (Tabela.Locate('CPF',dbeCPF.Text,[])) then
      if (not((DmDados.tbCliente.State = dsEdit) And (dmDados.tbCliente.RecNo = Tabela.RecNo))) then
        begin
        MsgDlg.MsgWarning('CPF j� Cadastrado');
        dbecpf.Clear;
        dbecpf.setfocus;
        end;
  Tabela.Free;
end;

procedure TFrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  if (not OutraJan) then
    begin
    dmDados.tbLibCredito.Close;
    dmDados.tbDepende.Close;
    dmDados.tbCReceber.Close;
    dmDados.tbVendas.Close;
    dmDados.tbContaCliente.Close;
    dmDados.tbCliente.Close;
    dmdados.HabilitaTeclado := False;
    Action := Cafree;
    end;
end;

procedure TFrmCadCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (dmdados.HabilitaTeclado) then
    case (key) of
      // Teclas de a��o na tabela
      VK_Insert : if (dmDados.vTabStt) then BtnNovo.Click;
      VK_Home   : if (dmDados.vTabStt) then BtnAlterar.Click;
      VK_Delete : if (dmDados.vTabStt) then BtnDeletar.Click;
      VK_End    : if not(dmDados.vTabStt) then BtnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
      VK_F9     : btnLocalizar.Click;
    end;
end;

procedure TFrmCadCliente.FormActivate(Sender: TObject);
begin
  FrmPrincipal.StatusTeclas(True,' [Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [F9] Localizar [Esc] Cancelar ou Sair');
  if dmDados.tbCliente.State      = dsInactive then
    dmDados.tbCliente.Open;
  if dmDados.tbContaCliente.State = dsInactive then
    dmDados.tbContaCliente.Open;
  if dmDados.tbCReceber.State     = dsInactive then
    dmDados.tbCReceber.Open;
  if dmDados.tbVendas.State       = dsInactive then
    dmDados.tbVendas.Open;
  if dmDados.tbDepende.State      = dsInactive then
    dmDados.tbDepende.Open;
  if dmDados.tbLibCredito.State   = dsInactive then
    dmDados.tbLibCredito.Open;
  if (not dmdados.HabilitaTeclado) then
    dmdados.HabilitaTeclado := True;
  dmDados.vTabStt := True ;
  NovoItem        := False;
  if (dmDados.tbCliente.RecordCount = 0) then
    begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    BtnProximo.Enabled  := False;
    BtnUltimo.Enabled   := False;
    BtnNovo.Enabled     := True ;
    BtnGravar.Enabled   := False;
    BtnCancelar.Enabled := False;
    BtnAlterar.Enabled  := False;
    Btndeletar.Enabled  := False;
    end;
  if (frmPrincipal.Acesso=1) or (frmPrincipal.Acesso=2) then
    BtnAlterar.Enabled := True;
  if (frmPrincipal.Acesso=1) then
    Btndeletar.Enabled := True;
  UserAccess.UserID := FrmPrincipal.Acesso;
end;

procedure TFrmCadCliente.dbObsExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TFrmCadCliente.FormCreate(Sender: TObject);
begin
  OutraJan := False;
end;

end.
