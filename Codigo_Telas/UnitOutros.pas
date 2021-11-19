//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 05-06-2007
// Ultima modifica��o: 02-07-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitOutros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EMsgDlg, StdCtrls, Mask, DBCtrls, RXCtrls, fcLabel, EGrad,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, DBTables,
  LMDCustomParentPanel, LMDBackPanel, fcButton, fcImgBtn, Grids, DBGrids,
  RXDBCtrl, JvComponent, JvTransBtn, EUserAcs, db;

type
  TFrmOutros = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel1: TfcLabel;
    Panel3: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel3: TRxLabel;
    btnLocProd: TfcImageBtn;
    dbDesc: TDBEdit;
    RxLabel4: TRxLabel;
    RxLabel5: TRxLabel;
    RxDBGrid1: TRxDBGrid;
    btnPrimeiro: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    dbCodProd: TDBEdit;
    dbQuant: TDBEdit;
    dbVlUnit: TDBEdit;
    dbValorTot: TDBEdit;
    UserAcess: TEvUserAccess;
    btnAlterar: TJvTransparentButton;
    MsgDlg: TEvMsgDlg;
    procedure btnSairClick(Sender: TObject);
    procedure btnLocProdClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbCodProdExit(Sender: TObject);
    procedure dbVlUnitExit(Sender: TObject);
    procedure dbValorTotExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOutros : TFrmOutros;
  NovoItem  : Boolean   ;
  Mudar     : Boolean   ;

implementation

uses unitDmDados, UnitPrincipal, UnitComanda, UnitLocProdOut;

{$R *.dfm}

procedure TFrmOutros.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmOutros.btnLocProdClick(Sender: TObject);
begin
  if (dmdados.tbOutros.State=DsInsert)or(dmdados.tbOutros.State=DsEdit) then
    begin
    try
      begin
      FrmLocProdOut.ShowModal;
      if FrmLocProdOut.WindowState=wsMinimized then
        FrmLocProdOut.WindowState:=wsNormal;
      end;
    except
      begin
      FrmLocProdOut:=TfrmLocProdOut.create(application);
      FrmLocProdOut.ShowModal;
      end;
    end;
    dmdados.tbOutrosCodProd.Value:=frmLocProdOut.resultado;
    dmDados.tbOutrosVlUnit.Value:=dmDados.tbCoEstoquePrecoVenda.Value;
    frmLocProdOut.Free;
    dbCodProd.SetFocus;
    end;
end;

procedure TFrmOutros.btnNovoClick(Sender: TObject);
begin
  btnAnterior.Enabled := False;
  btnPrimeiro.Enabled := False;
  btnProximo.Enabled  := False;
  btnUltimo.Enabled   := False;
  DMDados.tbOutros.Append;
  NovoItem := True;
  {habilitando os bot�es}
  btngravar.Enabled   := True ;
  BtnCancelar.Enabled := True ;
  BtnAlterar.Enabled  := False;
  BtnDeletar.Enabled  := False;
  BtnNovo.Enabled     := False;
  {habilitando os componentes}
  dbCodProd.Enabled   := True ;
  dbDesc.Enabled      := True ;
  dbQuant.Enabled     := True ;
  dbVlUnit.Enabled    := True ;
  dbValorTot.Enabled  := True ;
  dmDados.vTabStt     := False;
  dbCodProd.SetFocus;
  UserAcess.ForceDefinitions;
end;

procedure TFrmOutros.btnPrimeiroClick(Sender: TObject);
begin
  DMDados.tbOutros.First;
  BtnPrimeiro.Enabled := False;
  BtnAnterior.Enabled := False;
  BtnProximo.Enabled  := True ;
  BtnUltimo.Enabled   := True ;
  dmDados.vTabStt     := True ;
end;

procedure TFrmOutros.btnAnteriorClick(Sender: TObject);
begin
  DMDados.tbOutros.Prior;
  BtnProximo.Enabled := True;
  BtnUltimo.Enabled  := True;
  If DMDados.tbOutros.Bof Then
    Begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    End;
  dmDados.vTabStt := True;
end;

procedure TFrmOutros.btnProximoClick(Sender: TObject);
begin
  DMDados.tbOutros.Next;
  BtnPrimeiro.Enabled := True;
  BtnAnterior.Enabled := True;
  If DMDados.tbOutros.Eof Then
    Begin
    BtnProximo.Enabled := False;
    BtnUltimo.Enabled  := False;
    End;
  dmDados.vTabStt := True;
end;

procedure TFrmOutros.btnUltimoClick(Sender: TObject);
begin
  DMDados.tbOutros.Last;
  BtnPrimeiro.Enabled := True ;
  BtnAnterior.Enabled := True ;
  BtnProximo.Enabled  := False;
  BtnUltimo.Enabled   := False;
  dmDados.vTabStt     := True ;
end;

procedure TFrmOutros.btnGravarClick(Sender: TObject);
Var
  Gravar, Vazio : Boolean;
  Campos : string;
begin
  Gravar:=true;
  Vazio:=False;
  Campos:='';
  if dbCodProd.Text='' then
    begin
    if Length(Campos)>0 then
      Campos:=Campos+', ';
    Campos:=Campos+'C�DIGO PRODUTO';
    Gravar:=False;
    end;
  if dbQuant.Text='' then
  	begin
	  if Length(Campos)>0 then
      Campos:=Campos+', ';
    Campos:=Campos+'QUANTIDADE';
    Gravar:=False;
    end;
  if dbVlUnit.Text='' then
  	begin
	  if Length(Campos)>0 then
      Campos:=Campos+', ';
    Campos:=Campos+'VALOR UNIT�RIO';
    Gravar:=False;
    end;
  if Gravar then
    begin
    NovoItem:= False;
    dmdados.tbOutros.Post;
    dmDados.vTabStt:=True;
    {bot�es}
    BtnGravar.enabled := False;
    BtnCancelar.Enabled := False;
    BtnNovo.Enabled:=True;
    BtnPrimeiro.Enabled:=True;
    BtnAnterior.Enabled:=True;
    BtnProximo.Enabled:=True;
    BtnUltimo.Enabled:=True;
    BtnAlterar.Enabled:=True;
    Btndeletar.Enabled:=True;
    {componentes}
    dbCodProd.Enabled:=False;
    dbDesc.Enabled:=False;
    dbQuant.Enabled:=False;
    dbVlUnit.Enabled:=False;
    dbValorTot.Enabled:=False;
    //MsgDlg.MsgInformation('Dados gravados com sucesso!');
    Panel3.SetFocus;
    end
  else
    if Vazio then
      begin
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
      DbCodProd.Enabled:=true;
      end;
end;

procedure TFrmOutros.btnCancelarClick(Sender: TObject);
begin
  dmdados.tbOutros.Cancel;
  NovoItem:= False;
  btngravar.Enabled:=false;
  BtnCancelar.Enabled := false;
  BtnAlterar.Enabled:=True;
  BtnDeletar.Enabled:=True;
  BtnNovo.Enabled:=True;
  {Habilitando os componentes}
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  BtnAlterar.Enabled:=True;
  BtnDeletar.Enabled:=True;
  {desabilitando os objetos}
  dbCodProd.Enabled:=False;
  dbDesc.Enabled:=False;
  dbQuant.Enabled:=False;
  dbVlUnit.Enabled:=False;
  dbValorTot.Enabled:=False;
  dmDados.vTabStt:=True;
  Panel3.SetFocus;
  UserAcess.ForceDefinitions;
end;

procedure TFrmOutros.btnAlterarClick(Sender: TObject);
begin
  if dmdados.tbOutros.RecordCount=0 then
    MsgDlg.MsgError('Tabela sem registro')
  else
    begin
    novoitem:=true;
    dmdados.tbOutros.Edit;
    {habilitando os bot�es}
    BtnCancelar.Enabled:=True;
    btngravar.Enabled:=True;
    BtnNovo.Enabled:=False;
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    BtnAlterar.Enabled:=False;
    Btndeletar.Enabled:=False;
    {habilitando os componentes}
    dbCodProd.Enabled:=True;
    dbDesc.Enabled:=True;
    dbQuant.Enabled:=True;
    dbVlUnit.Enabled:=True;
    dbValorTot.Enabled:=True;
    dmDados.vTabStt:=False;
    DBCodProd.SetFocus;
    end;
  UserAcess.ForceDefinitions;
end;

procedure TFrmOutros.btnDeletarClick(Sender: TObject);
begin
  If dmDados.tbOutros.RecordCount=0 Then
    MsgDlg.MsgError('Tabela vazia!!!')
  Else
    if Application.MessageBox('Deseja realmente excluir o registro?','Aten��o !',MB_YESNO + MB_DEFBUTTON2 + MB_ICONEXCLAMATION) = IDYES then
       DMdados.tbOutros.Delete;
end;

procedure TFrmOutros.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmDados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_INSERT : if (dmDados.vTabStt) then BtnNovo.Click;
      VK_HOME   : if (dmDados.vTabStt) then BtnAlterar.Click;
      VK_DELETE : if (dmDados.vTabStt) then BtnDeletar.Click;
      VK_END    : if not(dmDados.vTabStt) then BtnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
      VK_F2     : BtnLocProd.Click;
    end;
end;

procedure TFrmOutros.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmOutros.FormActivate(Sender: TObject);
begin
  UserAcess.UserID:=frmPrincipal.Acesso;
end;

procedure TFrmOutros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  if (dmDados.tbOutros.RecordCount > 0) then
    begin
    frmComanda.edtOutros.Value := 0;
    frmComanda.dbOutros.Value  := 0;
    dmDados.tbOutros.First;
    while (not dmDados.tbOutros.Eof) do
      begin
      frmComanda.edtOutros.Value := frmComanda.edtOutros.Value + dmDados.tbOutrosVlTotal.Value;
      frmComanda.dbOutros.Value  := frmComanda.dbOutros.Value + dmDados.tbOutrosQuant.Value   ;
      dmDados.tbOutros.Next;
      end;
    end;
  Action:= Cafree;
end;

procedure TFrmOutros.FormShow(Sender: TObject);
begin
  //habilitando-desabilitanto bot�es
  If dmDados.tbOutros.RecordCount=0 Then
    begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    BtnProximo.Enabled  := False;
    BtnUltimo.Enabled   := False;
    BtnNovo.Enabled     := True ;
    BtnCancelar.Enabled := False;
    BtnAlterar.Enabled  := False;
    Btndeletar.Enabled  := False;
    end;
  dmDados.vTabStt         := True ;
  BtnSair.Enabled         := True ;
  BtnGravar.Enabled       := False;
  DBCodProd.Enabled       := False;
  dmDados.HabilitaTeclado := True ;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [F2] Loc. Produto [Esc] Cancelar ou Sair');
end;

procedure TFrmOutros.dbCodProdExit(Sender: TObject);
var
  tbBusca : TTable;
begin
  tbBusca := TTable.Create(Application);
  tbBusca.DatabaseName := dmDados.tbOutros.DatabaseName;
  tbBusca.TableName    := dmDados.tbOutros.TableName   ;
  tbBusca.IndexName    := dmdados.tbOutros.IndexName   ;
  tbBusca.MasterFields := dmDados.tbOutros.MasterFields;
  tbBusca.MasterSource := dmDados.tbOutros.MasterSource;
  tbBusca.Open;
  if novoItem then
    begin
      //localizar o produto
      if dbCodProd.Text='' then
        begin
        MsgDlg.MsgWarning('Necess�rio informar o C�DIGO DO PRODUTO');
        dbCodProd.SetFocus;
        end
      else
        if (not(dmdados.tbCoEstoque.Locate('CodMerc',dbCodProd.text,[]))) then
          begin
          MsgDlg.MsgWarning('C�DIGO DO PRODUTO n�o cadastrado,| ou n�o pertence ao Grupo OUTROS');
          dbCodProd.SetFocus;
          End
        Else
          Begin
          if (not(tbBusca.Locate('CodProd',dbCodProd.Text,[]))) then
            dmdados.tbOutrosVlUnit.Value:=dmDados.tbCoEstoquePrecoVenda.Value
          else
            begin
            MsgDlg.MsgWarning('C�DIGO DO PRODUTO j� cadastrado,| ALTERAR a Quantidade');
            btnCancelar.Click;
            end;
          end;
    end;
  tbBusca.Free;
end;

procedure TFrmOutros.dbVlUnitExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TFrmOutros.dbValorTotExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

end.
