//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-02-2001
// Ultima modifica��o: 05-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitLocProd;

interface
                            
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, fcButton, fcImgBtn, RXSplit, Grids, DBGrids, RackCtls,
  ExtCtrls, RXCtrls, jpeg,Db,dbUtils, RXDBCtrl, LMDCustomComponent,
  LMDCustomHint, LMDCustomShapeHint, LMDShapeHint, RxGrdCpt, fcImager,
  EMsgDlg, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, fcLabel, EGrad;

type
  TFrmLocProd = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    RxLabel3: TRxLabel;
    cmbCampo: TComboBox;
    RxDBGrid1: TRxDBGrid;
    RxLabel1: TRxLabel;
    EdtValor: TEdit;
    EdtCampo: TEdit;
    LEDButton1: TLEDButton;
    LEDButton2: TLEDButton;
    RxLabel2: TRxLabel;
    RxLabel7: TRxLabel;
    fclSair: TfcImageBtn;
    fcLabel1: TfcLabel;
    fclLocMerc: TfcImageBtn;
    MsgDlg: TEvMsgDlg;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdtValorExit(Sender: TObject);
    procedure fclSairClick(Sender: TObject);
    procedure cmbCampoExit(Sender: TObject);
    procedure fclLocMercClick(Sender: TObject);
    procedure RxDBGrid1GetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LEDButton1DblClick(Sender: TObject);
    procedure LEDButton2DblClick(Sender: TObject);
  private
    fresultado : String;
    fnome:string;
  public
    { Public declarations }
    Property Resultado:String Read Fresultado Write Fresultado;
    Property Nome:String Read Fnome Write Fnome;
  end;

var
  FrmLocProd: TFrmLocProd;
  LocOpts : TLocateOptions;
  cor,PorNome,PorCod : boolean;
  NomeTab : String;
  CodTab : String;
  habilitaTeclado : boolean=true;

implementation

uses UnitDmDados, unitPrincipal;

{$R *.DFM}

procedure TFrmLocProd.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    Begin
    Key := #0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;


procedure TFrmLocProd.EdtValorExit(Sender: TObject);
begin
  fclLocMerc.Default := True;
end;

procedure TFrmLocProd.fclSairClick(Sender: TObject);
begin
  resultado := dmdados.tbEstoqueCodMerc.Value  ;
  nome      := dmdados.tbEstoqueDescricao.Value;
  dmDados.tbEstoque.IndexFieldNames := '';
  Close;
end;


procedure TFrmLocProd.cmbCampoExit(Sender: TObject);
begin
  PorNome := False;
  PorCod  := False;
  if cmbCampo.Text = 'C�digo' Then
    Begin
    PorCod        := True     ;
    edtCampo.Text := 'CodMerc';
    End
  Else if cmbcampo.text = 'Produto' then
    Begin
     PorNome       := True       ;
     edtCampo.Text := 'Descricao';
    End;
end;

procedure TFrmLocProd.fclLocMercClick(Sender: TObject);
begin
  fclLocMerc.Default := False;
  LocOpts            := []   ;
  if LEDButton1.StateOn then
    LocOpts := LocOpts + [loPartialKey];
  if LEDButton2.StateOn then
    LocOpts := LocOpts + [loCaseInsensitive];
  If not dmdados.TbEstoque.locate(edtCampo.Text, edtValor.text,LocOpts) Then
    begin
    MsgDlg.MsgInformation('N�o foi encontrado o valor ' + edtValor.text + ' para o campo '+ cmbCampo.text);
    end
  else
    Begin
    cor := true;
    If PorNome Then
      NomeTab := dmDados.tbEstoqueDescricao.Value;
    If PorCod Then
      CodTab  := dmDados.tbEstoqueCodMerc.Value;
    End;
end;

procedure TFrmLocProd.RxDBGrid1GetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
var
  NOME   : String;
  CODIGO : String;
begin
  NOME   := (Sender as TrxDBGrid).DataSource.DataSet.FieldByName('Descricao').asString;
  CODIGO := (Sender as TrxDBGrid).DataSource.DataSet.FieldByName('CodMerc').asString  ;
  if cor then
    If PorNome Then
      If NOME = NomeTab Then
        background := $00D2E2FF;
    If PorCod Then
      If CODIGO = CodTab Then
        background := $00D2E2FF;
end;

procedure TFrmLocProd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    fclSair.Click;
  if Key=VK_PRIOR then
    LEDButton1DblClick(Sender);
  if Key=VK_NEXT then
    LEDButton2DblClick(Sender);
  if Key=VK_F10 then
    fclLocMerc.Click;
  
end;

procedure TFrmLocProd.FormShow(Sender: TObject);
begin
  frmPrincipal.StatusTeclas(True,'[PageUp] A=ABC [PageDown] A=a [F10] Localizar [ESC] Sai');
end;

procedure TFrmLocProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal.StatusTeclas(False,'');
end;

procedure TFrmLocProd.LEDButton1DblClick(Sender: TObject);
begin
  if LEDButton1.StateOn then
    LEDButton1.StateOn := False
  else
    LEDButton1.StateOn := True ;
end;

procedure TFrmLocProd.LEDButton2DblClick(Sender: TObject);
begin
  if LEDButton2.StateOn then
    LEDButton2.StateOn := False
  else
    LEDButton2.StateOn := True ;
end;

end.
