//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 12-02-2001
// Ultima modifica��o: 08-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitSaidaMat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RackCtls, SpeedBar, fcButton, fcImgBtn, ToolEdit, CurrEdit,
  RXDBCtrl, Mask, DBCtrls, StdCtrls, RXSplit, Grids, DBGrids, RXCtrls,
  ExtCtrls, jpeg, EFocCol,db, RxGrdCpt, fcImager, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  JvLabel, EMsgDlg, fcLabel, JvComponent, JvTransBtn, JvEnterTab;

type
  TFrmSaidaMat = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    dbCodMerc: TDBEdit;
    dbMotivo: TDBMemo;
    RxDBGrid1: TRxDBGrid;
    DBEdit2: TDBEdit;
    btnLocMerc: TfcImageBtn;
    dbQuant: TRxDBCalcEdit;
    Panel3: TLMDBackPanel;
    fcLabel2: TfcLabel;
    MsgDlg: TEvMsgDlg;
    JvLabel10: TJvLabel;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    btnPrimeiro: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure dbCodMercExit(Sender: TObject);
    procedure btnLocMercClick(Sender: TObject);
    procedure dbQuantExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure dbMotivoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSaidaMat : TFrmSaidaMat;
  NovoItem    : Boolean     ;

implementation

uses unitDmDados, UnitLocProd, unitPrincipal;

{$R *.dfm}

procedure TFrmSaidaMat.FormShow(Sender: TObject);
begin
  dmDados.vTabStt:=True;
  if (dmDados.tbEstoque.State    = dsInactive) then
    dmDados.tbEstoque.Open;
  if (dmDados.tbSaida.State      = dsInactive) then
    dmDados.tbSaida.Open;
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
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [Esc] Cancelar ou Sair [F9] Localizar Descri��o');
end;

procedure TFrmSaidaMat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.tbEstoque.Close;
  dmDados.tbSaida.Close;
  dmDados.tbFuncEsto.Close;
  dmDados.tbMovEstoque.Close;
  dmDados.tbGrupo.Close;
  dmDados.tbSubGrupo.Close;
  dmDados.tbMarca.Close;
  dmDados.tbUnidade.Close;
  dmDados.tbDetVendas.Close;
  Action:=caFree;
end;

procedure TFrmSaidaMat.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmDados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_INSERT : if (dmDados.vTabStt) then BtnNovo.Click;
      VK_END    : if not(dmDados.vTabStt) then BtnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
      VK_F9     : btnLocMerc.Click;
    end;
end;

procedure TFrmSaidaMat.BtnPrimeiroClick(Sender: TObject);
begin
  DMDados.tbSaida.First;
  BtnPrimeiro.Enabled := False;
  BtnAnterior.Enabled := False;
  BtnProximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
  dmDados.vTabStt     := True ;
end;

procedure TFrmSaidaMat.BtnAnteriorClick(Sender: TObject);
begin
  dmDados.tbSaida.Prior;
  BtnProximo.Enabled := True;
  BtnUltimo.Enabled  := True;
  if DMDados.tbSaida.Bof then
    begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    end;
  dmDados.vTabStt    := True;
end;

procedure TFrmSaidaMat.BtnProximoClick(Sender: TObject);
begin
  dmDados.tbSaida.Next;
  BtnPrimeiro.Enabled := True;
  BtnAnterior.Enabled := True;
  if DMDados.tbSaida.Eof then
    begin
    BtnProximo.Enabled := False;
    BtnUltimo.Enabled  := False;
    end;
  dmDados.vTabStt     :=True;
end;

procedure TFrmSaidaMat.BtnUltimoClick(Sender: TObject);
begin
  dmDados.tbSaida.Last;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  BtnProximo.Enabled  := False;
  BtnUltimo.Enabled   := False;
  dmDados.vTabStt     := True ;
end;

procedure TFrmSaidaMat.BtnNovoClick(Sender: TObject);
begin
  DMDados.tbSaida.Append;
  dmdados.tbSaidaData.Value := Date;
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
  RxDBGrid1.Enabled   := False;
  dmDados.vTabStt     := False;
  DBCodMerc.SetFocus;
end;

procedure TFrmSaidaMat.BtnGravarClick(Sender: TObject);
begin
  with dmDados do
    begin
    tbSaidaQuant.Value        := StrToFloat(dbQuant.Text)                                  ;
    tbSaidaTipo.Value         := 'S'                                                       ;
    tbSaida.Post;
    //Atualiza quantidade em estoque
    tbEstoque.Locate('CodMerc',dbCodMerc.Text,[]);
    tbEstoque.Edit;
    tbEstoqueQuantidade.Value := dmDados.tbEstoqueQuantidade.Value-StrToFloat(dbQuant.Text);
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
    RxDBGrid1.Enabled   := True ;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    Panel3.SetFocus;
end;

procedure TFrmSaidaMat.BtnCancelarClick(Sender: TObject);
begin
  dmDados.tbSaida.Cancel;
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
  RxDBGrid1.Enabled   := True ;
  dmDados.vTabStt     := True ;
  Panel3.SetFocus;
end;

procedure TFrmSaidaMat.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmSaidaMat.btnLocMercClick(Sender: TObject);
begin
  if (dmdados.tbSaida.State=dsInsert) or (dmdados.tbSaida.State=dsEdit) then
    begin
    frmLocProd := TfrmLocProd.Create(Application);
    frmLocProd.ShowModal;
    dmdados.tbSaidaCodMerc.Value := frmLocProd.Resultado;
    frmLocprod.free;
    end;
end;

procedure TFrmSaidaMat.dbCodMercExit(Sender: TObject);
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
        msgDlg.MsgError('C�DIGO n�o Cadastrado');
        dbCodMerc.SetFocus;
        end;
      end;
    end;
end;

procedure TFrmSaidaMat.dbQuantExit(Sender: TObject);
begin
  dmDados.tbEstoque.Locate('CodMerc',dbCodMerc.Text,[]);
  if dmDados.tbEstoqueQuantidade.Value < dbQuant.Value Then
    begin
    MsgDlg.MsgWarning('Quantidade no estoque � menor, QUANTIDADE = '+FloatToStr(dmDados.tbEstoqueQuantidade.Value));
    dbQuant.Value := dmDados.tbEstoqueQuantidade.Value;
    dbQuant.SetFocus;
    end;
end;
 
procedure TFrmSaidaMat.dbMotivoExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

end.
