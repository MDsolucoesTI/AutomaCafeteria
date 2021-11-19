/////////////////////////////////////////////////////////////////////////
// Cria��o...........: 13-02-2001
// Ultima modifica��o: 28-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitEntMat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EMsgDlg, JvComponent, JvTransBtn, StdCtrls, Mask, DBCtrls,
  Grids, DBGrids, RXDBCtrl, JvLabel, fcLabel, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  fcButton, fcImgBtn, JvToolEdit, JvCurrEdit, JvDBCtrl, DB, DBTables,
  JvEnterTab;

type
  TFrmEntrMat = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    JvLabel10: TJvLabel;
    GridEnt: TRxDBGrid;
    dbDesc: TDBEdit;
    Panel3: TLMDBackPanel;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    MsgDlg: TEvMsgDlg;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    dbCodMerc: TDBEdit;
    dbQuant: TJvDBCalcEdit;
    btnLocProd: TfcImageBtn;
    JvLabel3: TJvLabel;
    dbMotivo: TDBMemo;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure btnSairClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLocProdClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbCodMercExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEntrMat : TFrmEntrMat;
  NovoItem   : Boolean    ;
  Mudar      : Boolean    ;

implementation

uses unitDmDados, UnitLocProd, UnitPrincipal;

{$R *.dfm}

procedure TFrmEntrMat.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmEntrMat.btnPrimeiroClick(Sender: TObject);
begin
  dmDados.tbEntrada.First;
  BtnPrimeiro.Enabled := False;
  BtnAnterior.Enabled := False;
  BtnProximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
  dmDados.vTabStt     := True ;
end;

procedure TFrmEntrMat.btnAnteriorClick(Sender: TObject);
begin
  dmDados.tbEntrada.Prior;
  BtnProximo.Enabled := True;
  BtnUltimo.Enabled  := True;
  if dmDados.tbEntrada.Bof then
    begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    end;
  dmDados.vTabStt    := True;
end;

procedure TFrmEntrMat.btnProximoClick(Sender: TObject);
begin
  dmDados.tbEntrada.Next;
  BtnPrimeiro.Enabled := True;
  BtnAnterior.Enabled := True;
  if dmDados.tbEntrada.Eof then
    begin
    BtnProximo.Enabled := False;
    BtnUltimo.Enabled  := False;
    end;
  dmDados.vTabStt     := True;
end;

procedure TFrmEntrMat.btnUltimoClick(Sender: TObject);
begin
  dmDados.tbEntrada.Last;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  BtnProximo.Enabled  := False;
  BtnUltimo.Enabled   := False;
  dmDados.vTabStt     := True ;
end;

procedure TFrmEntrMat.btnNovoClick(Sender: TObject);
begin
  dmDados.tbEntrada.Append;
  dmdados.tbEntradaData.Value := Date;
  NovoItem            := True ;
  {habilitando os bot�es}
  BtnGravar.Enabled   := True ;
  BtnCancelar.Enabled := True ;
  BtnNovo.Enabled     := False;
  BtnPrimeiro.Enabled := False;
  BtnAnterior.Enabled := False;
  BtnProximo.Enabled  := False;
  BtnUltimo.Enabled   := False;
  {habilitando os componentes}
  DBQuant.Enabled     := True ;
  DBMotivo.Enabled    := True ;
  DBCodMerc.Enabled   := True ;
  GridEnt.Enabled     := False;
  dmDados.vTabStt     := False;
  DBCodMerc.SetFocus;
end;

procedure TFrmEntrMat.btnGravarClick(Sender: TObject);
begin
  with dmDados do
    begin
    tbEntradaQuant.Value      := StrToFloat(dbQuant.Text)                          ;
    tbEntradaTipo.Value       := 'E'                                               ;
    tbEntrada.Post;
    //Atualiza quantidade em estoque
    tbEstoque.Locate('CodMerc',dbCodMerc.Text,[]);
    tbEstoque.Edit;
    tbEstoqueQuantidade.Value := tbEstoqueQuantidade.Value+StrToFloat(dbQuant.Text);
    tbEstoque.Post;
    end;
    dmDados.vTabStt     := True ;
    NovoItem            := False;
    BtnGravar.Enabled   := False;
    BtnCancelar.Enabled := False;
    BtnNovo.Enabled     := True ;
    BtnPrimeiro.Enabled := True ;
    BtnAnterior.Enabled := True ;
    BtnProximo.Enabled  := True ;
    BtnUltimo.Enabled   := True ;
    {desabilitando os componentes}
    DBQuant.Enabled     := False;
    DBMotivo.Enabled    := False;
    DBCodMerc.Enabled   := False;
    GridEnt.Enabled     := True ;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    Panel3.SetFocus;
end;

procedure TFrmEntrMat.btnCancelarClick(Sender: TObject);
begin
  DMDados.tbEntrada.Cancel;
  NovoItem            := False;
  BtnGravar.Enabled   := False;
  BtnCancelar.Enabled := False;
  BtnNovo.Enabled     := True ;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  BtnProximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
  {desabilitando os objetos}
  DBQuant.Enabled     := False;
  DBMotivo.Enabled    := False;
  DBCodMerc.Enabled   := False;
  GridEnt.Enabled     := True ;
  dmDados.vTabStt     := True ;
  Panel3.SetFocus;
end;

procedure TFrmEntrMat.btnLocProdClick(Sender: TObject);
begin
  if (dmdados.tbEntrada.State=dsInsert) or (dmdados.tbEntrada.State=dsEdit) then
    begin
    frmLocProd := TfrmLocProd.Create(Application);
    frmLocProd.ShowModal;
    dmdados.tbEntradaCodMerc.Value := frmLocProd.Resultado;
    frmLocProd.free;
    end;
end;

procedure TFrmEntrMat.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmDados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_INSERT : if (dmDados.vTabStt) then BtnNovo.Click;
      VK_END    : if not(dmDados.vTabStt) then BtnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
      VK_F9     : btnLocProd.Click;
    end;
end;

procedure TFrmEntrMat.FormShow(Sender: TObject);
begin
  dmDados.vTabStt:=True;
  if (dmDados.tbEstoque.State    = dsInactive) then
    dmDados.tbEstoque.Open;
  if (dmDados.tbEntrada.State    = dsInactive) then
    dmDados.tbEntrada.Open;
  if (dmDados.tbFuncEsto.State   = dsInactive) then
    dmDados.tbFuncEsto.Open;
  if (dmDados.tbMovEstoque.State = dsInactive) then
    dmDados.tbMovEstoque.Open;
  if (dmDados.tbGrupo.State      = dsInactive) then
    dmDados.tbGrupo.Open;
  if (dmDados.tbSubGrupo.State   = dsInactive) then
    dmDados.tbSubGrupo.Open;
  if (dmDados.tbMarca.State      = dsInactive) then
    dmDados.tbMarca.Open;
  if (dmDados.tbUnidade.State    = dsInactive) then
    dmDados.tbUnidade.Open;
  if (dmDados.tbDetVendas.State  = dsInactive) then
    dmDados.tbDetVendas.Open;
  dmDados.HabilitaTeclado:= True;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [Esc] Cancelar ou Sair [F9] Localizar Produto ');
end;

procedure TFrmEntrMat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.tbEstoque.Close;
  dmDados.tbEntrada.Close;
  dmDados.tbFuncEsto.Close;
  dmDados.tbMovEstoque.Close;
  dmDados.tbGrupo.Close;
  dmDados.tbSubGrupo.Close;
  dmDados.tbMarca.Close;
  dmDados.tbUnidade.Close;
  dmDados.tbDetVendas.Close;
  Action:=caFree;
end;

procedure TFrmEntrMat.dbCodMercExit(Sender: TObject);
begin
if NovoItem then
    begin
    if dbCodMerc.Text= '' then
      begin
      MsgDlg.MsgError('� obrigat�rio o C�DIGO!');
      dbCodMerc.SetFocus;
      end
    else
      begin
      if Not(dmDados.tbEstoque.Locate('CodMerc',dbCodMerc.Text,[])) then
        begin
        MsgDlg.MsgError('C�DIGO n�o Cadastrado');
        dbCodMerc.SetFocus;
        end;
      end;
    end;
end;

end.
