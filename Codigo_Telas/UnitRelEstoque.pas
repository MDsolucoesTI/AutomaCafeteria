//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 02-03-2001
// Ultima modifica��o: 18-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitRelEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RXSplit, fcButton, fcImgBtn, RXCtrls,
  SpeedBar, jpeg, EFocCol, DCChoice, RxGrdCpt, fcImager, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  Mask, ToolEdit, EMsgDlg, fcLabel, JvComponent, JvTransBtn;

type
  TFrmRelEstoque = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    cmbClassif: TDCComboBox;
    cmbDestino: TDCComboBox;
    Panel3: TLMDBackPanel;
    edDataMov: TDateEdit;
    fcLabel2: TfcLabel;
    MsgDlg: TEvMsgDlg;
    RxLabel3: TRxLabel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    btnImprimir: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cmbClassifExit(Sender: TObject);
    procedure BtnimprimirClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure cmbDestinoExit(Sender: TObject);
    procedure cmbDestinoCloseUp(Sender: TObject);
    procedure cmbDestinoChange(Sender: TObject);
    procedure cmbclassifChange(Sender: TObject);
    procedure cmbClassifCloseUp(Sender: TObject);
    procedure edDataMovChange(Sender: TObject);
    procedure edDataMovExit(Sender: TObject);
    procedure cmbClassifKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelEstoque: TFrmRelEstoque;

implementation

uses unitPrincipal, unitDmDados, UnitQREstoque, untQrTabelaPreco,
  untQrInvent2, untQrInventario, DB, untMovDia;

{$R *.dfm}

procedure TFrmRelEstoque.FormShow(Sender: TObject);
begin
  Dmdados.HabilitaTeclado:= True;
  FrmPrincipal.StatusTeclas(True,'[F2] Imprimir [Esc] Cancelar e Sair');
  dmDados.tbEstoque.Open;
  dmDados.tbSaida.Open;
  dmDados.tbRelEsto.Open;
  dmDados.tbMovDia.Open;
  cmbclassif.setfocus;
end;

procedure TFrmRelEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.tbRelEsto.Close;
  dmDados.tbMovDia.Close;
  dmDados.tbSaida.Close;
  dmDados.tbEstoque.Close;
  Action:= Cafree;
end;

procedure TFrmRelEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_F2 : if Btnimprimir.Enabled then Btnimprimir.Click;
      VK_ESCAPE : BtnSair.Click;
    end;
end;

procedure TFrmRelEstoque.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmRelEstoque.BtnimprimirClick(Sender: TObject);
var
  quant,vendas,TQuant,TVendas : double;
begin
  cmbdestino.Enabled:=false;
  btnimprimir.Enabled:=false;
  dmDados.tbRelEsto.Filtered:= False;
  if (cmbClassif.Text='Abaixo do M�nimo') Then
    begin
    dmDados.tbRelEsto.IndexName:= 'iDescricao';
    dmDados.tbRelEsto.Filtered:= true;
    QREstoque:=tQREstoque.create(application);
    If cmbDestino.Text= 'V�deo' Then
	    QREstoque.Preview
    else
	    QREstoque.Print;
    QREstoque.Free;
    dmdados.tbRelEsto.IndexName:= '';
    dmdados.tbRelEsto.Filtered:= False;
    end;
  if (cmbClassif.Text='Acima do M�ximo') then
    begin
    dmDados.tbRelEsto.IndexName:= 'iDescricao';
    dmDados.tbRelEsto.Filtered:= true;
    QREstoque:=tQREstoque.create(application);
    If cmbDestino.Text= 'V�deo' Then
	    QREstoque.Preview
    else
	    QREstoque.Print;
    QREstoque.Free;
    dmdados.tbRelEsto.IndexName:= '';
    dmdados.tbRelEsto.Filtered:= False;
    end;
  if (cmbClassif.Text='Tabela de Pre�os') then
    begin
    dmDados.tbRelEsto.IndexName:= 'iCodMerc';
    QrTabelaPreco:=TQrTabelaPreco.create(application);
    If cmbDestino.Text= 'V�deo' Then
	    QrTabelaPreco.Preview
    else
	    QrTabelaPreco.Print;
    QrTabelaPreco.Free;
    dmdados.tbRelEsto.IndexName:= '';
    end;
  if (cmbClassif.Text='Invent�rio s/ Quantidade') then
    begin
    dmDados.tbRelEsto.IndexName:= 'iDescricao';
    QrInvent2:=TQrInvent2.create(application);
    If cmbDestino.Text= 'V�deo' Then
	    QrInvent2.Preview
    else
	    QrInvent2.Print;
    QrInvent2.Free;
    dmdados.tbRelEsto.IndexName:= '';
    end;
  if (cmbClassif.Text='Invent�rio c/ Quantidade') then
    begin
    dmDados.tbRelEsto.IndexName:= 'iDescricao';
    QrInventario:=TQrInventario.create(application);
    If cmbDestino.Text= 'V�deo' Then
	    QrInventario.Preview
    else
	    QrInventario.Print;
    QrInventario.Free;
    dmdados.tbRelEsto.IndexName:= '';
    end;
  if (cmbClassif.Text='Movimento do Dia') then
    begin
    quant:=0;
    vendas:=0;
    TQuant:=0;
    TVendas:=0;
    dmDados.tbMovDia.Close;
    dmDados.tbMovDia.EmptyTable;
    dmDados.tbMovDia.Open;
    dmDados.tbSaida.IndexName:='iData';
    dmDados.tbEstoque.First;
    while not(dmDados.tbEstoque.Eof) do
      begin
      dmDados.tbSaida.First;
      dmDados.tbSaida.Locate('Data',edDataMov.Text,[]);
      quant:=0;
      vendas:=0;
      while (dmDados.tbSaidaData.Value=edDataMov.Date) do
        begin
        if (dmDados.tbEstoqueCodMerc.Value=dmDados.tbSaidaCodMerc.Value) then
          begin
          quant:=quant+dmDados.tbSaidaQuant.Value;
          vendas:=vendas+(dmDados.tbSaidaQuant.Value*dmDados.tbEstoquePrecoVenda.Value);
          end;
        dmDados.tbSaida.Next;
        end;
      TQuant:=tQuant+quant;
      TVendas:=TVendas+vendas;
      dmDados.tbMovDia.Append;
      dmDados.tbMovDiaDataMov.Value:=dmDados.tbSaidaData.Value;
      dmDados.tbMovDiaCodMerc.Value:=dmDados.tbEstoqueCodMerc.Value;
      dmDados.tbMovDiaDescricao.Value:=dmDados.tbEstoqueDescricao.Value;
      dmDados.tbMovDiaQuantidade.Value:=quant;
      dmDados.tbMovDiaValor.Value:=vendas;
      dmDados.tbMovDia.Post;
      dmDados.tbEstoque.Next;
      end;
    dmDados.tbMovDia.IndexName:= 'iCodMerc';
    QrMovDia:=TQrMovDia.create(application);
    QrMovDia.TotValor.Caption:='R$ '+FloatToStr(TVendas);
    QrMovDia.TotVendas.Caption:=FloatToStr(TQuant);
    if cmbDestino.Text= 'V�deo' then
	    QrMovDia.Preview
    else
      QrMovDia.Print;
    QrMovDia.Free;
    dmdados.tbMovDia.IndexName:= '';
    dmDados.tbSaida.IndexName:='';
    end;
end;

procedure TFrmRelEstoque.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmRelEstoque.cmbDestinoExit(Sender: TObject);
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
      cmbDestino.clear;
      cmbDestino.SetFocus;
      End
    else
      begin
      Panel3.SetFocus;
      btnImprimir.Enabled:=true;
      end;
    end;
end;

procedure TFrmRelEstoque.cmbDestinoCloseUp(Sender: TObject);
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
      cmbDestino.clear;
      cmbDestino.SetFocus;
      End
    else
      begin
      Panel3.SetFocus;
      btnImprimir.Enabled:=true;
      end;
    end;
end;

procedure TFrmRelEstoque.cmbDestinoChange(Sender: TObject);
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
    for x:=0 to cmbDestino.Items.Count-1 Do
      If cmbDestino.Text=cmbDestino.Items[x] Then
        Flag:=False;
    If Flag Then
      Begin
      ShowMessage('Valor inv�lido');
      cmbDestino.clear;
      cmbDestino.SetFocus;
      End
    else
      begin
      Panel3.SetFocus;
      btnImprimir.Enabled:=true;
    end;
  end;
end;

procedure TFrmRelEstoque.cmbclassifChange(Sender: TObject);
begin
  dmDados.RelEstoque:=cmbClassif.Text;
  if cmbClassif.Text='Movimento do Dia' Then
    edDataMov.Enabled:=True
  else
    cmbdestino.Enabled:=true;
end;

procedure TFrmRelEstoque.cmbClassifCloseUp(Sender: TObject);
begin
  dmDados.RelEstoque:=cmbClassif.Text;
  if cmbClassif.Text='Movimento do Dia' Then
    edDataMov.Enabled:=True
  else
    cmbdestino.Enabled:=true;
end;

procedure TFrmRelEstoque.cmbClassifExit(Sender: TObject);
begin
  dmDados.RelEstoque:=cmbClassif.Text;
  if cmbClassif.Text='Movimento do Dia' Then
    edDataMov.Enabled:=True
  else
     cmbdestino.Enabled:=true;
end;

procedure TFrmRelEstoque.edDataMovChange(Sender: TObject);
begin
  cmbdestino.Enabled:=true;
end;

procedure TFrmRelEstoque.edDataMovExit(Sender: TObject);
begin
  cmbdestino.Enabled:=true;
end;

procedure TFrmRelEstoque.cmbClassifKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

end.
