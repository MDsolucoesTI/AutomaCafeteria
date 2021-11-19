//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 15-05-2007
// Ultima modifica��o: 10-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untBloCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, fcButton, fcImgBtn, RXSplit, ToolEdit, Mask, RXCtrls,
  ExtCtrls, SpeedBar, jpeg, RXDBCtrl, RackCtls, CurrEdit, ShellApi, DBTables, DB, DBUtils,
  RxGrdCpt, fcImager, EMsgDlg, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, EGrad, ComCtrls,
  JvDateTimePicker, JvDBDateTimePicker, JvComponent, JvTransBtn, JvLabel,
  JvPanel, JvTransparentPanel, JvEnterTab, JvDBComb;

type
  TfrmBloCli = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    RxLabel3: TRxLabel;
    LMDBackPanel1: TLMDBackPanel;
    Panel4: TLMDBackPanel;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    btnPrimeiro: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    MsgDlg: TEvMsgDlg;
    JvLabel6: TJvLabel;
    dbNomeCli: TDBEdit;
    btnLocCli: TfcImageBtn;
    edCodCli: TEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    btnAlterar: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    edtStatus: TJvDBComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbeContaExit(Sender: TObject);
    procedure btnLocCliClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edCodCliExit(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    fOutraJan : Boolean;
  public
    { Public declarations }
    property OutraJan : Boolean read fOutraJan write fOutraJan;
  end;

var
  frmBloCli : TfrmBloCli;
  NovoItem    : Boolean     ;

implementation

uses  UnitDmdados, unitPrincipal, UnitDetConta, UnitCredConta,
  unitLocCliente;

{$R *.DFM}

procedure TfrmBloCli.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.tbCliente.Close;
  Action := Cafree;
end;

procedure TfrmBloCli.BtnSairClick(Sender: TObject);
begin
  if (DmDados.tbCliente.State=dsEdit) or (DmDados.tbCliente.State=dsInsert) then
    DmDados.tbCliente.Cancel;
  Close;
end;

procedure TfrmBloCli.BtnPrimeiroClick(Sender: TObject);
begin
  dmdados.tbCliente.First;
  edCodCli.Text := dmDados.tbClienteCodCli.AsString;
  btnPrimeiro.Enabled :=False;
  btnAnterior.Enabled :=False;
  btnProximo.Enabled  :=True ;
  btnUltimo.Enabled   :=True ;
  dmDados.vTabStt     :=True ;
end;

procedure TfrmBloCli.BtnAnteriorClick(Sender: TObject);
begin
  dmdados.tbCliente.Prior;
  edCodCli.Text := dmDados.tbClienteCodCli.AsString;
  btnProximo.Enabled  := True ;
  btnUltimo.Enabled   := True ;
  if (dmdados.tbCliente.Bof) then
    begin
    btnPrimeiro.Enabled := False;
    btnAnterior.Enabled := False;
    end;
  dmDados.vTabStt     := True ;
end;

procedure TfrmBloCli.BtnProximoClick(Sender: TObject);
begin
  dmdados.tbCliente.next;
  edCodCli.Text := dmDados.tbClienteCodCli.AsString;
  btnPrimeiro.Enabled := True ;
  btnAnterior.Enabled := True ;
  If (dmdados.tbCliente.Eof) Then
    Begin
    btnProximo.Enabled :=False;
    btnUltimo.Enabled  :=False;
    end;
  dmDados.vTabStt     := True ;
end;

procedure TfrmBloCli.BtnUltimoClick(Sender: TObject);
begin
  dmdados.tbCliente.Last;
  edCodCli.Text := dmDados.tbClienteCodCli.AsString;
  btnPrimeiro.Enabled :=True ;
  btnAnterior.Enabled :=True ;
  btnProximo.Enabled  :=False;
  btnUltimo.Enabled   :=False;
  dmDados.vTabStt     :=True ;
end;

procedure TfrmBloCli.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
        VK_F2     : btnLocCli.Click;
    end;
end;

procedure TfrmBloCli.FormShow(Sender: TObject);
begin
  dmDados.vTabStt := True ;
  NovoItem        := False;
  FrmPrincipal.StatusTeclas(True,'[F2] Loc Cliente [F3] Detalhe de Venda [F4] Cr�dito em Conta [Esc] Cancelar ou Sair');
  dmDados.HabilitaTeclado := True;
  if (dmDados.tbCliente.State = dsInactive) then
    dmDados.tbCliente.Open;
  if (dmDados.tbCliente.RecordCount = 0) then
    begin
    edCodCli.Text := dmDados.tbClienteCodCli.AsString;
    Btnprimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    BtnProximo.Enabled  := False;
    BtnUltimo.Enabled   := False;
    end;
end;

procedure TfrmBloCli.dbeContaExit(Sender: TObject);
begin
  if edCodCli.Text <> '' then
    begin
    if (not dmdados.tbCliente.Locate('CodCli',edCodCli.text,[])) then
      begin
      MsgDlg.MsgWarning('C�DIGO DO CLIENTE n�o cadastrado!');
      edCodCli.SetFocus;
      end;
    end
end;

procedure TfrmBloCli.btnLocCliClick(Sender: TObject);
begin
  FrmLocCliente := TFrmLocCliente.Create(application);
  FrmLocCliente.Showmodal;
  edCodCli.Text := IntToStr(FrmLocCliente.Resultado);
  frmLocCliente.Free;
end;

procedure TfrmBloCli.FormCreate(Sender: TObject);
begin
  OutraJan := True;
end;

procedure TfrmBloCli.edCodCliExit(Sender: TObject);
begin
  if edCodCli.Text <> '' then
    begin
    if (not dmdados.tbCliente.Locate('CodCli',edcodCli.text,[])) then
      begin
      MsgDlg.MsgWarning('C�DIGO DO CLIENTE n�o cadastrado!');
      edCodCli.SetFocus;
      end;
    end
end;

procedure TfrmBloCli.btnAlterarClick(Sender: TObject);
begin
  dmDados.tbCliente.Edit;
  edtStatus.SetFocus;
  btnGravar.Enabled   := True ;
  btnCancelar.Enabled := True ;
  btnAlterar.Enabled  := False;
end;

procedure TfrmBloCli.btnGravarClick(Sender: TObject);
begin
  dmDados.tbCliente.Post;
  btnGravar.Enabled   := False;
  btnCancelar.Enabled := False;
  btnAlterar.Enabled  := True ;
  Panel4.SetFocus;
end;

procedure TfrmBloCli.btnCancelarClick(Sender: TObject);
begin
  dmDados.tbCliente.Cancel;
  btnGravar.Enabled   := False;
  btnCancelar.Enabled := False;
  btnAlterar.Enabled  := True ;
  Panel4.SetFocus;
end;

end.


