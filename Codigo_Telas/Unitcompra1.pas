//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 27-01-2001
// Ultima modifica��o: 28-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit Unitcompra1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DCChoice, fcButton, fcImgBtn, StdCtrls, Mask, ToolEdit, RXSplit,
  RXCtrls, ExtCtrls, SpeedBar, jpeg, RxGrdCpt, fcImager, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  EMsgDlg, fcLabel, JvComponent, JvTransBtn;

type
  TFrmRelCompras = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    cmbclassif: TDCComboBox;
    edCodMerc: TEdit;
    edData1: TDateEdit;
    cmbdestino: TDCComboBox;
    edData2: TDateEdit;
    Panel3: TLMDBackPanel;
    RxLabel3: TRxLabel;
    RxLabel1: TRxLabel;
    RxLabel4: TRxLabel;
    RxLabel5: TRxLabel;
    RxLabel6: TRxLabel;
    fcLabel2: TfcLabel;
    MsgDlg: TEvMsgDlg;
    btnLocFornec: TfcImageBtn;
    btnImprimir: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    procedure cmbclassifChange(Sender: TObject);
    procedure cmbdestinoChange(Sender: TObject);
    procedure cmbdestinoExit(Sender: TObject);
    procedure cmbclassifExit(Sender: TObject);
    procedure cmbclassifCloseUp(Sender: TObject);
    procedure cmbdestinoCloseUp(Sender: TObject);
    procedure BtnimprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fclLocFornecClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelCompras: TFrmRelCompras;

implementation

uses Unitqrcompra1, unitDmDados, UnitPrincipal, UnitLocProd, unitQrCompra;

{$R *.dfm}

procedure TFrmRelCompras.FormShow(Sender: TObject);
begin
  dmDados.HabilitaTeclado:=True;
  FrmPrincipal.StatusTeclas(True,'[F9] Localiza Mercadoria [F2] Imprimir [Esc] Cancelar ou Sair');
  dmDados.tbEstoque.Open;
  cmbclassif.SetFocus;
end;

procedure TFrmRelCompras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.tbEstoque.Close;
  action:=cafree;
end;

procedure TFrmRelCompras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_F2     : if Btnimprimir.Enabled then  btnimprimir.Click;
      VK_ESCAPE : BtnSair.Click;
      Vk_F9     : btnLocFornec.Click;
    end;
end;

procedure TFrmRelCompras.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmRelCompras.cmbclassifChange(Sender: TObject);
begin
  cmbdestino.Enabled:=true;
end;

procedure TFrmRelCompras.cmbclassifExit(Sender: TObject);
begin
  cmbdestino.Enabled:=true;
end;

procedure TFrmRelCompras.cmbclassifCloseUp(Sender: TObject);
begin
  cmbdestino.Enabled:=true;
end;

procedure TFrmRelCompras.cmbdestinoChange(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
  if cmbDestino.Text= '' then
    Begin
    ShowMessage('� obrigat�rio informar o destino do relat�rio');
    cmbDestino.SetFocus;
    End
  Else
    Begin
    Flag:=True;
    For x:=0 to cmbDestino.Items.Count-1 Do
      If cmbDestino.Text=cmbDestino.Items[x] Then
        Flag:=False;
    If Flag Then
      Begin
      ShowMessage('Valor inv�lido');
      cmbDestino.SetFocus;
      End
    else
      begin
      Panel3.SetFocus;
      btnImprimir.Enabled:=true;
      end;
    end;
end;

procedure TFrmRelCompras.cmbdestinoExit(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
  If cmbDestino.Text= '' then
    Begin
    ShowMessage('� obrigat�rio informar o destino do relat�rio');
    cmbDestino.SetFocus;
    End
  Else
    Begin
    Flag:=True;
    For x:=0 to cmbDestino.Items.Count-1 Do
      If cmbDestino.Text=cmbDestino.Items[x] Then
        Flag:=False;
    If Flag Then
      Begin
      ShowMessage('Valor inv�lido');
      cmbDestino.SetFocus;
      End
    else
      begin
      Panel3.SetFocus;
      btnImprimir.Enabled:=true;
      end;
    end;
end;

procedure TFrmRelCompras.cmbdestinoCloseUp(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
  If cmbDestino.Text= '' then
    Begin
    ShowMessage('� obrigat�rio informar o destino do relat�rio');
    cmbDestino.SetFocus;
    End
  Else
    Begin
    Flag:=True;
    For x:=0 to cmbDestino.Items.Count-1 Do
      If cmbDestino.Text=cmbDestino.Items[x] Then
        Flag:=False;
    If Flag Then
      Begin
      ShowMessage('Valor inv�lido');
      cmbDestino.SetFocus;
      End
    else
      begin
      Panel3.SetFocus;
      btnImprimir.Enabled:=true;
      end;
    end;
end;

procedure TFrmRelCompras.BtnimprimirClick(Sender: TObject);
begin
  cmbdestino.Enabled:=false;
  btnImprimir.Enabled:=false;
  Qrcompra1:=tQrCompra1.create(application);
  if cmbclassif.text='Mercadoria' then
    begin
    QrCompra1.tbDetCompra.Filtered:=false;
    QrCompra1.tbDetCompra.Filter:='(datacomp >='''+edData1.Text+''')and'+
                                  '(datacomp <='''+edData2.Text+''')and'+
                                  '(CodMerc ='''+edCodMerc.Text+''')';
    QrCompra1.tbDetCompra.Filtered:=true;
    end;
  if cmbDestino.Text='V�deo' then
    QrCompra1.preview
  else
    QrCompra1.print;
  QrCompra1.tbDetCompra.Filtered:=false;
  qrcompra1.free
end;

procedure TFrmRelCompras.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmRelCompras.fclLocFornecClick(Sender: TObject);
begin
  frmLocProd:=tfrmLocProd.create(application);
  frmLocProd.showModal;
  edCodMerc.Text:=frmLocProd.Resultado;
  frmLocProd.Free;
  edcodmerc.SetFocus;
  cmbdestino.Enabled:=true;
end;

end.
