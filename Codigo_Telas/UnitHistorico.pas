/////////////////////////////////////////////////////////////////////////
// Cria��o...........: 12-02-2001
// Ultima modifica��o: 27-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitHistorico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvTransBtn, StdCtrls, Mask, DBCtrls, Grids, DB,
  DBTables, DBGrids, RXDBCtrl, JvLabel, ExtCtrls, fcLabel, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  EMsgDlg;

type
  TFrmHistorico = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    JvLabel10: TJvLabel;
    gridHist: TRxDBGrid;
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
    procedure dbCodExit(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHistorico    : TFrmHistorico;
  NovoItem, Mudar : Boolean;

implementation

uses unitDmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmHistorico.btnSairClick(Sender: TObject);
begin
  DmDados.tbHistorico.Close;
  Close;
end;

procedure TFrmHistorico.dbCodExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbHistorico.DatabaseName;
  Tabela.TableName := dmDados.tbHistorico.TableName;
  Tabela.IndexName := dmdados.tbHistorico.IndexName;
  Tabela.Open;
  if NovoItem then
    begin
    if dbcod.Text = '' Then
      begin
      MsgDlg.MsgError('� necess�rio Informar o C�digo');
      Dbcod.setfocus;
      end
    else
      begin
      if Tabela.Locate('CodHist',dbcod.Text,[]) then
        begin
        if not ((DmDados.tbHistorico.State=dsEdit) And (dmDados.tbHistorico.RecNo = Tabela.RecNo)) then
          begin
          MsgDlg.MsgWarning('C�digo j� cadastrado');
          dbcod.Clear;
          dbcod.setfocus;
          end;
        end;
      end;
    end;
  Tabela.Free;
end;

procedure TFrmHistorico.btnPrimeiroClick(Sender: TObject);
begin
  dmdados.tbHistorico.First;
  Btnprimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  dmdados.vTabStt:=true;
end;

procedure TFrmHistorico.btnAnteriorClick(Sender: TObject);
begin
  dmdados.tbHistorico.Prior;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  if dmdados.tbHistorico.bof then
    begin
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    end;
  dmdados.vTabStt:=true;
end;

procedure TFrmHistorico.btnProximoClick(Sender: TObject);
begin
  dmdados.tbHistorico.next;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  if dmdados.tbHistorico.Eof then
    begin
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    end;
  dmdados.vTabStt:=true;
end;

procedure TFrmHistorico.btnUltimoClick(Sender: TObject);
begin
  dmdados.tbHistorico.last;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  dmdados.vTabStt:=true;
end;

procedure TFrmHistorico.btnNovoClick(Sender: TObject);
begin
  DMDados.tbHistorico.Append;
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
  dbCod.Enabled:=True;
  dbDesc.Enabled:= True;
  gridHist.Enabled:=true;
  dbCod.SetFocus;
end;

procedure TFrmHistorico.btnGravarClick(Sender: TObject);
Var
  Campos:String;
  Vazio,Gravar:Boolean;
  tabela: ttable;
begin
  Campos:='';
  Gravar:=true;
  Vazio:=False;
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbHistorico.DatabaseName;
  Tabela.TableName := dmDados.tbHistorico.TableName;
  Tabela.IndexName := dmdados.tbHistorico.IndexName;
  Tabela.Open;
  if dbCod.Text='' then
    begin
    if Length(Campos)>0 then Campos:=Campos+', ';
    Campos:=Campos+'C�digo';
    Gravar:=false;
    Vazio:=True;
    end
  else
    begin
    if Tabela.Locate('CodHist',dbCod.Text,[]) then
      if not((DmDados.tbHistorico.State=dsEdit) And (dmDados.tbHistorico.RecNo = Tabela.RecNo)) Then
        begin
        Gravar:=false;
        MsgDlg.MsgWarning('C�digo j� cadastrado');
        end;
    end;
  if dbDesc.Text='' then
    begin
    if Length(Campos)>0 then Campos:=Campos+', ';
    Campos:=Campos+'Descri��o';
    Gravar:=False;
    Vazio:=True;
    end
  else
    begin
    if Tabela.Locate('Descricao',dbDesc.Text,[]) then
      if not((DmDados.tbHistorico.State=dsEdit) And (dmDados.tbHistorico.RecNo = Tabela.RecNo)) Then
        begin
        Gravar:=False;
        MsgDlg.MsgWarning('Hist�rico j� cadastrado');
        end;
    end;
  if gravar then
    begin
    NovoItem:= False;
    dmdados.tbHistorico.Post;
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
    dbCod.Enabled:=false;
    dbDesc.Enabled:=false;
    gridHist.Enabled:=false;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    Panel3.SetFocus;
    end
  else
    begin
    if Vazio then
      begin
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
      dbCod.SetFocus;
      end;
    end;
  tabela.Free;
end;

procedure TFrmHistorico.btnCancelarClick(Sender: TObject);
begin
  dmdados.tbHistorico.cancel;
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
  BtnAlterar.Enabled:=True;
  BtnDeletar.Enabled:=True;
  {Habilitando os componentes}
  gridHist.Enabled:=false;
  DbCod.Enabled:=False;
  DbDesc.enabled:=false;
  Panel3.SetFocus;
end;

procedure TFrmHistorico.btnAlterarClick(Sender: TObject);
begin
  if dmdados.tbHistorico.RecordCount=0 then
    MsgDlg.MsgInformation('Tabela vazia')
  else
    begin
    novoitem:=true;
    dmdados.vTabStt:=false;
    dmdados.tbHistorico.Edit;
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
    gridHist.Enabled:=true;
    DbCod.Enabled:=True;
    dbDesc.Enabled:=True;
    DbCod.SetFocus;
    end;
end;

procedure TFrmHistorico.btnDeletarClick(Sender: TObject);
var
   flag:boolean;
begin
  NovoItem:=False;
  flag:=false;
  if dmdados.tbHistorico.RecordCount=0 then
    MsgDlg.MsgInformation('Tabela vazia')
  else
    If MsgDlg.MsgConfirmation('Tem certeza que deseja excluir esse registro?') = id_yes then
      begin
      if dmdados.tbCReceber.Locate('CodHist',dmdados.tbHistoricoCodHist.Value,[]) then
        flag:=true;
      if dmdados.TbMovConta.Locate('CodHist',dmdados.tbHistoricoCodHist.Value,[]) then
        flag:=true;
      if dmdados.tbCPagar.Locate('CodHist',dmdados.tbHistoricoCodHist.Value,[]) then
        flag:=true;
      if flag then
        MsgDlg.MsgWarning('Hist�rico ativo, ou com registro de opera��es anteriores, n�o pode ser exclu�do !!!')
      else
        dmdados.tbHistorico.Delete;
      end
    else
      dmdados.tbHistorico.Cancel;
end;

procedure TFrmHistorico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.HabilitaTeclado:=True;
  Action:= Cafree;
end;

procedure TFrmHistorico.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFrmHistorico.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    end;
end;

procedure TFrmHistorico.FormShow(Sender: TObject);
begin
  dmDados.vTabStt:=True;
  NovoItem:= false;
  dmDados.tbHistorico.Open;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [Esc] Cancelar ou Sair');
  if dmdados.tbHistorico.RecordCount=0 then
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

procedure TFrmHistorico.FormActivate(Sender: TObject);
begin
 FrmPrincipal.StatusTeclas(True,' [Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [Esc] Cancelar ou Sair');
  dmDados.vTabStt:=True;
  dmDados.tbCReceber.Open;
  dmDados.TbMovConta.Open;
  dmDados.tbCPagar.Open;
end;

end.
