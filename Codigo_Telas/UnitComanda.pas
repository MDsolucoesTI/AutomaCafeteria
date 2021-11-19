//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 14-05-2007
// Ultima modifica��o: 30-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitComanda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fcButton, fcImgBtn, RackCtls, StdCtrls, DBCtrls, RXDBCtrl,Variants,
  Mask, RXSplit, RXCtrls, ExtCtrls, SpeedBar, jpeg, Grids, DBGrids,db,
  ComCtrls, TFlatRadioButtonUnit, CurrEdit, RxLookup, Spin, EnhEdit,
  DBTables, RxDBComb, ToolEdit, LMDCustomComponent, LMDCustomHint,
  LMDCustomShapeHint, LMDShapeHint, RxGrdCpt, fcImager, EMsgDlg,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, JvEdit, JvTypedEdit, JvMaskEdit,
  JvSpin, JvDBSpinEdit, ahmtleds, JvComponent, JvTransLED, LMDControl,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDCustomLabelFill, LMDLabelFill, EGrad, JvTransBtn, ENumEd, EZeroEd,
  fcLabel, LMDCustomGroupBox, LMDGroupBox, fcpanel, JvPanel,
  JvTransparentPanel;

type
  TFrmComanda = class(TForm)
    LMDBackPanel1: TLMDBackPanel;
    Panel3: TLMDBackPanel;
    btnPagto: TJvTransparentButton;
    RxLabel2: TRxLabel;
    RxLabel13: TRxLabel;
    edCodCli: TDBEdit;
    BtnlocCli: TfcImageBtn;
    dbCliente: TDBEdit;
    btnCadCli: TfcImageBtn;
    pnEsquerdo: TfcPanel;
    LMDGroupBox2: TLMDGroupBox;
    Label1: TLabel;
    LedCafe: TAHMLed;
    Bevel3: TBevel;
    Label14: TLabel;
    LedCafP: TAHMLed;
    LedCafM: TAHMLed;
    Label55: TLabel;
    Bevel12: TBevel;
    Label56: TLabel;
    LedCafG: TAHMLed;
    Bevel15: TBevel;
    Label5: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label6: TLabel;
    Bevel7: TBevel;
    Label7: TLabel;
    edtCafPeq: TJvCurrencyEdit;
    edtCafM: TJvCurrencyEdit;
    edtCafG: TJvCurrencyEdit;
    dbCafG: TJvDBSpinEdit;
    dbCafM: TJvDBSpinEdit;
    dbCafP: TJvDBSpinEdit;
    LMDGroupBox1: TLMDGroupBox;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel8: TBevel;
    LedCapu: TAHMLed;
    Label3: TLabel;
    LedCapuP: TAHMLed;
    LedCapuM: TAHMLed;
    Label4: TLabel;
    Label8: TLabel;
    LedCapuG: TAHMLed;
    Label9: TLabel;
    Bevel9: TBevel;
    Label10: TLabel;
    Bevel10: TBevel;
    Label11: TLabel;
    edtCapuP: TJvCurrencyEdit;
    edtCapuM: TJvCurrencyEdit;
    edtCapuG: TJvCurrencyEdit;
    dbCapuG: TJvDBSpinEdit;
    dbCapuM: TJvDBSpinEdit;
    dbCapuP: TJvDBSpinEdit;
    LMDGroupBox3: TLMDGroupBox;
    Bevel11: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel16: TBevel;
    Label12: TLabel;
    LedChoco: TAHMLed;
    Label13: TLabel;
    LedChocoP: TAHMLed;
    LedChocoM: TAHMLed;
    Label15: TLabel;
    Label16: TLabel;
    LedChocoG: TAHMLed;
    Label17: TLabel;
    Bevel17: TBevel;
    Label18: TLabel;
    Bevel18: TBevel;
    Label19: TLabel;
    edtChocoP: TJvCurrencyEdit;
    edtChocoM: TJvCurrencyEdit;
    edtChocoG: TJvCurrencyEdit;
    dbChocoG: TJvDBSpinEdit;
    dbChocoM: TJvDBSpinEdit;
    dbChocoP: TJvDBSpinEdit;
    LMDGroupBox4: TLMDGroupBox;
    Label20: TLabel;
    LedCreme: TAHMLed;
    Bevel24: TBevel;
    Label26: TLabel;
    edtCreme: TJvCurrencyEdit;
    dbCreme: TJvDBSpinEdit;
    LMDGroupBox5: TLMDGroupBox;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Bevel21: TBevel;
    Bevel22: TBevel;
    Label21: TLabel;
    LedSuco: TAHMLed;
    Label22: TLabel;
    LedSuVale: TAHMLed;
    LedSuAg: TAHMLed;
    Label23: TLabel;
    Label24: TLabel;
    LedSuLeite: TAHMLed;
    Label25: TLabel;
    Bevel23: TBevel;
    Label27: TLabel;
    Bevel25: TBevel;
    Label28: TLabel;
    edtSuVale: TJvCurrencyEdit;
    edtSuAg: TJvCurrencyEdit;
    edtSuLei: TJvCurrencyEdit;
    dbSuLeite: TJvDBSpinEdit;
    dbSuAg: TJvDBSpinEdit;
    dbSuVale: TJvDBSpinEdit;
    LedSu2: TAHMLed;
    Bevel26: TBevel;
    Label29: TLabel;
    Label30: TLabel;
    Bevel27: TBevel;
    edtSu2: TJvCurrencyEdit;
    dbSu2: TJvDBSpinEdit;
    LMDGroupBox6: TLMDGroupBox;
    Bevel28: TBevel;
    Bevel30: TBevel;
    Bevel31: TBevel;
    Label31: TLabel;
    LedCha: TAHMLed;
    Label32: TLabel;
    LedChaQuen: TAHMLed;
    LedChaMate: TAHMLed;
    Label33: TLabel;
    Label35: TLabel;
    Bevel32: TBevel;
    Label36: TLabel;
    edtChaQuen: TJvCurrencyEdit;
    edtChaMate: TJvCurrencyEdit;
    dbChaMate: TJvDBSpinEdit;
    dbChaQuen: TJvDBSpinEdit;
    LMDGroupBox7: TLMDGroupBox;
    Label34: TLabel;
    LedIcea: TAHMLed;
    Bevel29: TBevel;
    Label37: TLabel;
    edtIcea: TJvCurrencyEdit;
    dbIcea: TJvDBSpinEdit;
    LMDGroupBox8: TLMDGroupBox;
    Bevel33: TBevel;
    Bevel34: TBevel;
    Bevel35: TBevel;
    Bevel36: TBevel;
    Bevel37: TBevel;
    Bevel38: TBevel;
    Label38: TLabel;
    LedAgua: TAHMLed;
    Label39: TLabel;
    LedAgTo: TAHMLed;
    LedAgCopo: TAHMLed;
    Label40: TLabel;
    Label41: TLabel;
    LedAgGa: TAHMLed;
    Label42: TLabel;
    Bevel39: TBevel;
    Label43: TLabel;
    Bevel40: TBevel;
    Label44: TLabel;
    LedAgGrd: TAHMLed;
    Label45: TLabel;
    Label46: TLabel;
    edtAgTo: TJvCurrencyEdit;
    edtAgCopo: TJvCurrencyEdit;
    edtAgGa: TJvCurrencyEdit;
    dbAgGar: TJvDBSpinEdit;
    dbAgCopo: TJvDBSpinEdit;
    edtAgGrd: TJvCurrencyEdit;
    dbAgGrd: TJvDBSpinEdit;
    Bevel41: TBevel;
    Label47: TLabel;
    LedAgGas: TAHMLed;
    Bevel42: TBevel;
    Label48: TLabel;
    edtAgGas: TJvCurrencyEdit;
    dbAgGas: TJvDBSpinEdit;
    LMDGroupBox9: TLMDGroupBox;
    Label49: TLabel;
    LedCerv: TAHMLed;
    Bevel43: TBevel;
    Label50: TLabel;
    edtCerv: TJvCurrencyEdit;
    dbCerv: TJvDBSpinEdit;
    pnDireito: TfcPanel;
    LMDGroupBox10: TLMDGroupBox;
    Bevel44: TBevel;
    Bevel45: TBevel;
    Bevel46: TBevel;
    Bevel47: TBevel;
    Label51: TLabel;
    LedRefri: TAHMLed;
    Label52: TLabel;
    LedRefriLa: TAHMLed;
    LedRefri600: TAHMLed;
    Label53: TLabel;
    Label54: TLabel;
    LedRefri2: TAHMLed;
    Label57: TLabel;
    Bevel48: TBevel;
    Label58: TLabel;
    Bevel49: TBevel;
    Label59: TLabel;
    edtRefLa: TJvCurrencyEdit;
    edtRef600: TJvCurrencyEdit;
    edtRef2: TJvCurrencyEdit;
    dbRef2: TJvDBSpinEdit;
    dbRef600: TJvDBSpinEdit;
    dbRefLa: TJvDBSpinEdit;
    LMDGroupBox11: TLMDGroupBox;
    Label60: TLabel;
    LedGua: TAHMLed;
    Bevel50: TBevel;
    Label61: TLabel;
    edtGua: TJvCurrencyEdit;
    dbGua: TJvDBSpinEdit;
    LMDGroupBox12: TLMDGroupBox;
    Label62: TLabel;
    LedGato: TAHMLed;
    Bevel51: TBevel;
    Label63: TLabel;
    edtGato: TJvCurrencyEdit;
    dbGato: TJvDBSpinEdit;
    LMDGroupBox13: TLMDGroupBox;
    Label64: TLabel;
    LedKapo: TAHMLed;
    Bevel52: TBevel;
    Label65: TLabel;
    edtKapo: TJvCurrencyEdit;
    dbKapo: TJvDBSpinEdit;
    LMDGroupBox14: TLMDGroupBox;
    Label66: TLabel;
    LedTodi: TAHMLed;
    Bevel53: TBevel;
    Label67: TLabel;
    edtTodi: TJvCurrencyEdit;
    dbTodi: TJvDBSpinEdit;
    LMDGroupBox15: TLMDGroupBox;
    Label68: TLabel;
    LedCopoLei: TAHMLed;
    Bevel54: TBevel;
    Label69: TLabel;
    edtCopoLei: TJvCurrencyEdit;
    dbCopoLei: TJvDBSpinEdit;
    LMDGroupBox16: TLMDGroupBox;
    Label70: TLabel;
    LedAcai: TAHMLed;
    Bevel55: TBevel;
    Label71: TLabel;
    edtAcai: TJvCurrencyEdit;
    dbAcai: TJvDBSpinEdit;
    LMDGroupBox17: TLMDGroupBox;
    Bevel56: TBevel;
    Bevel57: TBevel;
    Bevel58: TBevel;
    Bevel59: TBevel;
    Label72: TLabel;
    LedPao: TAHMLed;
    Label73: TLabel;
    LedPaoMel: TAHMLed;
    LedPaoQuei: TAHMLed;
    Label74: TLabel;
    Label75: TLabel;
    LedPaoMant: TAHMLed;
    Label76: TLabel;
    Bevel60: TBevel;
    Label77: TLabel;
    Bevel61: TBevel;
    Label78: TLabel;
    edtPaoMel: TJvCurrencyEdit;
    edtPaoQuei: TJvCurrencyEdit;
    edtPaoMant: TJvCurrencyEdit;
    dbPaoMant: TJvDBSpinEdit;
    dbPaoQuei: TJvDBSpinEdit;
    dbPaoMel: TJvDBSpinEdit;
    LMDGroupBox18: TLMDGroupBox;
    Label79: TLabel;
    LedBolo: TAHMLed;
    Bevel62: TBevel;
    Label80: TLabel;
    edtBolo: TJvCurrencyEdit;
    dbBolo: TJvDBSpinEdit;
    LMDGroupBox19: TLMDGroupBox;
    Label81: TLabel;
    LedTorDo: TAHMLed;
    Bevel63: TBevel;
    Label82: TLabel;
    edtTorDo: TJvCurrencyEdit;
    dbTorDo: TJvDBSpinEdit;
    LMDGroupBox20: TLMDGroupBox;
    Label83: TLabel;
    LedPudim: TAHMLed;
    Bevel64: TBevel;
    Label84: TLabel;
    edtPudim: TJvCurrencyEdit;
    dbPudim: TJvDBSpinEdit;
    LMDGroupBox21: TLMDGroupBox;
    Label85: TLabel;
    LedTorSal: TAHMLed;
    Bevel65: TBevel;
    Label86: TLabel;
    edtTorSal: TJvCurrencyEdit;
    dbTorSal: TJvDBSpinEdit;
    LMDGroupBox22: TLMDGroupBox;
    Label87: TLabel;
    LedSalg: TAHMLed;
    Bevel66: TBevel;
    Label88: TLabel;
    edtSal: TJvCurrencyEdit;
    dbSal: TJvDBSpinEdit;
    LMDGroupBox23: TLMDGroupBox;
    Label89: TLabel;
    LedSalChi: TAHMLed;
    Bevel67: TBevel;
    Label90: TLabel;
    edtSalChi: TJvCurrencyEdit;
    dbSalChi: TJvDBSpinEdit;
    LMDGroupBox24: TLMDGroupBox;
    Label91: TLabel;
    LedEnro: TAHMLed;
    Bevel68: TBevel;
    Label92: TLabel;
    edtEnro: TJvCurrencyEdit;
    dbEnro: TJvDBSpinEdit;
    LMDGroupBox25: TLMDGroupBox;
    Label93: TLabel;
    LedSandNat: TAHMLed;
    Bevel69: TBevel;
    Label94: TLabel;
    edtSandNat: TJvCurrencyEdit;
    dbSandNat: TJvDBSpinEdit;
    LMDGroupBox26: TLMDGroupBox;
    Label95: TLabel;
    LedSanBag: TAHMLed;
    Bevel70: TBevel;
    Label96: TLabel;
    edtSanBag: TJvCurrencyEdit;
    dbSanBag: TJvDBSpinEdit;
    LMDGroupBox27: TLMDGroupBox;
    Label97: TLabel;
    LedBauru: TAHMLed;
    Bevel71: TBevel;
    Label98: TLabel;
    edtBauru: TJvCurrencyEdit;
    dbBauru: TJvDBSpinEdit;
    LMDGroupBox28: TLMDGroupBox;
    Label99: TLabel;
    LedMisto: TAHMLed;
    Bevel72: TBevel;
    Label100: TLabel;
    edtMisto: TJvCurrencyEdit;
    dbMisto: TJvDBSpinEdit;
    Bevel73: TBevel;
    Bevel74: TBevel;
    edtAgCoco: TJvCurrencyEdit;
    dbAgCoco: TJvDBSpinEdit;
    Label101: TLabel;
    Label102: TLabel;
    LedAgCoco: TAHMLed;
    LMDGroupBox29: TLMDGroupBox;
    Label103: TLabel;
    LedOutros: TAHMLed;
    Bevel75: TBevel;
    Label104: TLabel;
    edtOutros: TJvCurrencyEdit;
    dbOutros: TJvDBSpinEdit;
    btnConfirmar: TJvTransparentButton;
    Label2: TLabel;
    MsgDlg: TEvMsgDlg;
    btnCancelar: TJvTransparentButton;
    spEsquerdo: TShape;
    spDireito: TShape;
    dbStatus: TDBEdit;
    dbData: TDBDateEdit;
    edtNumCart: TJvIntegerEdit;
    btnSair: TJvTransparentButton;
    dbAgTo: TJvDBSpinEdit;
    LMDGroupBox30: TLMDGroupBox;
    Status: TLMDLabelFill;
    JvTransparentPanel1: TJvTransparentPanel;
    JvTransparentPanel2: TJvTransparentPanel;
    procedure BtnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edCodCliExit(Sender: TObject);
    procedure btnPagtoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fcImageBtn8Click(Sender: TObject);
    procedure btnPlanopgtoClick(Sender: TObject);
    procedure btnCadCliClick(Sender: TObject);
    procedure BtnlocCliClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtNumCartExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MostraValores;
    procedure LigaLeds;
    procedure LimpaComanda;
    procedure ApagaComanda;
    procedure GravaComanda;
  private
    { Private declarations }
  cli          : longint  ;
  fDataVenda   : TDateTime;
  fCodigoVenda : integer  ;
  fComissao    : real     ;
  fCusto       : real     ;
  fTotal       : currency ;
  fPago        : Boolean  ;
  public
    { Public declarations }
   property Codcli      : longint   read cli          write cli         ;
   property DataVenda   : TDateTime read fDataVenda   write fDataVenda  ;
   property CodigoVenda : integer   read fCodigoVenda write fCodigoVenda;
   property Comissao    : real      read fComissao    write fComissao   ;
   property Custo       : real      read fCusto       write fCusto      ;
   property Total       : currency  read fTotal       write fTotal      ;
   property Pago        : Boolean   read fPago        write fPago       ;
  end;

var
  FrmComanda       : TFrmComanda    ;
  Pagto            : boolean = False;
  Alterar          : boolean = False;
  NovoItem         : boolean = False;
  cHabilitaTeclado : boolean = True ;
  vTabStt          : boolean = False;
  DataVendaAnt     : tdatetime      ;
  codigoVenda      : integer        ;
  PrazoPagto       : integer        ;
  qtdeVendida      : integer        ;
  vendedor         : integer        ;
  comissao         : integer        ;
  x                : integer        ;
  i                : integer        ;
  pagamento        : integer        ;
  Pos              : TBookMark      ;
  valorparc        : currency       ;
  limite           : currency       ;

implementation

uses unitLocCliente, unitDmDados, UnitLocProd, UnitPrincipal, UnitConsPlano, UnitCadCliente,
  UnitVendas, UnitOutros, untCancelar, untRecebComa;

{$R *.DFM}

procedure TFrmComanda.BtnSairClick(Sender: TObject);
begin
	Close;
end;

procedure TFrmComanda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.tbCliente.Filtered := False;
  dmDados.HabilitaTeclado    := False;
  dmDados.tbFaturamento.Close;
  dmdados.tbFunc.CancelRange;
  dmDados.tbFuncEsto.Close;
  dmDados.tbFunc.Close;
  dmDados.tbEstoque.Close;
  dmDados.tbCliente.Close;
  dmDados.tbLibCredito.Close;
  dmDados.tbPlanos.Close;
  dmDados.tbCargoFunc.Close;
  dmDados.tbVisDetVen.Close;
  dmDados.tbDetVendas.Close;
  dmDados.tbVendas.Close;
  dmDados.tbComanda.Close;
  dmDados.tbOutros.Close;
  dmDados.tbCoMarca.Close;
  dmDados.tbCoEstoque.Close;
  dmDados.tbMarca.Close;
  dmDados.tbCaixa.Close;
  dmDados.tbMovCaixa.Close;
  dmDados.tbAberComa.Close;
  dmDados.tbDetAberComa.Close;
  action:= caFree;
end;

procedure TFrmComanda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmComanda.edCodCliExit(Sender: TObject);
{
var
  Flag : boolean;
  }
begin
  //Flag := True;
  if NovoItem then
    if edCodCli.Text <> '' then
      begin
      if (dmDados.tbCliente.Locate('CodCli',edcodCli.text,[])) then
        begin
        //Verifica se cliente possue restri��o
        {
        if (FrmPrincipal.mnBloqueio.Tag = 2) then
          if (dmDados.tbClienteStatus.Value = 'R') then
            begin
            Flag := False;
            MsgDlg.MsgWarning('Cliente Temporariamente Desabilitado');
            edCodCli.SetFocus;
            end;
        if (Flag) then
          begin
          edCodCli.Enabled       := False  ;
          btnPagto.Enabled       := True   ;
          btnConfirmar.Enabled   := True   ;
          btnCancelar.Enabled    := True   ;
          spEsquerdo.Brush.Color := clGreen;
          pnEsquerdo.Enabled     := True   ;
          VtabStt                := True   ;
          end;
          }
        if (dmDados.tbClienteStatus.Value = 'R') then
          begin
          MsgDlg.MsgWarning('Cliente Temporariamente Desabilitado');
          edCodCli.SetFocus;
          end
        else
          begin
          edCodCli.Enabled       := False  ;
          btnPagto.Enabled       := True   ;
          btnConfirmar.Enabled   := True   ;
          btnCancelar.Enabled    := True   ;
          spEsquerdo.Brush.Color := clGreen;
          pnEsquerdo.Enabled     := True   ;
          VtabStt                := True   ;
          end;
        end
      else
        begin
        MsgDlg.MsgWarning('C�DIGO DO CLIENTE n�o cadastrado!');
        edCodCli.SetFocus;
        end;
      end
    else
      begin
      MsgDlg.MsgWarning('� obrigat�rio o C�DIGO DO CLIENTE');
      edCodCli.SetFocus;
      end
end;


procedure TFrmComanda.btnPagtoClick(Sender: TObject);
var
  cont : integer;
begin
  Status.Color   := clMoneyGreen;
  Status.Caption := 'PAGAMENTO' ;
  GravaComanda;
  Total := 0;
  for cont:=0 to Componentcount-1 do
    if (Components[cont] is TJvDBSpinEdit) then
      if (TJvDBSpinEdit(Components[cont]).Tag <> 0) then
        begin
        dmDados.tbEstoque.RecNo:=TJvDBSpinEdit(Components[cont]).Tag;
        Total := Total + (TJvDBSpinEdit(Components[cont]).Value * dmDados.tbEstoquePrecoVenda.Value);
        end;
  Total := Total + dmDados.tbComandaZDValor.Value;
  Pago  := False;
  frmRecebComa:=TfrmRecebComa.Create(application);
  frmRecebComa.Codcli := StrToInt(edCodCli.Text);
  frmRecebComa.Venda  := Total                  ;
  frmRecebComa.ShowModal;
  if Pago then
    begin
    ApagaComanda;
    spEsquerdo.Brush.Color := clWhite    ;
    spDireito.Brush.Color  := clWhite    ;
    pnEsquerdo.Enabled     := False      ;
    pnDireito.Enabled      := False      ;
    btnPagto.Enabled       := True       ;
    btnConfirmar.Enabled   := False      ;
    btnCancelar.Enabled    := False      ;
    edtNumCart.Enabled     := True       ;
    edCodCli.Enabled       := False      ;
    edtNumCart.Enabled     := True       ;
    NovoItem               := False      ;
    Alterar                := False      ;
    Pagto                  := False      ;
    VtabStt                := False      ;
    LimpaComanda;
    MostraValores;
    Status.Color           := clGreen    ;
    Status.Caption         := 'ESPERA'   ;
    edtNumCart.SetFocus;
    end
  else
    begin
    dmDados.tbComanda.Edit;
    MostraValores;
    LigaLeds;
    Alterar                := True       ;
    NovoItem               := False      ;
    btnPagto.Enabled       := True       ;
    btnConfirmar.Enabled   := True       ;
    btnCancelar.Enabled    := True       ;
    VtabStt                := True       ;
    Status.Color           := clPurple   ;
    Status.Caption         := 'ALTERA��O';
    end;
end;

procedure TFrmComanda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if dmdados.HabilitaTeclado then
    Case (key) of
      VK_END    : if (vTabStt) then BtnConfirmar.Click;
      VK_ESCAPE : if (vTabStt) then BtnCancelar.Click
                  else btnsair.Click;
      VK_F5     : if (vTabStt) then BtnPagto.Click;
      VK_F2     : if ((vTabStt)and(NovoItem)) then
                    BtnLocCli.Click
                  else
                    MsgDlg.MsgError('A Comanda est� em ESPERA ou ALTERA��O');
      VK_F4     : if ((vTabStt)and(NovoItem)) then
                    btnCadCli.Click
                  else
                    MsgDlg.MsgError('A Comanda est� em ESPERA ou ALTERA��O');
      VK_CONTROL:
      if (vTabStt) then
        begin
        if (pnEsquerdo.Enabled) then
          begin
          pnEsquerdo.Enabled     := False  ;
          pnDireito.Enabled      := True   ;
          spEsquerdo.Brush.Color := clWhite;
          spDireito.Brush.Color  := clGreen;
          end
        else
          begin
          pnEsquerdo.Enabled     :=True    ;
          pnDireito.Enabled      :=False   ;
          spEsquerdo.Brush.Color := clGreen;
          spDireito.Brush.Color  := clWhite;
          end;
        end;
      Ord('A') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            ledCafe.LedOn;
            LedCafP.LedOn;
            dbCafP.SetFocus;
            end
          else
            begin
            LedRefri.LedOn;
            LedRefriLa.LedOn;
            dbRefLa.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedCafM.LedisOn)and(not LedCafG.LedisOn) then
              ledCafe.LedOff;
            LedCafP.LedOff;
            dbCafP.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            if (not LedRefri600.LedisOn)and(not LedRefri2.LedisOn) then
              LedRefri.LedOff;
            LedRefriLa.LedOff;
            dbRefLa.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('B') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            ledCafe.LedOn;
            LedCafM.LedOn;
            dbCafM.SetFocus;
            end
          else
            begin
            LedRefri.LedOn;
            LedRefri600.LedOn;
            dbRef600.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedCafP.LedisOn)and(not LedCafG.LedisOn) then
              ledCafe.LedOff;
            LedCafM.LedOff;
            dbCafM.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            if (not LedRefriLa.LedisOn)and(not LedRefri2.LedisOn) then
              LedRefri.LedOff;
            LedRefri600.LedOff;
            dbRef600.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('C') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            ledCafe.LedOn;
            LedCafG.LedOn;
            dbCafG.SetFocus;
            end
          else
            begin
            LedRefri.LedOn;
            LedRefri2.LedOn;
            dbRef2.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedCafP.LedisOn)and(not LedCafM.LedisOn) then
              ledCafe.LedOff;
            LedCafG.LedOff;
            dbCafG.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            if (not LedRefriLa.LedisOn)and(not LedRefri600.LedisOn) then
              LedRefri.LedOff;
            LedRefri2.LedOff;
            dbRef2.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('D') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedCapu.LedOn;
            LedCapuP.LedOn;
            dbCapuP.SetFocus;
            end
          else
            begin
            LedGua.LedOn;
            dbGua.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedCapuM.LedisOn)and(not LedCapuG.LedisOn) then
              LedCapu.LedOff;
            LedCapuP.LedOff;
            dbCapuP.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedGua.LedOff;
            dbGua.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('E') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedCapu.LedOn;
            LedCapuM.LedOn;
            dbCapuM.SetFocus;
            end
          else
            begin
            LedGato.LedOn;
            dbGato.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedCapuP.LedisOn)and(not LedCapuG.LedisOn) then
              LedCapu.LedOff;
            LedCapuM.LedOff;
            dbCapuM.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedGato.LedOff;
            dbGato.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('F') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedCapu.LedOn;
            LedCapuG.LedOn;
            dbCapuG.SetFocus;
            end
          else
            begin
            LedKapo.LedOn;
            dbKapo.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedCapuP.LedisOn)and(not LedCapuM.LedisOn) then
              LedCapu.LedOff;
            LedCapuG.LedOff;
            dbCapuG.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedKapo.LedOff;
            dbKapo.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('G') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedChoco.LedOn;
            LedChocoP.LedOn;
            dbChocoP.SetFocus;
            end
          else
            begin
            LedTodi.LedOn;
            dbTodi.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedChocoM.LedisOn)and(not LedChocoG.LedisOn) then
              LedChoco.LedOff;
            LedChocoP.LedOff;
            dbChocoP.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedTodi.LedOff;
            dbTodi.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('H') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedChoco.LedOn;
            LedChocoM.LedOn;
            dbChocoM.SetFocus;
            end
          else
            begin
            LedCopoLei.LedOn;
            dbCopoLei.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedChocoP.LedisOn)and(not LedChocoG.LedisOn) then
              LedChoco.LedOff;
            LedChocoM.LedOff;
            dbChocoM.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedCopoLei.LedOff;
            dbCopoLei.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('I') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedChoco.LedOn;
            LedChocoG.LedOn;
            dbChocoG.SetFocus;
            end
          else
            begin
            LedAcai.LedOn;
            dbAcai.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedChocoP.LedisOn)and(not LedChocoM.LedisOn) then
              LedChoco.LedOff;
            LedChocoG.LedOff;
            dbChocoG.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedAcai.LedOff;
            dbAcai.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('J') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedCreme.LedOn;
            dbCreme.SetFocus;
            end
          else
            begin
            LedPao.LedOn;
            LedPaoMel.LedOn;
            dbPaoMel.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedCreme.LedOff;
            dbCreme.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            if (not LedPaoQuei.LedisOn)and(not LedPaoMant.LedisOn) then
              LedPao.LedOff;
            LedPaoMel.LedOff;
            dbPaoMel.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('K') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedSuco.LedOn;
            LedSuVale.LedOn;
            dbSuVale.SetFocus;
            end
          else
            begin
            LedPao.LedOn;
            LedPaoQuei.LedOn;
            dbPaoQuei.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedSuAg.LedisOn)and(not LedSuLeite.LedisOn)and
               (not LedSu2.LedisOn) then
              LedSuco.LedOff;
            LedSuVale.LedOff;
            dbSuVale.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            if (not LedPaoMel.LedisOn)and(not LedPaoMant.LedisOn) then
              LedPao.LedOff;
            LedPaoQuei.LedOff;
            dbPaoQuei.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('L') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedSuco.LedOn;
            LedSuAg.LedOn;
            dbSuAg.SetFocus;
            end
          else
            begin
            LedPao.LedOn;
            LedPaoMant.LedOn;
            dbPaoMant.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedSuVale.LedisOn)and(not LedSuLeite.LedisOn)and
               (not LedSu2.LedisOn) then
              LedSuco.LedOff;
            LedSuAg.LedOff;
            dbSuAg.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            if (not LedPaoMel.LedisOn)and(not LedPaoQuei.LedisOn) then
              LedPao.LedOff;
            LedPaoMant.LedOff;
            dbPaoMant.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('M') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedSuco.LedOn;
            LedSuLeite.LedOn;
            dbSuLeite.SetFocus;
            end
          else
            begin
            LedBolo.LedOn;
            dbBolo.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedSuAg.LedisOn)and(not LedSuVale.LedisOn)and
               (not LedSu2.LedisOn) then
              LedSuco.LedOff;
            LedSuLeite.LedOff;
            dbSuLeite.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedBolo.LedOff;
            dbBolo.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('N') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedSuco.LedOn;
            LedSu2.LedOn;
            dbSu2.SetFocus;
            end
          else
            begin
            LedTorDo.LedOn;
            dbTorDo.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedSuAg.LedisOn)and(not LedSuVale.LedisOn)and
               (not LedSuLeite.LedisOn) then
              LedSuco.LedOff;
            LedSu2.LedOff;
            dbSu2.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedTorDo.LedOff;
            dbTorDo.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('O') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedCha.LedOn;
            LedChaQuen.LedOn;
            dbChaQuen.SetFocus;
            end
          else
            begin
            LedPudim.LedOn;
            dbPudim.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedChaMate.LedisOn) then
              LedCha.LedOff;
            LedChaQuen.LedOff;
            dbChaQuen.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedPudim.LedOff;
            dbPudim.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('P') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedCha.LedOn;
            LedChaMate.LedOn;
            dbChaMate.SetFocus;
            end
          else
            begin
            LedTorSal.LedOn;
            dbTorSal.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedChaQuen.LedisOn) then
              LedCha.LedOff;
            LedChaMate.LedOff;
            dbChaMate.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedTorSal.LedOff;
            dbTorSal.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('Q') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedIcea.LedOn;
            dbIcea.SetFocus;
            end
          else
            begin
            LedSalg.LedOn;
            dbSal.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedIcea.LedOff;
            dbIcea.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedSalg.LedOff;
            dbSal.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('R') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedAgua.LedOn;
            LedAgTo.LedOn;
            dbAgTo.SetFocus;
            end
          else
            begin
            LedSalChi.LedOn;
            dbSalChi.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedAgCopo.LedisOn)and(not LedAgGa.LedisOn)and
               (not LedAgCoco.LedisOn)and(not LedAgGrd.LedisOn)and
               (not LedAgGas.LedisOn) then
              LedAgua.LedOff;
            LedAgTo.LedOff;
            dbAgTo.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedSalChi.LedOff;
            dbSalChi.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('S') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedAgua.LedOn;
            LedAgCopo.LedOn;
            dbAgCopo.SetFocus;
            end
          else
            begin
            LedEnro.LedOn;
            dbEnro.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedAgTo.LedisOn)and(not LedAgGa.LedisOn)and
               (not LedAgCoco.LedisOn)and(not LedAgGrd.LedisOn)and
               (not LedAgGas.LedisOn) then
              LedAgua.LedOff;
            LedAgCopo.LedOff;
            dbAgCopo.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedEnro.LedOff;
            dbEnro.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('T') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedAgua.LedOn;
            LedAgGa.LedOn;
            dbAgGar.SetFocus;
            end
          else
            begin
            LedSandNat.LedOn;
            dbSandNat.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedAgCopo.LedisOn)and(not LedAgTo.LedisOn)and
               (not LedAgCoco.LedisOn)and(not LedAgGrd.LedisOn)and
               (not LedAgGas.LedisOn) then
              LedAgua.LedOff;
            LedAgGa.LedOff;
            dbAgGar.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedSandNat.LedOff;
            dbSandNat.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('U') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedAgua.LedOn;
            LedAgGrd.LedOn;
            dbAgGrd.SetFocus;
            end
          else
            begin
            LedSanBag.LedOn;
            dbSanBag.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedAgCopo.LedisOn)and(not LedAgGa.LedisOn)and
               (not LedAgCoco.LedisOn)and(not LedAgTo.LedisOn)and
               (not LedAgGas.LedisOn) then
              LedAgua.LedOff;
            LedAgGrd.LedOff;
            dbAgGrd.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedSanBag.LedOff;
            dbSanBag.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('V') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedAgua.LedOn;
            LedAgGas.LedOn;
            dbAgGas.SetFocus;
            end
          else
            begin
            LedBauru.LedOn;
            dbBauru.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedAgCopo.LedisOn)and(not LedAgTo.LedisOn)and
               (not LedAgGa.LedisOn)and(not LedAgGrd.LedisOn)and
               (not LedAgCoco.LedisOn) then
              LedAgua.LedOff;
            LedAgGas.LedOff;
            dbAgGas.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedBauru.LedOff;
            dbBauru.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('X') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedAgua.LedOn;
            LedAgCoco.LedOn;
            dbAgCoco.SetFocus;
            end
          else
            begin
            LedMisto.LedOn;
            dbMisto.SetFocus;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            if (not LedAgCopo.LedisOn)and(not LedAgTo.LedisOn)and
               (not LedAgGa.LedisOn)and(not LedAgGrd.LedisOn)and
               (not LedAgGas.LedisOn) then
              LedAgua.LedOff;
            LedAgCoco.LedOff;
            dbAgCoco.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedMisto.LedOff;
            dbMisto.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
      Ord('Z') :
      if (vTabStt) then
        begin
        if not (ssShift in Shift) then
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedCerv.LedOn;
            dbCerv.SetFocus;
            end
          else
            begin
            LedOutros.LedOn;
            FrmOutros:=TFrmOutros.Create(application);
            FrmOutros.Showmodal;
            end;
          end
        else
          begin
          if (pnEsquerdo.Enabled) then
            begin
            LedCerv.LedOff;
            dbCerv.Clear;
            Panel3.SetFocus;
            end
          else
            begin
            LedOutros.LedOff;
            dbOutros.Clear;
            Panel3.SetFocus;
            end;
          end;
        end;
    end;
end;

procedure TFrmComanda.fcImageBtn8Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmComanda.btnPlanopgtoClick(Sender: TObject);
begin
  FrmConsPlano:=TFrmConsPlano.Create(application);
  FrmConsPlano.Showmodal;
end;

procedure TFrmComanda.btnCadCliClick(Sender: TObject);
begin
  if (NovoItem) then
    begin
    FrmCadCliente := TFrmCadCliente.Create(application);
    frmCadCliente.OutraJan := True;
    FrmCadCliente.Showmodal;
    edCodCli.Text := IntToStr(dmDados.tbClienteCodCli.Value);
    frmCadCliente.Free;
    end
  else
    MsgDlg.MsgError('A Comanda est� em ESPERA ou ALTERA��O');

end;

procedure TFrmComanda.BtnlocCliClick(Sender: TObject);
begin
  if (NovoItem) then
    begin
    FrmLocCliente := TFrmLocCliente.Create(application);
    FrmLocCliente.Showmodal;
    edCodCli.Text := IntToStr(frmLocCliente.Resultado);
    frmLocCliente.Free;
    end
  else
    MsgDlg.MsgError('A Comanda est� em ESPERA ou ALTERA��O');    
end;

procedure TFrmComanda.edtNumCartExit(Sender: TObject);
var
  Valor : integer;
begin
  //Localiza registro da comanda
  Valor := StrToInt(edtNumCart.Text);
  if ((Valor < 1)or(Valor > 40)) then
    begin
    MsgDlg.MsgWarning('O Cart�o n� '+edtNumCart.Text+' N�O � V�LIDO!!!');
    edtNumCart.SetFocus;
    end
  else
    begin
    dmDados.tbComanda.RecNo:=StrToInt(edtNumCart.Text);
    dmDados.tbComanda.Edit;
    MostraValores;
    if (dbStatus.Text = 'F') then
      begin
      dbStatus.Text                     := 'A'       ;
      dmDados.tbComandaCodCliente.Value := 1         ;
      NovoItem                          := True      ;
      Alterar                           := False     ;
      edCodCli.Enabled                  := True      ;
      edtNumCart.Enabled                := False     ;
      Status.Color                      := clRed     ;
      Status.Caption                    := 'ABERTURA';
      edCodCli.SetFocus;
      end
    else
      begin
      LigaLeds;
      edtNumCart.Enabled     := False      ;
      spEsquerdo.Brush.Color := clGreen    ;
      Alterar                := True       ;
      NovoItem               := False      ;
      btnPagto.Enabled       := True       ;
      btnConfirmar.Enabled   := True       ;
      btnCancelar.Enabled    := True       ;
      VtabStt                := True       ;
      pnEsquerdo.Enabled     := True       ;
      Status.Color           := clPurple   ;
      Status.Caption         := 'ALTERA��O';
      end;
    end;
end;

procedure TFrmComanda.btnCancelarClick(Sender: TObject);
var
  cont :Integer;
begin
  frmCancelar := TfrmCancelar.Create(Application);
  frmCancelar.ShowModal;
  frmCancelar.Free;
  NovoItem               := False   ;
  Alterar                := False   ;
  spEsquerdo.Brush.Color := clWhite ;
  spDireito.Brush.Color  := clWhite ;
  pnEsquerdo.Enabled     := False   ;
  pnDireito.Enabled      := False   ;
  btnPagto.Enabled       := False   ;
  btnConfirmar.Enabled   := False   ;
  btnCancelar.Enabled    := False   ;
  edCodCli.Enabled       := False   ;
  edtNumCart.Enabled     := True    ;
  VtabStt                := False   ;
  Status.Color           := clGreen ;
  Status.Caption         := 'ESPERA';
  LimpaComanda;
  MostraValores;
  edtNumCart.SetFocus;
end;

procedure TFrmComanda.btnConfirmarClick(Sender: TObject);
var
  cont : Integer;
  Flag : Boolean;
begin
  Flag := False;
  for cont:=0 to ComponentCount-1 do
    if (Components[cont] is TJvDBSpinEdit) then
      if (TJvDBSpinEdit(Components[cont]).Value > 0) then
        Flag := True;
  if Flag then
    begin
    GravaComanda;
    NovoItem               := False   ;
    Alterar                := False   ;
    spEsquerdo.Brush.Color := clWhite ;
    spDireito.Brush.Color  := clWhite ;
    pnEsquerdo.Enabled     := False   ;
    pnDireito.Enabled      := False   ;
    btnPagto.Enabled       := False   ;
    btnConfirmar.Enabled   := False   ;
    btnCancelar.Enabled    := False   ;
    edCodCli.Enabled       := False   ;
    edtNumCart.Enabled     := True    ;
    VtabStt                := False   ;
    Status.Color           := clGreen ;
    Status.Caption         := 'ESPERA';
    LimpaComanda;
    MostraValores;
    edtNumCart.SetFocus;
    end
  else
    MsgDlg.MsgError('N�o pode ser Gravada Comanda em BRANCO|CANCELE a Comanda ou INCLUA o pedido');
end;



procedure TFrmComanda.FormActivate(Sender: TObject);
var
  Cont : integer;
begin
  if dmDados.tbFaturamento.State = dsInactive then
    dmDados.tbFaturamento.Open;
  if dmDados.tbFuncEsto.State = dsInactive then
    dmDados.tbFuncEsto.Open;
  if dmDados.tbFunc.State = dsInactive then
    dmDados.tbFunc.Open;
  if dmDados.tbEstoque.State = dsInactive then
    dmDados.tbEstoque.Open;
  if dmDados.tbCompEsto.State = dsInactive then
    dmDados.tbCompEsto.Open;
  if dmDados.tbComanda.State = dsInactive then
    dmDados.tbComanda.Open;
  if dmDados.tbOutros.State = dsInactive then
    dmDados.tbOutros.Open;
  if dmDados.tbCliente.State = dsInactive then
    dmDados.tbCliente.Open;
  if dmDados.tbLibCredito.State = dsInactive then
    dmDados.tbLibCredito.Open;
  if dmDados.tbPlanos.State = dsInactive then
    dmDados.tbPlanos.Open;
  if dmDados.tbCargoFunc.State = dsInactive then
    dmDados.tbCargoFunc.Open;
  if dmDados.tbVendas.State = dsInactive then
    dmDados.tbVendas.Open;
  if dmDados.tbVisDetVen.State = dsInactive then
    dmDados.tbVisDetVen.Open;
  if dmDados.tbDetVendas.State = dsInactive then
    dmDados.tbDetVendas.Open;
  if dmDados.tbMarca.State = dsInactive then
    dmDados.tbMarca.Open;
  if dmDados.tbCoMarca.State = dsInactive then
    dmDados.tbCoMarca.Open;
  if dmDados.tbCoEstoque.State = dsInactive then
    dmDados.tbCoEstoque.Open;
  if dmDados.tbCaixa.State = dsInactive then
    dmDados.tbCaixa.Open;
  if dmDados.tbMovCaixa.State = dsInactive then
    dmDados.tbMovCaixa.Open;
  if dmDados.tbAberComa.State = dsInactive then
    dmDados.tbAberComa.Open;
  if dmDados.tbDetAberComa.State = dsInactive then
    dmDados.tbDetAberComa.Open;
  dmdados.tbFunc.ApplyRange;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [End] Gravar [F2] Loc. Cliente [F4] Cad Cliente [F5] Pagamento [Esc] Cancelar ou Sair');
  if (not dmDados.HabilitaTeclado) then
    dmDados.HabilitaTeclado := True;
  if ((not NovoItem) and (not Alterar)) then
    MostraValores;
  edtNumCart.Enabled := True;
  edtNumCart.SetFocus;
  dmDados.tbCliente.Filtered := False;
  dmDados.tbCliente.Filter   := '(Ativo = '''+'S'+''')';
  dmDados.tbCliente.Filtered := True ;
end;

procedure TFrmComanda.MostraValores;
var
  Cont : integer;
begin
  //verifica se � componente Currency e localiza o produto atrav�s do
  //registro f�sico indicado na propriedade TAG.
  //O Currency dos OUTROS n�o recebe valor
  for Cont:=0 to ComponentCount-1 do
    if (Components[Cont] is TJvCurrencyEdit) then
      if (TJvCurrencyEdit(Components[Cont]).Name <> 'edtOutros') then
        begin
        dmDados.tbEstoque.RecNo:=TJvCurrencyEdit(Components[Cont]).Tag;
        TJvCurrencyEdit(Components[Cont]).Value:=dmDados.tbEstoquePrecoVenda.Value;
        end;
  //Se a comanda estiver sendo alterada (Tabela fixa) coloca valor do OUTROS
  if (dmDados.tbComanda.State = dsEdit)then
    edtOutros.Value := dmDados.tbComandaZDValor.Value;
end;

procedure TFrmComanda.LigaLeds;
var
  Cont  : integer;
  Cont1 : integer;
begin
  //Localiza os componentes LED e "Acende" se houver quantidade nos DBs
  for Cont:=0 to ComponentCount-1 do
    if (Components[Cont] is TJvDBSpinEdit) then
      if (TJvDBSpinEdit(Components[Cont]).Value > 0) then
        for Cont1:=0 to ComponentCount-1 do
          if (Components[Cont1] is TAHMLed) then
            if (TAHMLed(Components[Cont1]).Tag = TJvDBSpinEdit(Components[Cont]).Tag) then
              TAHMLed(Components[Cont1]).LedOn;
  //Acende os LEDs de grupo
  if ((LedCafP.LedisOn)or(LedCafM.LedisOn)or(LedCafG.LedisOn)) then
    LedCafe.LedOn
  else
    LedCafe.LedOff;
  if ((LedRefriLa.LedisOn)or(LedRefri600.LedisOn)or(LedRefri2.LedisOn)) then
    LedRefri.LedOn
  else
    LedRefri.LedOff;
  if ((LedCapuP.LedisOn)or(LedCapuM.LedisOn)or(LedCapuG.LedisOn)) then
    LedCapu.LedOn
  else
    LedCapu.LedOff;
  if ((LedChocoP.LedisOn)or(LedChocoM.LedisOn)or(LedChocoG.LedisOn)) then
    LedChoco.LedOn
  else
    LedChoco.LedOff;
  if ((LedPaoMel.LedisOn)or(LedPaoQuei.LedisOn)or(LedPaoMant.LedisOn)) then
    LedPao.LedOn
  else
    LedPao.LedOff;
  if ((LedSuVale.LedisOn)or(LedSuAg.LedisOn)or(LedSuLeite.LedisOn)or(LedSu2.LedisOn)) then
    LedSuco.LedOn
  else
    LedSuco.LedOff;
  if ((LedChaQuen.LedisOn)or(LedChaMate.LedisOn)) then
    LedCha.LedOn
  else
    LedCha.LedOff;
  if ((LedAgTo.LedisOn)or(LedAgCopo.LedisOn)or(LedAgGa.LedisOn)or
     (LedAgCoco.LedisOn)or(LedAgGrd.LedisOn)or(LedAgGas.LedisOn)) then
    LedAgua.LedOn
  else
    LedAgua.LedOff;
end;

procedure TFrmComanda.LimpaComanda;
var
  Cont  : integer;
begin
  for Cont:=0 to Componentcount-1 do
    if (Components[Cont] is TAHMLed) then
      TAHMLed(Components[Cont]).LedOff;
  for Cont:=0 to Componentcount-1 do
    if (Components[Cont] is TJvDBSpinEdit) then
      TJvDBSpinEdit(Components[Cont]).Clear;
  edtOutros.Clear;
end;

procedure TFrmComanda.ApagaComanda;
begin
  if dmDados.tbOutros.RecordCount>0 then
    begin
    dmDados.tbOutros.First;
    while (not dmDados.tbOutros.Eof) do
      begin
      dmDados.tbOutros.Delete;
      dmDados.tbOutros.First;
      end;
    end;
  if (dmDados.tbComanda.State <> dsEdit) then
    dmDados.tbComanda.Edit;
  dmDados.tbComandaAE.Clear;
  dmDados.tbComandaAD.Clear;
  dmDados.tbComandaBE.Clear;
  dmDados.tbComandaBD.Clear;
  dmDados.tbComandaCE.Clear;
  dmDados.tbComandaCD.Clear;
  dmDados.tbComandaDE.Clear;
  dmDados.tbComandaDD.Clear;
  dmDados.tbComandaEE.Clear;
  dmDados.tbComandaED.Clear;
  dmDados.tbComandaFE.Clear;
  dmDados.tbComandaFD.Clear;
  dmDados.tbComandaGE.Clear;
  dmDados.tbComandaGD.Clear;
  dmDados.tbComandaHE.Clear;
  dmDados.tbComandaHD.Clear;
  dmDados.tbComandaIE.Clear;
  dmDados.tbComandaID.Clear;
  dmDados.tbComandaJE.Clear;
  dmDados.tbComandaJD.Clear;
  dmDados.tbComandaKE.Clear;
  dmDados.tbComandaKD.Clear;
  dmDados.tbComandaLE.Clear;
  dmDados.tbComandaLD.Clear;
  dmDados.tbComandaME.Clear;
  dmDados.tbComandaMD.Clear;
  dmDados.tbComandaNE.Clear;
  dmDados.tbComandaND.Clear;
  dmDados.tbComandaOE.Clear;
  dmDados.tbComandaOD.Clear;
  dmDados.tbComandaPE.Clear;
  dmDados.tbComandaPD.Clear;
  dmDados.tbComandaQE.Clear;
  dmDados.tbComandaQD.Clear;
  dmDados.tbComandaRE.Clear;
  dmDados.tbComandaRD.Clear;
  dmDados.tbComandaSE.Clear;
  dmDados.tbComandaSD.Clear;
  dmDados.tbComandaTE.Clear;
  dmDados.tbComandaTD.Clear;
  dmDados.tbComandaUE.Clear;
  dmDados.tbComandaUD.Clear;
  dmDados.tbComandaVE.Clear;
  dmDados.tbComandaVD.Clear;
  dmDados.tbComandaXE.Clear;
  dmDados.tbComandaXD.Clear;
  dmDados.tbComandaZE.Clear;
  dmDados.tbComandaZD.Clear;
  dmDados.tbComandaZDValor.Clear;
  dmDados.tbComandaData.Clear;
  dmDados.tbComandaCodCliente.Clear;
  dmDados.tbComandaStatus.Value := 'F';
  dmDados.tbComanda.Post;
  MsgDlg.MsgInformation('Comanda foi PAGA ou CANCELADA | Status : FECHADA');
end;

procedure TFrmComanda.GravaComanda;
begin
  if (dmDados.tbComanda.State <> dsEdit) then
    dmDados.tbComanda.Edit;
  dmDados.tbComandaAE.Value      := dbCafP.Value   ;
  dmDados.tbComandaAD.Value      := dbRefLa.Value  ;
  dmDados.tbComandaBE.Value      := dbCafM.Value   ;
  dmDados.tbComandaBD.Value      := dbRef600.Value ;
  dmDados.tbComandaCE.Value      := dbCafG.Value   ;
  dmDados.tbComandaCD.Value      := dbRef2.Value   ;
  dmDados.tbComandaDE.Value      := dbCapuP.Value  ;
  dmDados.tbComandaDD.Value      := dbGua.Value    ;
  dmDados.tbComandaEE.Value      := dbCapuM.Value  ;
  dmDados.tbComandaED.Value      := dbGato.Value   ;
  dmDados.tbComandaFE.Value      := dbCapuG.Value  ;
  dmDados.tbComandaFD.Value      := dbKapo.Value   ;
  dmDados.tbComandaGE.Value      := dbChocoP.Value ;
  dmDados.tbComandaGD.Value      := dbTodi.Value   ;
  dmDados.tbComandaHE.Value      := dbChocoM.Value ;
  dmDados.tbComandaHD.Value      := dbCopoLei.Value;
  dmDados.tbComandaIE.Value      := dbChocoG.Value ;
  dmDados.tbComandaID.Value      := dbAcai.Value   ;
  dmDados.tbComandaJE.Value      := dbCreme.Value  ;
  dmDados.tbComandaJD.Value      := dbPaoMel.Value ;
  dmDados.tbComandaKE.Value      := dbSuVale.Value ;
  dmDados.tbComandaKD.Value      := dbPaoQuei.Value;
  dmDados.tbComandaLE.Value      := dbSuAg.Value   ;
  dmDados.tbComandaLD.Value      := dbPaoMant.Value;
  dmDados.tbComandaME.Value      := dbSuLeite.Value;
  dmDados.tbComandaMD.Value      := dbBolo.Value   ;
  dmDados.tbComandaNE.Value      := dbSu2.Value    ;
  dmDados.tbComandaND.Value      := dbTorDo.Value  ;
  dmDados.tbComandaOE.Value      := dbChaQuen.Value;
  dmDados.tbComandaOD.Value      := dbPudim.Value  ;
  dmDados.tbComandaPE.Value      := dbChaMate.Value;
  dmDados.tbComandaPD.Value      := dbTorSal.Value ;
  dmDados.tbComandaQE.Value      := dbIcea.Value   ;
  dmDados.tbComandaQD.Value      := dbSal.Value    ;
  dmDados.tbComandaRE.Value      := dbAgTo.Value   ;
  dmDados.tbComandaRD.Value      := dbSalChi.Value ;
  dmDados.tbComandaSE.Value      := dbAgCopo.Value ;
  dmDados.tbComandaSD.Value      := dbEnro.Value   ;
  dmDados.tbComandaTE.Value      := dbAgGar.Value  ;
  dmDados.tbComandaTD.Value      := dbSandNat.Value;
  dmDados.tbComandaUE.Value      := dbAgGrd.Value  ;
  dmDados.tbComandaUD.Value      := dbSanBag.Value ;
  dmDados.tbComandaVE.Value      := dbAgGas.Value  ;
  dmDados.tbComandaVD.Value      := dbBauru.Value  ;
  dmDados.tbComandaXE.Value      := dbAgCoco.Value ;
  dmDados.tbComandaXD.Value      := dbMisto.Value  ;
  dmDados.tbComandaZE.Value      := dbCerv.Value   ;
  dmDados.tbComandaZD.Value      := dbOutros.Value ;
  dmDados.tbComandaZDValor.Value := edtOutros.Value;
  dmDados.tbComanda.Post;
  MsgDlg.MsgInformation('Comanda Gravada com Sucesso!!!');
end;


end.
