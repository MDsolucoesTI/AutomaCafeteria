//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 02-05-2007
// Ultima modifica��o: 26-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untComAberta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls, fcButton, fcImgBtn, StdCtrls, Mask, DBCtrls, fcLabel,
  JvComponent, JvTransBtn, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, Grids, DBGrids,
  RXDBCtrl, EMsgDlg, JvEnterTab, JvToolEdit;

type
  TfrmComAberta = class(TForm)
    RxLabel13: TRxLabel;
    Panel3: TLMDBackPanel;
    btnSair: TJvTransparentButton;
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    RxLabel1: TRxLabel;
    RxDBGridMarca: TRxDBGrid;
    RxLabel2: TRxLabel;
    RxDBGrid1: TRxDBGrid;
    MsgDlg: TEvMsgDlg;
    JvEnterAsTab1: TJvEnterAsTab;
    edtDataMov: TJvDateEdit;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDataMovChange(Sender: TObject);
    procedure edtDataMovEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmComAberta: TfrmComAberta;
  NovoItem   : Boolean     ;
implementation

uses unitDmDados, unitLocCliente, UnitPrincipal;

{$R *.dfm}

procedure TfrmComAberta.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmComAberta.FormShow(Sender: TObject);
begin
  dmDados.vTabStt         := True ;
  dmDados.tbAberComa.Open;
  dmDados.tbDetAberComa.Open;
  NovoItem                := False;
  dmDados.HabilitaTeclado := True ;
  FrmPrincipal.StatusTeclas(True,'[Esc] Sair');
end;

procedure TfrmComAberta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmDados.tbAberComa.Filtered := False;
  dmDados.tbDetAberComa.Close;
  dmDados.tbAberComa.Close;
  FrmPrincipal.StatusTeclas(False,'');
  Action := caFree;
end;

procedure TfrmComAberta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
        VK_ESCAPE     : btnSair.Click;

    end;
end;

procedure TfrmComAberta.edtDataMovChange(Sender: TObject);
begin
  dmDados.tbAberComa.Filtered := False                                         ;
  dmDados.tbAberComa.Filter   := '(DataVen = '''+ DateToStr(edtDataMov.Date)+''')';
  dmDados.tbAberComa.Filtered := True                                          ;
  dmDados.tbAberComa.First;
end;

procedure TfrmComAberta.edtDataMovEnter(Sender: TObject);
begin
  dmDados.tbAberComa.Filtered := False                                         ;
  dmDados.tbAberComa.Filter   := '(DataVen = '''+ DateToStr(edtDataMov.Date)+''')';
  dmDados.tbAberComa.Filtered := True                                          ;
  dmDados.tbAberComa.First;
end;

end.
