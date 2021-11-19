//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 07-05-2007
// Ultima modifica��o: 17-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untCCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, fcButton, fcImgBtn, RXSplit, ToolEdit, Mask, RXCtrls,
  ExtCtrls, SpeedBar, jpeg, RXDBCtrl, RackCtls, CurrEdit, ShellApi, DBTables, DB, DBUtils,
  RxGrdCpt, fcImager, EMsgDlg, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, EGrad, ComCtrls,
  JvDateTimePicker, JvDBDateTimePicker, JvComponent, JvTransBtn, JvLabel,
  JvPanel, JvTransparentPanel, JvEnterTab;

type
  TFrmCCliente = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    RxLabel3: TRxLabel;
    LMDBackPanel1: TLMDBackPanel;
    dbEdtCad: TDBDateEdit;
    RxDBSaldo: TRxDBCalcEdit;
    dbEdtMov: TDBDateEdit;
    Panel4: TLMDBackPanel;
    dbHoraMov: TJvDBDateTimePicker;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel5: TJvLabel;
    btnPrimeiro: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    MsgDlg: TEvMsgDlg;
    JvLabel6: TJvLabel;
    dbNomeCli: TDBEdit;
    btnDetConta: TJvTransparentButton;
    btnCredConta: TJvTransparentButton;
    btnLocCli: TfcImageBtn;
    JvTransparentPanel1: TJvTransparentPanel;
    edCodCli: TEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnDetContaClick(Sender: TObject);
    procedure btnCredContaClick(Sender: TObject);
    procedure dbeContaExit(Sender: TObject);
    procedure btnLocCliClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edCodCliExit(Sender: TObject);
  private
    { Private declarations }
    fOutraJan : Boolean;
  public
    { Public declarations }
    property OutraJan : Boolean read fOutraJan write fOutraJan;
  end;

var
  FrmCCliente : TFrmCCliente;
  NovoItem    : Boolean     ;

implementation

uses  UnitDmdados, unitPrincipal, UnitDetConta, UnitCredConta,
  unitLocCliente;

{$R *.DFM}

procedure TFrmCCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.tbContaCliente.Close;
  dmDados.tbCliente.Close;
  dmDados.tbConfVendas.Close;
  dmDados.tbConfDetVendas.Close;
  Action := Cafree;
end;

procedure TFrmCCliente.BtnSairClick(Sender: TObject);
begin
  if (DmDados.tbContaCliente.State=dsEdit) or (DmDados.tbContaCliente.State=dsInsert) then
    DmDados.tbContaCliente.Cancel;
  Close;
end;

procedure TFrmCCliente.BtnPrimeiroClick(Sender: TObject);
begin
  dmdados.tbContaCliente.First;
  edCodCli.Text := dmDados.tbContaClienteConta.Value;
  btnPrimeiro.Enabled :=False;
  btnAnterior.Enabled :=False;
  btnProximo.Enabled  :=True ;
  btnUltimo.Enabled   :=True ;
  dmDados.vTabStt     :=True ;
end;

procedure TFrmCCliente.BtnAnteriorClick(Sender: TObject);
begin
  dmdados.tbContaCliente.Prior;
  edCodCli.Text := dmDados.tbContaClienteConta.Value;
  btnProximo.Enabled  := True ;
  btnUltimo.Enabled   := True ;
  if (dmdados.tbContaCliente.Bof) then
    begin
    btnPrimeiro.Enabled := False;
    btnAnterior.Enabled := False;
    end;
  dmDados.vTabStt     := True ;
end;

procedure TFrmCCliente.BtnProximoClick(Sender: TObject);
begin
  dmdados.tbContaCliente.next;
  edCodCli.Text := dmDados.tbContaClienteConta.Value;
  btnPrimeiro.Enabled := True ;
  btnAnterior.Enabled := True ;
  If (dmdados.tbContaCliente.Eof) Then
    Begin
    btnProximo.Enabled :=False;
    btnUltimo.Enabled  :=False;
    end;
  dmDados.vTabStt     := True ;
end;

procedure TFrmCCliente.BtnUltimoClick(Sender: TObject);
begin
  dmdados.tbContaCliente.Last;
  edCodCli.Text := dmDados.tbContaClienteConta.Value;
  btnPrimeiro.Enabled :=True ;
  btnAnterior.Enabled :=True ;
  btnProximo.Enabled  :=False;
  btnUltimo.Enabled   :=False;
  dmDados.vTabStt     :=True ;
end;

procedure TFrmCCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
        VK_F2     : btnLocCli.Click;
        VK_F3     : btnDetConta.Click;
        VK_F4     : btnCredConta.Click;

    end;
end;

procedure TFrmCCliente.FormShow(Sender: TObject);
begin
  dmDados.vTabStt := True ;
  NovoItem        := False;
  FrmPrincipal.StatusTeclas(True,'[F2] Loc Cliente [F3] Detalhe de Venda [F4] Cr�dito em Conta [Esc] Cancelar ou Sair');
  dmDados.HabilitaTeclado := True;
  if (dmDados.tbContaCliente.State = dsInactive) then
    dmDados.tbContaCliente.Open;
  if (dmDados.tbCliente.State = dsInactive) then
    dmDados.tbCliente.Open;
  if (dmDados.tbConfVendas.State = dsInactive) then
    dmDados.tbConfVendas.Open;
  if (dmDados.tbConfDetVendas.State = dsInactive) then
    dmDados.tbConfDetVendas.Open;
  if (dmDados.tbContaCliente.RecordCount = 0) then
    begin
    edCodCli.Text := dmDados.tbContaClienteConta.Value;
    Btnprimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    BtnProximo.Enabled  := False;
    BtnUltimo.Enabled   := False;
    end;
end;

procedure TFrmCCliente.btnDetContaClick(Sender: TObject);
begin
  FrmDetConta:=TfrmDetConta.Create(application);
  FrmDetConta.edCodCli.Text := edCodCli.Text;
  FrmDetConta.edCodCliExit(Sender);
  FrmDetConta.Show;
  edCodCli.SetFocus;
end;

procedure TFrmCCliente.btnCredContaClick(Sender: TObject);
begin
  FrmCredConta:=TfrmCredConta.Create(application);
  FrmCredConta.Show;
  edCodCli.SetFocus;
end;

procedure TFrmCCliente.dbeContaExit(Sender: TObject);
begin
  if edCodCli.Text <> '' then
    begin
    if (not dmdados.tbContaCliente.Locate('Conta',edCodCli.text,[])) then
      begin
      MsgDlg.MsgWarning('C�DIGO DO CLIENTE n�o cadastrado!');
      edCodCli.SetFocus;
      end;
    end
end;

procedure TFrmCCliente.btnLocCliClick(Sender: TObject);
begin
  FrmLocCliente := TFrmLocCliente.Create(application);
  FrmLocCliente.Showmodal;
  dmDados.tbContaCliente.Locate('Conta', frmLocCliente.Resultado, []);
  edCodCli.Text := IntToStr(FrmLocCliente.Resultado);
  frmLocCliente.Free;
end;

procedure TFrmCCliente.FormCreate(Sender: TObject);
begin
  OutraJan := True;
end;

procedure TFrmCCliente.edCodCliExit(Sender: TObject);
begin
  if edCodCli.Text <> '' then
    begin
    if (not dmdados.tbContaCliente.Locate('Conta',edcodCli.text,[])) then
      begin
      MsgDlg.MsgWarning('C�DIGO DO CLIENTE n�o cadastrado!');
      edCodCli.SetFocus;
      end;
    end
end;

end.


