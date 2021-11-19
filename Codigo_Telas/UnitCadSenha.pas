/////////////////////////////////////////////////////////////////////////
// Cria��o...........: 14-05-2001
// Ultima modifica��o: 30-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitCadSenha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, ExtCtrls, StdCtrls, Mask, DBCtrls, ToolEdit, RXDBCtrl, RXSplit,
  SpeedBar, jpeg, RxDBComb, RxLookup, fcLabel, ComCtrls,
  Grids, DBGrids, ECripto, RackCtls, fcButton, fcImgBtn, RxGrdCpt, fcImager,
  ImgList, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, JvComponent, JvTransBtn, EGrad,
  EMsgDlg;

type
  TfrmCadSenha = class(TForm)
    evCripto: TEvCriptografa;
    img1: TImageList;
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    lbdoc: TRxLabel;
    dbCod: TDBEdit;
    RxLabel3: TRxLabel;
    dbUsuario: TDBEdit;
    dbsenha: TDBEdit;
    RxLabel2: TRxLabel;
    dbFunc: TDBEdit;
    RxLabel1: TRxLabel;
    edtConfSenha: TEdit;
    RxLabel5: TRxLabel;
    cmbNivel: TRxDBComboBox;
    btnLocFunc: TfcImageBtn;
    Panel3: TLMDBackPanel;
    RxLabel6: TRxLabel;
    img2: TImageList;
    fcLabel1: TfcLabel;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnAlterar: TJvTransparentButton;
    MsgDlg: TEvMsgDlg;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
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
    procedure cmbNivelExit(Sender: TObject);
    procedure edtConfSenhaExit(Sender: TObject);
    procedure btnLocFuncClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadSenha: TfrmCadSenha;

implementation

uses UnitDmdados, UnitPrincipal, UnitLocFunc;


{$R *.DFM}

procedure TfrmCadSenha.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmdados.tbSenha.Close;
  dmDados.tbFunc.Close;
  action:=caFree;
end;

procedure TfrmCadSenha.FormShow(Sender: TObject);
begin
  dmdados.tbSenha.Filtered:=false;
  dmdados.tbSenha.Filter:='(usuario <> '''+'Phoenix'+''')';
  dmdados.tbSenha.filtered:=true;
  dmdados.tbSenha.Open;
  dmDados.tbFunc.Open;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [Esc] Cancelar ou Sair [F2] Loc Funcion�rio');
end;

procedure TfrmCadSenha.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_Insert : if (dmDados.vTabStt) then btnNovo.Click;
      VK_Home   : if (dmDados.vTabStt) then btnAlterar.Click;
      VK_Delete : if (dmDados.vTabStt) then btnDeletar.Click;
      VK_End    : if not(dmDados.vTabStt) then btnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then btnCancelar.Click
                  else btnSair.Click;
      VK_F2     : btnLocFunc.Click;
    end;
end;

procedure TfrmCadSenha.FormKeyPress(Sender: TObject; var Key: Char);
begin
If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TfrmCadSenha.btnPrimeiroClick(Sender: TObject);
begin
dmdados.tbSenha.First;
btnPrimeiro.Enabled:=False;
btnAnterior.Enabled:=False;
btnProximo.Enabled:=True;
btnUltimo.Enabled:=True;
end;

procedure TfrmCadSenha.btnAnteriorClick(Sender: TObject);
begin
dmdados.tbSenha.Prior;
btnProximo.Enabled:=True;
btnUltimo.Enabled:=True;
If dmdados.tbSenha.Bof Then
 Begin
  btnPrimeiro.Enabled:=False;
  btnAnterior.Enabled:=False;
  End;
end;

procedure TfrmCadSenha.btnProximoClick(Sender: TObject);
begin
dmdados.tbSenha.Next;
btnPrimeiro.Enabled:=True;
btnAnterior.Enabled:=True;
If dmdados.tbSenha.Eof Then
 Begin
 btnProximo.Enabled:=False;
 btnUltimo.Enabled:=False;
 end;
end;

procedure TfrmCadSenha.btnUltimoClick(Sender: TObject);
begin
dmdados.tbSenha.Last;
btnPrimeiro.Enabled:=True;
btnAnterior.Enabled:=True;
btnProximo.Enabled:=False;
btnUltimo.Enabled:=False;
end;

procedure TfrmCadSenha.btnNovoClick(Sender: TObject);
begin
  dmdados.tbSenha.Append;
  dmdados.vTabStt      := False;
  btnGravar.Enabled    := True ;
  btnCancelar.Enabled  := True ;
  btnNovo.Enabled      := False;
  btnPrimeiro.Enabled  := False;
  btnAnterior.Enabled  := False;
  btnProximo.Enabled   := False;
  btnUltimo.Enabled    := False;
  btnAlterar.Enabled   := False;
  btnDeletar.Enabled   := False;
  dbCod.Enabled        := True ;
  dbUsuario.Enabled    := True ;
  dbSenha.Enabled      := True ;
  edtConfSenha.Enabled := True ;
  cmbNivel.Enabled     := True ;
  dbCod.SetFocus;
end;

procedure TfrmCadSenha.btnGravarClick(Sender: TObject);
var
  campos : string;
begin
If (dbUsuario.Text = 'Phoenix') then
  begin
  ShowMessage('Palavra Reservada!  Por favor utilize outra.');
  dbUsuario.SetFocus;
  end
else
  begin
  if (dbUsuario.Text='') then campos:='USUARIO';
   if (dbSenha.Text='') then campos:=campos+'  SENHA';
    If Length(campos)=0 then
    begin
    dbSenha.Text:= EvCripto.TextToCriptoBin(dbSenha.Text);
    dmdados.tbSenha.Post;
    dmdados.vTabStt      := True ;
    btnGravar.enabled    := False;
    btnCancelar.Enabled  := False;
    btnNovo.Enabled      := True ;
    btnPrimeiro.Enabled  := True ;
    btnAnterior.Enabled  := True ;
    btnProximo.Enabled   := True ;
    btnUltimo.Enabled    := True ;
    btnAlterar.Enabled   := True ;
    btnDeletar.Enabled   := True ;
    dbCod.Enabled        := False;
    dbUsuario.Enabled    := False;
    dbSenha.Enabled      := False;
    edtConfSenha.Enabled := False;
    cmbNivel.Enabled     := False;
    showmessage('Dados gravados com sucesso!');
    Panel3.SetFocus;
    end;
  end;

end;

procedure TfrmCadSenha.btnCancelarClick(Sender: TObject);
begin
  dmdados.tbSenha.cancel;
  dmdados.vTabStt      := True;
  btnGravar.enabled    := False;
  btnCancelar.Enabled  := False;
  btnNovo.Enabled      := True ;
  btnPrimeiro.Enabled  := True ;
  btnAnterior.Enabled  := True ;
  btnProximo.Enabled   := True ;
  btnUltimo.Enabled    := True ;
  btnAlterar.Enabled   := True ;
  btnDeletar.Enabled   := True ;
  dbCod.Enabled        := False;
  dbUsuario.Enabled    := False;
  dbSenha.Enabled      := False;
  edtConfSenha.Enabled := False;
  cmbNivel.Enabled     := False;
  Panel3.SetFocus
end;

procedure TfrmCadSenha.btnAlterarClick(Sender: TObject);
begin
  dmdados.tbSenha.Edit;
  dmdados.vTabStt      := False;
  btnCancelar.enabled  := True ;
  btnGravar.Enabled    := True ;
  btnNovo.Enabled      := False;
  btnPrimeiro.Enabled  := False;
  btnAnterior.Enabled  := False;
  btnProximo.Enabled   := False;
  btnUltimo.Enabled    := False;
  btnAlterar.Enabled   := False;
  btnDeletar.Enabled   := False;
  dbCod.Enabled        := True ;
  dbUsuario.Enabled    := True ;
  dbSenha.Enabled      := True ;
  edtConfSenha.Enabled := True ;
  cmbNivel.Enabled     := True ;
  dbCod.SetFocus;
end;

procedure TfrmCadSenha.btnDeletarClick(Sender: TObject);
begin
  If application.MessageBox('Tem certeza que deseja excluir este registro?','Aten��o', mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = id_yes then
    begin
    if (dmDados.tbSenhaUsuario.Value = 'Phoenix') then
      MsgDlg.MsgInformation('Este Usu�rio n�o pode ser DELETADO!!!')
    else
      dmdados.tbSenha.Delete;
    end
  else
    dmdados.tbSenha.Cancel;
end;

procedure TfrmCadSenha.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadSenha.cmbNivelExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TfrmCadSenha.edtConfSenhaExit(Sender: TObject);
begin
  if (edtConfSenha.Text <> dbsenha.Text) then
    begin
    MsgDlg.MsgError('Senhas n�o conferem|Redigitar...');
    dbsenha.SetFocus;
    end;
end;

procedure TfrmCadSenha.btnLocFuncClick(Sender: TObject);
begin
  FrmLocFunc:=TFrmLocFunc.Create(Application);
  FrmLocFunc.Showmodal;
  dmDados.tbSenhaCodFunc.Value := FrmLocFunc.Resultado;
  FrmLocFunc.Free;
end;

end.
