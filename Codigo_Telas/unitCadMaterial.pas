//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 15-05-2007
// Ultima modifica��o: 29-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit unitCadMaterial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RxDBComb, fcButton, fcImgBtn, DBCtrls, RxLookup, Mask,
  Grids, DBGrids, RXDBCtrl, SpeedBar, ExtDlgs, ImgList,
  RXCtrls, RxGIF, ExtCtrls, RackCtls, jpeg,db,dbtables, EFocCol, RxGrdCpt,
  fcImager, EMsgDlg, EUserAcs, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, JvComponent,
  JvTransBtn, EGrad, JvLabel, fcLabel, JvEnterTab, Buttons;

type
  TFrmCadMaterial = class(TForm)
    AbreFigura: TOpenPictureDialog;
    UserAcess: TEvUserAccess;
    LMDBackPanel2: TLMDBackPanel;
    LMDBackPanel1: TLMDBackPanel;
    dbeCodProd: TDBEdit;
    dbeDescri: TDBEdit;
    dblSubGrupo: TRxDBLookupCombo;
    dblMarca: TRxDBLookupCombo;
    dbePrVenda: TDBEdit;
    dblUnidade: TRxDBLookupCombo;
    dbeEstoMin: TDBEdit;
    dbeEstoMax: TDBEdit;
    dbeEstoque: TDBEdit;
    Panel3: TLMDBackPanel;
    dbeGrupo: TDBEdit;
    MsgDlg: TEvMsgDlg;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnLocalizar: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnAnterior: TJvTransparentButton;
    btnAlterar: TJvTransparentButton;
    fcLabel2: TfcLabel;
    JvLabel10: TJvLabel;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel7: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel11: TJvLabel;
    JvLabel12: TJvLabel;
    JvEnterAsTab1: TJvEnterAsTab;
    btnCompo: TSpeedButton;
    JvLabel6: TJvLabel;
    dbePrCompra: TDBEdit;
    procedure btnLocImagemClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeCodProdExit(Sender: TObject);
    procedure fcImageBtn2Click(Sender: TObject);
    procedure dbeDescriExit(Sender: TObject);
    procedure dblSubGrupoExit(Sender: TObject);
    procedure dblUnidadeExit(Sender: TObject);
    procedure dblMarcaExit(Sender: TObject);
    procedure dbePrCompraExit(Sender: TObject);
    procedure dbePrVendaExit(Sender: TObject);
    procedure dbeEstoMinExit(Sender: TObject);
    procedure dbeEstoMaxExit(Sender: TObject);
    procedure dbeEstoqueExit(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadMaterial: TFrmCadMaterial;
  NovoItem:boolean;

implementation

uses unitDmDados, UnitPrincipal, UnitLocProd, untCompos;

{$R *.dfm}


procedure TFrmCadMaterial.BtnAlterarClick(Sender: TObject);
begin
  If dmDados.tbEstoque.RecordCount=0 Then
    MsgDlg.MsgError('Tabela vazia!!!')
  Else
    begin
    NovoItem:=True;
    DMDados.tbEstoque.Edit;
    {habilitando os bot�es}
    BtnCancelar.Enabled:=True;
    BtnGravar.Enabled:=True;
    BtnNovo.Enabled:=False;
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    BtnAlterar.Enabled:=False;
    Btndeletar.Enabled:=False;
    BtnLocalizar.Enabled:=False;
    {habilitando os componentes}
    dbeCodProd.Enabled:=True;
    dbeDescri.Enabled:=True;
    dbeEstoMin.Enabled:=True;
    dbeEstoMax.Enabled:=True;
    dbePrCompra.Enabled:=True;
    dbePrVenda.Enabled:=True;
    dbeEstoque.Enabled:=True;
    dblSubGrupo.Enabled:=True;
    dblMarca.Enabled:=True;
    dblUnidade.Enabled:=True;
//    DBImage1.Enabled:=True;
    dmDados.vTabStt:=False;
    dbeCodProd.SetFocus;
    end;
end;

procedure TFrmCadMaterial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmDados.tbEstoque.IndexName:= '';
  dmDados.tbDetVendas.Close;
  dmDados.tbUnidade.Close;
  dmDados.tbMarca.Close;
  dmDados.tbSubGrupo.Close;
  dmDados.tbGrupo.Close;
  dmDados.tbMovEstoque.Close;
  dmDados.tbFuncEsto.Close;
  dmDados.tbEstoque.Close;
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.HabilitaTeclado := False;
  Action := caFree;
end;

procedure TFrmCadMaterial.FormKeyDown(Sender: TObject; var Key: Word;
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
      VK_F9     : btnLocalizar.Click;
    end;
end;

procedure TFrmCadMaterial.dbeCodProdExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  If NovoItem Then
    Begin
    Tabela              := TTable.Create(Application)    ;
    Tabela.DatabaseName := dmDados.tbEstoque.DatabaseName;
    Tabela.TableName    := dmDados.tbEstoque.TableName   ;
    Tabela.IndexName    := dmDados.tbEstoque.IndexName   ;
    Tabela.Open;
    If dbeCodProd.Text = '' then
      begin
      MsgDlg.MsgWarning('� obrigat�rio o C�digo');
      dbeCodProd.SetFocus;
      end
    else
      Begin
      If Tabela.Locate('CodMerc',dbeCodProd.Text,[]) Then
        If not ((DmDados.tbEstoque.State=dsEdit) And (dmDados.tbEstoque.RecNo = Tabela.RecNo)) Then
          Begin
          MsgDlg.MsgWarning('C�digo j� Cadastrado');
          dbeCodProd.Clear;
          dbeCodProd.setfocus;
          End;
      End;
    Tabela.Free;
   End;
end;

procedure TFrmCadMaterial.fcImageBtn2Click(Sender: TObject);
begin
  if (dmdados.tbEstoque.State=dsedit)or(dmdados.tbEstoque.State=dsInsert) then
    DMdados.tbEstoqueFoto.Clear;
end;

procedure TFrmCadMaterial.dbeDescriExit(Sender: TObject);
begin
  If NovoItem Then
    If dbeDescri.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio a Nome do Produto');
      dbeDescri.SetFocus;
      End;
end;

procedure TFrmCadMaterial.dblSubGrupoExit(Sender: TObject);
begin
If NovoItem Then
    Begin
    If dblSubGrupo.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o SubGrupo');
      dblSubGrupo.SetFocus;
      End
    Else
      If Not(dmDados.tbSubgrupo.Locate('SubGrupo',dblSubGrupo.Text,[])) Then
        Begin
        MsgDlg.MsgWarning('SubGrupo n�o Cadastrado');
        dblSubGrupo.SetFocus;
        End;
     end;
end;

procedure TFrmCadMaterial.dblUnidadeExit(Sender: TObject);
begin
  If NovoItem Then
    Begin
    If dblUnidade.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio a Unidade');
      dblUnidade.SetFocus;
      End
    Else
      If Not(dmDados.tbUnidade.Locate('Descricao',dblUnidade.Text,[])) Then
        Begin
        MsgDlg.MsgWarning('Unidade n�o Cadastrada');
        dblUnidade.SetFocus;
        End;
    end;
END;

procedure TFrmCadMaterial.dblMarcaExit(Sender: TObject);
begin
  If NovoItem Then
    Begin
    If dblMarca.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio a Marca');
      dblMarca.SetFocus;
      End
    Else
      If Not(dmDados.tbMarca.Locate('Marca',dblMarca.Text,[])) Then
        Begin
        MsgDlg.MsgWarning('Marca n�o Cadastrada');
        dblMarca.SetFocus;
        End;
      end;
end;

procedure TFrmCadMaterial.dbePrCompraExit(Sender: TObject);
begin
  If NovoItem Then
    Begin
    If dbePrCompra.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o Pre�o de Compra');
      dbePrCompra.SetFocus;
      End;
    end;  
end;

procedure TFrmCadMaterial.dbePrVendaExit(Sender: TObject);
begin
  If NovoItem Then
    Begin
    If dbePrVenda.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o Pre�o de Venda');
      dbePrVenda.SetFocus;
      End;
    end;
end;

procedure TFrmCadMaterial.dbeEstoMinExit(Sender: TObject);
begin
  If NovoItem Then
    Begin
    If dbeEstoMin.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o Estoque M�nimo');
      dbeEstoMin.SetFocus;
      End;
    end;
end;

procedure TFrmCadMaterial.dbeEstoMaxExit(Sender: TObject);
begin
  If NovoItem Then
    Begin
    If dbeEstoMax.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o Estoque M�ximo');
      dbeEstoMax.SetFocus;
      End;
    End;
end;

procedure TFrmCadMaterial.dbeEstoqueExit(Sender: TObject);
begin
  If NovoItem Then
    Begin
    If dbeEstoque.Text= '' then
      Begin
      MsgDlg.MsgWarning('� obrigat�rio o Estoque Atual');
      dbeEstoque.SetFocus;
      End;
    End;
end;

procedure TFrmCadMaterial.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadMaterial.btnPrimeiroClick(Sender: TObject);
begin
  DMDados.tbEstoque.First;
  BtnPrimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  dmDados.vTabStt:=True;
end;

procedure TFrmCadMaterial.btnAnteriorClick(Sender: TObject);
begin
  DMDados.tbEstoque.Prior;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  If DMDados.tbEstoque.Bof Then
    Begin
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
    End;
  dmDados.vTabStt:=True;
end;

procedure TFrmCadMaterial.btnProximoClick(Sender: TObject);
begin
  DMDados.tbEstoque.Next;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  If DMDados.tbEstoque.Eof Then
    Begin
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
    End;
  dmDados.vTabStt:=True;
end;

procedure TFrmCadMaterial.btnUltimoClick(Sender: TObject);
begin
  DMDados.tbEstoque.Last;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  dmDados.vTabStt:=True;
end;

procedure TFrmCadMaterial.btnNovoClick(Sender: TObject);
begin
  btnAnterior.Enabled:=false;
  btnPrimeiro.Enabled:=false;
  btnProximo.Enabled:=false;
  btnUltimo.Enabled:=false;
  DMDados.tbEstoque.Append;
  NovoItem:=True;
{habilitando os bot�es}
  BtnGravar.Enabled :=True;
  BtnCancelar.Enabled:=True;
  BtnNovo.Enabled:=False;
  BtnPrimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  BtnAlterar.Enabled:=False;
  BtnDeletar.Enabled:=False;
  BtnLocalizar.Enabled:=False;
{habilitando os componentes}
  dbeCodProd.Enabled:=True;
  dbeDescri.Enabled:=True;
  dbeEstoMin.Enabled:=True;
  dbeEstoMax.Enabled:=True;
  dbePrCompra.Enabled:=True;
  dbePrVenda.Enabled:=True;
  dbeEstoque.Enabled:=True;
  dblSubGrupo.Enabled:=True;
  dblMarca.Enabled:=True;
  dblUnidade.Enabled:=True;
//  DBImage1.Enabled:=True;
  dmDados.vTabStt:=False;
  dbeCodProd.SetFocus;
end;

procedure TFrmCadMaterial.btnLocImagemClick(Sender: TObject);
begin
  if (dmdados.tbEstoque.State=dsedit)or(dmdados.tbEstoque.State=dsInsert) then
    if AbreFigura.Execute then DMdados.tbEstoqueFoto.LoadFromFile(AbreFigura.FileName);
end;

procedure TFrmCadMaterial.btnCancelarClick(Sender: TObject);
begin
  NovoItem:=False;
  DMDados.tbEstoque.Cancel;
  BtnGravar.Enabled:=False;
  BtnCancelar.Enabled:=False;
  BtnNovo.Enabled:=True;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  BtnAlterar.Enabled:=True;
  BtnDeletar.Enabled:=True;
  BtnLocalizar.Enabled:=True;
  {desabilitando os objetos}
  dbeCodProd.Enabled:=False;
  dbeDescri.Enabled:=False;
  dbeEstoMin.Enabled:=False;
  dbeEstoMax.Enabled:=False;
  dbePrCompra.Enabled:=False;
  dbePrVenda.Enabled:=False;
  dbeEstoque.Enabled:=False;
  dblSubGrupo.Enabled:=False;
  dblMarca.Enabled:=False;
  dblUnidade.Enabled:=False;
//  DBImage1.Enabled:=False;
  dmDados.vTabStt:=True;
  Panel3.SetFocus;
end;

procedure TFrmCadMaterial.btnDeletarClick(Sender: TObject);
var
  Flag : Boolean;
begin
  Flag:=False;
  If dmDados.tbEstoque.RecordCount=0 Then
    MsgDlg.MsgError('Tabela vazia!!!')
  Else
    begin
     if MsgDlg.MsgConfirmation('Tem certeza que deseja excluir este registro?') = id_yes then
      begin
      if dmDados.tbFuncEsto.Locate('CodMerc',dmDados.tbEstoqueCodMerc.Value,[]) then
        flag:=true;
      if dmDados.tbMovEstoque.Locate('CodMerc',dmDados.tbEstoqueCodMerc.Value,[]) then
        flag:=true;
      if dmDados.tbDetVendas.Locate('CodMerc',dmDados.tbEstoqueCodMerc.Value,[]) then
        flag:=true;
      if Flag Then
        MsgDlg.MsgInformation('Material ativo, ou com registro de opera��es anteriores.'+#13+#13+'N�o pode ser EXCLU�DO!!!')
      else
        dmdados.TbEstoque.Delete;
      end;
    end;
end;

procedure TFrmCadMaterial.btnLocalizarClick(Sender: TObject);
begin
  frmLocProd := TfrmLocProd.Create(Application);
  frmLocProd.ShowModal;
  frmLocProd.free;
end;

procedure TFrmCadMaterial.btnGravarClick(Sender: TObject);
Var
  Campos:String;
  Vazio,Gravar:Boolean;
  Tabela: TTable;
begin
  Campos:='';
  Gravar:=True;
  Vazio:=False;
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbEstoque.DatabaseName;
  Tabela.TableName := dmDados.tbEstoque.TableName;
  Tabela.IndexName:=dmDados.tbEstoque.IndexName;
  Tabela.Open;
  //Campo que n�o pode repetir
  If dbeCodProd.Text= '' then
    begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'C�digo';
    Gravar:=False;
    Vazio:=True;
    end
  else
    If Tabela.Locate('CodMerc',dbeCodProd.Text,[]) Then
      If Not((DmDados.tbEstoque.State=dsEdit) And (dmDados.tbEstoque.RecNo = Tabela.RecNo)) Then
        Begin
       	Gravar:=False;
        MsgDlg.MsgWarning('C�digo j� Cadastrado');
        End;
  //Campo que n�o pode estar vazio
  If dbeEstoque.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Estoque Atual';
    Gravar:=False;
    Vazio:=True;
    end;
  If dbeEstoMax.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Estoque M�ximo';
    Gravar:=False;
    Vazio:=True;
    end;
  If dbeEstoMin.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Estoque M�nimo';
    Gravar:=False;
    Vazio:=True;
    end;
  If dbePrVenda.Text= '' then
    begin
    If Length(Campos)>0 Then
      Campos:=Campos+', ';
    Campos:=Campos+'Pre�o de Venda';
    Gravar:=False;
    Vazio:=True;
    end;
  if (frmPrincipal.Acesso <> 3) then
    if dbePrCompra.Text= '' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'Pre�o de Compra';
      Gravar:=False;
      Vazio:=True;
      end;
  //Campo que tem conte�do de outra Tabela
  If dblUnidade.Text='' Then
    begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'Unidade';
    Gravar:=False;
    Vazio:=True;
    End
  Else
    If Not(dmDados.tbUnidade.Locate('Descricao',dblUnidade.Text,[])) Then
      Begin
      MsgDlg.MsgWarning('Unidade n�o Cadastrada');
      Gravar:=False;
      End;
  If dblUnidade.Text='' Then
    begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'Marca';
    Gravar:=False;
    Vazio:=True;
    End
  Else
    If Not(dmDados.tbMarca.Locate('Marca',dblMarca.Text,[])) Then
      Begin
      MsgDlg.MsgWarning('Marca n�o Cadastrada');
      Gravar:=False;
      End;
  If dblSubGrupo.Text='' Then
    begin
    If Length(Campos)>0 Then
    	Campos:=Campos+', ';
    Campos:=Campos+'SubGrupo';
    Gravar:=False;
    Vazio:=True;
    End
  Else
    If Not(dmDados.tbSubgrupo.Locate('SubGrupo',dblSubGrupo.Text,[])) Then
      Begin
      MsgDlg.MsgWarning('SubGrupo n�o Cadastrado');
      Gravar:=False;
      End;
  If Gravar Then
    Begin
    DMdados.tbEstoque.Post;
    dmDados.vTabStt:=true;
    NovoItem:=False;
    BtnGravar.Enabled:=False;
    BtnCancelar.Enabled:=False;
    BtnNovo.Enabled:=True;
    BtnPrimeiro.Enabled:=True;
    BtnAnterior.Enabled:=True;
    BtnProximo.Enabled:=True;
    BtnUltimo.Enabled:=True;
    BtnAlterar.Enabled:=True;
    Btndeletar.Enabled:=True;
    BtnLocalizar.Enabled:=True;
    Panel3.SetFocus;
    {desabilitando os componentes}
    dbeCodProd.Enabled:=False;
    dbeDescri.Enabled:=False;
    dbeEstoMin.Enabled:=False;
    dbeEstoMax.Enabled:=False;
    dbePrCompra.Enabled:=False;
    dbePrVenda.Enabled:=False;
    dbeEstoque.Enabled:=False;
    dblSubGrupo.Enabled:=False;
    dblMarca.Enabled:=False;
    dblUnidade.Enabled:=False;
//    DBImage1.Enabled:=False;
    MsgDlg.MsgInformation('Dados gravados com sucesso!');
    End
  Else
    Begin
    If Vazio Then
      MsgDlg.MsgWarning('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
    dbeCodProd.SetFocus;
    end;
  Tabela.Free;
end;

procedure TFrmCadMaterial.FormActivate(Sender: TObject);
begin
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [F9] Localiza [Esc] Cancelar ou Sair');
  if (dmDados.tbEstoque.State    = dsInactive) then
    dmDados.tbEstoque.Open;
  if (dmDados.tbFuncEsto.State   = dsInactive) then
    dmDados.tbFuncEsto.Open;
  if (dmDados.tbMovEstoque.State = dsInactive) then
    dmDados.tbMovEstoque.Open;
  if (dmDados.tbGrupo.State      = dsInactive) then
    dmDados.tbGrupo.Open;
  if (dmDados.tbSubGrupo.State   = dsInactive) then
    dmDados.tbSubGrupo.Open;
  if (dmDados.tbMarca.State      = dsInactive) then
    dmDados.tbMarca.Open;
  if (dmDados.tbUnidade.State    = dsInactive) then
    dmDados.tbUnidade.Open;
  if (dmDados.tbDetVendas.State  = dsInactive) then
    dmDados.tbDetVendas.Open;
  dmDados.tbEstoque.IndexName:= 'iDescricao';
  dmDados.tbEstoque.First;
  if (dmDados.tbEstoque.RecordCount = 0) then
    begin
    BtnPrimeiro.Enabled := False;
    BtnAnterior.Enabled := False;
    BtnProximo.Enabled  := False;
    BtnUltimo.Enabled   := False;
    BtnNovo.Enabled     := True ;
    BtnGravar.Enabled   := False;
    BtnCancelar.Enabled := False;
    BtnAlterar.Enabled  := False;
    Btndeletar.Enabled  := False;
    end;
  BtnSair.Enabled       := True ;
  dmDados.vTabStt       := True ;
  if (not dmdados.HabilitaTeclado) then
    dmdados.HabilitaTeclado := True;
  UserAcess.UserID:=frmPrincipal.Acesso;
end;

procedure TFrmCadMaterial.FormShow(Sender: TObject);
begin
  dbeCodProd.Enabled  :=False;
  dbeDescri.Enabled   :=False;
  dbeEstoMin.Enabled  :=False;
  dbeEstoMax.Enabled  :=False;
  dbePrCompra.Enabled :=False;
  dbePrVenda.Enabled  :=False;
  dbeEstoque.Enabled  :=False;
  dblSubGrupo.Enabled :=False;
  dblMarca.Enabled    :=False;
  dblUnidade.Enabled  :=False;
end;

procedure TFrmCadMaterial.btnCompoClick(Sender: TObject);
var
  Registro : Integer;
begin
  Registro                := dmDados.tbEstoque.RecNo;
  dmdados.tbEstoPrinc.Open;
  dmdados.tbCompEsto.Open;
  FrmCompos := TFrmCompos.Create(application);
  dmdados.tbEstoPrinc.Locate('CodMerc',dbeCodProd.Text,[]);
  FrmCompos.ShowModal;
  dmDados.tbEstoque.RecNo := Registro               ;
end;

end.
