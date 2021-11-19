/////////////////////////////////////////////////////////////////////////
// Cria��o...........: 13-01-2001
// Ultima modifica��o: 26-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitCadBanco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvTransBtn, EMsgDlg, fcLabel, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  StdCtrls, Mask, DBCtrls, JvLabel, Grids, DBGrids, RXDBCtrl, ExtCtrls, DB,
  DBTables;

type
  TFrmCadBanco = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    MsgDlg: TEvMsgDlg;
    LMDBackPanel3: TLMDBackPanel;
    Panel3: TLMDBackPanel;
    btnDeletar: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnAlterar: TJvTransparentButton;
    JvLabel1: TJvLabel;
    dbNumbanco: TDBEdit;
    JvLabel2: TJvLabel;
    dbBanco: TDBEdit;
    GridGrupo: TRxDBGrid;
    procedure btnSairClick(Sender: TObject);
    procedure dbBancoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbNumbancoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fOutraJan : Boolean;
  public
    { Public declarations }
    property OutraJan : Boolean read fOutraJan write fOutraJan;
  end;

var
  FrmCadBanco    :  TFrmCadBanco;
  NovoItem, Mudar:  Boolean;

implementation

uses unitDmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmCadBanco.btnSairClick(Sender: TObject);
begin
  dmdados.tbBanco.Close;
  Close;
end;

procedure TFrmCadBanco.dbBancoExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.TbBanco.DatabaseName;
  Tabela.TableName := dmDados.TbBanco.TableName;
  Tabela.IndexName := dmdados.tbBanco.IndexName;
  Tabela.Open;
  if NovoItem then
    if dbBanco.Text = '' then
      begin
      MsgDlg.MsgError('� necess�rio Informar o BANCO');
      DbBanco.setfocus;
      end
    else
      if Tabela.Locate('NomeBanco',dbBanco.Text,[]) then
        if not ((DmDados.tbBanco.State=dsEdit) And (dmDados.tbBanco.RecNo = Tabela.RecNo)) then
          begin
          MsgDlg.MsgWarning('Banco j� cadastrado');
          dbBanco.Clear;
          dbBanco.setfocus;
          end;
  Tabela.Free;
end;

procedure TFrmCadBanco.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmCadBanco.dbNumbancoExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.TbBanco.DatabaseName;
  Tabela.TableName := dmDados.TbBanco.TableName;
  Tabela.IndexName := dmdados.tbBanco.IndexName;
  Tabela.Open;
  if NovoItem then
    if dbNumBanco.Text= '' then
      begin
      MsgDlg.MsgError('� obrigat�rio o Nome');
      dbNumBanco.SetFocus;
      end
    else
      if Tabela.Locate('NumBanco',dbNumBanco.Text,[]) then
        if not ((DmDados.tbBanco.State=dsEdit) And (dmDados.tbBanco.RecNo = Tabela.RecNo)) then
          begin
          MsgDlg.MsgWarning('N�mero j� cadastrado');
          dbNumBanco.Clear;
          dbNumBanco.setfocus;
          end;
  tabela.Free;

end;

procedure TFrmCadBanco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.HabilitaTeclado:=True;
  Action:= Cafree;
  if (not OutraJan) then
    begin
    dmDados.tbBanco.Close;
    dmDados.TbCCorrente.Close;
    end;
end;

procedure TFrmCadBanco.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFrmCadBanco.btnDeletarClick(Sender: TObject);
begin
  NovoItem:=False;
  if dmdados.tbBanco.RecordCount=0 then
    MsgDlg.MsgInformation('Tabela sem registro')
  else
    if MsgDlg.MsgConfirmation('Tem certeza que deseja excluir esse registro?') = id_yes then
      if dmDados.TbCCorrente.Locate('NumBanco',dmDados.tbBancoNumBanco.Value,[]) then
        MsgDlg.MsgWarning('Banco com Conta Corrente Ativa, n�o pode ser exclu�do !!!')
     else
        dmdados.tbBanco.Delete;
end;

procedure TFrmCadBanco.btnPrimeiroClick(Sender: TObject);
begin
  dmdados.TbBanco.First;
  Btnprimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  dmdados.vTabStt:=true;
end;

procedure TFrmCadBanco.btnAnteriorClick(Sender: TObject);
begin
  dmdados.TbBanco.Prior;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  if dmdados.TbBanco.bof then
    begin
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    end;
  dmdados.vTabStt:=true;
end;

procedure TFrmCadBanco.btnProximoClick(Sender: TObject);
begin
  dmdados.TbBanco.next;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  if dmdados.TbBanco.Eof then
    begin
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    end;
  dmdados.vTabStt:=true;
end;

procedure TFrmCadBanco.btnUltimoClick(Sender: TObject);
begin
  dmdados.TbBanco.last;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  dmdados.vTabStt:=true;
end;

procedure TFrmCadBanco.btnNovoClick(Sender: TObject);
begin
  DMDados.tbBanco.Append;
  NovoItem:=True;
  dmdados.vTabStt:=false;
  {habilitando os bot�es}
  BtnGravar.Enabled := true;
  BtnCancelar.Enabled:=true;
  BtnNovo.Enabled:=False;
  BtnPrimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  BtnAlterar.Enabled:=False;
  BtnDeletar.Enabled:=False;
  {habilitando os componentes}
  dbNumbanco.Enabled:=True;
  dbBanco.Enabled:= True;
  dbNumbanco.SetFocus;
end;

procedure TFrmCadBanco.btnGravarClick(Sender: TObject);
Var
  Campos:String;
  Vazio,Gravar:Boolean;
  tabela: ttable;
begin
  Campos:='';
  Gravar:=True;
  Vazio:=False;
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.TbBanco.DatabaseName;
  Tabela.TableName := dmDados.TbBanco.TableName;
  Tabela.IndexName := dmdados.tbBanco.IndexName;
  Tabela.Open;
	if dbNumbanco.Text='' then
  	begin
    if Length(Campos)>0 then Campos:=Campos+', ';
    Campos:=Campos+'N�mero do Banco';
    Gravar:=False;
    Vazio:=True;
    end
  else
    if Tabela.Locate('NumBanco',dbNumbanco.Text,[]) Then
      if not((DmDados.tbBanco.State=dsEdit) And (dmDados.tbBanco.RecNo = Tabela.RecNo)) then
        begin
        Gravar:=False;
        MsgDlg.MsgWarning('N�mero j� cadastrado');
        dbNumbanco.SetFocus;
        end;
	if dbBanco.Text='' then
  	begin
    if Length(Campos)>0 then Campos:=Campos+', ';
    Campos:=Campos+'Banco';
    Gravar:=False;
    Vazio:=True;
  	End
  else
    if Tabela.Locate('NomeBanco',dbBanco.Text,[]) then
      if not((DmDados.tbBanco.State=dsEdit) And (dmDados.tbBanco.RecNo = Tabela.RecNo)) then
        begin
        Gravar:=False;
        MsgDlg.MsgWarning('Banco j� cadastrado');
        dbBanco.SetFocus;
        end;
  if gravar then
    begin
    NovoItem:= False;
    dmdados.tbBanco.Post;
    dmDados.vTabStt:=True;
    BtnGravar.enabled := False;
    BtnCancelar.Enabled := False;
    BtnNovo.Enabled:=True;
    BtnPrimeiro.Enabled:=True;
    BtnAnterior.Enabled:=True;
    BtnProximo.Enabled:=True;
    BtnUltimo.Enabled:=True;
    BtnAlterar.Enabled:=True;
    Btndeletar.Enabled:=True;
    dbNumbanco.Enabled:=false;
    dbBanco.Enabled:=false;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    Panel3.SetFocus;
    end
  else
    begin
    if Vazio then
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
    dbNumbanco.Enabled:=true;
    end;
  tabela.Free;
end;

procedure TFrmCadBanco.btnCancelarClick(Sender: TObject);
begin
  dmdados.tbBanco.cancel;
  NovoItem:= False;
  dmdados.vTabStt:=true;
  {Desabilitando os bot�es}
  BtnGravar.enabled := false;
  BtnCancelar.Enabled := false;
  BtnNovo.Enabled:=True;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  Btnproximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  BtnAlterar.Enabled:=True;
  BtnDeletar.Enabled:=True;
  {Habilitando os componentes}
  dbNumbanco.Enabled:=False;
  dbBanco.enabled:=false;
  Panel3.SetFocus;
end;

procedure TFrmCadBanco.btnAlterarClick(Sender: TObject);
begin
  novoitem:=true;
  dmdados.vTabStt:=false;
  dmdados.tbBanco.Edit;
  //habilitar bot�es
  BtnCancelar.enabled:= true;
  BtnGravar.Enabled:= true;
  BtnNovo.Enabled:=False;
  BtnPrimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  BtnAlterar.Enabled:=False;
  Btndeletar.Enabled:=False;
  //habilitar objetos
  dbNumbanco.Enabled:=True;
  dbBanco.Enabled:=True;
  dbNumbanco.SetFocus;
end;

procedure TFrmCadBanco.FormActivate(Sender: TObject);
begin
  if dmDados.tbBanco.State = dsInactive then
    dmDados.tbBanco.Open;
  if dmDados.TbCCorrente.State = dsInactive then
    dmDados.TbCCorrente.Open;
    dmDados.vTabStt:=True;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [Esc] Cancelar ou Sair');
  if dmdados.tbBanco.RecordCount=0 then
    begin
    btnPrimeiro.Enabled:=false;
    btnAnterior.Enabled:=false;
    btnProximo.Enabled:=false;
    btnUltimo.Enabled:=false;
    btnAlterar.Enabled:=false;
    btnGravar.Enabled:=false;
    btnCancelar.Enabled:=false;
    BtnDeletar.Enabled:=false;
    end;
end;

procedure TFrmCadBanco.FormCreate(Sender: TObject);
begin
  OutraJan := False;
end;

end.
