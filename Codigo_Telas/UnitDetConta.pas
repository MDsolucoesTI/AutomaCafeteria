//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 17-05-2007
// Ultima modifica��o: 28-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitDetConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls, fcButton, fcImgBtn, StdCtrls, Mask, DBCtrls, fcLabel,
  JvComponent, JvTransBtn, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, Grids, DBGrids,
  RXDBCtrl, EMsgDlg, JvEnterTab;

type
  TFrmDetConta = class(TForm)
    dbCliente: TDBEdit;
    RxLabel13: TRxLabel;
    Panel3: TLMDBackPanel;
    btnSair: TJvTransparentButton;
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    edCodCli: TEdit;
    RxLabel1: TRxLabel;
    RxDBGridMarca: TRxDBGrid;
    RxLabel2: TRxLabel;
    RxDBGrid1: TRxDBGrid;
    MsgDlg: TEvMsgDlg;
    RxLabel3: TRxLabel;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure BtnlocCliClick(Sender: TObject);
    procedure edCodCliExit(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDetConta: TFrmDetConta;
  NovoItem   : Boolean     ;
implementation

uses unitDmDados, unitLocCliente, UnitPrincipal;

{$R *.dfm}

procedure TFrmDetConta.BtnlocCliClick(Sender: TObject);
begin
  FrmLocCliente := TFrmLocCliente.Create(application);
  FrmLocCliente.Showmodal;
  edCodCli.Text := IntToStr(frmLocCliente.Resultado);
  frmLocCliente.Free;
end;

procedure TFrmDetConta.edCodCliExit(Sender: TObject);
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

procedure TFrmDetConta.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmDetConta.FormShow(Sender: TObject);
begin
  dmDados.vTabStt         := True ;
  NovoItem                := False;
  dmDados.HabilitaTeclado := True ;
  FrmPrincipal.StatusTeclas(True,'[Esc] Sair');
end;

procedure TFrmDetConta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  Action := caFree;
end;

procedure TFrmDetConta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
        VK_ESCAPE     : btnSair.Click;

    end;
end;

end.
