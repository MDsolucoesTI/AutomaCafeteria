//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-02-2001
// Ultima modifica��o: 10-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

 unit UnitPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, RxMenus, StdCtrls, ImgList, ComCtrls, ToolWin, ExtCtrls, jpeg,
  LMDGraphicControl, LMDScrollText, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDCustomLabelFill,
  LMDLabelFill, XPMenu, ShellApi, LMDCustomComponent, LMDCustomHint,
  LMDCustomShapeHint, LMDShapeHint, EHintBal, EAppProt, LMDCustomGraphicLabel,
  LMDGraphicLabel, RXCtrls, EFocCol, DB, DBTables, EPaswd, ECripto, Mask,
  ToolEdit, EMsgDlg, EUserAcs, JvComponent, JvTransBtn, EGrad, fcpanel,
  JvButton, EFiCrpto, JvGradient, WinSkinData, ExtDlgs, JvEnterTab, EOneInst,
  EFiMgr;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Sair1: TMenuItem;
    Relatrio1: TMenuItem;
    Ajuda1: TMenuItem;           
    MenuItem5: TMenuItem;
    EnviesuaDvidapeloEmail1: TMenuItem;
    ImageList2: TImageList;
    Clientes1: TMenuItem;
    Cliente1: TMenuItem;
    PopRelatorio: TPopupMenu;
    PopAjuda: TPopupMenu;
    Cliente2: TMenuItem;
    Pedidos1: TMenuItem;
    Ajuda2: TMenuItem;
    EnviesuaDvidapeloEmail2: TMenuItem;
    Funcionrio2: TMenuItem;
    Cargo1: TMenuItem;
    Cadastro1: TMenuItem;
    PopCadastro: TPopupMenu;
    Cliente3: TMenuItem;
    Funcionrios1: TMenuItem;
    NotaFiscal2: TMenuItem;
    ImageList1: TImageList;
    Funcionrio1: TMenuItem;
    SobreoEROS1: TMenuItem;
    SobreoEROS2: TMenuItem;
    Funcionrio3: TMenuItem;
    Table1: TTable;
    Table1Senha: TStringField;
    DataSource1: TDataSource;
    Table1Usuario: TStringField;
    Table1TipoAcesso: TStringField;
    Table1CodFunc: TIntegerField;
    fcPanel1: TfcPanel;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Grupo1: TMenuItem;
    SubGrupo1: TMenuItem;
    Unidade1: TMenuItem;
    Marca1: TMenuItem;
    Produto1: TMenuItem;
    Fornecedor1: TMenuItem;
    N4: TMenuItem;
    Fornecedor2: TMenuItem;
    Estoque1: TMenuItem;
    Compra1: TMenuItem;
    Mercadoria1: TMenuItem;
    FornecedoreporPerodo1: TMenuItem;
    Estoque2: TMenuItem;
    N2: TMenuItem;
    Utilitrios1: TMenuItem;
    OpesdoSistema1: TMenuItem;
    Senhas1: TMenuItem;
    UsuriodoSistema1: TMenuItem;
    MudarUsurio1: TMenuItem;
    AlterarUsurio1: TMenuItem;
    MsgDlg: TEvMsgDlg;
    EvAppProtect1: TEvAppProtect;
    EvFocusColor1: TEvFocusColor;
    evCripto: TEvCriptografa;
    EvHintBalloon1: TEvHintBalloon;
    XPMenu1: TXPMenu;
    UserAcess: TEvUserAccess;
    EvPassword1: TEvPassword;
    sd1: TSkinData;
    btnCadCli: TJvTransparentButton;
    btnCadProd: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    Opd1: TOpenPictureDialog;
    MudarAparncia1: TMenuItem;
    N6: TMenuItem;
    Cadastro2: TMenuItem;
    Entrada1: TMenuItem;
    Sada1: TMenuItem;
    EvOneInstance1: TEvOneInstance;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sair1Click(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
              Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StatusTeclas(vAcao:boolean;vTeclas:string);
    procedure EnviesuaDvidapeloEmail1Click(Sender: TObject);
    procedure SobreoEROS2Click(Sender: TObject);
    procedure SobreoEROS1Click(Sender: TObject);
    procedure Subgrupo1Click(Sender: TObject);
    procedure Materiais1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure EvPassword1Error(Sender: TObject; Error: TEvPasswordError);
    procedure EvPassword1BeforeInput(Sender: TObject);
    procedure EvPassword1Validate(Sender: TObject; UserName,
      Password: String; var Valid: Boolean);
    procedure EvPassword1AfterInput(Sender: TObject);
    procedure EnviesuaDvidapeloEmail2Click(Sender: TObject);
    procedure MudarOperador1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure Grupo1Click(Sender: TObject);
    procedure Unidade1Click(Sender: TObject);
    procedure Marca1Click(Sender: TObject);
    procedure btnCadProdClick(Sender: TObject);
    procedure MudarAparncia1Click(Sender: TObject);
    procedure Cadastro2Click(Sender: TObject);
    procedure Entrada1Click(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure UsuriodoSistema1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fAcesso : integer;
    fUser   : string ;
  public
    { Public declarations }
    property Acesso : integer read fAcesso write fAcesso;
    property User   : string read fUser write fUser     ;
  end;

var
  FrmPrincipal : TFrmPrincipal;
  ListaTeclas  : String;
  PilhaTeclas  : array[1..10] of string;
  Topo         : integer;
  Acao         : boolean;

implementation

uses unitdmdados, UnitCargos, UnitSobre, UnitRelCliente, unitParametro,
     UnitRelFunc, UnitCadGrupo, UnitCadSubgrupo, UnitCadUnidade, UnitCadMarca,
     SkinGraphic, unitCadMaterial, UnitCadSenha, UnitCadCliente, UnitEntMat,
     UnitSaidaMat, UnitRelEstoque, unitRelCompras, Unitcompra1, UnitCadFornec,
     unitFunc, UnitRelFornec;

{$R *.DFM}

procedure TfrmPrincipal.StatusTeclas(vAcao:boolean;vTeclas:string);
begin
  if vAcao then
    begin
    Topo:=Topo + 1;
    if Topo > 0 Then
      PilhaTeclas[Topo]:=StatusBar1.Panels[0].Text;
    StatusBar1.Panels[0].Text:=vTeclas;
    end
  else
    begin
    StatusBar1.Panels[0].Text:=PilhaTeclas[Topo];
    Topo:=Topo-1;
    end;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= Cafree;
end;

procedure TFrmPrincipal.Sair1Click(Sender: TObject);
begin
	Close;
end;

procedure TFrmPrincipal.Sair2Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case (key) of
    // Teclas de navega��o
    VK_F2     : btnCadCli.Click;
    VK_F6     : btnCadProd.Click;
    VK_ESCAPE : close;
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  Topo:= -1;
  ListaTeclas:='[F1] Ajuda [F2] Clientes [F6] Produtos [ESC] Sai';
  StatusTeclas(True,ListaTeclas);
  dmDados.HabilitaTeclado     := True;
  dmDados.BaseDados.Connected := True;
  dmDados.TbParametro.Open;
  dmDados.tbSenha.Open;
  if table1.RecordCount=1 then  //obriga o cadastro de senha no 1� uso
      begin
        frmCadSenha:=tfrmCadSenha.create(application);
        frmCadSenha.showModal;
      end;
  evPassword1.Execute;
end;

procedure TFrmPrincipal.EnviesuaDvidapeloEmail1Click(Sender: TObject);
var
  url : string;
begin
  url :='mailto:suportephoenix@terra.com.br';
  shellexecute(0, 'open',Pchar(url), nil, nil, sw_showNormal);
end;

procedure TFrmPrincipal.SobreoEROS2Click(Sender: TObject);
begin
  frmSobre := TfrmSobre.create(application);
  frmSobre.showmodal;
end;

procedure TFrmPrincipal.SobreoEROS1Click(Sender: TObject);
begin
  frmSobre := TfrmSobre.create(application);
  frmSobre.showmodal;
end;

procedure TFrmPrincipal.Subgrupo1Click(Sender: TObject);
begin
  frmCadSubgrupo := TfrmCadSubgrupo.create(application);
  frmCadSubgrupo.showModal;
end;

procedure TFrmPrincipal.Materiais1Click(Sender: TObject);
begin
  frmCadmaterial := tfrmCadmaterial.create(application);
  frmCadmaterial.show;
end;

procedure TFrmPrincipal.C1Click(Sender: TObject);
begin
  frmCadSenha := tfrmCadSenha.create(application);
  frmCadSenha.showModal;
end;

procedure TFrmPrincipal.EvPassword1Error(Sender: TObject;
  Error: TEvPasswordError);
begin
  MsgDlg.MsgWarning('O usu�rio atual n�o pode ser confirmado.|A aplica��o ser� terminada.');
  Application.Terminate;
end;

procedure TFrmPrincipal.EvPassword1BeforeInput(Sender: TObject);
begin
  table1.Open;
end;

procedure TFrmPrincipal.EvPassword1Validate(Sender: TObject; UserName,
  Password: String; var Valid: Boolean);
begin
  if Table1.FindKey([username]) then
    begin
    Valid := EvCripto.CriptoBinToText(Table1senha.AsString) = Password;
    Acesso:=StrtoInt(Table1TipoAcesso.Value);
    User:=Table1Usuario.Value;
    end
  else
    ShowMessage('O nome de usu�rio e senha informado n�o s�o v�lidos.');
end;

procedure TFrmPrincipal.EvPassword1AfterInput(Sender: TObject);
begin
  Table1.Close;
end;

procedure TFrmPrincipal.EnviesuaDvidapeloEmail2Click(Sender: TObject);
var
  url : string;
begin
  url :='mailto:suportephoenix@terra.com.br.com.br';
  shellexecute(0, 'open',Pchar(url), nil, nil, sw_showNormal);
end;

procedure TFrmPrincipal.MudarOperador1Click(Sender: TObject);
begin
  EvPassword1.Execute;
  UserAcess.UserID:=frmPrincipal.Acesso;
  UserAcess.ForceDefinitions;
end;

procedure TFrmPrincipal.FormActivate(Sender: TObject);
begin
  UserAcess.UserID:=frmPrincipal.Acesso;
  UserAcess.ForceDefinitions;
  if (UserAcess.UserID = 3) then
    begin
    btnCReceber.Enabled := False;
    btnCPagar.Enabled   := False;
    end
  else
    begin
    btnCReceber.Enabled := True ;
    btnCPagar.Enabled   := True ;
    end;
end;

procedure TFrmPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipal.Grupo1Click(Sender: TObject);
begin
  frmCadGrupo := TfrmCadGrupo.create(application);
  frmCadGrupo.showModal;
end;

procedure TFrmPrincipal.Unidade1Click(Sender: TObject);
begin
  frmCadUnidades := TfrmCadUnidades.Create(application);
  frmCadUnidades.showModal;
end;

procedure TFrmPrincipal.Marca1Click(Sender: TObject);
begin
  frmCadMarca := TfrmCadMarca.create(application);
  frmCadMarca.showModal;
end;

procedure TFrmPrincipal.btnCadProdClick(Sender: TObject);
begin
  frmCadMaterial := TfrmCadMaterial.create(application);
  frmCadMaterial.showModal;
end;

procedure TFrmPrincipal.MudarAparncia1Click(Sender: TObject);
begin
  opd1.InitialDir:='..\skins';//ExtractFilePath(ParamStr(0));
  opd1.Filter:= 'Text files (*.skn)|*.skn';
  if opd1.Execute then begin
     sd1.SkinFile:=opd1.FileName;
  end;
end;

procedure TFrmPrincipal.Cadastro2Click(Sender: TObject);
begin
  frmCadMaterial := TfrmCadMaterial.create(application);
  frmCadMaterial.showModal;
end;

procedure TFrmPrincipal.Entrada1Click(Sender: TObject);
begin
  frmEntrMat := TfrmEntrMat.create(application);
  frmEntrMat.showModal;
end;

procedure TFrmPrincipal.Sada1Click(Sender: TObject);
begin
  frmSaidaMat := TfrmSaidaMat.create(application);
  frmSaidaMat.showModal;
end;

procedure TFrmPrincipal.UsuriodoSistema1Click(Sender: TObject);
begin
  frmCadSenha := TfrmCadSenha.create(application);
  frmCadSenha.showModal;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Table1.Open;
end;

end.
