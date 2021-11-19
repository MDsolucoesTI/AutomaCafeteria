//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 27-01-2001
// Ultima modifica��o: 28-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////


unit unitCpagar;

interface

uses
  Windows, Messages, SysUtils, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, SpeedBar, jpeg, ExtCtrls, fcButton, fcImgBtn, ToolWin, ComCtrls,
  RXCtrls, RXSplit, StdCtrls, DBCtrls, Mask, ToolEdit, RXDBCtrl, CurrEdit,
  SRColBtn, TFlatCheckBoxUnit, Spin, RackCtls, RxLookup, TFlatHintUnit,db,
  LMDCustomComponent, LMDCustomHint, LMDCustomShapeHint, LMDShapeHint,
  RxGrdCpt, fcImager, TFlatSplitterUnit, EMsgDlg, lmdstdcA, RxDBComb,
  JvComponent, JvTransBtn, fcLabel, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, JvPanel,
  JvTransparentPanel;

type
  TFrmCPagar = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel1: TfcLabel;
    LMDBackPanel3: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    Panel3: TLMDBackPanel;
    btnSair: TJvTransparentButton;
    btnRestaurar: TJvTransparentButton;
    btnPagar: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnLocalizar: TJvTransparentButton;
    btnAlterar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    dbDtPgto: TDBDateEdit;
    dbDesc: TRxDBCalcEdit;
    dbJuros: TRxDBCalcEdit;
    dbVlPago: TRxDBCalcEdit;
    btnSim: TfcImageBtn;
    btnNao: TfcImageBtn;
    RxLabel8: TRxLabel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel3: TRxLabel;
    RxLabel4: TRxLabel;
    dbeNumDoc: TDBEdit;
    dblookTipo: TRxDBLookupCombo;
    dblookFor: TRxDBLookupCombo;
    dblookhist: TRxDBLookupCombo;
    dbemissao: TDBDateEdit;
    dbvenc: TDBDateEdit;
    dbvalor: TRxDBCalcEdit;
    dbSituacao: TDBEdit;
    cmbPortador: TRxDBComboBox;
    dbIntervalo: TEdit;
    dbParcela: TLMDSpinEdit;
    RxLabel5: TRxLabel;
    RxLabel6: TRxLabel;
    RxLabel7: TRxLabel;
    dbPagamento: TDBText;
    RxLabel9: TRxLabel;
    btnLocFor: TfcImageBtn;
    RxLabel10: TRxLabel;
    RxLabel11: TRxLabel;
    RxLabel12: TRxLabel;
    RxLabel13: TRxLabel;
    RxLabel14: TRxLabel;
    RxLabel15: TRxLabel;
    RxLabel16: TRxLabel;
    RxLabel17: TRxLabel;
    dbComplHist: TDBMemo;
    MsgDlg: TEvMsgDlg;
    JvTransparentPanel1: TJvTransparentPanel;
    dbLookBanc: TDBLookupComboBox;
    RxLabel18: TRxLabel;
    JvTransparentPanel2: TJvTransparentPanel;
    function GeraData(iData:TdateTime;iDias:integer):TDateTime;
    procedure BtnSairClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNumDocExit(Sender: TObject);
    procedure dbemissaoExit(Sender: TObject);
    procedure dbvalorExit(Sender: TObject);
    procedure dbvencExit(Sender: TObject);
    procedure btBaixaClick(Sender: TObject);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure btlocdocClick(Sender: TObject);
    procedure btnlocforClick(Sender: TObject);
    procedure BtnPrimeiroClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnUltimoClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btReciboClick(Sender: TObject);
    procedure fcImageBtn1Click(Sender: TObject);
    procedure fcImageBtn2Click(Sender: TObject);
    procedure fcImageBtn3Click(Sender: TObject);
    procedure dbDtPgtoExit(Sender: TObject);
    procedure dbDescExit(Sender: TObject);
    procedure dbJurosExit(Sender: TObject);
    procedure btnPagarClick(Sender: TObject);
    procedure btnSimClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure dbParcelaExit(Sender: TObject);
    procedure cmbPortadorChange(Sender: TObject);
    procedure cmbPortadorExit(Sender: TObject);
    procedure dbParcelaChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCPagar: TFrmCPagar;
  novoItem:boolean;
  
implementation

uses unitDmdados, unitPrincipal, unitLocFornec, UnitLocCP, UnitBaixaLoteCP,
     unitTipoReceb, unitLocTipoDoc, UnitTipoPagto;

{$R *.DFM}

function TFrmCPagar.GeraData(iData:TdateTime;iDias:integer):TDateTime;
var
  vVenc,vDia,vMes,vAno:Word;
  iDia,iMes,iAno:string;
  x:integer;
begin
  decodedate(iData,vAno,vMes,vDia);
  vVenc:=vDia;
  if iDias >= 30 then
    begin
    for x:=1 to (iDias div 30) do
      begin
      vMes:=vMes+1;
      if vMes=13 then
        begin
        vAno:=vAno+1;
        vMes:=1;
        end;
      end;
    if ((vDia<=31)and(vDia>=29))and(vMes=2) then
      begin
      if (vAno mod 4)=0 then
        vDia:=29
      else
        vDia:=28;
      end;
    if (vDia=31)and((vMes=4)or(vMes=6)or(vMes=9)or(vMes=11)) then
      vDia:=30;
    if vDia < vVenc then
      if vMes <> 2 then
        if (vMes=4)or(vMes=6)or(vMes=9)or(vMes=11) then
          if vVenc=31 Then
            vDia:=30
          else
            vDia:=vVenc
        else
          vDia:=vVenc;
    iDia:=IntToStr(vDia);
    iMes:=IntToStr(vMes);
    iAno:=IntToStr(vAno);
    GeraData:=StrToDate(iDia+'/'+iMes+'/'+iAno);
    end
  else
    GeraData:=iData+iDias;
end;

procedure TFrmCPagar.BtnSairClick(Sender: TObject);
begin
  if (dmdados.tbCPagar.State=dsInsert) or (dmdados.tbCPagar.State=dsEdit) then
    dmdados.tbCPagar.Cancel;
  Close;
end;

procedure TFrmCPagar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    end;
end;

procedure TFrmCPagar.dbeNumDocExit(Sender: TObject);
begin
  if NovoItem then
    if dbeNumDoc.Text='' then
      begin
      MsgDlg.MsgError('Necess�rio informar o N�mero do Documento');
      dbeNumDoc.SetFocus;
      end;
end;

procedure TFrmCPagar.dbemissaoExit(Sender: TObject);
begin
  if NovoItem then
    if dbemissao.Text= '  /  /    ' then
      begin
      MsgDlg.MsgError('� obrigat�rio a Data de Emiss�o');
      dbEmissao.SetFocus;
      end;
end;

procedure TFrmCPagar.dbvalorExit(Sender: TObject);
begin
  if NovoItem then
    if dbvalor.Text= '' then
      begin
      MsgDlg.MsgError('� obrigat�rio o Valor do documento');
      dbvalor.SetFocus;
      end;
  Panel3.SetFocus;
end;

procedure TFrmCPagar.dbvencExit(Sender: TObject);
begin
  if NovoItem then
    if dbvenc.Text= '  /  /    ' then
      begin
      MsgDlg.MsgError('� obrigat�rio a Data de Emiss�o');
      dbvenc.SetFocus;
      end;
end;

procedure TFrmCPagar.btBaixaClick(Sender: TObject);
begin
  FrmBaixaLoteCP:=TFrmBaixaLoteCP.Create(Application);
  FrmBaixaLoteCP.ShowModal;
end;

procedure TFrmCPagar.BtnLocalizarClick(Sender: TObject);
begin
  FrmLocCpagar:=TFrmLocCpagar.Create(Application);
  FrmLocCpagar.ShowModal;
  FrmLocCpagar.Free;
end;

procedure TFrmCPagar.btlocdocClick(Sender: TObject);
begin
  if (dmdados.tbCpagar.State=dsedit)or(dmdados.tbCpagar.State=dsInsert) then
    begin
    frmLocTipoDoc:=tfrmLocTipoDoc.create(application);
    frmLocTipoDoc.showmodal;
    dmdados.tbCpagarCodDoc.value:=frmlocTipoDoc.resultado;
    frmLocTipoDoc.Free;
    end;
end;

procedure TFrmCPagar.btnlocforClick(Sender: TObject);
begin
  if (dmdados.tbCpagar.State=dsedit)or(dmdados.tbCpagar.State=dsInsert) then
    begin
    frmLocFornec:=tfrmLocFornec.Create(application);
    frmLocFornec.ShowModal;
    dmdados.tbCpagarCodFor.Value:=frmLocFornec.Resultado;
    frmLocFornec.Free;
    end;
end;

procedure TFrmCPagar.BtnPrimeiroClick(Sender: TObject);
begin
  dmdados.tbCpagar.First;
  btnPrimeiro.Enabled:=False;
  btnAnterior.Enabled:=False;
  btnProximo.Enabled:=True;
  btnUltimo.Enabled:=True;
end;

procedure TFrmCPagar.BtnAnteriorClick(Sender: TObject);
begin
  dmdados.tbCpagar.Prior;
  btnProximo.Enabled:=True;
  btnUltimo.Enabled:=True;
  if dmdados.tbCpagar.bof then
    begin
    btnPrimeiro.Enabled:=False;
    btnAnterior.Enabled:=False;
    end;
end;

procedure TFrmCPagar.BtnProximoClick(Sender: TObject);
begin
  dmdados.tbCpagar.next;
  btnPrimeiro.Enabled:=True;
  btnAnterior.Enabled:=True;
  if dmdados.tbCpagar.Eof then
    begin
    btnProximo.Enabled:=False;
    btnUltimo.Enabled:=False;
    end;
end;

procedure TFrmCPagar.BtnUltimoClick(Sender: TObject);
begin
  dmdados.tbCpagar.Last;
  btnPrimeiro.Enabled:=True;
  btnAnterior.Enabled:=True;
  btnProximo.Enabled:=False;
  btnUltimo.Enabled:=False;
end;

procedure TFrmCPagar.BtnNovoClick(Sender: TObject);
begin
  novoItem:=true;
  dmdados.vTabStt:= False;
  dmdados.tbCpagar.Append;
  {habilitando os bot�es}
  BtnGravar.Enabled := true;
  BtnCancelar.Enabled:=true;
  BtnNovo.Enabled:=False;
  BtnPrimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  BtnAlterar.Enabled:=False;
  BtnDeletar.Enabled:=False;
  btnLocFor.Enabled:=true;
  {habilitando os componentes}
  dbeNumDoc.Enabled:=true;
  DblookTipo.Enabled:= True;
  dblookFor.Enabled:=True;
  dblookhist.Enabled:=true;
  dbComplHist.Enabled:=True;
  dbEmissao.Enabled:=True;
  dbVenc.Enabled:=true;
  dbvalor.Enabled:=True;
  dbParcela.Enabled:=True;
  //dbIntervalo.Enabled:=True;
  cmbPortador.Enabled:=True;
  //dbLookBanc.Enabled:=True;
  {desativar radio group}
  dbeNumDoc.SetFocus;
end;

procedure TFrmCPagar.BtnGravarClick(Sender: TObject);
var
  Campos:String;
  NumDoc,CodDoc,CodHist,CompHist,CodcCusto,Portador,NumBanco : string;
  CodFor,c,f,I : integer;
  DataEmis,DataVenc : TDateTime;
  Valor : Real;
  Vazio,Gravar:Boolean;
begin
  Campos:='';
  Gravar:=True;
  Vazio:=False;
  if dbeNumDoc.Text= '' then
    begin
    if Length(Campos)>0 then Campos:=Campos+', ';
    Campos:=Campos+'N�Doc';
    Gravar:=False;
    Vazio:=True;
    end;
  if dbEmissao.Text= '  /  /    ' then
    begin
    if Length(Campos)>0 then Campos:=Campos+', ';
    Campos:=Campos+'Emissao';
    Gravar:=False;
    Vazio:=True;
    end
  else
    try StrToDate(dbemissao.text)
    except on EConvertError do
      begin
      MsgDlg.MsgError('Data de Emiss�o Inv�lida');
      gravar:= false;
      end;
    end;
  if dbVenc.Text= '  /  /    ' then
    begin
    if Length(Campos)>0 then Campos:=Campos+', ';
    Campos:=Campos+'Vencimento';
    Gravar:=False;
    Vazio:=True;
    end
  else
    try StrToDate(dbVenc.text)
    except on EConvertError do
      begin
      MsgDlg.MsgError('Data de Vencimento Inv�lida');
      gravar:= false;
      end;
    end;
  if dbValor.Text= '' then
    begin
    if dbvalor.value=0 then Campos:=Campos+', ';
    Campos:=Campos+'Valor(R$)';
    Gravar:=False;
    Vazio:=True;
    end;
  if Gravar then
    begin
    novoItem:=false;
    dmdados.vTabStt:= True;
    if dbParcela.Value > 1 then
      begin
      c:=1;
      f:=dbParcela.Value;
      I:=StrToInt(dbIntervalo.Text);
      CompHist:=dbComplHist.Text;
      dmdados.tbCPagarPago.Value:='ABERTO';
      dmDados.tbCPagarCompHist.Value:=IntToStr(c)+'/'+IntToStr(f)+' - '+dbcomplhist.Text;
      dmdados.tbCPagar.Post;
      NumDoc:=dmDados.tbCPagarNumDoc.Value;
      CodDoc:=dmDados.tbCPagarCodDoc.Value;
      CodFor:=dmDados.tbCPagarCodFor.Value;
      DataEmis:=dmDados.tbCPagarDataEmis.Value;
      DataVenc:=dmDados.tbCPagarDataVenc.Value;
      CodHist:=dmDados.tbCPagarCodHist.Value;
      Valor:=dmDados.tbCPagarValor.Value;
      CodCCusto:=dmDados.tbCPagarCodCCusto.Value;
      Portador:=dmDados.tbCPagarPortador.Value;
      NumBanco:=dmDados.tbCPagarNumBanco.Value;
      for c:=2 to f do
        begin
        dmDados.tbCPagar.Append;
        dmdados.tbCPagarPago.Value:='ABERTO';
        dmDados.tbCPagarCompHist.Value:=IntToStr(c)+'/'+IntToStr(f)+' - '+CompHist;
        dmDados.tbCPagarNumDoc.Value:=NumDoc;
        dmDados.tbCPagarCodDoc.Value:=CodDoc;
        dmDados.tbCPagarCodFor.Value:=CodFor;
        dmDados.tbCPagarDataEmis.Value:=DataEmis;
        dmDados.tbCPagarDataVenc.Value:=GeraData(DataVenc,(I*(c-1)));
        dmDados.tbCPagarCodHist.Value:=CodHist;
        dmDados.tbCPagarValor.Value:=Valor;
        dmDados.tbCPagarCodCCusto.Value:=CodCCusto;
        dmDados.tbCPagarPortador.Value:=Portador;
        dmDados.tbCPagarNumBanco.Value:=NumBanco;
        dmDados.tbCPagar.Post;
        end;
      end
    else
      begin
      dmdados.tbCPagarPago.Value:='ABERTO';
      dmdados.tbCPagar.Post;
      end;
    BtnGravar.enabled := False;
    BtnCancelar.Enabled := False;
    BtnNovo.Enabled:=True;
    BtnPrimeiro.Enabled:=True;
    BtnAnterior.Enabled:=True;
    BtnProximo.Enabled:=True;
    BtnUltimo.Enabled:=True;
    BtnAlterar.Enabled:=True;
    Btndeletar.Enabled:=True;
    BtnLocFor.Enabled:=True;
    {desabilitando os componentes}
    dbParcela.Enabled:=False;
    dbIntervalo.Enabled:=False;
    cmbPortador.Enabled:=False;
    dbLookBanc.Enabled:=False;
    DblookTipo.Enabled:= false;
    dblookFor.Enabled:=false;
    dblookhist.Enabled:=false;
    dbComplHist.Enabled:=false;
    dbEmissao.Enabled:=false;
    dbVenc.Enabled:=false;
    dbvalor.Enabled:=false;
    dbenumdoc.Enabled:=false;
    MsgDlg.MsgInformation('Dados gravados com sucesso');
    end
  else
    begin
    if Vazio then
      begin
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
      DbeNumDoc.SetFocus;
      end;
    end;
end;

procedure TFrmCPagar.BtnCancelarClick(Sender: TObject);
begin
  novoItem:=false;
  dmdados.vTabStt:= True;
  dmdados.tbCpagar.cancel;
  BtnGravar.enabled := false;
  BtnCancelar.Enabled := false;
  BtnNovo.Enabled:=True;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  Btnproximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  BtnAlterar.Enabled:=True;
  BtnDeletar.Enabled:=True;
  BtnLocFor.Enabled:=True;
  {desabilitando os objetos}
  dbParcela.Enabled:=False;
  dbIntervalo.Enabled:=False;
  cmbPortador.Enabled:=False;
  dbLookBanc.Enabled:=False;
  DblookTipo.Enabled:= false;
  dblookFor.Enabled:=false;
  dblookhist.Enabled:=false;
  dbComplHist.Enabled:=false;
  dbEmissao.Enabled:=false;
  dbVenc.Enabled:=false;
  dbvalor.Enabled:=false;
  dbeNumDoc.Enabled:=false;
  Panel3.SetFocus;
end;

procedure TFrmCPagar.BtnAlterarClick(Sender: TObject);
begin
  if dmdados.tbCpagar.RecordCount=0 then
    MsgDlg.MsgInformation('Tabela sem registro')
  else
    begin
    novoItem:=true;
    dmdados.vTabStt:= False;
    dmdados.tbCpagar.Edit;
    BtnCancelar.enabled:= true;
    BtnGravar.Enabled:= true;
    BtnNovo.Enabled:=False;
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    BtnAlterar.Enabled:=False;
    Btndeletar.Enabled:=False;
    BtnLocFor.Enabled:=true;
    {habilitando os objetos}
    DblookTipo.Enabled:= True;
    dblookFor.Enabled:=True;
    dblookhist.Enabled:=true;
    dbComplHist.Enabled:=True;
    dbParcela.Enabled:=True;
    cmbPortador.Enabled:=True;
    //dbLookBanc.Enabled:=True;
    dbEmissao.Enabled:=True;
    dbVenc.Enabled:=true;
    dbvalor.Enabled:=True;
    dblooktipo.SetFocus;
    end;
end;

procedure TFrmCPagar.BtnDeletarClick(Sender: TObject);
begin
  novoitem:=false;
  dmdados.vTabStt:= True;
  if dmdados.tbCpagar.RecordCount=0 then
    MsgDlg.MsgInformation('Tabela sem registro')
  else
   if MsgDlg.MsgConfirmation('Tem certeza que deseja exluir esse registro?') = id_yes then
      dmdados.tbCpagar.Delete;
end;

procedure TFrmCPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_Insert : if (dmDados.vTabStt) then BtnNovo.Click;
      VK_Home   : if (dmDados.vTabStt) then BtnAlterar.Click;
      VK_Delete : if (dmDados.vTabStt) then BtnDeletar.Click;
      VK_End    : if not(dmDados.vTabStt) then btnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
      VK_F3     : btnlocFor.Click;
    end;
end;

procedure TFrmCPagar.btReciboClick(Sender: TObject);
begin
  {QrReciboCp:=tQrReciboCp.create(application);
  QrReciboCp.pag.preview;}
end;

procedure TFrmCPagar.fcImageBtn1Click(Sender: TObject);
begin
{  if dmdados.tbCPagarPago.value='PAGO' then
    MsgDlg.MsgInformation('Este titulo j� est� PAGO')
  else
    if (dmdados.tbCPagarPago.Value='ABERTO') then
      if MsgDlg.MsgConfirmation.MessageBox('Est titulo est� em ABERTO, voc� deseja efetuar o pagamento?') = id_yes then
        begin
        dmdados.tbCPagar.Edit;
        frmCPagar.Visible:=false;
        FrmBaixaCPagar:=TFrmBaixaCPagar.Create(Application);
        FrmBaixaCPagar.ShowModal;
        end;}
end;

procedure TFrmCPagar.fcImageBtn2Click(Sender: TObject);
begin
{  if dmdados.tbCPagarPago.value='ABERTO' then
    MsgDlg.MsgInformation('Este titulo j� est� PAGO')
  else
    if (dmdados.tbCPagarPago.Value='PAGO') then
      if MsgDlg.MsgConfirmation('Esta conta est� QUITADA, voc� quer mesmo RESTAURAR?') = id_yes then
        begin
        dmdados.tbCPagar.Edit;
        frmRestauraCPagar:=tfrmRestauraCPagar.create(application);
        frmRestauraCPagar.showmodal;
        end;}
end;

procedure TFrmCPagar.fcImageBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmCPagar.dbDtPgtoExit(Sender: TObject);
begin
  if  (dbDtPgto.text ='  / /   ') then
    begin
    MsgDlg.MsgWarning('Data Vazia');
    dbDtPgto.SetFocus;
    end
  else
    try StrToDate(dbDtPgto.text)
    except on EConvertError do
      begin
      MsgDlg.MsgError('Data Inv�lida');
      dbDtPgto.SetFocus;
      end;
    end;
end;

procedure TFrmCPagar.dbDescExit(Sender: TObject);
begin
  if NovoItem then
    dmDados.tbCPagarValorPago.Value:=dmDados.tbCPagarValor.Value-dbDesc.Value;
    Panel3.SetFocus;
end;

procedure TFrmCPagar.dbJurosExit(Sender: TObject);
begin
  if NovoItem then
    dmDados.tbCPagarValorPago.Value:=dmDados.tbCPagarValor.Value-dbJuros.Value;
    Panel3.SetFocus;
end;

procedure TFrmCPagar.btnPagarClick(Sender: TObject);
begin
  if dmdados.tbCPagarPago.value='PAGO' then
    MsgDlg.MsgInformation('T�tulo j� est� PAGO')
  else
    begin
    dmdados.tbCPagar.Edit;
    NovoItem:=True;
    {habilitando os bot�es}
    BtnGravar.Enabled := False;
    BtnCancelar.Enabled:=False;
    BtnNovo.Enabled:=False;
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    BtnAlterar.Enabled:=False;
    BtnDeletar.Enabled:=False;
    btnLocalizar.Enabled:=False;
    btnPagar.Enabled:=False;
    btnRestaurar.Enabled:=False;
    btnSim.Enabled:=True;
    btnNao.Enabled:=True;
    {habilitando os componentes}
    dbDtPgto.Enabled:=True;
    dbDesc.Enabled:=True;
    dbJuros.Enabled:=True;
    dbVlPago.Enabled:=True;
    dbDtPgto.SetFocus;
    end;
end;

procedure TFrmCPagar.btnSimClick(Sender: TObject);
begin
  FrmTipoPgto:=TFrmTipoPgto.create(application);
  FrmTipoPgto.showmodal;
  if FrmTipoPgto.PagoStt = 'S' then
    begin
    FrmTipoPgto.Free;
    NovoItem:=False;
    dmdados.vTabStt:=True;
    dmDados.tbCPagarPago.Value:='PAGO';
    dmDados.tbCPagarTipoPago.Value:='Pagamento Total';
    dmdados.tbCPagar.Post;
    BtnGravar.enabled := false;
    BtnCancelar.Enabled := false;
    BtnNovo.Enabled:=True;
    BtnPrimeiro.Enabled:=True;
    BtnAnterior.Enabled:=True;
    Btnproximo.Enabled:=True;
    BtnUltimo.Enabled:=True;
    BtnAlterar.Enabled:=True;
    BtnDeletar.Enabled:=True;
    btnLocalizar.Enabled:=True;
    btnPagar.Enabled:=True;
    btnRestaurar.Enabled:=True;
    btnSim.Enabled:=False;
    btnNao.Enabled:=False;
    {desabilitando os objetos}
    dbDtPgto.Enabled:=False;
    dbDesc.Enabled:=False;
    dbJuros.Enabled:=False;
    dbVlPago.Enabled:=False;
    Panel3.SetFocus;
    end
  else
    begin
    FrmTipoPgto.Free;
    btnNao.Click;
    end;
end;

procedure TFrmCPagar.btnNaoClick(Sender: TObject);
begin
  NovoItem:=False;
  dmdados.vTabStt:=True;
  dmdados.tbCPagar.cancel;
  BtnGravar.enabled := false;
  BtnCancelar.Enabled := false;
  BtnNovo.Enabled:=True;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  Btnproximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  BtnAlterar.Enabled:=True;
  BtnDeletar.Enabled:=True;
  btnLocalizar.Enabled:=True;
  btnPagar.Enabled:=True;
  btnRestaurar.Enabled:=True;
  btnSim.Enabled:=False;
  btnNao.Enabled:=False;
  {desabilitando os objetos}
  dbDtPgto.Enabled:=False;
  dbDesc.Enabled:=False;
  dbJuros.Enabled:=False;
  dbVlPago.Enabled:=False;
  Panel3.SetFocus;
end;

procedure TFrmCPagar.btnRestaurarClick(Sender: TObject);
var
  ano,mes,dia : word;
  mesCusto,anoCusto,Conta,Custo : string;
begin
  if dmdados.tbCPagarPago.Value='ABERTO' then
    MsgDlg.MsgInformation('T�tulo j� est� ABERTO')
  else
    if (dmdados.tbCPagarPago.Value='PAGO') then
      If MsgDlg.MsgConfirmation('T�tulo est� em PAGO, voc� quer mesmo RESTAURAR?') = id_yes then
        begin
        if dmdados.TbMovConta.Locate('CodDoc;DataMov',VarArrayOf([dmDados.tbCPagarCodDoc.Value,dmDados.tbCPagarDataVenc.Value]),[]) then
          Conta:=dmDados.TbMovContaConta.Value
        else
          Conta:='000000000000001';
        {inserir inf de estorno no movimento de conta}
        dmdados.TbMovConta.Append;
        dmdados.TbMovContaDosNumero.Value:=dmdados.tbCPagarNumDoc.Value;
        dmdados.TbMovContaConta.Value:=Conta;
        dmdados.TbMovContaDataMov.Value:=date;
        dmdados.tbMovContaDataReg.value:=date;
        dmdados.TbMovContaHoraReg.Value:=time;
        dmdados.TbMovContaTipoOper.Value:='E';
        dmdados.TbMovContaCodHist.Value:=dmdados.tbCPagarCodHist.Value;
        dmdados.TbMovContaCodDoc.Value:=dmdados.tbCPagarCodDoc.Value;
        dmdados.TbMovContaComplHist.Value:='Estorno do Pagamento';
        dmdados.TbMovContaValor.Value:=dmdados.tbCPagarValorPago.Value;
        dmdados.TbMovConta.Post;
        {atualizar conta corrente}
        if dmdados.TbCCorrente.Locate('Conta',Conta,[]) then
          begin
          dmdados.TbCCorrente.Edit;
          dmdados.TbCCorrenteSaldo.Value:=dmDados.TbCCorrenteSaldo.Value+dmdados.tbCPagarValorPago.Value;
          dmdados.tbccorrenteUltMov.value:=date;
          dmdados.TbCCorrente.post;
          end;
        dmdados.tbCPagar.Edit;
        dmdados.tbCPagarDataPaga.Clear;
        dmdados.tbCPagarValorPago.Clear;
        dmDados.tbCPagarDescPago.Clear;
        dmDados.tbCPagarMuJuPago.Clear;
        dmdados.tbCPagarPago.Value:='ABERTO';
        dmdados.tbCPagar.Post;
        end;
end;

procedure TFrmCPagar.dbParcelaExit(Sender: TObject);
begin
  if dbParcela.Value > 1 then
    dbIntervalo.Enabled:=True
  else
    dbIntervalo.Enabled:=False;
end;

procedure TFrmCPagar.cmbPortadorChange(Sender: TObject);
begin
  if cmbPortador.Text='Cobran�a Banc�ria' then
    dbLookBanc.Enabled:=True
  else
    dbLookBanc.Enabled:=False;
end;

procedure TFrmCPagar.cmbPortadorExit(Sender: TObject);
begin
  if cmbPortador.Text='Cobran�a Banc�ria' then
    dbLookBanc.Enabled:=True
  else
    dbLookBanc.Enabled:=False;
end;

procedure TFrmCPagar.dbParcelaChange(Sender: TObject);
begin
  if dbParcela.Value > 1 then
    dbIntervalo.Enabled:=True
  else
    dbIntervalo.Enabled:=False;
end;

procedure TFrmCPagar.FormActivate(Sender: TObject);
begin
  dmDados.vTabStt:=True;
  dmdados.tbCPagar.Open;
  dmdados.tbFornecedor.Open;
  dmdados.tbBanco.Open;
  dmDados.tbCheque.Open;
  dmdados.TbMovConta.Open;
  dmDados.tbMovCaixa.Open;
  dmDados.tbCaixa.Open;
  dmDados.TbCCorrente.Open;
  dmdados.tbBalCusto.Open;
  dmDados.tbChequePro.Open;
  NovoItem:= False;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [F3] Loc Fornecedor [Del] Excluir [Esc] Cancelar ou Sair');
  dmDados.HabilitaTeclado := True;
  if dmdados.TbCpagar.RecordCount=0 then
    begin
    Btnprimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    BtnProximo.Enabled:=false;
    BtnUltimo.Enabled:=false;
    btnGravar.Enabled:=false;
    btnAlterar.Enabled:=false;
    btnCancelar.Enabled:=false;
    btnDeletar.Enabled:=false;
    end;
end;

procedure TFrmCPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmdados.tbCPagar.Close;
  dmdados.tbFornecedor.Close;
  dmDados.tbCheque.Close;
  dmdados.tbBanco.Close;
  dmdados.TbMovConta.Close;
  dmDados.tbMovCaixa.Close;
  dmDados.tbCaixa.Close;
  dmDados.TbCCorrente.Close;
  dmdados.tbBalCusto.Close;
  dmDados.tbChequePro.Close;
  Action:= Cafree;
end;

end.
