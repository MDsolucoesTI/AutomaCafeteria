//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 07-05-2007
// Ultima modifica��o: 21-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untFechaCx;

interface

uses
  Windows, Messages, SysUtils, Variants,DB, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fcButton, fcImgBtn, Mask, DBCtrls, ExtCtrls, RXCtrls,
  JvComponent, JvTransBtn, fcLabel, EGrad, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel,
  EMsgDlg, JvToolEdit, JvEdit, JvTypedEdit, JvLabel, JvDBCtrl;

type
  TFrmFechaCx = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    Panel3: TLMDBackPanel;
    btnSair: TJvTransparentButton;
    btnAbrirCx: TJvTransparentButton;
    LMDBackPanel1: TLMDBackPanel;
    MsgDlg: TEvMsgDlg;
    edtTroco: TJvCurrencyEdit;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    fcLabel1: TfcLabel;
    edtData: TJvDBDateEdit;
    procedure btnSairClick(Sender: TObject);
    procedure btnAbrirCxClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtTrocoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFechaCx: TFrmFechaCx;

implementation

uses unitDmDados, UnitPrincipal;

{$R *.dfm}

procedure TFrmFechaCx.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmFechaCx.btnAbrirCxClick(Sender: TObject);
var
  Entradas     : double   ;
  Saidas       : double   ;
  Total        : real     ;
  CodCli       : longint  ;
  cont         : integer  ;
  Canceladas   : integer  ;
  Abertas      : integer  ;
  CodigoVenda  : integer  ;
  DataVendaAnt : TDateTime;
  DataVenda    : TDateTime;
begin
  Entradas   := 0;
  Saidas     := 0;
  Abertas    := 0;
  Canceladas := 0;
  if (MsgDlg.MsgConfirmation('Deseja fechar o CAIXA???') = mrYes) then
    begin
    if (dmDados.tbCaixaStatus.Value = 'A') then
      begin
      dmDados.tbComanda.First;
      while not(dmDados.tbComanda.Eof) do
        begin
        if (dmDados.tbComandaStatus.Value = 'A') then
          begin
          Abertas := Abertas + 1;
          Total   := 0          ;
          //Registro dos dados da comnada cancelada
          dmDados.tbAberComa.Last;
          CodigoVenda                     := dmdados.tbAberComaCodVen.Value   ;
          DataVendaAnt                    := dmdados.tbAberComaDataVen.Value  ;
          dmDados.tbAberComa.Append;
          dmDados.tbAberComaDataVen.Value := Date                             ;
          //calcula o c�digo da venda
          if DataVendaAnt = date then
            dmdados.tbAberComaCodVen.Value := CodigoVenda + 1
          else
            dmdados.tbAberComaCodVen.Value := 1              ;
          CodigoVenda                     := dmdados.tbAberComaCodVen.value   ;
          DataVenda                       := dmdados.tbAberComaDataVen.Value  ;
          dmdados.tbAberComaHoraVen.Value := Time                             ;
          dmDados.tbAberComaCodCli.Value  := dmDados.tbComandaCodCliente.Value;
          dmDados.tbAberComaStatus.Value  := 'A'                              ;
          dmDados.tbAberComa.Post;
          //Pedidos lado Esquerdo
          if (dmDados.tbComandaAE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 1;
            Total := Total + (dmDados.tbComandaAE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaAE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaBE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 2;
            Total := Total + (dmDados.tbComandaBE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaBE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaCE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 3;
            Total := Total + (dmDados.tbComandaCE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaCE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaDE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 4;
            Total := Total + (dmDados.tbComandaDE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaDE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaEE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 5;
            Total := Total + (dmDados.tbComandaEE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaEE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaFE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 6;
            Total := Total + (dmDados.tbComandaFE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaFE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaGE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 7;
            Total := Total + (dmDados.tbComandaGE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaGE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaHE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 8;
            Total := Total + (dmDados.tbComandaHE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaHE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaIE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 9;
            Total := Total + (dmDados.tbComandaIE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaIE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaJE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 10;
            Total := Total + (dmDados.tbComandaJE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaJE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaKE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 11;
            Total := Total + (dmDados.tbComandaKE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaKE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaLE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 12;
            Total := Total + (dmDados.tbComandaLE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaLE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaME.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 13;
            Total := Total + (dmDados.tbComandaME.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaME.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaNE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 14;
            Total := Total + (dmDados.tbComandaNE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaNE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaOE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 15;
            Total := Total + (dmDados.tbComandaOE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaOE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaPE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 16;
            Total := Total + (dmDados.tbComandaPE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaPE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaQE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 17;
            Total := Total + (dmDados.tbComandaQE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaQE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaRE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 47;
            Total := Total + (dmDados.tbComandaRE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaRE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaSE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 18;
            Total := Total + (dmDados.tbComandaSE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaSE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaTE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 19;
            Total := Total + (dmDados.tbComandaTE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaTE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaUE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 20;
            Total := Total + (dmDados.tbComandaUE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaUE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaVE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 21;
            Total := Total + (dmDados.tbComandaVE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaVE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaXE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 22;
            Total := Total + (dmDados.tbComandaXE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaXE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaZE.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 23;
            Total := Total + (dmDados.tbComandaZE.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaZE.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          //Pedidos lado Direito
          if (dmDados.tbComandaAD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 24;
            Total := Total + (dmDados.tbComandaAD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaAD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaBD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 25;
            Total := Total + (dmDados.tbComandaBD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaBD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaCD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 26;
            Total := Total + (dmDados.tbComandaCD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaCD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaDD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 27;
            Total := Total + (dmDados.tbComandaDD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaDD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaED.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 28;
            Total := Total + (dmDados.tbComandaED.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaED.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaFD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 29;
            Total := Total + (dmDados.tbComandaFD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaFD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaGD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 30;
            Total := Total + (dmDados.tbComandaGD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaGD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaHD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 31;
            Total := Total + (dmDados.tbComandaHD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaHD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaID.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 32;
            Total := Total + (dmDados.tbComandaID.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaID.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaJD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 33;
            Total := Total + (dmDados.tbComandaJD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaJD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaKD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 34;
            Total := Total + (dmDados.tbComandaKD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaKD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaLD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 35;
            Total := Total + (dmDados.tbComandaLD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaLD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaMD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 36;
            Total := Total + (dmDados.tbComandaMD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaMD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaND.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 37;
            Total := Total + (dmDados.tbComandaND.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaND.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaOD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 38;
            Total := Total + (dmDados.tbComandaOD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaOD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaPD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 39;
            Total := Total + (dmDados.tbComandaPD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaPD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaQD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 40;
            Total := Total + (dmDados.tbComandaQD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaQD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaRD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 41;
            Total := Total + (dmDados.tbComandaRD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaRD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaSD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 42;
            Total := Total + (dmDados.tbComandaSD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaSD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaTD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 43;
            Total := Total + (dmDados.tbComandaTD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaTD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaUD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 44;
            Total := Total + (dmDados.tbComandaUD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaUD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaVD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 45;
            Total := Total + (dmDados.tbComandaVD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaVD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaXD.Value > 0) then
            begin
            dmDados.tbEstoque.RecNo := 46;
            Total := Total + (dmDados.tbComandaXD.Value * dmDados.tbEstoquePrecoVenda.Value);
            dmdados.tbDetAberComa.Append;
            dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
            dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
            dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
            dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
            dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
            dmdados.tbDetAberComaQuant.Value     := dmDados.tbComandaXD.Value         ;
            dmDados.tbDetAberComa.Post;
            end;
          if (dmDados.tbComandaZD.Value > 0) then
            begin
            Total := Total + dmDados.tbComandaZDValor.Value;
            dmDados.tbOutros.First;
            while (not dmDados.tbOutros.Eof) do
              begin
              dmDados.tbEstoque.First;
              dmdados.tbEstoque.Locate('CodMerc',dmDados.tbOutrosCodProd.Value,[]);
              dmdados.tbDetAberComa.Append;
              dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                       ;
              dmdados.tbDetAberComaDataVen.Value   := DataVenda                         ;
              dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value    ;
              dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value;
              dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value ;
              dmdados.tbDetAberComaQuant.Value     := dmDados.tbOutrosQuant.Value       ;
              dmDados.tbDetAberComa.Post;
              dmDados.tbOutros.Next;
              end;
            end;
          dmDados.tbAberComa.Edit;
          dmDados.tbAberComaValor.Value := Total;
          dmDados.tbAberComa.Post;
          end;
        //Apaga a Comanda
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
        //Pr�xima Comanda
        dmDados.tbComanda.Next;
        end;
      dmDados.tbAberComa.Filtered := False                                         ;
      dmDados.tbAberComa.Filter   := '(DataVen = '''+ DateToStr(edtData.Date)+''')';
      dmDados.tbAberComa.Filtered := True                                          ;
      dmDados.tbAberComa.First;
      while not(dmDados.tbAberComa.Eof) do
        begin
        if (dmDados.tbAberComaStatus.Value = 'C') then
          Canceladas := Canceladas + 1;
        dmDados.tbAberComa.Next;
        end;
      dmDados.tbAberComa.Filtered := True                                         ;
      //Fecha o CAIXA
      dmDados.tbCaixa.Open;
      dmDados.tbCaixa.Edit;
      dmDados.tbCaixaStatus.Value := 'F';
      Entradas := dmDados.tbCaixaTrocoIni.Value + dmDados.tbCaixaRDin.Value +
                  dmDados.tbCaixaRCheque.Value + dmDados.tbCaixaRValeRefe.Value +
                  dmDados.tbCaixaRConVale.Value + dmDados.tbCaixaRCCliente.Value +
                  dmDados.tbCaixaRFiado.Value + dmDados.tbCaixaRValEletro.Value  ;
      Saidas   := dmDados.tbCaixaVales.Value + dmDados.tbCaixaSaida.Value +
                  dmDados.tbCaixaPagto.Value + dmDados.tbCaixaSContra.Value      ;
      dmDados.tbCaixaTrocoFim.Value  := edtTroco.Value                           ;
      dmDados.tbCaixaDiferenca.Value := Entradas - Saidas                        ;
      dmDados.tbCaixaComaAber.Value  := Abertas                                  ;
      dmDados.tbCaixaComaCanc.Value  := Canceladas                               ;
      dmDados.tbCaixa.Post;
      MsgDlg.MsgInformation('Caixa do dia' + DateToStr(dmDados.tbCaixaDataMov.Value) + ' -> FECHADO');
      end
    else
      MsgDlg.MsgWarning('O Caixa n�o est� ABERTO!|Abrir o Caixa para continuar...');
    end;
  Close;
end;

procedure TFrmFechaCx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmPrincipal.StatusTeclas(False,'');
  dmDados.tbCaixa.Close;
  dmDados.tbComanda.Close;
  dmDados.tbOutros.Close;
  dmDados.tbAberComa.Close;
  dmDados.tbDetAberComa.Close;
  dmDados.tbEstoque.Close;
  Action := caFree;
end;

procedure TFrmFechaCx.edtTrocoExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

procedure TFrmFechaCx.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (dmDados.HabilitaTeclado) then
    case (key) of
      // Teclas de navega��o
      VK_END    : btnAbrirCx.Click;
      VK_ESCAPE : btnSair.Click   ;
    end;
end;

procedure TFrmFechaCx.FormActivate(Sender: TObject);
begin
  dmDados.HabilitaTeclado := True;
  dmDados.vTabStt:=True;
  FrmPrincipal.StatusTeclas(True,'[End] Fechamento do Caixa [Esc] Cancelar ou Sair');
  if dmDados.tbCaixa.State       = dsInactive then
    dmDados.tbCaixa.Open;
  if dmDados.tbComanda.State     = dsInactive then
    dmDados.tbComanda.Open;
  if dmDados.tbOutros.State      = dsInactive then
    dmDados.tbOutros.Open;
  if dmDados.tbAberComa.State    = dsInactive then
    dmDados.tbAberComa.Open;
  if dmDados.tbDetAberComa.State = dsInactive then
    dmDados.tbDetAberComa.Open;
  if dmDados.tbEstoque.State     = dsInactive then
    dmDados.tbEstoque.Open;
  dmDados.tbCaixa.Last;
  edtTroco.SetFocus;
end;

end.
