//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 03-03-2001
// Ultima modifica��o: 17-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitRelCReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, ToolEdit, RXSplit, fcButton, fcImgBtn, RXCtrls,
  SpeedBar, jpeg, LMDCustomComponent, LMDCustomHint, LMDCustomShapeHint,
  LMDShapeHint, DCChoice, RxGrdCpt, fcImager, JvComponent, JvTransBtn,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, fcLabel, EMsgDlg;

type
  TFrmRelCReceber = class(TForm)
    Panel3: TLMDBackPanel;
    btnImprimir: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    cmbClassif: TComboBox;
    EdtInicial: TDateEdit;
    EdtFinal: TDateEdit;
    DCComboDestino: TDCComboBox;
    RxLabel8: TRxLabel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel4: TRxLabel;
    MsgDlg: TEvMsgDlg;
    procedure BtnSairClick(Sender: TObject);
    procedure cmbClassifChange(Sender: TObject);
    procedure BtnimprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cmbClassifExit(Sender: TObject);
    procedure EdtInicialExit(Sender: TObject);
    procedure EdtFinalExit(Sender: TObject);
    procedure DCComboDestinoChange(Sender: TObject);
    procedure DCComboDestinoCloseUp(Sender: TObject);
    procedure DCComboDestinoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelCReceber: TFrmRelCReceber;

implementation

uses unitDmDados, UnitQRCReceber, UnitPrincipal;

{$R *.DFM}

procedure TFrmRelCReceber.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmRelCReceber.cmbClassifChange(Sender: TObject);
begin
  if (cmbClassif.Text = 'Recebidas por Per�odo') then
	  begin
  	EdtInicial.Enabled     := True ;
    EdtFinal.Enabled       := True ;
    Btnimprimir.Enabled    := True ;
    DCComboDestino.Enabled := True ;
    end;
  if (cmbClassif.Text = 'A Receber por Per�odo') then
 	  begin
  	EdtInicial.Enabled     := True ;
    EdtFinal.Enabled       := True ;
    Btnimprimir.Enabled    := True ;
    DCComboDestino.Enabled := True ;
    end;
  if (cmbClassif.Text = 'A Receber') then
	  begin
  	EdtInicial.Enabled     := False;
    EdtFinal.Enabled       := False;
    Btnimprimir.Enabled    := True ;
    DCComboDestino.Enabled := True ;
    end;
  if (cmbClassif.Text = 'Atrasadas') then
	  begin
  	EdtInicial.Enabled     := False;
    EdtFinal.Enabled       := False;
    Btnimprimir.Enabled    := True ;
    DCComboDestino.Enabled := True ;
    end;
  if (cmbClassif.Text = 'Recebidas') then
	  begin
  	EdtInicial.Enabled     := False;
    EdtFinal.Enabled       := False;
    Btnimprimir.Enabled    := True ;
    DCComboDestino.Enabled := True ;
    end;
end;

procedure TFrmRelCReceber.BtnimprimirClick(Sender: TObject);
begin
  Btnimprimir.Enabled            := False;
  DCComboDestino.Enabled         := False;
  QRCReceber:= TQRCReceber.Create(application);
  QRCReceber.tbCReceber.Open;
  QRCReceber.tbCReceber.Filtered := False;
  if (cmbClassif.Text = 'Atrasadas') then
	  begin
	  QRCReceber.tbCReceber.Filter    := '(DataVenc < '''+DateToStr(now)+''') and'+
                                       '(Pago='''+'ABERTO'+''')'                ;
    QRCReceber.QRLabel2.Caption     := 'Contas a Receber Atrasadas'             ;
    QrCreceber.QRDBText5.DataField  := 'Valor';
    QRCReceber.SomaValor.Expression := 'SUM(tbCReceber.Valor)'                  ;
    end;
  if (cmbClassif.Text = 'A Receber') then
	  begin
    QRCReceber.tbCReceber.Filter    := '(Pago='''+'ABERTO'+''')';
    QRCReceber.QRLabel2.Caption     := 'Contas a Receber'       ;
    QrCreceber.QRDBText5.DataField  := 'Valor'                  ;
    QRCReceber.SomaValor.Expression := 'SUM(tbCReceber.Valor)'  ;
    end;
  if (cmbClassif.Text = 'Recebidas') then
	  begin
    QRCReceber.tbCReceber.Filter    := '(Pago='''+'PAGO'+''')'    ;
    QRCReceber.QRLabel2.Caption     := 'Contas Recebidas'         ;
    QrCreceber.QRDBText5.DataField  := 'ValorPago'                ;
    QRCReceber.SomaValor.Expression := 'SUM(tbCReceber.ValorPago)';
    end;
  if (cmbClassif.Text = 'Recebidas por Per�odo') then
	  begin
    QRCReceber.tbCReceber.Filter    := '(Pago='''+'PAGO'+''') and '+
   	  		     			  						     '(DataPaga>='''+EdtInicial.Text+''')And'+
                                       '(DataPaga<='''+EdtFinal.Text+''')'     ;
    QRCReceber.QRLabel2.Caption     := 'Contas Recebidas por Per�odo'          ;
    QrCreceber.QRDBText5.DataField  := 'ValorPago'                             ;
    QRCReceber.SomaValor.Expression := 'SUM(tbCReceber.ValorPago)'             ;
    end;
  if (cmbClassif.Text = 'A Receber por Per�odo') then
	  begin
    QRCReceber.tbCReceber.Filter    := '(Pago='''+'ABERTO'+''') and '+
   		  												       '(DataVenc>='''+EdtInicial.Text+''')And'+
                                       '(DataVenc<='''+EdtFinal.Text+''')'     ;
    QRCReceber.QRLabel2.Caption     := 'Contas a Receber por Per�odo'          ;
    QrCreceber.QRDBText5.DataField  := 'Valor'                                 ;
    QRCReceber.SomaValor.Expression := 'SUM(tbCReceber.Valor)'                 ;
    end;
  QRCReceber.tbCReceber.Filtered:= True;

  if (DCComboDestino.Text = 'V�deo') then
    QRCReceber.Preview
  else
    QRCReceber.Print;
  QRCReceber.Free;
end;

procedure TFrmRelCReceber.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
end;

procedure TFrmRelCReceber.FormKeyPress(Sender: TObject; var Key: Char);
begin
If Key=#13 Then
      Begin
      Key:=#0;
      Perform(wm_nextdlgctl,0,0);
      End;
end;

procedure TFrmRelCReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_F2    : Btnimprimir.Click;
      VK_ESCAPE : if dmDados.vTabStt Then BtnSair.Click;
    end;
end;

procedure TFrmRelCReceber.FormShow(Sender: TObject);
begin
  FrmPrincipal.StatusTeclas(True,'[F2] Imprimir [Esc] Cancelar ou Sair');
  DCComboDestino.Enabled:=false;
end;

procedure TFrmRelCReceber.cmbClassifExit(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
 If cmbClassif.Text= '' then
      Begin
      ShowMessage('� obrigat�rio informar a classifica��o do relat�rio');
      cmbClassif.SetFocus;
      End
   Else
      Begin
      Flag:=True;
      For x:=0 to cmbClassif.Items.Count-1 Do
        If cmbClassif.Text=cmbClassif.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('Valor inv�lido');
        cmbClassif.Clear;
        cmbClassif.SetFocus;
        End;
      end;
end;

procedure TFrmRelCReceber.EdtInicialExit(Sender: TObject);
begin
If edtInicial.Text= '  /  /    ' then
   Begin
   ShowMessage('� obrigat�rio a DATA INICIAL');
   edtInicial.SetFocus;
   End
else
   begin
   try
     StrToDate(edtInicial.Text);
     except
     on EConvertError do
     begin
     ShowMessage ('Data Inv�lida');
     edtInicial.SetFocus;
     end;
   end;
   end;
end;

procedure TFrmRelCReceber.EdtFinalExit(Sender: TObject);
begin
If edtFinal.Text= '  /  /    ' then
   Begin
   ShowMessage('� obrigat�rio a DATA FINAL');
   edtFinal.SetFocus;
   End
else
   begin
   try
     StrToDate(edtFinal.Text);
     except
     on EConvertError do
     begin
     ShowMessage ('Data Inv�lida');
     edtFinal.SetFocus;
     end;
   end;
   end;
end;

procedure TFrmRelCReceber.DCComboDestinoChange(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
 If DCComboDestino.Text= '' then
      Begin
      ShowMessage('� obrigat�rio informar o destino do relat�rio');
      DCComboDestino.SetFocus;
      End
   Else
      Begin
      Flag:=True;
      For x:=0 to DCComboDestino.Items.Count-1 Do
        If DCComboDestino.Text=DCComboDestino.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('Valor inv�lido');
        DCComboDestino.clear;
        DCComboDestino.SetFocus;
        End
      else
        begin
        Panel3.SetFocus;
        btnImprimir.Enabled:=true;
        end;
      end;
end;

procedure TFrmRelCReceber.DCComboDestinoCloseUp(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
 If DCComboDestino.Text= '' then
      Begin
      ShowMessage('� obrigat�rio informar o destino do relat�rio');
      DCComboDestino.SetFocus;
      End
   Else
      Begin
      Flag:=True;
      For x:=0 to DCComboDestino.Items.Count-1 Do
        If DCComboDestino.Text=DCComboDestino.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('Valor inv�lido');
        DCComboDestino.clear;
        DCComboDestino.SetFocus;
        End
      else
        begin
        Panel3.SetFocus;
        btnImprimir.Enabled:=true;
        end;
      end;
end;

procedure TFrmRelCReceber.DCComboDestinoExit(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
 If DCComboDestino.Text= '' then
      Begin
      ShowMessage('� obrigat�rio informar o destino do relat�rio');
      DCComboDestino.SetFocus;
      End
   Else
      Begin
      Flag:=True;
      For x:=0 to DCComboDestino.Items.Count-1 Do
        If DCComboDestino.Text=DCComboDestino.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('Valor inv�lido');
        DCComboDestino.clear;
        DCComboDestino.SetFocus;
        End
      else
        begin
        Panel3.SetFocus;
        btnImprimir.Enabled:=true;
        end;
      end;
end;
end.
