//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 15-05-2007
// Ultima modifica��o: 29-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitCCorrente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvTransBtn, fcLabel, LMDCustomControl, DB, DBTables,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  StdCtrls, JvLabel, EDBTime, fcButton, fcImgBtn, RxLookup, ToolEdit,
  RXDBCtrl, Mask, DBCtrls, CurrEdit, EMsgDlg, DBUtils, ShellApi, ExtCtrls,
  JvPanel, JvTransparentPanel, JvEnterTab;

type
  TFrmCCorrente = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    Panel3: TLMDBackPanel;
    btnAnterior: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnAlterar: TJvTransparentButton;
    dbDtAb: TDBDateEdit;
    cmblLkBanco: TRxDBLookupCombo;
    btnCadBanco: TfcImageBtn;
    dbAgencia: TDBEdit;
    dbNumConta: TDBEdit;
    dbTitular: TDBEdit;
    dbGerente: TDBEdit;
    dbDtUlMov: TDBDateEdit;
    dbHora: TEvDBTimeEdit;
    dbEmail: TDBEdit;
    DbFax: TDBEdit;
    DbTel1: TDBEdit;
    dbInternet: TDBEdit;
    btnInternt: TfcImageBtn;
    dbDataCad: TDBDateEdit;
    BtnEmail: TfcImageBtn;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel7: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel11: TJvLabel;
    JvLabel12: TJvLabel;
    JvLabel13: TJvLabel;
    JvLabel14: TJvLabel;
    JvLabel15: TJvLabel;
    dbSaldo: TRxDBCalcEdit;
    dbLimite: TRxDBCalcEdit;
    JvLabel16: TJvLabel;
    JvLabel17: TJvLabel;
    MsgDlg: TEvMsgDlg;
    dbDesc: TDBEdit;
    btnNovo: TJvTransparentButton;
    JvTransparentPanel1: TJvTransparentPanel;
    JvTransparentPanel2: TJvTransparentPanel;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure btnDescClick(Sender: TObject);
    procedure btnCadBancoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbInternetExit(Sender: TObject);
    procedure dbDtAbExit(Sender: TObject);
    procedure dbDescExit(Sender: TObject);
    procedure dbHoraEnter(Sender: TObject);
    procedure dbAgenciaExit(Sender: TObject);
    procedure dbNumContaExit(Sender: TObject);
    procedure dbTitularExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure BtnEmailClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCCorrente : TFrmCCorrente;

implementation

uses UnitHistorico, UnitCadBanco, unitDmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmCCorrente.btnDescClick(Sender: TObject);
begin
    FrmHistorico := TFrmHistorico.Create(application);
    FrmHistorico.Show;
end;

procedure TFrmCCorrente.btnCadBancoClick(Sender: TObject);
begin
    FrmCadBanco := TFrmCadBanco.Create(application);
    frmCadBanco.OutraJan := True;
    FrmCadBanco.ShowModal;
end;

procedure TFrmCCorrente.btnSairClick(Sender: TObject);
begin
  DmDados.TbCCorrente.Open;
  Close;
end;

procedure TFrmCCorrente.dbInternetExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TFrmCCorrente.dbDtAbExit(Sender: TObject);
begin
  if NovoItem then
    if dbDtAb.Text = '  /  /    ' then
      begin
      MsgDlg.MsgError('� obrigat�rio a DATA INICIAL');
      dbDtAb.SetFocus;
      End
  else
    begin
    try
      StrToDate(dbDtAb.Text);
    except
      on EConvertError do
        begin
        MsgDlg.MsgError('Data Inv�lida');
        dbDtAb.SetFocus;
        end;
    end;
  end;
end;

procedure TFrmCCorrente.dbDescExit(Sender: TObject);
Var
  Tabela : TTable;
begin
  if NovoItem then
    begin
    Tabela              := TTable.Create(Application)      ;
    Tabela.DatabaseName := dmDados.tbCCorrente.DatabaseName;
    Tabela.TableName    := dmDados.tbCCorrente.TableName   ;
    Tabela.IndexName    := dmdados.TbCCorrente.IndexName   ;
    Tabela.Open;
    if dbDesc.Text = '' then
      begin
      MsgDlg.MsgError('� obrigat�rio a DESCRI��O');
      dbDesc.SetFocus;
      end
    else
      if Tabela.Locate('Descricao',dbDesc.Text,[]) then
        if not ((DmDados.tbCCorrente.State=dsEdit) And (dmDados.tbCCorrente.RecNo = Tabela.RecNo)) then
          begin
          MsgDlg.MsgWarning('DEDSCRI��O j� Cadastrada');
          dbDesc.Clear;
          dbDesc.setfocus;
          end;
    Tabela.Free;
    end;
end;

procedure TFrmCCorrente.dbHoraEnter(Sender: TObject);
begin
  dmDados.TbCCorrenteHoraMov.Value := Now;
end;

procedure TFrmCCorrente.dbAgenciaExit(Sender: TObject);
begin
  if NovoItem then
    begin
    if dbDesc.Text = '' then
      begin
      MsgDlg.MsgError('� obrigat�rio o Tipo de Conta');
      dbDesc.SetFocus;
      end;
    end;
end;

procedure TFrmCCorrente.dbNumContaExit(Sender: TObject);
Var
  Tabela : TTable;
begin
  if NovoItem then
    begin
    Tabela              := TTable.Create(Application)      ;
    Tabela.DatabaseName := dmDados.TbCCorrente.DatabaseName;
    Tabela.TableName    := dmDados.TbCCorrente.TableName   ;
    Tabela.IndexName    := dmdados.TbCCorrente.IndexName   ;
    Tabela.Open;
    if dbNumConta.Text = '' then
       begin
       MsgDlg.MsgError('� obrigat�rio o N�MERO DA CONTA');
       dbNumConta.SetFocus;
       end
    else
      if Tabela.Locate('Conta',dbNumConta.Text,[]) then
        if not ((DmDados.TbCCorrente.State=dsEdit) And (dmDados.TbCCorrente.RecNo = Tabela.RecNo)) then
          begin
          MsgDlg.MsgWarning('N�MERO DA CONTA j� Cadastrada');
          dbNumConta.Clear;
          dbNumConta.setfocus;
          end;
    Tabela.Free;
    end;
end;

procedure TFrmCCorrente.dbTitularExit(Sender: TObject);
begin
  if NovoItem then
    begin
    if dbTitular.Text = '' then
      begin
      MsgDlg.MsgError('� obrigat�rio o TITULAR');
      dbTitular.SetFocus;
      end;
    end;
end;

procedure TFrmCCorrente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.TbCCorrente.Close;
  dmDados.TbMovConta.Close;
  dmDados.tbBanco.Close;
  Action := Cafree;
end;

procedure TFrmCCorrente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_Insert : if (dmDados.vTabStt) then BtnNovo.Click;
      VK_Home   : if (dmDados.vTabStt) then BtnAlterar.Click;
      VK_Delete : if (dmDados.vTabStt) then BtnDeletar.Click;
      VK_End    : if not(dmDados.vTabStt) then BtnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
      VK_F2     : btnCadBanco.Click;
    end;
end;

procedure TFrmCCorrente.btnPrimeiroClick(Sender: TObject);
begin
  dmdados.tbCCorrente.First;
  btnPrimeiro.Enabled := False;
  btnAnterior.Enabled := False;
  btnProximo.Enabled  := True ;
  btnUltimo.Enabled   := True ;
  dmDados.vTabStt     := True ;
end;

procedure TFrmCCorrente.btnAnteriorClick(Sender: TObject);
begin
  dmdados.tbCCorrente.Prior;
  btnProximo.Enabled := True;
  btnUltimo.Enabled  := True;
  if dmdados.TbCCorrente.bof then
    begin
    btnPrimeiro.Enabled := False;
    btnAnterior.Enabled := False;
    end;
  dmDados.vTabStt    := True;
end;

procedure TFrmCCorrente.btnProximoClick(Sender: TObject);
begin
  dmdados.tbCCorrente.next;
  btnPrimeiro.Enabled := True;
  btnAnterior.Enabled := True;
  if dmdados.tbCCorrente.Eof then
    begin
    btnProximo.Enabled := False;
    btnUltimo.Enabled  := False;
    end;
  dmDados.vTabStt     := True;
end;

procedure TFrmCCorrente.btnUltimoClick(Sender: TObject);
begin
  dmdados.tbCCorrente.Last;
  btnPrimeiro.Enabled := True ;
  btnAnterior.Enabled := True ;
  btnProximo.Enabled  := False;
  btnUltimo.Enabled   := False;
  dmDados.vTabStt     := True ;
end;

procedure TFrmCCorrente.btnNovoClick(Sender: TObject);
begin
  dmDados.tbCCorrente.Append;
  NovoItem            := True ;
  dmDados.vTabStt     := False;
  {habilitando os bot�es}
  BtnEmail.Enabled    := True ;
  btnInternt.Enabled  := True ;
  btnCadBanco.Enabled := True ;
  BtnGravar.Enabled   := True ;
  BtnCancelar.Enabled := True ;
  BtnNovo.Enabled     := False;
  BtnPrimeiro.Enabled := False;
  BtnAnterior.Enabled := False;
  BtnProximo.Enabled  := False;
  BtnUltimo.Enabled   := False;
  BtnAlterar.Enabled  := False;
  BtnDeletar.Enabled  := False;
  {habilitando os componentes}
  dbDtAb.Enabled      := True ;
  dbDesc.Enabled      := True ;
  cmblLkBanco.Enabled := True ;
  dbAgencia.Enabled   := True ;
  dbNumConta.Enabled  := True ;
  dbTitular.Enabled   := True ;
  dbLimite.Enabled    := True ;
  dbSaldo.Enabled     := True ;
  dbGerente.Enabled   := True ;
  dbDtUlMov.Enabled   := True ;
  dbHora.Enabled      := True ;
  dbTel1.Enabled      := True ;
  dbFax.Enabled       := True ;
  dbEmail.Enabled     := True ;
  dbInternet.Enabled  := True ;
  dmDados.TbCCorrenteHoraMov.Value := Now;
  dbDtAb.SetFocus;
end;

procedure TFrmCCorrente.btnGravarClick(Sender: TObject);
Var
  Campos : String ;
  Vazio  : Boolean;
  Gravar : Boolean;
  Tabela : TTable ;
begin
  Campos              := ''                              ;
  Gravar              := True                            ;
  Vazio               := False                           ;
  Tabela              := TTable.Create(Application)      ;
  Tabela.DatabaseName := dmDados.TbCCorrente.DatabaseName;
  Tabela.TableName    := dmDados.TbCCorrente.TableName   ;
  Tabela.IndexName    := dmdados.TbCCorrente.IndexName   ;
  Tabela.Open;
  //Campo que n�o pode repetir
  if dbNumConta.Text = '' then
    begin
    if Length(Campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'N�mero da Conta';
    Gravar := False                   ;
    Vazio  := True                    ;
    end
  else
    if Tabela.Locate('Conta',dbNumConta.Text,[]) then
      if Not((DmDados.TbCCorrente.State=dsEdit) And (dmDados.TbCCorrente.RecNo = Tabela.RecNo)) then
        begin
       	Gravar := False;
        MsgDlg.MsgWarning('N�mero da Conta j� Cadastrado');
        end;
  if dbDesc.Text = '' then
    begin
    if Length(Campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'Descri��o';
    Gravar := False             ;
    Vazio  := True              ;
    end
  else
    if Tabela.Locate('Descricao',dbDesc.Text,[]) then
      if Not((DmDados.TbCCorrente.State=dsEdit) And (dmDados.TbCCorrente.RecNo = Tabela.RecNo)) then
        begin
       	Gravar := False;
        MsgDlg.MsgWarning('Descri��o j� Cadastrada');
        end;
  //Campo que n�o pode estar vazio
  if dbTitular.Text = '' then
    begin
    If Length(Campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'Titular';
    Gravar := False           ;
    Vazio  := True            ;
    end;
  if dbAgencia.Text = '' then
    begin
    if Length(Campos) > 0 Then Campos := Campos+', ';
    Campos := Campos+'Ag�ncia';
    Gravar := False           ;
    Vazio  := True            ;
    end;
  //Campo Data n�o podendo ser vazio
  if dbDtAb.Text= '  /  /    ' then
    begin
    if Length(Campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'Data de Abertura';
    Gravar := False                    ;
    Vazio  := True                     ;
    end;
  if cmblLkBanco.Text = '' then
    begin
    if Length(campos) > 0 then Campos := Campos+', ';
    Campos := Campos+'BANCO';
    Gravar := False         ;
    Vazio  := True          ;
    End;
  if (dbDtAb.text <> '') then
    try StrToDate(dbDtAb.text)
    except on EConvertError do
      begin
      MsgDlg.MsgError('Data de Abertura Inv�lida');
      Gravar := False;
      end;
    end;
  if Gravar then
    begin
    dmdados.tbCCorrente.Post;
    //lan�a o primeiro movimento ref. a cadastro
    if Not (dmDados.TbMovConta.Locate('NumAgencia;Conta',
       VarArrayOf([dmDados.TbCCorrenteNumAgencia.Value,dmDados.TbCCorrenteConta.Value]),[])) then
      begin
      dmDados.TbMovConta.Append;
      dmdados.TbMovContaTipoOper.Value:='E';
      dmdados.TbMovContaNumAgencia.Value:=dmdados.TbCCorrenteNumAgencia.Value;
      dmdados.TbMovContaConta.Value:=dmdados.TbCCorrenteConta.Value;
      dmdados.TbMovContaCodHist.Value:='2';
      dmdados.TbMovContaComplHist.Value:='ABERTURA/CRIA��O DA CONTA';
      dmdados.TbMovContaDataMov.Value:=dmdados.TbCCorrenteDataCad.Value;
      dmDados.TbMovContaValor.Value:=dmdados.TbCCorrenteSaldo.Value;
      dmDados.TbMovContaDataReg.Value:=dmDados.TbCCorrenteUltMov.Value;
      dmdados.TbMovContaHoraReg.Value:=StrToTime('00:00:00');
      dmdados.TbMovConta.Post;
      end;
    NovoItem            := False;
    dmDados.vTabStt     := True ;
    btnCadBanco.Enabled := False;
    BtnEmail.Enabled    := False;
    btnInternt.Enabled  := False;
    BtnGravar.enabled   := False;
    BtnCancelar.Enabled := False;
    BtnNovo.Enabled     := True ;
    BtnPrimeiro.Enabled := True ;
    BtnAnterior.Enabled := True ;
    BtnProximo.Enabled  := True ;
    BtnUltimo.Enabled   := True ;
    BtnAlterar.Enabled  := True ;
    Btndeletar.Enabled  := True ;
    {desabilitando os componentes}
    dbDtAb.Enabled      := False;
    dbDesc.Enabled      := False;
    cmblLkBanco.Enabled := False;
    dbAgencia.Enabled   := False;
    dbNumConta.Enabled  := False;
    dbTel1.Enabled      := False;
    dbFax.Enabled       := False;
    dbGerente.Enabled   := False;
    dbDtUlMov.Enabled   := False;
    dbHora.Enabled      := False;
    dbTitular.Enabled   := False;
    dbLimite.Enabled    := False;
    dbSaldo.Enabled     := False;
    dbEmail.Enabled     := False;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    Panel3.SetFocus;
    end
  else
    begin
    if Vazio then
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
    dbDtAb.SetFocus;
    end;
  Tabela.Free;
end;

procedure TFrmCCorrente.btnCancelarClick(Sender: TObject);
begin
  dmDados.tbCCorrente.cancel;
  NovoItem            := False;
  dmDados.vTabStt     := True ;
  btnCadBanco.Enabled := False;
  BtnEmail.Enabled    := False;
  btnInternt.Enabled  := False;
  BtnGravar.enabled   := False;
  BtnCancelar.Enabled := False;
  BtnNovo.Enabled     := True ;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  Btnproximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
  BtnAlterar.Enabled  := True ;
  BtnDeletar.Enabled  := True ;
  {desabilitando os componentes}
  dbDtAb.Enabled      := False;
  dbDesc.Enabled      := False;
  cmblLkBanco.Enabled := False;
  dbAgencia.Enabled   := False;
  dbNumConta.Enabled  := False;
  dbTel1.Enabled      := False;
  dbFax.Enabled       := False;
  dbGerente.Enabled   := False;
  dbDtUlMov.Enabled   := False;
  dbHora.Enabled      := False;
  dbTitular.Enabled   := False;
  dbLimite.Enabled    := False;
  dbSaldo.Enabled     := False;
  dbEmail.Enabled     := False;
  Panel3.SetFocus;
end;

procedure TFrmCCorrente.btnAlterarClick(Sender: TObject);
begin
  if dmdados.tbCCorrente.RecordCount = 0 then
    begin
    MsgDlg.MsgInformation('Tabela sem registro');
    end
  else
    begin
    dmDados.tbCCorrente.Edit;
    NovoItem            := True ;
    dmDados.vTabStt     := False;
    btnCadBanco.Enabled := True ;
    BtnEmail.Enabled    := True ;
    btnInternt.Enabled  := True ;
    BtnCancelar.enabled := True ;
    BtnGravar.Enabled   := True ;
    BtnNovo.Enabled     := False;
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    BtnProximo.Enabled  := False;
    BtnUltimo.Enabled   := False;
    BtnAlterar.Enabled  := False;
    Btndeletar.Enabled  := False;
    {habilitando os componentes}
    dbDtAb.Enabled      := True ;
    DbDesc.Enabled      := True ;
    cmblLkBanco.Enabled := True ;
    dbAgencia.Enabled   := True ;
    dbNumConta.Enabled  := True ;
    dbTel1.Enabled      := True ;
    dbFax.Enabled       := True ;
    dbGerente.Enabled   := True ;
    dbDtUlMov.Enabled   := True ;
    dbHora.Enabled      := True ;
    dbTitular.Enabled   := True ;
    dbLimite.Enabled    := True ;
    dbSaldo.Enabled     := True ;
    dbEmail.Enabled     := True ;
    dbDtAb.SetFocus;
    end;
end;

procedure TFrmCCorrente.btnDeletarClick(Sender: TObject);
begin
  if dmdados.tbCCorrente.RecordCount=0 then
    MsgDlg.MsgInformation('Tabela sem registro')
  else
    if MsgDlg.MsgConfirmation('Tem certeza que deseja exluir esse registro?') = id_yes then
      if dmDados.TbMovConta.Locate('NumAgencia;Conta',VarArrayOf([dmDados.TbCCorrenteNumAgencia.Value,dmDados.TbCCorrenteConta.Value]),[]) then
        MsgDlg.MsgWarning('CONTA CORRENTE ativa, n�o pode ser excluida !!!')
      else
        dmdados.tbCCorrente.Delete;
end;

procedure TFrmCCorrente.BtnEmailClick(Sender: TObject);
var
 url : string;
begin
  url := 'mailto:'+dmdados.TbCCorrenteEMail.Value;
  if dmDados.TbCCorrenteEMail.Value <> '' then
    shellexecute(0, 'open',Pchar(url), nil, nil, sw_showNormal);
end;

procedure TFrmCCorrente.FormActivate(Sender: TObject);
begin
  dmDados.TbCCorrente.Open;
  dmDados.tbBanco.Open;
  dmDados.TbMovConta.Open;
  dmDados.vTabStt := True ;
  NovoItem        := False;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [F2] Banco [Delete] Excluir [Esc] Cancelar ou Sair');
  if dmdados.TbCCorrente.RecordCount = 0 then
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
