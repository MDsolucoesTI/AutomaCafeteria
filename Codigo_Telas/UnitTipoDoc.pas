//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 20-02-2001
// Ultima modifica��o: 09-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitTipoDoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EMsgDlg, JvComponent, JvTransBtn, StdCtrls, Mask, DBCtrls, DB,
  DBTables, Grids, DBGrids, RXDBCtrl, JvLabel, ExtCtrls, fcLabel,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDBackPanel;

type
  TFrmTipoDoc = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    JvLabel10: TJvLabel;
    GridTipoDoc: TRxDBGrid;
    dbDesc: TDBEdit;
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
    MsgDlg: TEvMsgDlg;
    JvLabel1: TJvLabel;
    dbCod: TDBEdit;
    procedure btnSairClick(Sender: TObject);
    procedure dbDescExit(Sender: TObject);
    procedure dbCodExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTipoDoc      : TFrmTipoDoc;
  NovoItem, Mudar : Boolean;

implementation

uses unitDmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmTipoDoc.btnSairClick(Sender: TObject);
begin
  DmDados.tbTipoDoc.Close;
  Close;
end;

procedure TFrmTipoDoc.dbDescExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.TbTipoDoc.DatabaseName;
  Tabela.TableName := dmDados.TbTipoDoc.TableName;
  Tabela.Open;
  if NovoItem then
    begin
    if dbDesc.Text = '' then
      begin
      MsgDlg.MsgError('� necess�rio Informar o DOCUMENTO');
      DbDesc.setfocus;
      end
    else
      begin
      if Tabela.Locate('DESCRICAO',dbDesc.Text,[]) then
        begin
        if not ((DmDados.tbTipoDoc.State=dsEdit) And (dmDados.tbTipoDoc.RecNo = Tabela.RecNo)) then
          begin
          MsgDlg.MsgWarning('DOCUMENTO j� Cadastrado');
          dbDesc.Clear;
          dbDesc.setfocus;
          end;
        end;
      end;
    end;
  Tabela.Free;
end;

procedure TFrmTipoDoc.dbCodExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.TbTipoDoc.DatabaseName;
  Tabela.TableName := dmDados.TbTipoDoc.TableName;
  Tabela.Open;
  if NovoItem then
    begin
    if dbCod.Text = '' then
      begin
      MsgDlg.MsgError('� necess�rio Informar o C�DIGO');
      dbCod.setfocus;
      end
    else
      begin
      if Tabela.Locate('CodDoc',dbCod.Text,[]) then
        begin
        if not ((DmDados.tbTipoDoc.State=dsEdit) And (dmDados.tbTipoDoc.RecNo = Tabela.RecNo)) then
          begin
          MsgDlg.MsgWarning('C�DIGO j� Cadastrado');
          dbCod.Clear;
          dbCod.setfocus;
          end;
        end;
      end;
    end;
  Tabela.Free;

end;

procedure TFrmTipoDoc.FormActivate(Sender: TObject);
begin
  dmDados.vTabStt:=True;
  FrmPrincipal.StatusTeclas(True,' [Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [Esc] Cancelar ou Sair');
  dmDados.tbTipoDoc.Open;
  dmDados.tbCReceber.Open;
  dmDados.TbMovConta.Open;
  dmDados.tbCPagar.Open;
  if (frmPrincipal.Acesso=1) or (frmPrincipal.Acesso=2) then
    BtnAlterar.Enabled:=True;
  if (frmPrincipal.Acesso=1) then
    Btndeletar.Enabled:=True;  
end;

procedure TFrmTipoDoc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.HabilitaTeclado:=True;
  dmDados.tbTipoDoc.Close;
  dmDados.tbCReceber.Close;
  dmDados.TbMovConta.Close;
  dmDados.tbCPagar.Close;
  Action:= Cafree;
end;

procedure TFrmTipoDoc.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFrmTipoDoc.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmTipoDoc.FormShow(Sender: TObject);
begin
  dmDados.vTabStt:=True;
  NovoItem:= false;
  dmDados.tbTipoDoc.Open;
  dmDados.tbCReceber.Open;
  dmDados.TbMovConta.Open;
  dmDados.tbCPagar.Open;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [Esc] Cancelar ou Sair');
  if dmdados.TbTipoDoc.RecordCount=0 then
    begin
    Btnprimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    BtnProximo.Enabled:=false;
    BtnUltimo.Enabled:=false;
    btnGravar.Enabled:=false;
    btnAlterar.Enabled:=false;
    btnCancelar.Enabled:=false;
    btnDeletar.Enabled:=false;
    end;
end;

procedure TFrmTipoDoc.btnPrimeiroClick(Sender: TObject);
begin
  dmdados.tbTipoDoc.First;
  Btnprimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  dmdados.vTabStt:=true;
end;

procedure TFrmTipoDoc.btnAnteriorClick(Sender: TObject);
begin
  dmdados.tbTipoDoc.Prior;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  if dmdados.TbTipoDoc.bof then
    begin
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    end;
  dmdados.vTabStt:=true;
end;

procedure TFrmTipoDoc.btnProximoClick(Sender: TObject);
begin
  dmdados.tbTipoDoc.next;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  if dmdados.TbTipoDoc.Eof then
    begin
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    end;
  dmdados.vTabStt:=true;
end;

procedure TFrmTipoDoc.btnUltimoClick(Sender: TObject);
begin
  dmdados.tbTipoDoc.last;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  dmdados.vTabStt:=true;
end;

procedure TFrmTipoDoc.btnNovoClick(Sender: TObject);
begin
  DMDados.tbTipoDoc.Append;
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
  gridTipoDoc.Enabled:=true;
  dbDesc.Enabled:= True;
  dbCod.Enabled:=True;
  dbCod.SetFocus;
end;

procedure TFrmTipoDoc.btnGravarClick(Sender: TObject);
Var
  Campos:String;
  Vazio,Gravar:Boolean;
  tabela: ttable;
begin
  Campos:='';
  Gravar:=True;
  Vazio:=False;
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbTipoDoc.DatabaseName;
  Tabela.TableName := dmDados.tbTipoDoc.TableName;
  Tabela.IndexName := dmdados.tbTipoDoc.IndexName;
  Tabela.Open;
	if dbCod.Text='' then
  	begin
    if Length(Campos)>0 then
    	Campos:=Campos+', ';
    Campos:=Campos+'C�digo';
    Gravar:=False;
    Vazio:=True;
  	end
   else
     begin
     if Tabela.Locate('CodDoc',dbCod.Text,[]) then
       if not((DmDados.tbTipoDoc.State=dsEdit) And (dmDados.tbTipoDoc.RecNo = Tabela.RecNo)) then
          begin
          Gravar:=False;
          MsgDlg.MsgWarning('C�DIGO j� cadastrado');
          end;
     end;
	if dbDesc.Text='' then
  	begin
    if Length(Campos)>0 then
    	Campos:=Campos+', ';
    Campos:=Campos+'Documento';
    Gravar:=False;
    Vazio:=True;
  	end
   else
     begin
     if Tabela.Locate('Descricao',dbDesc.Text,[]) then
       if not((DmDados.tbTipoDoc.State=dsEdit) And (dmDados.tbTipoDoc.RecNo = Tabela.RecNo)) then
          begin
          Gravar:=False;
          MsgDlg.MsgWarning('DOCUMENTO j� cadastrado');
          end;
     end;
  if gravar then
    begin
    NovoItem:= False;
    dmdados.tbTipoDoc.Post;
    dmDados.vTabStt:=True;
    BtnGravar.enabled := False;
    BtnCancelar.Enabled := False;
    BtnNovo.Enabled:=True;
    BtnPrimeiro.Enabled:=True;
    BtnAnterior.Enabled:=True;
    BtnProximo.Enabled:=True;
    BtnUltimo.Enabled:=True;
    if (frmPrincipal.Acesso=1) or (frmPrincipal.Acesso=2) then
      BtnAlterar.Enabled:=True;
    if (frmPrincipal.Acesso=1) then
      Btndeletar.Enabled:=True;
    gridTipoDoc.Enabled:=false;
    dbDesc.Enabled:=false;
    dbCod.Enabled:=False;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    Panel3.SetFocus;
    end
  else
    begin
    if Vazio then
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
      dbCod.Enabled:=true;
    end;
  Tabela.Free;
end;

procedure TFrmTipoDoc.btnCancelarClick(Sender: TObject);
begin
  dmdados.tbTipoDoc.cancel;
  NovoItem:= False;
  dmdados.vTabStt:=true;
  {Desabilitando os bot�es}
  BtnGravar.enabled := false;
  BtnCancelar.Enabled := false;
  BtnNovo.Enabled:=True;
  btnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  Btnproximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  if (frmPrincipal.Acesso=1) or (frmPrincipal.Acesso=2) then
    BtnAlterar.Enabled:=True;
  if (frmPrincipal.Acesso=1) then
    Btndeletar.Enabled:=True;  
  {Habilitando os componentes}
  DbDesc.enabled:=false;
  dbCod.Enabled:=False;
  gridTipoDoc.Enabled:=false;
  Panel3.SetFocus;
end;

procedure TFrmTipoDoc.btnAlterarClick(Sender: TObject);
begin
  if dmdados.tbTipoDoc.RecordCount=0 then
    MsgDlg.MsgInformation('Tabela vazia')
  else
    begin
    novoitem:=true;
    dmdados.vTabStt:=false;
    dmdados.tbTipoDoc.Edit;
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
    dbDesc.Enabled:=True;
    dbCod.Enabled:=True;
    gridTipoDoc.Enabled:=true;
    dbCod.SetFocus;
    end;
end;

procedure TFrmTipoDoc.btnDeletarClick(Sender: TObject);
var
  flag:boolean;
begin
  NovoItem:=False;
  Flag:=False;
  if dmdados.tbTipoDoc.RecordCount=0 then
    MsgDlg.MsgInformation('Tabela vazia')
  else
  if MsgDlg.MsgConfirmation('Tem certeza que deseja exluir esse registro?') = id_yes then
    begin
      if dmDados.tbCReceber.Locate('CodDoc',dmDados.tbTipoDocCodDoc.Value,[]) then
        Flag:=True;
      if dmDados.tbMovConta.Locate('CodDoc',dmDados.tbTipoDocCodDoc.Value,[]) then
        Flag:=True;
      if dmDados.tbCPagar.Locate('CodDoc',dmDados.tbTipoDocCodDoc.Value,[]) then
        Flag:=True;
      if Flag then
        MsgDlg.MsgWarning('Documento ativo, ou com registro de opera��es anteriores, n�o pode ser exclu�do !!!')
      else
        dmdados.TbTipoDoc.Delete;
    end
  else
    dmdados.tbTipoDoc.Cancel;

end;

end.
