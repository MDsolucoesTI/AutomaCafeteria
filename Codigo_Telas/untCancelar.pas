//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 02-05-2007
// Ultima modifica��o: 27-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untCancelar;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, DB, JvComponent, JvTransBtn, EMsgDlg, JvEdit, JvTypedEdit,
  JvMaskEdit, JvSpin, JvDBSpinEdit;

type
  TFrmCancelar = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    btnOpera: TButton;
    btnComanda: TButton;
    procedure btnOperaClick(Sender: TObject);
    procedure btnComandaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCancelar: TFrmCancelar;

implementation

uses UnitComanda, unitDmDados, untMotivo;

{$R *.dfm}

procedure TFrmCancelar.btnOperaClick(Sender: TObject);
begin
  dmDados.tbComanda.Cancel;
  Close;
end;

procedure TFrmCancelar.btnComandaClick(Sender: TObject);
var
  Total        : real     ;
  Venda        : real     ;
  CodCli       : longint  ;
  cont         : integer  ;
  Motivo       : string   ;
  CodigoVenda  : Integer  ;
  DataVendaAnt : TDateTime;
  DataVenda    : TDateTime;
begin
  //Grava os dados da comanda
  if (dmDados.tbComanda.State <> dsEdit) then
    dmDados.tbComanda.Edit;
  dmDados.tbComandaAE.Value      := frmComanda.dbCafP.Value   ;
  dmDados.tbComandaAD.Value      := frmComanda.dbRefLa.Value  ;
  dmDados.tbComandaBE.Value      := frmComanda.dbCafM.Value   ;
  dmDados.tbComandaBD.Value      := frmComanda.dbRef600.Value ;
  dmDados.tbComandaCE.Value      := frmComanda.dbCafG.Value   ;
  dmDados.tbComandaCD.Value      := frmComanda.dbRef2.Value   ;
  dmDados.tbComandaDE.Value      := frmComanda.dbCapuP.Value  ;
  dmDados.tbComandaDD.Value      := frmComanda.dbGua.Value    ;
  dmDados.tbComandaEE.Value      := frmComanda.dbCapuM.Value  ;
  dmDados.tbComandaED.Value      := frmComanda.dbGato.Value   ;
  dmDados.tbComandaFE.Value      := frmComanda.dbCapuG.Value  ;
  dmDados.tbComandaFD.Value      := frmComanda.dbKapo.Value   ;
  dmDados.tbComandaGE.Value      := frmComanda.dbChocoP.Value ;
  dmDados.tbComandaGD.Value      := frmComanda.dbTodi.Value   ;
  dmDados.tbComandaHE.Value      := frmComanda.dbChocoM.Value ;
  dmDados.tbComandaHD.Value      := frmComanda.dbCopoLei.Value;
  dmDados.tbComandaIE.Value      := frmComanda.dbChocoG.Value ;
  dmDados.tbComandaID.Value      := frmComanda.dbAcai.Value   ;
  dmDados.tbComandaJE.Value      := frmComanda.dbCreme.Value  ;
  dmDados.tbComandaJD.Value      := frmComanda.dbPaoMel.Value ;
  dmDados.tbComandaKE.Value      := frmComanda.dbSuVale.Value ;
  dmDados.tbComandaKD.Value      := frmComanda.dbPaoQuei.Value;
  dmDados.tbComandaLE.Value      := frmComanda.dbSuAg.Value   ;
  dmDados.tbComandaLD.Value      := frmComanda.dbPaoMant.Value;
  dmDados.tbComandaME.Value      := frmComanda.dbSuLeite.Value;
  dmDados.tbComandaMD.Value      := frmComanda.dbBolo.Value   ;
  dmDados.tbComandaNE.Value      := frmComanda.dbSu2.Value    ;
  dmDados.tbComandaND.Value      := frmComanda.dbTorDo.Value  ;
  dmDados.tbComandaOE.Value      := frmComanda.dbChaQuen.Value;
  dmDados.tbComandaOD.Value      := frmComanda.dbPudim.Value  ;
  dmDados.tbComandaPE.Value      := frmComanda.dbChaMate.Value;
  dmDados.tbComandaPD.Value      := frmComanda.dbTorSal.Value ;
  dmDados.tbComandaQE.Value      := frmComanda.dbIcea.Value   ;
  dmDados.tbComandaQD.Value      := frmComanda.dbSal.Value    ;
  dmDados.tbComandaRE.Value      := frmComanda.dbAgTo.Value   ;
  dmDados.tbComandaRD.Value      := frmComanda.dbSalChi.Value ;
  dmDados.tbComandaSE.Value      := frmComanda.dbAgCopo.Value ;
  dmDados.tbComandaSD.Value      := frmComanda.dbEnro.Value   ;
  dmDados.tbComandaTE.Value      := frmComanda.dbAgGar.Value  ;
  dmDados.tbComandaTD.Value      := frmComanda.dbSandNat.Value;
  dmDados.tbComandaUE.Value      := frmComanda.dbAgGrd.Value  ;
  dmDados.tbComandaUD.Value      := frmComanda.dbSanBag.Value ;
  dmDados.tbComandaVE.Value      := frmComanda.dbAgGas.Value  ;
  dmDados.tbComandaVD.Value      := frmComanda.dbBauru.Value  ;
  dmDados.tbComandaXE.Value      := frmComanda.dbAgCoco.Value ;
  dmDados.tbComandaXD.Value      := frmComanda.dbMisto.Value  ;
  dmDados.tbComandaZE.Value      := frmComanda.dbCerv.Value   ;
  dmDados.tbComandaZD.Value      := frmComanda.dbOutros.Value ;
  dmDados.tbComandaZDValor.Value := frmComanda.edtOutros.Value;
  dmDados.tbComanda.Post;
  //Calcula o gasto total
  Total := 0;
  for cont:=0 to frmComanda.Componentcount-1 do
    if (frmComanda.Components[cont] is TJvDBSpinEdit) then
      if (TJvDBSpinEdit(frmComanda.Components[cont]).Tag <> 0) then
        begin
        dmDados.tbEstoque.RecNo:=TJvDBSpinEdit(frmComanda.Components[cont]).Tag;
        Total := Total + (TJvDBSpinEdit(frmComanda.Components[cont]).Value * dmDados.tbEstoquePrecoVenda.Value);
        end;
  Total  := Total + dmDados.tbComandaZDValor.Value;
  Codcli := StrToInt(frmComanda.edCodCli.Text)    ;
  Venda  := Total                                 ;
  //registra o motivo de cancelamento
  frmMotivo := TfrmMotivo.Create(Application);
  frmMotivo.ShowModal;
  Motivo    := frmMotivo.edtMotivo.Text      ;
  frmMotivo.Free;
  //Registro dos dados da comnada cancelada
  dmDados.tbAberComa.Last;
  CodigoVenda                     := dmdados.tbAberComaCodVen.Value ;
  DataVendaAnt                    := dmdados.tbAberComaDataVen.Value;
  dmDados.tbAberComa.Append;
  dmDados.tbAberComaDataVen.Value := Date                           ;
  //calcula o c�digo da venda
  if DataVendaAnt = date then
    dmdados.tbAberComaCodVen.Value := CodigoVenda + 1
  else
    dmdados.tbAberComaCodVen.Value := 1              ;
  CodigoVenda                     := dmdados.tbAberComaCodVen.value ;
  DataVenda                       := dmdados.tbAberComaDataVen.Value;
  dmdados.tbAberComaHoraVen.Value := Time                           ;
  dmdados.tbAberComaValor.Value   := Venda                          ;
  dmDados.tbAberComaCodCli.Value  := CodCli                         ;
  dmDados.tbAberComaObs.Value     := Motivo                         ;
  dmDados.tbAberComaStatus.Value  := 'C'                            ;
  dmDados.tbAberComa.Post;
  for Cont:=0 to frmComanda.Componentcount-1 do
    if (frmComanda.Components[Cont] is TJvDBSpinEdit) then
        if (TJvDBSpinEdit(frmComanda.Components[Cont]).Tag <> 0) and
           (TJvDBSpinEdit(frmComanda.Components[Cont]).Value > 0) then
          begin
          dmDados.tbEstoque.RecNo := TJvDBSpinEdit(frmComanda.Components[Cont]).Tag;
          dmdados.tbDetAberComa.Append;
          dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                                     ;
          dmdados.tbDetAberComaDataVen.Value   := DataVenda                                       ;
          dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value                  ;
          dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value              ;
          dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value               ;
          dmdados.tbDetAberComaQuant.Value     := TJvDBSpinEdit(frmComanda.Components[Cont]).Value;
          dmDados.tbDetAberComa.Post;
          end;
  if (dmDados.tbOutros.RecordCount > 0) then
    begin
    dmDados.tbOutros.First;
    while (not dmDados.tbOutros.Eof) do
      begin
      dmDados.tbEstoque.First;
      dmdados.tbEstoque.Locate('CodMerc',dmDados.tbOutrosCodProd.Value,[]);
      dmdados.tbDetAberComa.Append;
      dmdados.tbDetAberComaCodVen.Value    := CodigoVenda                                     ;
      dmdados.tbDetAberComaDataVen.Value   := DataVenda                                       ;
      dmDados.tbDetAberComaCodMerc.Value   := dmDados.tbEstoqueCodMerc.Value                  ;
      dmdados.tbDetAberComaCustoUnit.Value := dmdados.tbEstoquePrecoCompra.Value              ;
      dmdados.tbDetAberComaPrecoUnit.Value := dmdados.tbEstoquePrecoVenda.Value               ;
      dmdados.tbDetAberComaQuant.Value     := dmDados.tbOutrosQuant.Value                     ;
      dmDados.tbDetAberComa.Post;
      dmDados.tbOutros.Next;
      end;
    end;
  frmComanda.ApagaComanda;
  Close;
end;

end.
