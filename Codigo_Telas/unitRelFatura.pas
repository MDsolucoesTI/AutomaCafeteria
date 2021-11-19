//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 01-03-2001
// Ultima modifica��o: 18-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit unitRelFatura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DBCtrls, fcButton, fcImgBtn, RXSplit, RXCtrls,
  SpeedBar, jpeg, ToolEdit, RxLookup, RxGrdCpt, fcImager,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, JvCombobox, JvComponent, JvTransBtn,
  EMsgDlg, fcLabel;

type
  TfrmRelFatura = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    EdtInicial: TDateEdit;
    EdtFinal: TDateEdit;
    Panel3: TLMDBackPanel;
    cmbClassif: TJvComboBox;
    cmbdestino: TJvComboBox;
    fcLabel2: TfcLabel;
    MsgDlg: TEvMsgDlg;
    RxLabel3: TRxLabel;
    RxLabel4: TRxLabel;
    RxLabel5: TRxLabel;
    RxLabel1: TRxLabel;
    btnImprimir: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnimprimirClick(Sender: TObject);
    procedure cmbClassifExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbDestinoExit(Sender: TObject);
    procedure cmbDestinoCloseUp(Sender: TObject);
    procedure cmbdestinoChange(Sender: TObject);
    procedure cmbClassifChange(Sender: TObject);
    procedure cmbClassifCloseUp(Sender: TObject);
    procedure EdtInicialExit(Sender: TObject);
    procedure EdtFinalExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelFatura: TfrmRelFatura;

implementation

uses UnitPrincipal, unitDmDados, unitQrFatura, untFatProd, DB, untRelCaixa;

{$R *.DFM}

procedure TfrmRelFatura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmDados.tbFaturamento.Close;
  dmDados.tbDetVendas.Close;
  dmDados.tbEstoque.Close;
  dmDados.tbCaixa.Close;
  FrmPrincipal.StatusTeclas(False,'');
end;

procedure TfrmRelFatura.BtnSairClick(Sender: TObject);
begin
	Close;
end;

procedure TfrmRelFatura.BtnimprimirClick(Sender: TObject);
var
  Data : TDateTime;
begin
  Btnimprimir.Enabled:=false;
  //criar os qr(s)
  qrFatura := TqrFatura.Create(Application);
  qrFatPro := TqrFatPro.Create(Application);
  qrCaixa  := TqrCaixa.Create(Application) ;
  {Filtros diversos}
  if ((cmbClassif.Text = 'Produto - Dia')or(cmbClassif.Text = 'Produto - Per�odo')) then
    begin
    qrFatPro.tbFaturamento.Open;
    qrFatPro.tbFatProd.Open;
    qrFatpro.tbFatProd.EmptyTable;
    if (cmbClassif.Text = 'Produto - Dia') then
      begin
      qrFatPro.tbFaturamento.Filtered := False;
      qrFatPro.tbFaturamento.Filter   := '(DataVen >= '''+DateToStr(Date)+''')and'+
                                         '(DataVen <= '''+DateToStr(Date)+''')';
      qrFatPro.tbFaturamento.Filtered := True ;
      dmDados.tbDetVendas.Filtered    := False;
      dmDados.tbDetVendas.Filter      := '(DataVen >= '''+DateToStr(Date)+''')and'+
                                         '(DataVen <= '''+DateToStr(Date)+''')';
      dmDados.tbDetVendas.Filtered    := True ;
      dmDados.tbEstoque.First;
      while not(dmDados.tbEstoque.Eof) do
        begin
        //Localizar todas as vendas da mercadoria
        dmDados.tbDetVendas.First;
        if (dmDados.tbDetVendas.Locate('CodMerc',dmDados.tbEstoqueCodMerc.Value,[])) then
          begin
          qrFatPro.tbFatProd.Append;
          qrFatPro.tbFatProdCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value  ;
          qrFatPro.tbFatProdDescricao.Value := dmDados.tbEstoqueDescricao.Value;
          qrFatPro.tbFatProdDataVen.Value   := dmDados.tbDetVendasDataVen.Value;
          qrFatPro.tbFatProd.Post;
          while not(dmDados.tbDetVendas.Eof) do
            begin
            if (dmDados.tbDetVendasCodMerc.Value = dmDados.tbEstoqueCodMerc.Value) then
              begin
              qrFatPro.tbFatProd.Edit;
              qrFatPro.tbFatProdQuant.Value := qrFatPro.tbFatProdQuant.Value +
                                               dmDados.tbDetVendasQuant.Value;
              qrFatPro.tbFatProdValor.Value := qrFatPro.tbFatProdValor.Value +
                                               (dmDados.tbDetVendasPrecoUnit.Value *
                                               dmDados.tbDetVendasQuant.Value);
              qrFatPro.tbFatProd.Post;
              end;
            dmDados.tbDetVendas.Next;
            end;
          qrFatPro.tbFatProd.Edit;
          qrFatPro.tbFatProdPerc.Value := ((qrFatPro.tbFatProdValor.Value*100)/
                                          qrFatPro.tbFaturamentoTotalVenda.Value);
          qrFatPro.tbFatProd.Post;
          end;
        dmDados.tbEstoque.Next;
        end;
      if (cmbDestino.Text = 'V�deo') then
        qrFatPro.Preview
      else
        qrFatPro.Print;
      end
    else
      begin
      qrFatPro.tbFaturamento.Filtered := False;
      qrFatPro.tbFaturamento.Filter   := '(DataVen >= '''+edtInicial.text+''')and'+
                                         '(DataVen <= '''+edtFinal.Text+''')';
      qrFatPro.tbFaturamento.Filtered := True ;
      qrFatPro.tbFaturamento.First;
      while not(qrFatPro.tbFaturamento.Eof) do
        begin
        Data := qrFatPro.tbFaturamentoDataVen.Value;
        dmDados.tbDetVendas.Filtered    := False;
        dmDados.tbDetVendas.Filter      := '(DataVen >= '''+DateToStr(Data)+''')and'+
                                           '(DataVen <= '''+DateToStr(Data)+''')';
        dmDados.tbDetVendas.Filtered    := True ;
        dmDados.tbEstoque.First;
        while not(dmDados.tbEstoque.Eof) do
          begin
          //Localizar todas as vendas da mercadoria
          dmDados.tbDetVendas.First;
          if (dmDados.tbDetVendas.Locate('CodMerc',dmDados.tbEstoqueCodMerc.Value,[])) then
            begin
            qrFatPro.tbFatProd.Append;
            qrFatPro.tbFatProdCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value  ;
            qrFatPro.tbFatProdDescricao.Value := dmDados.tbEstoqueDescricao.Value;
            qrFatPro.tbFatProdDataVen.Value   := dmDados.tbDetVendasDataVen.Value;
            qrFatPro.tbFatProd.Post;
            while not(dmDados.tbDetVendas.Eof) do
              begin
              if (dmDados.tbDetVendasCodMerc.Value = dmDados.tbEstoqueCodMerc.Value) then
                begin
                qrFatPro.tbFatProd.Edit;
                qrFatPro.tbFatProdQuant.Value := qrFatPro.tbFatProdQuant.Value +
                                                 dmDados.tbDetVendasQuant.Value;
                qrFatPro.tbFatProdValor.Value := qrFatPro.tbFatProdValor.Value +
                                                 (dmDados.tbDetVendasPrecoUnit.Value *
                                                 dmDados.tbDetVendasQuant.Value);
                qrFatPro.tbFatProd.Post;
                end;
              dmDados.tbDetVendas.Next;
              end;
            qrFatPro.tbFatProd.Edit;
            qrFatPro.tbFatProdPerc.Value := ((qrFatPro.tbFatProdValor.Value*100)/
                                            qrFatPro.tbFaturamentoTotalVenda.Value);
            qrFatPro.tbFatProd.Post;
            end;
          dmDados.tbEstoque.Next;
          end;
        qrFatPro.tbFaturamento.Next;
        end;
      if (cmbDestino.Text = 'V�deo') then
        qrFatPro.Preview
      else
        qrFatPro.Print;
      end;
    end;
  if (cmbClassif.Text = 'Do Dia') then
    begin
    dmdados.tbFaturamento.Filtered := False;
    dmdados.tbFaturamento.Filter := '(DataVen >= '''+DateToStr(Date)+''')and'+
                                    '(DataVen <= '''+DateToStr(Date)+''')';
    dmdados.tbFaturamento.Filtered := True ;
    if (cmbDestino.Text = 'V�deo') then
      QrFatura.rpFatura.Preview
    else
      QrFatura.rpFatura.Print;
    end;
  if (cmbClassif.Text = 'Per�odo') then
    begin
    dmdados.tbFaturamento.Filtered := False;
    dmdados.tbFaturamento.Filter := '(DataVen >= '''+edtInicial.text+''')and'+
                                   '(DataVen <= '''+edtFinal.Text+''')';
    dmdados.tbFaturamento.Filtered := True ;
    if (cmbDestino.Text = 'V�deo') then
      QrFatura.rpFatura.Preview
    else
      QrFatura.rpFatura.Print;
    end;
  if (cmbClassif.Text = 'Caixa - Fechado') then
    begin
    dmdados.tbCaixa.Filtered := False;
    dmdados.tbCaixa.Filter   := '(DataMov >= '''+edtInicial.text+''')and'+
                                '(DataMov <= '''+edtFinal.Text+''')';
    dmdados.tbCaixa.Filtered := True ;
    if (cmbDestino.Text = 'V�deo') then
      qrCaixa.Preview
    else
      qrCaixa.Print;
    end;
  qrFatPro.Free;
  qrFatura.Free;
  qrCaixa.Free;
  dmdados.tbFaturamento.Filtered := False;
  dmDados.tbDetVendas.Filtered   := False;
  dmdados.tbCaixa.Filtered       := False;
end;

procedure TfrmRelFatura.cmbClassifExit(Sender: TObject);
begin
  if ((cmbClassif.Text = 'Do Dia')or(cmbClassif.Text = 'Produto - Dia')) then
    begin
    edtinicial.Enabled := False;
    edtfinal.Enabled   := False;
    cmbdestino.Enabled := True ;
    end;
  if ((cmbClassif.Text = 'Per�odo')or(cmbClassif.Text = 'Produto - Per�odo')) then
    begin
    edtinicial.Enabled := True ;
    edtfinal.Enabled   := True ;
    cmbdestino.Enabled := True ;
    end;
  if (cmbClassif.Text = 'Caixa - Fechado') then
    begin
    edtinicial.Enabled := True ;
    edtfinal.Enabled   := True ;
    cmbdestino.Enabled := True ;
    end;
end;

procedure TfrmRelFatura.FormShow(Sender: TObject);
begin
  dmDados.tbFaturamento.Open;
  dmDados.tbDetVendas.Open;
  dmDados.tbEstoque.Open;
  dmDados.tbCaixa.Open;
  FrmPrincipal.StatusTeclas(True,'[F2] Imprimir [Esc] Cancelar ou Sair');
  cmbclassif.setfocus;
end;

procedure TfrmRelFatura.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_F2    : Btnimprimir.Click;
      VK_ESCAPE : if dmDados.vTabStt then BtnSair.Click;
    end;
end;

procedure TfrmRelFatura.cmbDestinoExit(Sender: TObject);
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
        cmbdestino.Enabled:=false;
        end;
      end;
end;

procedure TfrmRelFatura.cmbDestinoCloseUp(Sender: TObject);
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

procedure TfrmRelFatura.cmbdestinoChange(Sender: TObject);
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
        cmbdestino.Enabled:=false
        end;
      end;
end;

procedure TfrmRelFatura.cmbClassifChange(Sender: TObject);
begin
  if ((cmbClassif.Text = 'Do Dia')or(cmbClassif.Text = 'Produto - Dia')) then
    begin
    edtinicial.Enabled := False;
    edtfinal.Enabled   := False;
    cmbdestino.Enabled := True ;
    end;
  if ((cmbClassif.Text = 'Per�odo')or(cmbClassif.Text = 'Produto - Per�odo')) then
    begin
    edtinicial.Enabled := True ;
    edtfinal.Enabled   := True ;
    cmbdestino.Enabled := True ;
    end;
  if (cmbClassif.Text = 'Caixa - Fechado') then
    begin
    edtinicial.Enabled := True ;
    edtfinal.Enabled   := True ;
    cmbdestino.Enabled := True ;
    end;
end;

procedure TfrmRelFatura.cmbClassifCloseUp(Sender: TObject);
begin
  if ((cmbClassif.Text = 'Do Dia')or(cmbClassif.Text = 'Produto - Dia')) then
    begin
    edtinicial.Enabled := False;
    edtfinal.Enabled   := False;
    cmbdestino.Enabled := True ;
    end;
  if ((cmbClassif.Text = 'Per�odo')or(cmbClassif.Text = 'Produto - Per�odo')) then
    begin
    edtinicial.Enabled := True ;
    edtfinal.Enabled   := True ;
    cmbdestino.Enabled := True ;
    end;
  if (cmbClassif.Text = 'Caixa - Fechado') then
    begin
    edtinicial.Enabled := True ;
    edtfinal.Enabled   := True ;
    cmbdestino.Enabled := True ;
    end;
end;

procedure TfrmRelFatura.EdtInicialExit(Sender: TObject);
begin
  If (EdtInicial.text = '  /  /    ') then
    begin
    ShowMessage('DATA INICIAL n�o foi preenchida');
    EdtInicial.SetFocus;
    end
  else
    begin
    try StrToDate(EdtInicial.text)
    except on EConvertError do
      begin
      ShowMessage('DATA INICIAL inv�lida');
      EdtInicial.SetFocus;
      end;
    end;
    end;
end;

procedure TfrmRelFatura.EdtFinalExit(Sender: TObject);
begin
  If (EdtFinal.text = '  /  /    ') then
    begin
    ShowMessage('DATA FINAL n�o foi preenchida');
    EdtFinal.SetFocus;
    end
  else
    begin
    try StrToDate(EdtFinal.text)
    except on EConvertError do
      begin
      ShowMessage('DATA FINAL inv�lida');
      EdtFinal.SetFocus;
      end;
    end;
    end;
end;

end.
