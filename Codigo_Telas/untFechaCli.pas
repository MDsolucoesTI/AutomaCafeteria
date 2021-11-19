//////////////////////////////////////////////////////////////////////////
// Cria��o...........: 07-05-2007
// Ultima modifica��o: 21-06-2007
// Sistema...........: Olimpo Cafe - Automa��o de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untFechaCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, EMsgDlg, JvComponent, JvTransBtn;

type
  TfrmFechaCli = class(TForm)
    MsgDlg: TEvMsgDlg;
    Label1: TLabel;
    pbFecha: TProgressBar;
    btnFecha: TJvTransparentButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFechaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFechaCli: TfrmFechaCli;

implementation

uses unitDmDados;

{$R *.dfm}

procedure TfrmFechaCli.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmDados.tbCliente.Close;
  dmDados.tbVendas.Close;
  dmDados.tbCReceber.Close;
  dmDados.tbContaCliente.Close;
  Action := caFree;
end;

procedure TfrmFechaCli.btnFechaClick(Sender: TObject);
var
  Dia   : word     ;
  Mes   : word     ;
  Ano   : word     ;
  DtIni : TDateTime;
  DtFim : TDateTime;
  Venc  : TDateTime;
  Total : real     ;
begin
  DecodeDate(Now,Ano,Mes,Dia);
  DtIni := StrToDate('01/'+IntToStr(Mes-1)+'/'+IntToStr(Ano));
  DtFim := dmDados.DataFim(DtIni)                            ;
  Venc  := StrToDate('15/'+IntToStr(Mes)+'/'+IntToStr(Ano))  ;
  with dmDados do
    begin
    tbCliente.First;
    pbFecha.Position := tbCliente.RecNo      ;
    while Not(tbCliente.Eof) do
      begin
      if (tbClienteCodCli.Value <> 1) then
        begin
        tbVendas.Filtered := False;
        tbVendas.Filter   := '(((DataVen >= '''+DateToStr(DtIni)+
                             ''')And(DataVen <= '''+DateToStr(DtFim)+
                             '''))And(CodCli = '''+IntToStr(tbClienteCodCli.Value)+'''))';
        tbVendas.Filtered := True;
        tbVendas.First;
        Total := 0;
        while Not(tbVendas.Eof) do
          begin
          Total := Total + tbVendasValor.Value;
          tbVendas.Next;
          end;
        if (Total > 0) then
          begin
          //Gerar o Contas a Receber
          tbCReceber.Append;
          tbCReceberCodCli.Value     := tbClienteCodCli.Value                   ;
          tbCReceberCodDoc.Value     := '4'                                     ;
          tbCReceberNumDoc.Value     := 'Comandas do m�s = '+IntToStr(Mes-1)    ;
          tbCReceberDataVen.Value    := DtFim                                   ;
          tbCReceberDataEmis.Value   := DtIni                                   ;
          tbCReceberDataVenc.Value   := Venc                                    ;
          tbCReceberCompHist.Value   := 'Pedidos do per�odo: '+DateToStr(DtIni)
                                        +' a '+DateToStr(DtFim)                 ;
          tbCReceberValor.Value      := Total                                   ;
          tbCReceberPago.Value       := 'ABERTO'                                ;
          tbCReceberDescDia.Value    := Venc - dmDados.TbParametroDescDia.Value ;
          tbCReceberMultaDia.Value   := Venc + dmDados.TbParametroMultaDia.Value;
          tbCReceberJurosDia.Value   := Venc + dmDados.TbParametroJurosDia.Value;
          tbCReceberPercDesc.Value   := dmdados.TbParametroPercDesc.Value       ;
          tbCReceberPercMulta.Value  := dmdados.TbParametroPercMulta.Value      ;
          tbCReceberPercJuros.Value  := dmdados.TbParametroPercMulta.Value      ;
          tbCReceberValorMulta.Value := 0                                       ;
          tbCReceberValorDesc.Value  := 0                                       ;
          tbCReceberValorJuros.Value := 0                                       ;
          tbCReceber.Post;
          //Ajustar Conta Cliente
          tbContaCliente.Locate('Conta',tbClienteCodCli.Value,[]);
          tbContaCliente.Edit;
          tbContaClienteSaldo.Value := tbContaClienteSaldo.Value + Total      ;
          tbContaCliente.Post;
          end;
        end
      else
        begin
        //Ajustar Conta COnzumidor - Zerar
        tbContaCliente.Locate('Conta',IntToStr(tbClienteCodCli.Value),[]);
        tbContaCliente.Edit;
        tbContaClienteSaldo.Value := 0;
        tbContaCliente.Post;
        end;
      tbCliente.Next;
      pbFecha.Position := tbCliente.RecNo;
      end;
    end;
  MsgDlg.MsgInformation('Fechamento Conclu�do....');
  dmDados.tbVendas.Filtered := False;
  Close;
end;

procedure TfrmFechaCli.FormShow(Sender: TObject);
begin
  dmDados.tbCliente.Open;
  dmDados.tbVendas.Open;
  dmDados.tbCReceber.Open;
  dmDados.tbContaCliente.Open;
  pbFecha.Max := dmDados.tbCliente.RecordCount;
end;

end.
