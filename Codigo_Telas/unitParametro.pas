//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-02-2001
// Ultima modifica��o: 09-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit unitParametro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fcButton, fcImgBtn, RackCtls, StdCtrls, DBCtrls, ToolEdit, RXDBCtrl,
  Mask, RXSplit, RXCtrls, ExtCtrls, SpeedBar, jpeg, ComCtrls, SRColBtn,
  ExtDlgs, VerCPF, VerCNPJ, DCStdCtrls, LMDCustomComponent, LMDCustomHint,
  LMDCustomShapeHint, LMDShapeHint, EDBZero, RxGrdCpt, fcImager, EMsgDlg,
  RxDBComb, JvComponent, JvTransBtn, fcLabel, EGrad, JvComCtrls;

type
  TFrmParametro = class(TForm)
    AbreFigura: TOpenPictureDialog;
    VerCNPJ1: TVerCNPJ;
    VerCPF1: TVerCPF;
    Panel2: TPanel;
    lbempresa: TRxLabel;
    dbEmpresa: TDBEdit;
    lbie: TRxLabel;
    dbIE: TDBEdit;
    lbprop: TRxLabel;
    dbProp: TDBEdit;
    lbcgc: TRxLabel;
    dbCGC: TDBEdit;
    dbCPF: TDBEdit;
    lbcpf: TRxLabel;
    lbendereco: TRxLabel;
    DBend: TDBEdit;
    lbnumero: TRxLabel;
    lbcomplemento: TRxLabel;
    DBcompl: TDBEdit;
    lbuf: TRxLabel;
    DBCBoxUF: TDBComboBox;
    DBcep: TDBEdit;
    lbcep: TRxLabel;
    DBcidade: TDBEdit;
    lbcidade: TRxLabel;
    DBbairro: TDBEdit;
    lbBairro: TRxLabel;
    lbtel1: TRxLabel;
    DBtel1: TDBEdit;
    lbtel2: TRxLabel;
    DBTel2: TDBEdit;
    lbcelular: TRxLabel;
    DBcel: TDBEdit;
    lbicms: TRxLabel;
    dbicms: TDBEdit;
    RxSplitter1: TRxSplitter;
    lbMensPromo: TRxLabel;
    dbMensPromo: TDBEdit;
    lbMensRodape: TRxLabel;
    dbMensRodape: TDBEdit;
    RxSplitter3: TRxSplitter;
    Image7: TImage;
    Label3: TLabel;
    Label4: TLabel;
    dblogo: TDBImage;
    RxLabel22: TRxLabel;
    RxLabel33: TRxLabel;
    dbPis: TDBEdit;
    RxLabel3: TRxLabel;
    dbCofins: TDBEdit;
    RxLabel4: TRxLabel;
    dbCS: TDBEdit;
    RxLabel5: TRxLabel;
    dbNum: TEvDBZeroEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    Bevel1: TBevel;
    RxLabel23: TRxLabel;
    dbjurosdias: TDBEdit;
    dbjurosvalor: TDBEdit;
    RxLabel24: TRxLabel;
    RxLabel25: TRxLabel;
    dbjurosperc: TDBEdit;
    RxLabel7: TRxLabel;
    RxLabel26: TRxLabel;
    dbmultadias: TDBEdit;
    dbmultavalor: TDBEdit;
    RxLabel27: TRxLabel;
    RxLabel28: TRxLabel;
    dbmultaperc: TDBEdit;
    RxLabel29: TRxLabel;
    dbdescdias: TDBEdit;
    dbdescvalor: TDBEdit;
    RxLabel30: TRxLabel;
    RxLabel31: TRxLabel;
    dbdescperc: TDBEdit;
    RxLabel32: TRxLabel;
    dbcredito: TDBEdit;
    dbcomissao: TDBEdit;
    RxLabel20: TRxLabel;
    RxLabel8: TRxLabel;
    Bevel2: TBevel;
    RxLabel9: TRxLabel;
    Bevel3: TBevel;
    RxLabel1: TRxLabel;
    rbEntrada: TRadioButton;
    rbSaida: TRadioButton;
    RxLabel2: TRxLabel;
    RxLabel11: TRxLabel;
    dbPosCaixa: TRxDBComboBox;
    RxLabel12: TRxLabel;
    fcLabel1: TfcLabel;
    MsgDlg: TEvMsgDlg;
    btnGravar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    pgcConfig: TPageControl;
    tbsEmpresa: TTabSheet;
    tbsDiversos: TTabSheet;
    tbsValores: TTabSheet;
    Bevel5: TBevel;
    Bevel4: TBevel;
    RxLabel6: TRxLabel;
    dbFrente: TDBComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbCGCExit(Sender: TObject);
    procedure dbCPFExit(Sender: TObject);
    procedure DBcelExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dblogoDblClick(Sender: TObject);
    procedure rbEntradaClick(Sender: TObject);
    procedure rbSaidaClick(Sender: TObject);
    procedure tbsValoresShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblogoExit(Sender: TObject);
    procedure fcImageBtn2Click(Sender: TObject);
    procedure tbsValoresEnter(Sender: TObject);
    procedure tbsDiversosEnter(Sender: TObject);
    procedure tbsEmpresaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmParametro: TFrmParametro;
  NovoItem : boolean;

implementation

uses UnitDmdados, UnitPrincipal;

{$R *.DFM}

procedure TFrmParametro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
	Action:= Cafree;
end;

procedure TFrmParametro.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmParametro.dbCGCExit(Sender: TObject);
begin
  if NovoItem then
    begin
    VerCnpj1.NumCnpj:= dbcgc.text;
    If not VerCnpj1.valid Then
      Begin
      if application.MessageBox('CNPJ inv�lido. Deseja continuar cadastro?','Valida��o CNPJ', mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = id_no then
        begin
        dbcgc.Clear;
        dbcgc.setfocus;
        end;
      End;
    end;
end;

procedure TFrmParametro.dbCPFExit(Sender: TObject);
begin
  if NovoItem then
    begin
    VerCpf1.NumeroCpf:= dbcpf.text;
    If not VerCpf1.valid Then
      Begin
      if application.MessageBox('CPF inv�lido. Deseja continuar cadastro?','Valida��o CPF', mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = id_no then
        begin
        dbcpf.Clear;
        dbcpf.setfocus;
        end;
      End;
    end;
end;

procedure TFrmParametro.DBcelExit(Sender: TObject);
begin
  pgcConfig.ActivePage:=tbsDiversos;
end;

procedure TFrmParametro.FormShow(Sender: TObject);
begin
  NovoItem:=True;
  pgcConfig.ActivePage:=tbsEmpresa;
  FrmPrincipal.StatusTeclas(True,'[End] Gravar [Esc] Cancelar');
  If dmDados.TbParametro.RecordCount=0 Then
    Begin
    dmDados.TbParametro.Append;
    pgcConfig.ActivePage:=tbsEmpresa;
    dbempresa.SetFocus;
    End
  Else
    Begin
    dmDados.TbParametro.First;
    dmdados.TbParametro.Edit;
    pgcConfig.ActivePage:=tbsEmpresa;
    dbempresa.SetFocus;
    End;
end;

procedure TFrmParametro.BtnGravarClick(Sender: TObject);
Var
  Campos:String;
  Vazio,Gravar:Boolean;
BEGIN
  NovoItem:=False;
  Campos:='';
  Gravar:=True;
  Vazio:=False;
  If dbempresa.Text='' Then
    Begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:='Empresa';
    Gravar:=False;
    Vazio:=True;
    End;
  If dbCpf.Text='           ' Then
    Begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'CPF';
    Gravar:=False;
    Vazio:=True;
    End
  Else
    Begin
    VerCPF1.NumeroCPF:= dbcpf.text;
    If not VerCpf1.valid Then
      if application.MessageBox('CPF inv�lido. Deseja continuar cadastro?','Valida��o CPF', mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = id_no then
        Gravar:=False;
    end;
  If dbCgc.Text='              ' Then
    Begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'CNPJ';
    Gravar:=False;
    Vazio:=True;
    End
  Else
    begin
    VerCnpj1.NumCnpj:= dbcgc.text;
    If not VerCnpj1.valid Then
      if application.MessageBox('CNPJ inv�lido. Deseja continuar cadastro?','Valida��o CNPJ', mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = id_no then
      Gravar:=False;
    end;
  If Gravar Then
    Begin
    dmdados.TbParametro.Post;
    MsgDlg.MsgInformation('Dados gravados com sucesso');
    Close;
    End
  Else
    Begin
    If Vazio Then
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
    dbempresa.SetFocus;
    end;
end;

procedure TFrmParametro.btnCancelarClick(Sender: TObject);
begin
  NovoItem:=False;
  dmdados.TbParametro.cancel;
  Panel4.SetFocus;
  Close;
end;

procedure TFrmParametro.dblogoDblClick(Sender: TObject);
begin
  if AbreFigura.Execute then DMdados.tbparametroLogo.LoadFromFile(AbreFigura.FileName);
end;

procedure TFrmParametro.rbEntradaClick(Sender: TObject);
begin
  dmDados.TbParametroDecoEntra.Value:='S';
end;

procedure TFrmParametro.rbSaidaClick(Sender: TObject);
begin
  dmDados.TbParametroDecoEntra.Value:='N';
end;

procedure TFrmParametro.tbsValoresShow(Sender: TObject);
begin
  if dmdados.TbParametroDecoEntra.Value='S' then
    begin
    rbEntrada.Checked:=True;
    rbSaida.Checked:=False;
    end
  else
    begin
    rbEntrada.Checked:=True;
    rbSaida.Checked:=False;
    end;
end;

procedure TFrmParametro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case (key) of
    VK_END    : BtnGravar.Click;
    VK_ESCAPE : BtnCancelar.Click;
    VK_F2     : dblogoDblClick(Sender);
    VK_PRIOR  : begin
                if pgcConfig.ActivePage=tbsEmpresa then
                  pgcConfig.ActivePage:=tbsDiversos
                else if pgcConfig.ActivePage=tbsDiversos then
                  pgcConfig.ActivePage:=tbsValores
                else
                  pgcConfig.ActivePage:=tbsEmpresa;
                end;
    VK_NEXT   : begin
                if pgcConfig.ActivePage=tbsValores then
                  pgcConfig.ActivePage:=tbsDiversos
                else if pgcConfig.ActivePage=tbsDiversos then
                  pgcConfig.ActivePage:=tbsEmpresa
                else
                  pgcConfig.ActivePage:=tbsValores;
                end;
  end;
end;

procedure TFrmParametro.dblogoExit(Sender: TObject);
begin
pgcConfig.ActivePage:=tbsvalores;
end;

procedure TFrmParametro.fcImageBtn2Click(Sender: TObject);
begin
  dmdados.TbParametro.cancel;
  Panel4.SetFocus;
  Close;
end;

procedure TFrmParametro.tbsValoresEnter(Sender: TObject);
begin
  dbjurosdias.SetFocus;
end;

procedure TFrmParametro.tbsDiversosEnter(Sender: TObject);
begin
  dbicms.SetFocus;
end;

procedure TFrmParametro.tbsEmpresaEnter(Sender: TObject);
begin
 dbEmpresa.SetFocus;
end;

end.
