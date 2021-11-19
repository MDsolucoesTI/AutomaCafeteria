//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 17-05-2007
// Ultima modifica��o: 10-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untCompos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RXDBCtrl, StdCtrls, Mask, DBCtrls, fcButton,
  fcImgBtn, RXCtrls, fcLabel, EMsgDlg, JvComponent, JvTransBtn,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, EUserAcs, JvEnterTab, ExtCtrls,
  JvPanel, JvTransparentPanel;

type
  TFrmCompos = class(TForm)
    UserAcess: TEvUserAccess;
    Panel3: TLMDBackPanel;
    btnGravar: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnAlterar: TJvTransparentButton;
    MsgDlg: TEvMsgDlg;
    LMDBackPanel2: TLMDBackPanel;
    fcLabel1: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel3: TRxLabel;
    btnLocProd: TfcImageBtn;
    dbDescComp: TDBEdit;
    RxDBGrid1: TRxDBGrid;
    dbCodComp: TDBEdit;
    dbFator: TDBEdit;
    dbCodProd: TDBEdit;
    RxLabel6: TRxLabel;
    RxLabel7: TRxLabel;
    dbDesc: TDBEdit;
    Principal: TGroupBox;
    Composicao: TGroupBox;
    edtCodComp: TEdit;
    dbNada: TDBEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    JvTransparentPanel1: TJvTransparentPanel;
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
    procedure btnLocProdClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtCodCompExit(Sender: TObject);
    procedure dbFatorExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCompos : TFrmCompos;
  NovoItem  : Boolean   ;
  Mudar     : Boolean   ;

implementation

uses unitDmDados, UnitLocProd, UnitPrincipal, DB;

{$R *.dfm}

procedure TFrmCompos.btnPrimeiroClick(Sender: TObject);
begin
  dmDados.tbCompEsto.First;
  BtnPrimeiro.Enabled := False;
  BtnAnterior.Enabled := False;
  BtnProximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
  dmDados.vTabStt     := True ;
end;

procedure TFrmCompos.btnAnteriorClick(Sender: TObject);
begin
  dmDados.tbCompEsto.Prior;
  BtnProximo.Enabled := True;
  BtnUltimo.Enabled  := True;
  If dmDados.tbCompEsto.Bof Then
    Begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    End;
  dmDados.vTabStt := True;
end;

procedure TFrmCompos.btnProximoClick(Sender: TObject);
begin
  dmDados.tbCompEsto.Next;
  BtnPrimeiro.Enabled := True;
  BtnAnterior.Enabled := True;
  If dmDados.tbCompEsto.Eof Then
    Begin
    BtnProximo.Enabled := False;
    BtnUltimo.Enabled  := False;
    End;
  dmDados.vTabStt := True;
end;

procedure TFrmCompos.btnUltimoClick(Sender: TObject);
begin
  dmDados.tbCompEsto.Last;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  BtnProximo.Enabled  := False;
  BtnUltimo.Enabled   := False;
  dmDados.vTabStt     := True ;
end;

procedure TFrmCompos.btnNovoClick(Sender: TObject);
begin
  dmDados.tbCompEsto.Append;
  btnAnterior.Enabled := False;
  btnPrimeiro.Enabled := False;
  btnProximo.Enabled  := False;
  btnUltimo.Enabled   := False;
  NovoItem            := True ;
  {habilitando os bot�es}
  btngravar.Enabled   := True ;
  BtnCancelar.Enabled := True ;
  BtnAlterar.Enabled  := False;
  BtnDeletar.Enabled  := False;
  BtnNovo.Enabled     := False;
  {habilitando os componentes}
  dbCodProd.Enabled   := True;
  dbDesc.Enabled      := True;
  edtCodComp.Enabled  := True ;
  dbDescComp.Enabled  := True ;
  dbFator.Enabled     := True ;
  dmDados.vTabStt     := False;
  UserAcess.ForceDefinitions;
  edtCodComp.SetFocus;
end;

procedure TFrmCompos.btnGravarClick(Sender: TObject);
var
  Gravar : Boolean;
  Vazio  : Boolean;
  Campos : string ;
begin
  Gravar := True ;
  Vazio  := False;
  Campos := ''   ;
  if edtCodComp.Text = '' then
    begin
    if Length(Campos) > 0 then
      Campos := Campos + ', ';
    Campos := Campos + 'C�DIGO PRODUTO';
    Gravar := False                    ;
    end;
  if dbFator.Text = '' then
  	begin
	  if Length(Campos) > 0 then
      Campos := Campos + ', ';
    Campos := Campos + 'FATOR';
    Gravar := False           ;
    end;
  if Gravar then
    begin
    dmDados.tbCompEsto.Post;
    dmDados.tbEstoPrinc.Edit;
    dmDados.tbEstoPrincComponente.Value := 'S';
    dmDados.tbEstoPrinc.Post;
    NovoItem            := False;
    dmDados.vTabStt     := True ;
    {bot�es}
    BtnGravar.enabled   := False;
    BtnCancelar.Enabled := False;
    BtnNovo.Enabled     := True ;
    BtnPrimeiro.Enabled := True ;
    BtnAnterior.Enabled := True ;
    BtnProximo.Enabled  := True ;
    BtnUltimo.Enabled   := True ;
    BtnAlterar.Enabled  := True ;
    Btndeletar.Enabled  := True ;
    {componentes}
    dbCodProd.Enabled   := False;
    dbDesc.Enabled      := False;
    edtCodComp.Enabled  := False;
    dbDescComp.Enabled  := False;
    dbFator.Enabled     := False;
    //MsgDlg.MsgInformation('Dados gravados com sucesso!');
    Panel3.SetFocus;
    end
  else
    if Vazio then
      begin
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
      edtCodComp.Enabled := True;
      end;
end;

procedure TFrmCompos.btnCancelarClick(Sender: TObject);
begin
  dmdados.tbCompEsto.Cancel;
  NovoItem            := False;
  btngravar.Enabled   := False;
  BtnCancelar.Enabled := False;
  BtnAlterar.Enabled  := True ;
  BtnDeletar.Enabled  := True ;
  BtnNovo.Enabled     := True ;
  {Habilitando os componentes}
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  BtnProximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
  BtnAlterar.Enabled  := True ;
  BtnDeletar.Enabled  := True ;
  {desabilitando os objetos}
  dbCodProd.Enabled   := False;
  dbDesc.Enabled      := False;
  edtCodComp.Enabled  := False;
  dbDescComp.Enabled  := False;
  dbFator.Enabled     := False;
  dmDados.vTabStt     := True ;
  UserAcess.ForceDefinitions;
  Panel3.SetFocus;
end;

procedure TFrmCompos.btnAlterarClick(Sender: TObject);
begin
  if dmdados.tbCompEsto.RecordCount = 0 then
    MsgDlg.MsgError('Tabela sem registro')
  else
    begin
    dmdados.tbCompEsto.Edit;
    NovoItem            := True ;
    {habilitando os bot�es}
    BtnCancelar.Enabled := True ;
    btngravar.Enabled   := True ;
    BtnNovo.Enabled     := False;
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    BtnProximo.Enabled  := False;
    BtnUltimo.Enabled   := False;
    BtnAlterar.Enabled  := False;
    Btndeletar.Enabled  := False;
    {habilitando os componentes}
    dbCodProd.Enabled   := True;
    dbDesc.Enabled      := True;
    edtCodComp.Enabled  := True ;
    dbDescComp.Enabled  := True ;
    dbFator.Enabled     := True ;
    dmDados.vTabStt     := False;
    edtCodComp.SetFocus;
    end;
  UserAcess.ForceDefinitions;
end;

procedure TFrmCompos.btnDeletarClick(Sender: TObject);
begin
  If dmDados.tbCompEsto.RecordCount=0 Then
    MsgDlg.MsgError('Tabela vazia!!!')
  Else
    if MsgDlg.MsgConfirmation('Deseja realmente excluir o registro?') = IDYES then
       DMdados.tbCompEsto.Delete;
end;

procedure TFrmCompos.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCompos.btnLocProdClick(Sender: TObject);
begin
  if (dmdados.tbCompEsto.State = dsInsert)or(dmdados.tbCompEsto.State = dsEdit) then
    begin
    FrmLocProd := TfrmLocProd.create(application);
    FrmLocProd.ShowModal;
    edtCodComp.Text                := frmLocProd.Resultado       ;
    dmdados.tbCompEstoCodCom.Value := dmDados.tbEstoqueNada.Value;
    frmLocProd.Free;
    edtCodComp.SetFocus;
    end;
end;

procedure TFrmCompos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmDados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_INSERT : if (dmDados.vTabStt) then BtnNovo.Click;
      VK_HOME   : if (dmDados.vTabStt) then BtnAlterar.Click;
      VK_DELETE : if (dmDados.vTabStt) then BtnDeletar.Click;
      VK_END    : if not(dmDados.vTabStt) then BtnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
      VK_F2     : BtnLocProd.Click;
    end;
end;

procedure TFrmCompos.FormActivate(Sender: TObject);
begin
  UserAcess.UserID:=frmPrincipal.Acesso;
end;

procedure TFrmCompos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  Action := Cafree;
end;

procedure TFrmCompos.FormShow(Sender: TObject);
begin
  //habilitando-desabilitanto bot�es
  If dmDados.tbCompEsto.RecordCount=0 Then
    begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    BtnProximo.Enabled  := False;
    BtnUltimo.Enabled   := False;
    BtnNovo.Enabled     := True ;
    BtnCancelar.Enabled := False;
    BtnAlterar.Enabled  := False;
    Btndeletar.Enabled  := False;
    end;
  dmDados.vTabStt         := True ;
  BtnSair.Enabled         := True ;
  BtnGravar.Enabled       := False;
  edtCodComp.Enabled      := False;
  dmDados.HabilitaTeclado := True ;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [F2] Loc. Produto [Esc] Cancelar ou Sair');
end;

procedure TFrmCompos.edtCodCompExit(Sender: TObject);
begin
  if NovoItem then
    begin
    //localizar o produto
    if edtCodComp.Text = '' then
      begin
      MsgDlg.MsgWarning('Necess�rio informar o C�DIGO DO PRODUTO');
      edtCodComp.SetFocus;
      end
    else
      if not (dmdados.tbEstoque.Locate('CodMerc',edtCodComp.text,[])) then
        begin
        MsgDlg.MsgWarning('C�DIGO DO PRODUTO n�o cadastrado');
        edtCodComp.SetFocus;
        end
      else
        dmdados.tbCompEstoCodCom.Value := dmDados.tbEstoqueNada.Value;
    end;
end;

procedure TFrmCompos.dbFatorExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

end.
