//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 13-02-2001
// Ultima modifica��o: 28-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit unitFunc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  VerCPF, ToolEdit, RXDBCtrl, RackCtls, StdCtrls, DBCtrls, RXSplit, Mask,
  RXCtrls, ExtCtrls, SpeedBar, jpeg, CurrEdit, fcButton, fcImgBtn, RxLookup,
  DB, DBTables, DCStdCtrls, ImgList, Grids, DBGrids, ComCtrls, EDBZero,
  EFocCol, RxGrdCpt, fcImager, EMsgDlg, EUserAcs, TFlatSplitterUnit,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, fcLabel, EGrad, JvPanel,
  JvTransparentPanel, JvComponent, JvTransBtn, JvLabel;

type
  TFrmFuncionario = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    DBECod: TDBEdit;
    DBnome: TDBEdit;
    DBEtel1: TDBEdit;
    dbdEdtNasc: TDBDateEdit;
    DBEend: TDBEdit;
    DBEbairro: TDBEdit;
    dbeNum: TEvDBZeroEdit;
    DBEcompl: TDBEdit;
    DBEcep: TDBEdit;
    cmbUF: TDBComboBox;
    RxDBSal: TRxDBCalcEdit;
    dbdedtAdm: TDBDateEdit;
    DBEcel: TDBEdit;
    DBcmbSit: TDBComboBox;
    dbLookCargo: TDBLookupComboBox;
    DBEcpf: TDBEdit;
    DBErg: TDBEdit;
    Panel3: TLMDBackPanel;
    fcLabel1: TfcLabel;
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
    dbDataCad: TDBDateEdit;
    JvTransparentPanel1: TJvTransparentPanel;
    dbCidade: TDBEdit;
    MsgDlg: TEvMsgDlg;
    JvLabel2: TJvLabel;
    JvLabel1: TJvLabel;
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
    JvLabel16: TJvLabel;
    JvLabel17: TJvLabel;
    JvLabel18: TJvLabel;
    JvLabel19: TJvLabel;
    procedure BtnSairClick(Sender: TObject);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure DBEnomeExit(Sender: TObject);
    procedure DBEendExit(Sender: TObject);
    procedure DBEnumExit(Sender: TObject);
    procedure DBEbairroExit(Sender: TObject);
    procedure DBEcidadeExit(Sender: TObject);
    procedure DBEcepExit(Sender: TObject);
    procedure dbdEdtNascExit(Sender: TObject);
    procedure dbdedtAdmExit(Sender: TObject);
    procedure cmbUFExit(Sender: TObject);
    procedure DBcmbSitExit(Sender: TObject);
    procedure DBEcpfExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure DBMemoInfoExit(Sender: TObject);
    procedure dbLookCargoExit(Sender: TObject);
    procedure dbNomeExit(Sender: TObject);
    procedure DBedtNascExit(Sender: TObject);
    procedure dbcmbParenExit(Sender: TObject);
    procedure DCPage3Show(Sender: TObject);
    procedure btnGravaDepClick(Sender: TObject);
    procedure DCPage3Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btnDepenClick(Sender: TObject);
    procedure btnObsClick(Sender: TObject);
    procedure btnCidadeClick(Sender: TObject);
    procedure dbEmailExit(Sender: TObject);
    procedure dbCidadeExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFuncionario: TFrmFuncionario;
  NovoItem:Boolean;

implementation

uses UnitLocFunc, UnitDmDados, UnitCustoFunc, unitPrincipal, UnitCadDepFunc,
  UnitObs, UnitCidade;

{$R *.DFM}

procedure TFrmFuncionario.BtnSairClick(Sender: TObject);
begin
  dmDados.tbDepenFunc.Cancel;
	Close;
end;

procedure TFrmFuncionario.BtnLocalizarClick(Sender: TObject);
begin
  FrmLocFunc:=TFrmLocFunc.Create(Application);
  FrmLocFunc.Showmodal;
  FrmLocFunc.Free;
end;

procedure TFrmFuncionario.DBEnomeExit(Sender: TObject);
begin
  If NovoItem Then
    If DBnome.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o Nome do Funcion�rio');
      DBnome.SetFocus;
      End;
end;

procedure TFrmFuncionario.DBEendExit(Sender: TObject);
begin
  If NovoItem Then
    If DBEend.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o Endere�o');
      DBEend.SetFocus;
      End;
end;

procedure TFrmFuncionario.DBEnumExit(Sender: TObject);
begin
  If NovoItem Then
    If DBEnum.Text= '00000' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o N�mero');
      DBEnum.SetFocus;
      End;
end;

procedure TFrmFuncionario.DBEbairroExit(Sender: TObject);
begin
  If NovoItem Then
    If DBEbairro.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o Bairro');
      DBEbairro.SetFocus;
      End;
end;

procedure TFrmFuncionario.DBEcidadeExit(Sender: TObject);
begin
  If NovoItem Then
    If dbCidade.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio a Cidade');
      dbCidade.SetFocus;
      End;
end;

procedure TFrmFuncionario.DBEcepExit(Sender: TObject);
begin
  If NovoItem Then
    If cmbUF.Text= '        ' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o CEP');
      cmbUF.SetFocus;
      End;
end;

procedure TFrmFuncionario.dbdEdtNascExit(Sender: TObject);
begin
  If NovoItem Then
    If dbdEdtNasc.Text= '  /  /    ' then
      Begin
      MsgDlg.MsgWarning ('� obrigat�rio a Data de Nascimento');
      dbdEdtNasc.SetFocus;
      End
    else
      begin
        try StrToDate(dbdEdtNasc.text)
        except on EConvertError do
          begin
          MsgDlg.MsgError('DATA DE NASCIMENTO INV�LIDA');
          dbdEdtNasc.SetFocus;
          end;
        end;
      end;
end;

procedure TFrmFuncionario.dbdedtAdmExit(Sender: TObject);
begin
  If NovoItem Then
    If dbdedtAdm.Text= '  /  /    ' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio a Data de Admiss�o');
      dbdedtAdm.SetFocus;
      End
    else
      begin
      try StrToDate(dbdedtAdm.text)
        except on EConvertError do
          begin
          MsgDlg.MsgError('DATA DE ADMISS�O INV�LIDA');
          dbdedtAdm.SetFocus;
          end;
      end;
      end;
end;

procedure TFrmFuncionario.cmbUFExit(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
  If NovoItem Then
    Begin
    If cmbUF.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio informar o Estado');
      cmbUF.SetFocus;
      End
    Else
      Begin
      Flag:=True;
      For x:=0 to cmbUF.Items.Count-1 Do
        If cmbUF.Text=cmbUF.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        MsgDlg.MsgError('Sigla do Estado inv�lida');
        cmbUF.SetFocus;
        End
      Else
      End;
    End
  Else
end;

procedure TFrmFuncionario.DBcmbSitExit(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
  If NovoItem Then
    Begin
    If DBcmbSit.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio informar a Situa��o');
      DBcmbSit.SetFocus;
      End
    Else
      Begin
      Flag:=True;
      For x:=0 to DBcmbSit.Items.Count-1 Do
        If DBcmbSit.Text=DBcmbSit.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        MsgDlg.MsgError('Tipo de Situa��o inv�lida');
        DBcmbSit.SetFocus;
        End;
      End;
    end;
end;

procedure TFrmFuncionario.DBEcpfExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbFunc.DatabaseName;
  Tabela.TableName := dmDados.tbFunc.TableName;
  Tabela.IndexName := dmdados.tbFunc.IndexName;
  Tabela.Open;
  {If NovoItem Then
    If dbeCPF.Text = '           ' Then
      Begin
      MsgDlg.MsgWarning('� necess�rio Informar o CPF');
      dbeCPF.setfocus;
      end
    else
      Begin
      VerCPF1.NumeroCPF:= dbecpf.text;
      If not VerCpf1.valid Then
        if application.MessageBox('CPF inv�lido. Deseja continuar cadastro?','Valida��o CPF', mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = id_no then
          begin
          dbecpf.Clear;
          dbecpf.setfocus;
          Exit;
          end;
      If Tabela.Locate('CPF',dbeCPF.Text,[]) Then
        If not((DmDados.tbFunc.State=dsEdit) And (dmDados.tbFunc.RecNo = Tabela.RecNo)) Then
          Begin
          MsgDlg.MsgWarning('CPF j� Cadastrado');
          dbecpf.Clear;
          dbecpf.setfocus;
          End;
      End;
  Tabela.Free;}

  end;
procedure TFrmFuncionario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmFuncionario.BtnPrimeiroClick(Sender: TObject);
begin
  DMDados.tbFunc.First;
  BtnPrimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  dmdados.vTabStt:=true;
end;

procedure TFrmFuncionario.BtnAnteriorClick(Sender: TObject);
begin
  DMDados.tbFunc.Prior;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  If DMDados.tbFunc.Bof Then
    Begin
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    End;
  dmdados.vTabStt:=true;
end;

procedure TFrmFuncionario.BtnProximoClick(Sender: TObject);
begin
  DMDados.tbFunc.Next;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  If DMDados.tbFunc.Eof Then
    Begin
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    End;
  dmdados.vTabStt:=true;
end;

procedure TFrmFuncionario.BtnUltimoClick(Sender: TObject);
begin
  DMDados.tbFunc.Last;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  dmdados.vTabStt:=true;
end;

procedure TFrmFuncionario.BtnNovoClick(Sender: TObject);
begin
  DMDados.tbFunc.Append;
  NovoItem:=True;
  {habilitando os bot�es}
  BtnGravar.Enabled :=True;
  BtnCancelar.Enabled:=True;
  BtnNovo.Enabled:=False;
  BtnPrimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  BtnAlterar.Enabled:=False;
  BtnDeletar.Enabled:=False;
  BtnLocalizar.Enabled:=False;
  {habilitando os componentes}
  DbLookCargo.Enabled:=True;
  //rxdbComissao.Enabled:=True;
  DBNome.Enabled:=True;
  dbDataCad.Enabled:=True;
  DBdEdtNasc.Enabled:=True;
  DBETel1.Enabled:=True;
  dbeCel.Enabled:=True;
  DBEcpf.Enabled:=True;
  DBErg.Enabled:=True;
  DBEend.Enabled:=True;
  DBEnum.Enabled:=True;
  DBEcompl.Enabled:=True;
  DBEbairro.Enabled:=True;
  dbCidade.Enabled:=True;
  dbeCep.Enabled:=True;
  cmbUF.Enabled:=True;
  dbdedtAdm.Enabled:=True;
  RxDBSal.Enabled:=True;
  DBcmbSit.Enabled:=True;
//  dbLimDesc.Enabled:=True;
  dmdados.vTabStt:=false;
  dmDados.tbFuncCEP.Value:='11600000';
  dmDados.tbFuncCidade.Value:='S�O SEBASTI�O';
  cmbUf.Text:='SP';
  DbNome.SetFocus;
end;

procedure TFrmFuncionario.BtnCancelarClick(Sender: TObject);
begin
  NovoItem:=False;
  DMDados.tbFunc.Cancel;
  BtnGravar.Enabled:=False;
  BtnCancelar.Enabled:=False;
  BtnNovo.Enabled:=True;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  if (frmPrincipal.Acesso=1) or (frmPrincipal.Acesso=2) then
    BtnAlterar.Enabled:=True;
  if (frmPrincipal.Acesso=1) then
    Btndeletar.Enabled:=True;
  BtnLocalizar.Enabled:=True;
  dmdados.vTabStt:=true;
  Panel3.SetFocus;
  {desabilitando os objetos}
  DbLookCargo.Enabled:=False;
//  rxdbComissao.Enabled:=False;
  DBNome.Enabled:=False;
  dbDataCad.Enabled:=False;
  DBdEdtNasc.Enabled:=False;
  DBETel1.Enabled:=False;
  dbeCel.Enabled:=False;
  DBEcpf.Enabled:=False;
  DBErg.Enabled:=False;
  DBEend.Enabled:=False;
  DBEnum.Enabled:=False;
  DBEcompl.Enabled:=False;
  DBEbairro.Enabled:=False;
  dbCidade.Enabled:=False;
//  dbLimDesc.Enabled:=False;
  DBEcep.Enabled:=False;
  cmbUF.Enabled:=False;
  dbdedtAdm.Enabled:=False;
  RxDBSal.Enabled:=False;
  DBcmbSit.Enabled:=False;
end;

procedure TFrmFuncionario.BtnAlterarClick(Sender: TObject);
begin
  NovoItem:=True;
  DMDados.tbFunc.Edit;
  dmdados.vTabStt:=false;
  {habilitando os bot�es}
  BtnCancelar.Enabled:=True;
  BtnGravar.Enabled:=True;
  BtnNovo.Enabled:=False;
  BtnPrimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  BtnAlterar.Enabled:=False;
  Btndeletar.Enabled:=False;
  BtnLocalizar.Enabled:=False;
  {habilitando os componentes}
  DbLookCargo.Enabled:=True;
//  rxdbComissao.Enabled:=True;
  DBNome.Enabled:=True;
  DBdEdtNasc.Enabled:=True;
  DBETel1.Enabled:=True;
  dbeCel.Enabled:=True;
  DBEcpf.Enabled:=True;
  DBErg.Enabled:=True;
  DBEend.Enabled:=True;
  DBEnum.Enabled:=True;
  DBEcompl.Enabled:=True;
  DBEbairro.Enabled:=True;
  dbCidade.Enabled:=True;
  DBEcep.Enabled:=True;
  cmbUF.Enabled:=True;
  dbdedtAdm.Enabled:=True;
  RxDBSal.Enabled:=True;
//  dbLimDesc.Enabled:=True;
  DBcmbSit.Enabled:=True;
  DbNome.SetFocus;
end;

procedure TFrmFuncionario.BtnDeletarClick(Sender: TObject);
var
  flag:boolean;
begin
  flag:=false;
  if dmdados.tbFunc.RecordCount=0 then
    MsgDlg.MsgError('Tabela vazia')
  else
    If MsgDlg.MsgConfirmation('Tem certeza que deseja excluir este funcion�rio ?') = id_yes then
      begin
      if dmdados.tbDepenFunc.Locate('CodFunc',dmdados.tbFuncCodFunc.Value,[]) then
         flag:=true;
      if dmdados.tbFuncEsto.Locate('CodFunc',dmdados.tbFuncCodFunc.Value,[]) then
         flag:=true;
      if dmdados.tbMovEstoque.Locate('CodFunc',dmdados.tbFuncCodFunc.Value,[]) then
         flag:=true;
      if dmdados.tbVendas.Locate('CodFunc',dmdados.tbFuncCodFunc.Value,[]) then
         flag:=true;
      if flag then
         MsgDlg.MsgInformation('Funcion�rio ativo, ou com registro de opera��es anteriores.|N�o pode ser EXCLU�DO!!!')
         else
           dmdados.tbFunc.Delete;
      dmdados.tbFunc.Refresh;
      end;
end;

procedure TFrmFuncionario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.HabilitaTeclado:=True;
  if (dmDados.tbDepenFunc.State=dsEdit) or (dmDados.tbDepenFunc.State=dsInsert) then
    dmDados.tbDepenFunc.Cancel;
  if (dmDados.tbFunc.State=dsEdit) or (dmDados.tbFunc.State=dsInsert) then
    dmDados.tbFunc.Cancel;
  dmDados.tbFuncEsto.Close;
  dmDados.tbMovEstoque.Close;
  dmDados.tbVendas.Close;
  dmDados.tbDepenFunc.Close;
  dmDados.tbFunc.Close;
  dmDados.tbCargo.Close;
  Action:=caFree;
end;

procedure TFrmFuncionario.FormCreate(Sender: TObject);
begin
  NovoItem:=False;
end;

procedure TFrmFuncionario.BtnGravarClick(Sender: TObject);
Var
  Campos:String;
  Vazio,Gravar,Flag:Boolean;
  x:Integer;
  Tabela: TTable;
begin
  Campos:='';
  Gravar:=True;
  Vazio:=False;
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbFunc.DatabaseName;
  Tabela.TableName := dmDados.tbFunc.TableName;
  Tabela.Open;
  //Campo que n�o pode repetir
  {If dbeCpf.Text<>'           ' Then
      Begin
      VerCPF1.NumeroCPF:= dbecpf.text;
      If not VerCpf1.valid Then
        MsgDlg.MsgError('CPF inv�lido');
      If Tabela.Locate('CPF',dbeCPF.Text,[]) Then
        If not((DmDados.tbFunc.State=dsEdit) And (dmDados.tbFunc.RecNo = Tabela.RecNo)) Then
          Begin
          Gravar:=False;
          MsgDlg.MsgWarning('CPF j� Cadastrado');
          end;
      End;}
  //Campo que n�o pode estar vazio
  If DBnome.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Nome do Funcion�rio';
    Gravar:=False;
    Vazio:=True;
    end;
  If DBEend.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Endere�o';
    Gravar:=False;
    Vazio:=True;
    end;
  If DBEnum.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'N�mero';
    Gravar:=False;
    Vazio:=True;
    end;
  If DBEbairro.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Bairro';
    Gravar:=False;
    Vazio:=True;
    end;
  If dbCidade.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Cidade';
    Gravar:=False;
    Vazio:=True;
    end;
  If DBEcep.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'CEP';
    Gravar:=False;
    Vazio:=True;
    end;
  If RxDBSal.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Sal�rio';
    Gravar:=False;
    Vazio:=True;
    end;
  //Campos com uso de Combo
  If cmbUF.Text= '' then
    begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'Estado';
    Gravar:=False;
    Vazio:=True;
    End
  Else
    Begin
    Flag:=True;
    For x:=0 to cmbUF.Items.Count-1 Do
      If cmbUF.Text=cmbUF.Items[x] Then
        Flag:=False;
    If Flag Then
      Begin
      MsgDlg.MsgError('Valor do Estado inv�lido');
      Gravar:=False;
      End;
    End;
  If DBcmbSit.Text= '' then
    begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'Situa��o';
    Gravar:=False;
    Vazio:=True;
    End
  Else
    Begin
    Flag:=True;
    For x:=0 to DBcmbSit.Items.Count-1 Do
      If DBcmbSit.Text=DBcmbSit.Items[x] Then
        Flag:=False;
    If Flag Then
      Begin
      MsgDlg.MsgError('Valor do Situa��o inv�lido');
      Gravar:=False;
      End;
    End;
  //Campo que tem conte�do de outra Tabela
  If DbLookCargo.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Cargo Ocupado';
    Gravar:=False;
    Vazio:=True;
    end
  Else
    If Not(dmDados.tbCargoFunc.Locate('Cargo',DbLookCargo.Text,[])) Then
      Begin
      MsgDlg.MsgWarning('Cargo Ocupado n�o Cadastrado');
      Gravar:=False;
      End;
  //Campo Data n�o podendo ser vazio
  If dbdEdtNasc.Text= '  /  /    ' then
    Begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'Data de Nascimento';
    Gravar:=False;
    Vazio:=True;
    End;
  If dbdedtAdm.Text= '  /  /    ' then
    Begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'Data de Admiss�o';
    Gravar:=False;
    Vazio:=True;
    End;
  If Gravar Then
    Begin
    DMDados.TbFunc.Post;
    NovoItem:=False;
    BtnGravar.Enabled:=False;
    BtnCancelar.Enabled:=False;
    BtnNovo.Enabled:=True;
    BtnPrimeiro.Enabled:=True;
    BtnAnterior.Enabled:=True;
    BtnProximo.Enabled:=True;
    BtnUltimo.Enabled:=True;
    if (frmPrincipal.Acesso=1) or (frmPrincipal.Acesso=2) then
      BtnAlterar.Enabled:=True;
    if (frmPrincipal.Acesso=1) then
      Btndeletar.Enabled:=True;
    BtnLocalizar.Enabled:=True;
    Panel3.SetFocus;
    {desabilitando os componentes}
    DbLookCargo.Enabled:=False;
//    rxdbComissao.Enabled:=False;
    DBNome.Enabled:=False;
    dbDataCad.Enabled:=False;
    DBdEdtNasc.Enabled:=False;
    DBETel1.Enabled:=False;
    dbeCel.Enabled:=False;
    DBEcpf.Enabled:=False;
    DBErg.Enabled:=False;
    DBEend.Enabled:=False;
    DBEnum.Enabled:=False;
    DBEcompl.Enabled:=False;
    DBEbairro.Enabled:=False;
    dbCidade.Enabled:=False;
    DBEcep.Enabled:=False;
    cmbUF.Enabled:=False;
    dbdedtAdm.Enabled:=False;
    RxDBSal.Enabled:=False;
    DBcmbSit.Enabled:=False;
//    dbLimDesc.Enabled:=False;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    End
  Else
    Begin
    If Vazio Then
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
    end;
  Tabela.Free;
end;

procedure TFrmFuncionario.DBMemoInfoExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TFrmFuncionario.dbLookCargoExit(Sender: TObject);
begin
  If NovoItem Then
    Begin
    If DbLookCargo.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o Cargo Ocupado');
      DbLookCargo.SetFocus;
      End
    Else
      If Not(dmDados.tbCargoFunc.Locate('Cargo',DbLookCargo.Text,[])) Then
        Begin
        MsgDlg.MsgWarning('Cargo n�o Cadastrado');
        DbLookCargo.SetFocus;
        End;
    end;
end;

procedure TFrmFuncionario.dbNomeExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  If NovoItem Then
    Begin
    Tabela := TTable.Create(Application);
    Tabela.DatabaseName := dmDados.tbDepenFunc.DatabaseName;
    Tabela.TableName := dmDados.tbDepenFunc.TableName;
    Tabela.IndexName := dmDados.tbDepenFunc.IndexName;
    Tabela.MasterSource := dmDados.tbDepenFunc.MasterSource;
    Tabela.MasterFields := dmDados.tbDepenFunc.MasterFields;
    Tabela.Open;
    If dbNome.Text= '' then
      begin
      MsgDlg.MsgWarning('� obrigat�rio o Nome do Dependente');
      dbNome.SetFocus;
      end
    else
      Begin
      If Tabela.Locate('NomeDep',dbNome.Text,[]) Then
        If (DmDados.tbDepenFunc.State=dsEdit) And (dmDados.tbDepenFunc.RecNo = Tabela.RecNo) Then
        Else
          Begin
          MsgDlg.MsgWarning('Dependente j� Cadastrado');
          dbNome.Clear;
          dbNome.setfocus;
          End;
      End;
    Tabela.Free;
    end;
end;

procedure TFrmFuncionario.DBedtNascExit(Sender: TObject);
begin
  {If NovoItem Then
    If DbDateEditCad.Text= '  /  /    ' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio a Data de Nascimento');
      DbDateEditCad.SetFocus;
      End; }
end;

procedure TFrmFuncionario.dbcmbParenExit(Sender: TObject);
{Var
  x:integer;
  Flag:Boolean;}
begin
 { If NovoItem Then
    Begin
    If dbcmbParen.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio informar o Parentesco');
      dbcmbParen.SetFocus;
      End
    Else
      Begin
      Flag:=True;
      For x:=0 to dbcmbParen.Items.Count-1 Do
        If dbcmbParen.Text=dbcmbParen.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        MsgDlg.MsgWarning('Valor de Parentesco inv�lido');
        dbcmbParen.SetFocus;
        End
      Else
        Begin
        btnGravaDep.Default:= True;
        btnGravaDep.SetFocus;
        End;
      End;
    End
  Else
    Begin
    btnGravaDep.Default:= True;
    btnGravaDep.SetFocus;
    End; }
end;

procedure TFrmFuncionario.DCPage3Show(Sender: TObject);
begin
  NovoItem:=True;
  dmDados.tbDepenFunc.Append;
  dbNome.SetFocus;
end;

procedure TFrmFuncionario.btnGravaDepClick(Sender: TObject);
{Var
  Campos:String;
  Vazio,Gravar,Flag:Boolean;
  x:Integer;
  Tabela: TTable; }
begin
 { btnGravaDep.Default:= False;
  Campos:='';
  Gravar:=True;
  Vazio:=False;
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbDepenFunc.DatabaseName;
  Tabela.TableName := dmDados.tbDepenFunc.TableName;
  Tabela.IndexName := dmDados.tbDepenFunc.IndexName;
  Tabela.MasterSource := dmDados.tbDepenFunc.MasterSource;
  Tabela.MasterFields := dmDados.tbDepenFunc.MasterFields;
  Tabela.Open;
  //Campo que n�o pode repetir
  If dbNome.Text= '' then
    begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'Nome Dependente';
    Gravar:=False;
    Vazio:=True;
    end
  else
    If Tabela.Locate('NomeDep',dbNome.Text,[]) Then
      If Not((DmDados.tbDepenFunc.State=dsEdit) And (dmDados.tbDepenFunc.RecNo = Tabela.RecNo)) Then
        Begin
       	Gravar:=False;
        MsgDlg.MsgWarning('Dependente j� Cadastrado');
        End;
  //Campos com uso de Combo
  If dbcmbParen.Text= '' then
    begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'Parentesco';
    Gravar:=False;
    Vazio:=True;
    End
  Else
    Begin
    Flag:=True;
    For x:=0 to dbcmbParen.Items.Count-1 Do
      If dbcmbParen.Text=dbcmbParen.Items[x] Then
        Flag:=False;
    If Flag Then
      Begin
      MsgDlg.MsgWarning('Valor de Parentesco inv�lido');
      Gravar:=False;
      End;
    End;
  //Campo Data n�o podendo ser vazio
  If DBedtNasc.Text= '  /  /    ' then
    Begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'Data Nascimento';
    Gravar:=False;
    Vazio:=True;
    End;
  If Gravar Then
    Begin
    DMDados.TbDepenFunc.Post;
    Panel3.SetFocus;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    End
  Else
    Begin
    If Vazio Then
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
    dbNome.SetFocus;
    end;
  Tabela.Free;
  dmDados.tbDepenFunc.Append;
  dbNome.SetFocus;}
end;

procedure TFrmFuncionario.DCPage3Exit(Sender: TObject);
begin
  NovoItem:=False;
  dmDados.tbDepenFunc.Cancel;
end;

procedure TFrmFuncionario.FormShow(Sender: TObject);
begin
  dmdados.tbCargo.Open;
  dmDados.tbFunc.Open;
  dmDados.tbDepenFunc.Open;
  dmDados.tbFuncEsto.Open;
  dmDados.tbMovEstoque.Open;
  dmDados.tbVendas.Open;
  dmDados.vTabStt:=True;
  NovoItem:= false;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar  [F9] Localizar [Delete] Excluir [Esc] Cancelar ou Sair');
end;

procedure TFrmFuncionario.FormKeyDown(Sender: TObject; var Key: Word;
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
      VK_F9     : btnLocalizar.Click;
     end;
end;
procedure TFrmFuncionario.FormActivate(Sender: TObject);
begin
  if (frmPrincipal.Acesso=1) or (frmPrincipal.Acesso=2) then
    BtnAlterar.Enabled:=True;
  if (frmPrincipal.Acesso=1) then
    Btndeletar.Enabled:=True;
  dmdados.tbCargo.Open;
  dmDados.tbFunc.Open;
  dmDados.tbDepenFunc.Open;
  dmDados.tbFuncEsto.Open;
  dmDados.tbMovEstoque.Open;
  dmDados.tbVendas.Open;
  dmDados.vTabStt:=True;
end;

procedure TFrmFuncionario.btnDepenClick(Sender: TObject);
begin
  if (dmdados.tbFunc.State=dsInsert) or (dmdados.tbFunc.State=dsEdit) then
    MsgDlg.MsgWarning('Bot�o n�o pode ser acionado no momento|Gravar as Informa��es do Cliente primeiro')
  else
    begin
    FrmCadDepFunc:=TFrmCadDepFunc.create(application);
    FrmCadDepFunc.Show;
    end;
end;

procedure TFrmFuncionario.btnObsClick(Sender: TObject);
begin
    FrmObs:=TFrmObs.create(application);
    FrmObs.Show;
end;

procedure TFrmFuncionario.btnCidadeClick(Sender: TObject);
begin
    FrmCidade:=TFrmCidade.create(application);
    FrmCidade.Show;
end;

procedure TFrmFuncionario.dbEmailExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TFrmFuncionario.dbCidadeExit(Sender: TObject);
begin
    Panel3.SetFocus;
end;

end.
