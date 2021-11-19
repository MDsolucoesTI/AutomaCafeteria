//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 12-02-2001
// Ultima modifica��o: 20-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untRelVendas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DBCtrls, fcButton, fcImgBtn, RXSplit, RXCtrls,
  SpeedBar, jpeg, ToolEdit, RxLookup, RxGrdCpt, fcImager,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, JvCombobox, JvComponent, JvTransBtn,
  fcLabel, EMsgDlg;

type
  TfrmRelVendas = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    RxLabel2: TRxLabel;
    EdtInicial: TDateEdit;
    RxLabel5: TRxLabel;
    Panel3: TLMDBackPanel;
    cmbdestino: TJvComboBox;
    fcLabel2: TfcLabel;
    btnImprimir: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    MsgDlg: TEvMsgDlg;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnimprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtInicialExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelVendas: TfrmRelVendas;

implementation

uses UnitPrincipal, unitDmDados, unitQrVendas;

{$R *.DFM}

procedure TfrmRelVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
end;

procedure TfrmRelVendas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TfrmRelVendas.BtnSairClick(Sender: TObject);
begin
	Close;
end;

procedure TfrmRelVendas.BtnimprimirClick(Sender: TObject);
begin
  //criar os qr(s)
  QrVenda:=TQrVenda.Create(application);
  {Filtros diversos}
  QrVenda.tbVendas.Filtered:=false;
  QrVenda.tbVendas.Filter:='(DataVen >= '''+edtInicial.text+''')and'+
                           '(DataVen <= '''+edtInicial.text+''')and'+
                           '(CodCli = '''+'1'+''')';
  QrVenda.tbVendas.Filtered:=true;
  if cmbDestino.Text= 'V�deo' then
    QrVenda.rpVenda.Preview
  else
    QrVenda.rpVenda.Print;
  QrVenda.rpVenda.Free;
  QrVenda.tbVendas.Filtered:=false;
end;

procedure TfrmRelVendas.FormShow(Sender: TObject);
begin
  FrmPrincipal.StatusTeclas(True,'[F2] Imprimir [Esc] Cancelar ou Sair');
  EdtInicial.setfocus;
end;

procedure TfrmRelVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_F2    : Btnimprimir.Click;
      VK_ESCAPE : if dmDados.vTabStt then BtnSair.Click;
    end;
end;

procedure TfrmRelVendas.EdtInicialExit(Sender: TObject);
begin
  If (EdtInicial.text = '  /  /    ') then
    begin
    ShowMessage('DATA n�o foi preenchida');
    EdtInicial.SetFocus;
    end
  else
    begin
    try StrToDate(EdtInicial.text)
    except on EConvertError do
      begin
      ShowMessage('DATA inv�lida');
      EdtInicial.SetFocus;
      end;
    end;
    end;
end;

end.
