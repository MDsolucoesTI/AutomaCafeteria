/////////////////////////////////////////////////////////////////////////
// Cria��o...........: 17-05-2007
// Ultima modifica��o: 28-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitCredConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EMsgDlg, fcLabel, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, StdCtrls, Mask,
  DBCtrls, JvLabel, fcButton, fcImgBtn, ToolEdit, CurrEdit, RXDBCtrl,
  JvComponent, JvTransBtn, JvToolEdit, JvCurrEdit, JvEnterTab;

type
  TFrmCredConta = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel1: TfcLabel;
    MsgDlg: TEvMsgDlg;
    Panel3: TLMDBackPanel;
    LMDBackPanel3: TLMDBackPanel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    dbSaldoAt: TRxDBCalcEdit;
    btnGravar: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    JvLabel1: TJvLabel;
    DbeConta: TDBEdit;
    JvLabel6: TJvLabel;
    dbNomeCli: TDBEdit;
    edtCred: TJvCalcEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure dbSaldoAtExit(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtCredExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCredConta: TFrmCredConta;

implementation

uses unitDmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmCredConta.dbSaldoAtExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TFrmCredConta.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCredConta.edtCredExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TFrmCredConta.btnGravarClick(Sender: TObject);
begin
  dmDados.tbContaCliente.Edit;
  dmDados.tbContaClienteSaldo.Value := dmDados.tbContaClienteSaldo.Value +  edtCred.Value;
  dmDados.tbContaCliente.Post;
  Close;
end;

procedure TFrmCredConta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  Action := caFree;
end;

procedure TFrmCredConta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
        VK_END     : btnGravar.Click;
        VK_ESCAPE  : btnSair.Click;
    end;
end;

procedure TFrmCredConta.FormActivate(Sender: TObject);
begin
  dmDados.vTabStt         := True;
  dmDados.HabilitaTeclado := True;
  FrmPrincipal.StatusTeclas(True,'[End] Confirmar [Esc] Cancelar ou Sair');
end;

end.
