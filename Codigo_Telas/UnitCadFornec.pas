//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 13-01-2001
// Ultima modifica��o: 26-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitCadFornec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatSplitterUnit, ToolEdit, RXDBCtrl, DBCtrls, EDBZero,
  StdCtrls, RxDBComb, Mask, RxGrdCpt, fcButton, fcImgBtn, VerCNPJ, VerCPF,
  RXCtrls, ExtCtrls, DbTables, DB, ShellApi, jpeg, fcImager, EMsgDlg,
  fcLabel, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, JvPanel, JvTransparentPanel, JvLabel,
  JvComponent, JvTransBtn, EChkCGC, EChkCPF;

type
  TFrmCadFornec = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel2: TfcLabel;
    MsgDlg: TEvMsgDlg;
    Panel3: TLMDBackPanel;
    btnAnterior: TJvTransparentButton;
    btnUltimo: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    btnProximo: TJvTransparentButton;
    btnPrimeiro: TJvTransparentButton;
    btnNovo: TJvTransparentButton;
    btnLocalizar: TJvTransparentButton;
    btnGravar: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnCancelar: TJvTransparentButton;
    btnAlterar: TJvTransparentButton;
    LMDBackPanel1: TLMDBackPanel;
    dbRaz: TDBEdit;
    dbNome: TDBEdit;
    dbFantasia: TDBEdit;
    dbTel2: TDBEdit;
    dbTel1: TDBEdit;
    dbRG: TDBEdit;
    dbIE: TDBEdit;
    dbCpf: TDBEdit;
    dbCod: TDBEdit;
    dbCnpj: TDBEdit;
    dbCel: TDBEdit;
    cmbTipo: TRxDBComboBox;
    dbDataCad: TDBDateEdit;
    JvLabel7: TJvLabel;
    dbEnd: TDBEdit;
    JvLabel8: TJvLabel;
    dbNum: TEvDBZeroEdit;
    JvLabel9: TJvLabel;
    dbCompl: TDBEdit;
    JvLabel10: TJvLabel;
    dbBairro: TDBEdit;
    JvLabel11: TJvLabel;
    dbCep: TDBEdit;
    JvLabel12: TJvLabel;
    cmbUf: TDBComboBox;
    JvLabel14: TJvLabel;
    JvTransparentPanel1: TJvTransparentPanel;
    dbCidade: TDBEdit;
    JvLabel13: TJvLabel;
    JvLabel15: TJvLabel;
    dbObs: TDBMemo;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    Labelnome: TJvLabel;
    Labelraz: TJvLabel;
    labelFan: TJvLabel;
    Rxlabelcpf: TJvLabel;
    RxLabelie: TJvLabel;
    RxLabelcnpj: TJvLabel;
    RxLabelRG: TJvLabel;
    JvLabel19: TJvLabel;
    JvLabel20: TJvLabel;
    JvLabel21: TJvLabel;
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cmbTipoChange(Sender: TObject);
    procedure cmbTipoExit(Sender: TObject);
    procedure dbFantasiaExit(Sender: TObject);
    procedure dbRazExit(Sender: TObject);
    procedure dbNomeExit(Sender: TObject);
    procedure dbCnpjExit(Sender: TObject);
    procedure dbCpfExit(Sender: TObject);
    procedure DBEendExit(Sender: TObject);
    procedure dbeNumExit(Sender: TObject);
    procedure DBEbairroExit(Sender: TObject);
    procedure DBEcidadeExit(Sender: TObject);
    procedure DBCBoxUFExit(Sender: TObject);
    procedure DBEemailExit(Sender: TObject);
    procedure fcImageBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadFornec: TFrmCadFornec;
  NovoItem: Boolean;
  mudaPag:boolean;

implementation

uses unitDmDados, UnitPrincipal, unitLocFornec;

{$R *.dfm}

procedure TFrmCadFornec.btnLocalizarClick(Sender: TObject);
begin
  FrmLocFornec:=TFrmLocFornec.Create(Application);
  FrmLocFornec.showmodal;
  FrmLocFornec.Free;
  If dmdados.tbFornecedorTipo.Value='1' then
    begin
    dbfantasia.Visible:= False;
    Labelfan.Visible:= False;
    dbRaz.Visible:= False;
    LabelRaz.Visible:= False;
    dbCnpj.visible:= false;
    dbIE.visible:= false;
    RxLabelcnpj.visible:= false;
    RxLabelie.visible:= false;
    dbNome.Visible:= True;
    Labelnome.Visible:= True;
    dbCpf.visible:= true;
    dbRg.visible:= true;
    Rxlabelcpf.visible:= true;
    RxlabelRg.visible:= true;
    end
  else
    Begin
    dbfantasia.Visible:= True;
    labelfan.Visible:= True;
    dbRaz.Visible:= True;
    labelRaz.Visible:=True;
    dbCnpj.visible:= true;
    RxlabelCnpj.visible:= true;
    dbIE.visible:= true;
    Rxlabelie.visible:= true;
    dbNome.Visible:=False;
    LabelNome.Visible:=false;
    dbRg.visible:= false;
    dbCpf.visible:= false;
    RxlabelRg.visible:= false;
    RxlabelCpf.visible:= false;
    end;
end;

procedure TFrmCadFornec.btnPrimeiroClick(Sender: TObject);
begin
  dmdados.tbFornecedor.First;
  Btnprimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  If (cmbTipo.Text='Pessoa F�sica') then
    Begin
    dbfantasia.Visible:= False;
    Labelfan.Visible:= False;
    dbRaz.Visible:= False;
    LabelRaz.Visible:= False;
    dbCnpj.visible:= false;
    dbIE.visible:= false;
    RxLabelcnpj.visible:= false;
    RxLabelie.visible:= false;
    dbNome.Visible:= True;
    Labelnome.Visible:= True;
    dbCpf.visible:= true;
    dbRg.visible:= true;
    Rxlabelcpf.visible:= true;
    RxlabelRg.visible:= true;
    end
  else
    Begin
    dbfantasia.Visible:= True;
    labelfan.Visible:= True;
    dbRaz.Visible:= True;
    labelRaz.Visible:=True;
    dbCnpj.visible:= true;
    RxlabelCnpj.visible:= true;
    dbIE.visible:= true;
    Rxlabelie.visible:= true;
    dbNome.Visible:=False;
    LabelNome.Visible:=false;
    dbRg.visible:= false;
    dbCpf.visible:= false;
    RxlabelRg.visible:= false;
    RxlabelCpf.visible:= false;
    end;
end;

procedure TFrmCadFornec.btnAnteriorClick(Sender: TObject);
begin
  dmdados.tbFornecedor.Prior;
  BtnProximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  If dmdados.tbFornecedor.bof Then
  Begin
    BtnPrimeiro.Enabled:=False;
    BtnAnterior.Enabled:=False;
  End;
  If (cmbTipo.Text='Pessoa F�sica') then
    Begin
    dbfantasia.Visible:= False;
    Labelfan.Visible:= False;
    dbRaz.Visible:= False;
    LabelRaz.Visible:= False;
    dbCnpj.visible:= false;
    dbIE.visible:= false;
    RxLabelcnpj.visible:= false;
    RxLabelie.visible:= false;
    dbNome.Visible:= True;
    Labelnome.Visible:= True;
    dbCpf.visible:= true;
    dbRg.visible:= true;
    Rxlabelcpf.visible:= true;
    RxlabelRg.visible:= true;
    end
  else
    Begin
    dbfantasia.Visible:= True;
    labelfan.Visible:= True;
    dbRaz.Visible:= True;
    labelRaz.Visible:=True;
    dbCnpj.visible:= true;
    RxlabelCnpj.visible:= true;
    dbIE.visible:= true;
    Rxlabelie.visible:= true;
    dbNome.Visible:=False;
    LabelNome.Visible:=false;
    dbRg.visible:= false;
    dbCpf.visible:= false;
    RxlabelRg.visible:= false;
    RxlabelCpf.visible:= false;
    end;
end;

procedure TFrmCadFornec.btnProximoClick(Sender: TObject);
begin
 dmdados.tbFornecedor.next;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  If dmdados.tbFornecedor.Eof Then
  Begin
    BtnProximo.Enabled:=False;
    BtnUltimo.Enabled:=False;
  End;
  If (cmbTipo.Text='Pessoa F�sica') then
    Begin
    dbfantasia.Visible:= False;
    Labelfan.Visible:= False;
    dbRaz.Visible:= False;
    LabelRaz.Visible:= False;
    dbCnpj.visible:= false;
    dbIE.visible:= false;
    RxLabelcnpj.visible:= false;
    RxLabelie.visible:= false;
    dbNome.Visible:= True;
    Labelnome.Visible:= True;
    dbCpf.visible:= true;
    dbRg.visible:= true;
    Rxlabelcpf.visible:= true;
    RxlabelRg.visible:= true;
    end
  else
    Begin
    dbfantasia.Visible:= True;
    labelfan.Visible:= True;
    dbRaz.Visible:= True;
    labelRaz.Visible:=True;
    dbCnpj.visible:= true;
    RxlabelCnpj.visible:= true;
    dbIE.visible:= true;
    Rxlabelie.visible:= true;
    dbNome.Visible:=False;
    LabelNome.Visible:=false;
    dbRg.visible:= false;
    dbCpf.visible:= false;
    RxlabelRg.visible:= false;
    RxlabelCpf.visible:= false;
    end;
end;

procedure TFrmCadFornec.btnUltimoClick(Sender: TObject);
begin
  dmdados.tbFornecedor.last;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  If (cmbTipo.Text='Pessoa F�sica') then
    Begin
    dbfantasia.Visible:= False;
    Labelfan.Visible:= False;
    dbRaz.Visible:= False;
    LabelRaz.Visible:= False;
    dbCnpj.visible:= false;
    dbIE.visible:= false;
    RxLabelcnpj.visible:= false;
    RxLabelie.visible:= false;
    dbNome.Visible:= True;
    Labelnome.Visible:= True;
    dbCpf.visible:= true;
    dbRg.visible:= true;
    Rxlabelcpf.visible:= true;
    RxlabelRg.visible:= true;
    end
  else
    Begin
    dbfantasia.Visible:= True;
    labelfan.Visible:= True;
    dbRaz.Visible:= True;
    labelRaz.Visible:=True;
    dbCnpj.visible:= true;
    RxlabelCnpj.visible:= true;
    dbIE.visible:= true;
    Rxlabelie.visible:= true;
    dbNome.Visible:=False;
    LabelNome.Visible:=false;
    dbRg.visible:= false;
    dbCpf.visible:= false;
    RxlabelRg.visible:= false;
    RxlabelCpf.visible:= false;
    end;
end;

procedure TFrmCadFornec.btnNovoClick(Sender: TObject);
begin
  dmdados.tbFornecedor.Append;
  novoitem:=true;
  {habilitando os bot�es}
  BtnGravar.Enabled    := True;
  BtnCancelar.Enabled  := True;
  BtnNovo.Enabled      := False;
  BtnPrimeiro.Enabled  := False;
  BtnAnterior.Enabled  := False;
  BtnProximo.Enabled   := False;
  BtnUltimo.Enabled    := False;
  BtnAlterar.Enabled   := False;
  BtnDeletar.Enabled   := False;
  BtnLocalizar.Enabled := False;
  {habilitando os componentes}
  If (cmbTipo.Text='Pessoa F�sica') then
    Begin
    dbfantasia.Visible  := False;
    Labelfan.Visible    := False;
    dbRaz.Visible       := False;
    LabelRaz.Visible    := False;
    dbCnpj.visible      := False;
    dbIE.visible        := False;
    RxLabelcnpj.visible := False;
    RxLabelie.visible   := False;
    dbNome.Visible      := True;
    Labelnome.Visible   := True;
    dbCpf.visible       := True;
    dbRg.visible        := True;
    Rxlabelcpf.visible  := True;
    RxlabelRg.visible   := True;
    end
  else
    Begin
    dbfantasia.Visible  := True;
    labelfan.Visible    := True;
    dbRaz.Visible       := True;
    labelRaz.Visible    :=True;
    dbCnpj.visible      := true;
    RxlabelCnpj.visible := true;
    dbIE.visible        := true;
    Rxlabelie.visible:= true;
    dbNome.Visible:=False;
    LabelNome.Visible:=false;
    dbRg.visible:= false;
    dbCpf.visible:= false;
    RxlabelRg.visible:= false;
    RxlabelCpf.visible:= false;
    end;
  cmbTipo.Enabled:=true;
  dbRaz.Enabled:=true;
  DbNome.Enabled:= True;
  dbfantasia.Enabled:=true;
  DbTel1.Enabled:=true;
  dbTel2.Enabled:=true;
  dbcel.Enabled:=true;
  dbcpf.Enabled:=true;
  dbcnpj.Enabled:=true;
  dbrg.Enabled:=true;
  dbie.Enabled:=true;
  dbEnd.Enabled:=true;
  dbnum.Enabled:=true;
  Dbcompl.Enabled:=true;
  DbBairro.Enabled:=true;
  dbCidade.Enabled:=true;
  dbcep.Enabled:=true;
  cmbUf.Enabled:=true;
  dbObs.Enabled:=True;
  dmDados.vTabStt:=False;
  cmbTipo.setfocus;
end;

procedure TFrmCadFornec.btnGravarClick(Sender: TObject);
Var
  Campos:String;
  Vazio,Gravar,Flag:Boolean;
  Tabela: TTable;
  x:integer;
begin
  Campos:='';
  Gravar:=True;
  Vazio:=False;
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbFornecedor.DatabaseName;
  Tabela.TableName := dmDados.tbFornecedor.TableName;
  Tabela.IndexName := dmdados.tbFornecedor.IndexName;
  Tabela.Open;
  If (cmbTipo.Text='Pessoa F�sica') Then
    Begin
    If dbNome.Text='' Then
      Begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:='Nome';
      Gravar:=False;
      Vazio:=True;
      end;
    If DBcidade.Text= '' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'Cidade';
      Gravar:=False;
      Vazio:=True;
    end;
    If DBbairro.Text= '' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'Bairro';
      Gravar:=False;
      Vazio:=True;
    end;
    If DBnum.Text= '' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'N�mero';
      Gravar:=False;
      Vazio:=True;
    end;
    If DBend.Text= '' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'Endere�o';
      Gravar:=False;
      Vazio:=True;
    end;
    If DBtel1.Text= '          ' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'Telefone 1';
      Gravar:=False;
      Vazio:=True;
    end;
    If cmbUF.Text= '' then
      begin
      If Length(Campos)>0 Then
    	  Campos:=Campos+', ';
      Campos:=Campos+'Estado';
      Gravar:=False;
      Vazio:=True;
      End
    Else
      Begin
      Flag:=True;
      For x:=0 to cmbUF.Items.Count-1 Do
        If cmbUF.Text=cmbUF.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('Valor da UF inv�lido');
        Gravar:=False;
        End;
      End;
    If cmbTipo.Text= '' then
      begin
      If Length(Campos)>0 Then
    	  Campos:=Campos+', ';
      Campos:=Campos+'Tipo de Pessoa';
      Gravar:=False;
      Vazio:=True;
      End
    Else
      Begin
      Flag:=True;
      For x:=0 to cmbTipo.Items.Count-1 Do
        If cmbTipo.Text=cmbTipo.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('Valor do TIPO DE PESSOA inv�lido');
        Gravar:=False;
        End;
      End;
    End
  Else
    Begin
    If dbfantasia.Text='' Then
      Begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=' Nome Fantasia ';
      Gravar:=False;
      Vazio:=True;
      end;
    If dbRaz.Text='' Then
      Begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=' Raz�o Social ';
      Gravar:=False;
      Vazio:=True;
      End;
    If DBcidade.Text= '' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'Cidade';
      Gravar:=False;
      Vazio:=True;
    end;
    If DBbairro.Text= '' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'Bairro';
      Gravar:=False;
      Vazio:=True;
    end;
    If DBnum.Text= '' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'N�mero';
      Gravar:=False;
      Vazio:=True;
    end;
    If DBend.Text= '' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'Endere�o';
      Gravar:=False;
      Vazio:=True;
    end;
    If DBtel1.Text= '          ' then
      begin
      If Length(Campos)>0 Then
        Campos:=Campos+', ';
      Campos:=Campos+'Telefone 1';
      Gravar:=False;
      Vazio:=True;
    end;
    If cmbUF.Text= '' then
      begin
      If Length(Campos)>0 Then
    	  Campos:=Campos+', ';
      Campos:=Campos+'Estado';
      Gravar:=False;
      Vazio:=True;
      End
    Else
      Begin
      Flag:=True;
      For x:=0 to cmbUF.Items.Count-1 Do
        If cmbUF.Text=cmbUF.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('Valor da UF inv�lido');
        Gravar:=False;
        End;
      End;
    If cmbTipo.Text= '' then
      begin
      If Length(Campos)>0 Then
    	  Campos:=Campos+', ';
      Campos:=Campos+'Tipo de Pessoa';
      Gravar:=False;
      Vazio:=True;
      End
    Else
      Begin
      Flag:=True;
      For x:=0 to cmbTipo.Items.Count-1 Do
        If cmbTipo.Text=cmbTipo.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('Valor do TIPO DE PESSOA inv�lido');
        Gravar:=False;
        End;
      End;
    End;
  If Gravar Then
    Begin
    NovoItem:= False;
    dmdados.tbFornecedor.Post;
    dmDados.vTabStt:=True;
    BtnGravar.enabled := False;
    BtnCancelar.Enabled := False;
    BtnNovo.Enabled:=True;
    BtnPrimeiro.Enabled:=True;
    BtnAnterior.Enabled:=True;
    BtnProximo.Enabled:=True;
    BtnUltimo.Enabled:=True;
    BtnAlterar.Enabled:=True;
    Btndeletar.Enabled:=True;
    BtnLocalizar.Enabled:=True;
    {desabilitando os componentes}
    cmbTipo.Enabled:=false;
    dbRaz.Enabled:=false;
    DbNome.Enabled:= false;
    //dblookrota.Enabled:=false;
    //dbprazo.Enabled:=false;
    dbfantasia.Enabled:=false;
    DbTel1.Enabled:=false;
    dbTel2.Enabled:=false;
    dbcel.Enabled:=false;
    dbCnpj.Enabled:=false;
    dbIE.Enabled:=false;
    dbcpf.Enabled:=false;
    dbrg.Enabled:=false;
    dbEnd.Enabled:=false;
    dbnum.Enabled:=false;
    Dbcompl.Enabled:=false;
    DbBairro.Enabled:=false;
    dbCidade.Enabled:=false;
    dbcep.Enabled:=false;
    cmbUF.Enabled:=false;
    dbObs.Enabled:=false;
    DbDataCad.enabled:=false;
    showmessage('Dados gravados com sucesso!');
    Panel3.SetFocus;
    If (cmbTipo.Text='Pessoa F�sica') then
      Begin
      dbfantasia.Visible:= False;
      Labelfan.Visible:= False;
      dbRaz.Visible:= False;
      LabelRaz.Visible:= False;
      dbCnpj.visible:= false;
      dbIE.visible:= false;
      RxLabelcnpj.visible:= false;
      RxLabelie.visible:= false;
      dbNome.Visible:= True;
      Labelnome.Visible:= True;
      dbCpf.visible:= true;
      dbRg.visible:= true;
      Rxlabelcpf.visible:= true;
      RxlabelRg.visible:= true;
      end
    else
      Begin
      dbfantasia.Visible:= True;
      labelfan.Visible:= True;
      dbRaz.Visible:= True;
      labelRaz.Visible:=True;
      dbCnpj.visible:= true;
      RxlabelCnpj.visible:= true;
      dbIE.visible:= true;
      Rxlabelie.visible:= true;
      dbNome.Visible:=False;
      LabelNome.Visible:=false;
      dbRg.visible:= false;
      dbCpf.visible:= false;
      RxlabelRg.visible:= false;
      RxlabelCpf.visible:= false;
      end;
    End
  Else
    Begin
    If Vazio Then
      begin
        mudaPag:=false;
        ShowMessage('O(s) Campo(s) '+Campos+' n�o tem Valor(es) ');
        If (cmbTipo.Text='Pessoa F�sica') then
           begin
            dbnome.Enabled:=true;
            dbNome.SetFocus;
           end
        else
           begin
           dbfantasia.SetFocus;
           end;
        mudapag:=true;
      end;
    end;

end;

procedure TFrmCadFornec.btnCancelarClick(Sender: TObject);
begin
  dmdados.tbFornecedor.cancel;
  NovoItem:= False;
  BtnGravar.enabled := false;
  BtnCancelar.Enabled := false;
  BtnNovo.Enabled:=True;
  BtnPrimeiro.Enabled:=True;
  BtnAnterior.Enabled:=True;
  Btnproximo.Enabled:=True;
  BtnUltimo.Enabled:=True;
  BtnAlterar.Enabled:=True;
  BtnDeletar.Enabled:=True;
  BtnLocalizar.Enabled:=True;
  {desabilitando os componentes}
  cmbTipo.Enabled:=false;
  dbRaz.Enabled:=false;
  dbNome.Enabled:=false;
  //dblookrota.Enabled:=false;
  //dbprazo.Enabled:=false;
  dbfantasia.Enabled:=false;
  DbTel1.Enabled:=false;
  dbTel2.Enabled:=false;
  dbcel.Enabled:=false;
  dbcpf.Enabled:=false;
  DBcnpj.Enabled:= False;
  DBie.Enabled:= False;
  dbrg.Enabled:=false;
  dbEnd.Enabled:=false;
  dbnum.Enabled:=false;
  Dbcompl.Enabled:=false;
  DbBairro.Enabled:=false;
  dbCidade.Enabled:=false;
  dbcep.Enabled:=false;
  cmbUF.Enabled:=false;
  dbObs.Enabled:=false;
  DbDataCad.enabled:=false;
  dmDados.vTabStt:=True;
  Panel3.SetFocus;
  If (cmbTipo.Text='Pessoa F�sica') then
      Begin
      dbfantasia.Visible:= False;
      Labelfan.Visible:= False;
      dbRaz.Visible:= False;
      LabelRaz.Visible:= False;
      dbCnpj.visible:= false;
      dbIE.visible:= false;
      RxLabelcnpj.visible:= false;
      RxLabelie.visible:= false;
      dbNome.Visible:= True;
      Labelnome.Visible:= True;
      dbCpf.visible:= true;
      dbRg.visible:= true;
      Rxlabelcpf.visible:= true;
      RxlabelRg.visible:= true;
      end
    else
      Begin
      dbfantasia.Visible:= True;
      labelfan.Visible:= True;
      dbRaz.Visible:= True;
      labelRaz.Visible:=True;
      dbCnpj.visible:= true;
      RxlabelCnpj.visible:= true;
      dbIE.visible:= true;
      Rxlabelie.visible:= true;
      dbNome.Visible:=False;
      LabelNome.Visible:=false;
      dbRg.visible:= false;
      dbCpf.visible:= false;
      RxlabelRg.visible:= false;
      RxlabelCpf.visible:= false;
      end;
end;

procedure TFrmCadFornec.btnAlterarClick(Sender: TObject);
begin
if dmdados.tbFornecedor.RecordCount=0 then
begin
ShowMessage('Tabela vazia')
end
else
  begin
  dmdados.tbFornecedor.Edit;
  NovoItem:= True;
  {habilitando os bot�es}
  BtnCancelar.enabled:= true;
  BtnGravar.Enabled:= true;
  BtnNovo.Enabled:=False;
  BtnPrimeiro.Enabled:=False;
  BtnAnterior.Enabled:=False;
  BtnProximo.Enabled:=False;
  BtnUltimo.Enabled:=False;
  BtnAlterar.Enabled:=False;
  Btndeletar.Enabled:=False;
  BtnLocalizar.Enabled:=False;
  {habilitando os componentes}
  cmbTipo.Enabled:=True;
  dbRaz.Enabled:=True;
  dbNome.Enabled:= True;
  //dblookrota.Enabled:=true;
  //dbprazo.Enabled:=true;
  dbfantasia.Enabled:=true;
  DbTel1.Enabled:=True;
  dbTel2.Enabled:=True;
  dbcel.Enabled:=True;
  dbcpf.Enabled:=True;
  dbrg.Enabled:=True;
  dbcnpj.Enabled:=True;
  dbie.Enabled:=True;
  dbEnd.Enabled:=True;
  dbnum.Enabled:=True;
  Dbcompl.Enabled:=True;
  DbBairro.Enabled:=True;
  dbCidade.Enabled:=True;
  dbcep.Enabled:=True;
  cmbUF.Enabled:=True;
  dbObs.Enabled:=True;
  DbDataCad.enabled:=True;
  dmDados.vTabStt:=False;
  cmbTipo.SetFocus;
  end;
end;

procedure TFrmCadFornec.btnDeletarClick(Sender: TObject);
var
  Flag : Boolean;
begin
  Flag:=False;
  if dmdados.tbFornecedor.RecordCount=0 then
    begin
    ShowMessage('Tabela vazia');
    end
  else
    If application.MessageBox('Tem certeza que deseja excluir este registro?','Excluir', mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = id_yes then
      Begin
      if dmDados.tbCompras.Locate('CodFor',dmDados.tbfornecedorCodFor.Value,[]) Then
        Flag:=True;
      if dmDados.tbCPagar.Locate('CodFor',dmDados.tbFornecedorCodFor.Value,[]) Then
        Flag:=True;
      if Flag Then
        ShowMessage('Fornecedor ativo, ou com registro de opera��es anteriores.'+#13+#13+'N�o pode ser EXCLUI�DO!!!')
      else
        dmdados.tbFornecedor.Delete;
        dmdados.tbFornecedor.Refresh;
      If (cmbTipo.Text='Pessoa F�sica') then
        Begin
        dbfantasia.Visible:= False;
        Labelfan.Visible:= False;
        dbRaz.Visible:= False;
        LabelRaz.Visible:= False;
        dbCnpj.visible:= false;
        dbIE.visible:= false;
        RxLabelcnpj.visible:= false;
        RxLabelie.visible:= false;
        dbNome.Visible:= True;
        Labelnome.Visible:= True;
        dbCpf.visible:= true;
        dbRg.visible:= true;
        Rxlabelcpf.visible:= true;
        RxlabelRg.visible:= true;
        end
      else
        Begin
        dbfantasia.Visible:= True;
        labelfan.Visible:= True;
        dbRaz.Visible:= True;
        labelRaz.Visible:=True;
        dbCnpj.visible:= true;
        RxlabelCnpj.visible:= true;
        dbIE.visible:= true;
        Rxlabelie.visible:= true;
        dbNome.Visible:=False;
        LabelNome.Visible:=false;
        dbRg.visible:= false;
        dbCpf.visible:= false;
        RxlabelRg.visible:= false;
        RxlabelCpf.visible:= false;
        end;
      End
    else
      dmdados.tbFornecedor.cancel;
end;

procedure TFrmCadFornec.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadFornec.cmbTipoChange(Sender: TObject);
begin
  If (cmbTipo.Text='Pessoa F�sica') then
    begin
    dbfantasia.Visible:= False;
    Labelfan.Visible:= False;
    dbRaz.Visible:= False;
    LabelRaz.Visible:= False;
    dbCnpj.visible:= false;
    dbIE.visible:= false;
    RxLabelcnpj.visible:= false;
    RxLabelie.visible:= false;
    dbNome.Visible:= True;
    Labelnome.Visible:= True;
    dbCpf.visible:= true;
    dbRg.visible:= true;
    Rxlabelcpf.visible:= true;
    RxlabelRg.visible:= true;
    end
  else
    Begin
    dbfantasia.Visible:= True;
    labelfan.Visible:= True;
    dbRaz.Visible:= True;
    labelRaz.Visible:=True;
    dbCnpj.visible:= true;
    RxlabelCnpj.visible:= true;
    dbIE.visible:= true;
    Rxlabelie.visible:= true;
    dbNome.Visible:=False;
    LabelNome.Visible:=false;
    dbRg.visible:= false;
    dbCpf.visible:= false;
    RxlabelRg.visible:= false;
    RxlabelCpf.visible:= false;
    end;
end;

procedure TFrmCadFornec.cmbTipoExit(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
  If NovoItem Then
    If cmbTipo.Text= '' then
      Begin
      ShowMessage('� obrigat�rio informar o TIPO DE PESSOA');
      cmbTipo.SetFocus;
      End
    Else
      Begin
      Flag:=True;
      For x:=0 to cmbTipo.Items.Count-1 Do
        If cmbTipo.Text=cmbTipo.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('Valor do TIPO DE PESSOA inv�lido');
        cmbTipo.SetFocus;
        End;
      End;
end;

procedure TFrmCadFornec.dbFantasiaExit(Sender: TObject);
begin
  If NovoItem Then
    If dbfantasia.Text= '' then
      Begin
      ShowMessage('� obrigat�rio o NOME FANTASIA');
      dbfantasia.SetFocus;
      End
end;

procedure TFrmCadFornec.dbRazExit(Sender: TObject);
begin
  If NovoItem Then
    If dbRaz.Text= '' then
      Begin
      ShowMessage('� obrigat�rio o NOME OU RAZ�O SOCIAL');
      dbRaz.SetFocus;
      End
end;

procedure TFrmCadFornec.dbNomeExit(Sender: TObject);
begin
  If NovoItem Then
    If dbNome.Text= '' then
      Begin
      ShowMessage('� obrigat�rio o Nome');
      dbNome.SetFocus;
      End
end;

procedure TFrmCadFornec.dbCnpjExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbfornecedor.DatabaseName;
  Tabela.TableName := dmDados.tbfornecedor.TableName;
  Tabela.IndexName := dmdados.tbfornecedor.IndexName;
  Tabela.Open;
  If NovoItem Then
    If dbcnpj.Text = '              ' Then
      Begin
      ShowMessage('� necess�rio Informar o CNPJ');
      dbcnpj.setfocus;
      end
    Else
     If Tabela.Locate('CNPJ',dbCnpj.Text,[]) Then
        If not((DmDados.tbfornecedor.State=dsEdit) And (dmDados.tbfornecedor.RecNo = Tabela.RecNo)) Then
          Begin
          Showmessage('CNPJ j� Cadastrado');
          dbcnpj.Clear;
          dbcnpj.setfocus;
          End;
End;

procedure TFrmCadFornec.dbCpfExit(Sender: TObject);
Var
  Tabela: TTable;
begin
  Tabela := TTable.Create(Application);
  Tabela.DatabaseName := dmDados.tbfornecedor.DatabaseName;
  Tabela.TableName := dmDados.tbfornecedor.TableName;
  Tabela.IndexName := dmdados.tbfornecedor.IndexName;
  Tabela.Open;
  If NovoItem Then
    If dbCPF.Text = '           ' Then
      Begin
      ShowMessage('� necess�rio Informar o CPF');
      dbCPF.setfocus;
      end
    else
      If Tabela.Locate('CPF',dbCPF.Text,[]) Then
        If not((DmDados.tbfornecedor.State=dsEdit) And (dmDados.tbfornecedor.RecNo = Tabela.RecNo)) Then
          Begin
          Showmessage('CPF j� Cadastrado');
          dbcpf.Clear;
          dbcpf.setfocus;
          End;
End;

procedure TFrmCadFornec.DBEendExit(Sender: TObject);
begin
  If NovoItem Then
    If DBend.Text= '' then
      Begin
      ShowMessage('� obrigat�rio o Endere�o');
      DBend.SetFocus;
      End
end;

procedure TFrmCadFornec.dbeNumExit(Sender: TObject);
begin
  If NovoItem Then
    If DBnum.Text= '00000' then
      Begin
      ShowMessage('� obrigat�rio o N�mero');
      DBnum.SetFocus;
      End
end;

procedure TFrmCadFornec.DBEbairroExit(Sender: TObject);
begin
  If NovoItem Then
    If DBbairro.Text= '' then
      Begin
      ShowMessage('� obrigat�rio o Bairro');
      DBbairro.SetFocus;
      End
end;

procedure TFrmCadFornec.DBEcidadeExit(Sender: TObject);
begin
  If NovoItem Then
    If DBcidade.Text= '' then
      Begin
      ShowMessage('� obrigat�rio a Cidade');
      DBcidade.SetFocus;
      End
end;

procedure TFrmCadFornec.DBCBoxUFExit(Sender: TObject);
Var
  x:integer;
  Flag:Boolean;
begin
  If NovoItem Then
    If cmbUF.Text= '' then
      Begin
      ShowMessage('� obrigat�rio informar ESTADO');
      cmbUF.SetFocus;
      End
    Else
      Begin
      Flag:=True;
      For x:=0 to cmbUF.Items.Count-1 Do
        If cmbUF.Text=cmbUF.Items[x] Then
          Flag:=False;
      If Flag Then
        Begin
        ShowMessage('ESTADO inv�lido');
        cmbUF.SetFocus;
        End
      End;

end;

procedure TFrmCadFornec.DBEemailExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TFrmCadFornec.fcImageBtn2Click(Sender: TObject);
var
 url : string;
begin
  url :='mailto:'+dmdados.tbFornecedorEMail.Value;
  if dmDados.tbfornecedorEMail.Value <> '' then
    shellexecute(0, 'open',Pchar(url), nil, nil, sw_showNormal);
end;

procedure TFrmCadFornec.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  Action:= Cafree;
end;

procedure TFrmCadFornec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if dmdados.HabilitaTeclado then
    case (key) of
      // Teclas de a��o na tabela
      VK_Insert : if (dmDados.vTabStt) then btnNovo.Click;
      VK_Home   : if (dmDados.vTabStt) then btnAlterar.Click;
      VK_Delete : if (dmDados.vTabStt) then btnDeletar.Click;
      VK_End    : if not(dmDados.vTabStt) then btnGravar.Click;
      VK_ESCAPE : if not(dmDados.vTabStt) then BtnCancelar.Click
                  else BtnSair.Click;
      VK_F9     : btnLocalizar.Click;
    end;
end;

procedure TFrmCadFornec.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key=#13 Then
    Begin
    Key:=#0;
    Perform(wm_nextdlgctl,0,0);
    End;
end;

procedure TFrmCadFornec.FormShow(Sender: TObject);
begin
  dmdados.HabilitaTeclado := True;
  FrmPrincipal.StatusTeclas(True,'[Insert] Novo [Home] Alterar [End] Gravar [Delete] Excluir [F9] Localiza [Esc] Cancelar ou Sair');
  dmDados.vTabStt:=True;
  NovoItem:= false;
  MudaPag:=true;
  dmDados.tbFornecedor.Open;
  dmDados.tbCPagar.Open;
  dmDados.tbCompras.Open;
  If dmdados.tbFornecedorTipo.Value='1' then
    begin
    dbfantasia.Visible:= False;
    Labelfan.Visible:= False;
    dbRaz.Visible:= False;
    LabelRaz.Visible:= False;
    dbCnpj.visible:= false;
    dbIE.visible:= false;
    RxLabelcnpj.visible:= false;
    RxLabelie.visible:= false;
    dbNome.Visible:= True;
    Labelnome.Visible:= True;
    dbCpf.visible:= true;
    dbRg.visible:= true;
    Rxlabelcpf.visible:= true;
    RxlabelRg.visible:= true;
    end
  else
    Begin
    dbfantasia.Visible:= True;
    labelfan.Visible:= True;
    dbRaz.Visible:= True;
    labelRaz.Visible:=True;
    dbCnpj.visible:= true;
    RxlabelCnpj.visible:= true;
    dbIE.visible:= true;
    Rxlabelie.visible:= true;
    dbNome.Visible:=False;
    LabelNome.Visible:=false;
    dbRg.visible:= false;
    dbCpf.visible:= false;
    RxlabelRg.visible:= false;
    RxlabelCpf.visible:= false;
    end;
end;

end.
