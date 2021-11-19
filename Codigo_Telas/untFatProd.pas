//////////////////////////////////////////////////////////////////////////
// Criação...........: 07-02-2001
// Ultima modificação: 25-06-2007
// Sistema...........: Olimpo Cafe - Automação de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untFatProd;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TqrFatPro = class(TQuickRep)
    tbFaturamento: TTable;
    tbFaturamentoDataVen: TDateField;
    tbFaturamentoTotalVenda: TCurrencyField;
    tbFaturamentoTotalDesc: TCurrencyField;
    tbFaturamentoTotalCom: TCurrencyField;
    tbFaturamentoTotalCusto: TCurrencyField;
    dsFaturamento: TDataSource;
    tbFatProd: TTable;
    tbFatProdDataVen: TDateField;
    tbFatProdCodMerc: TStringField;
    tbFatProdDescricao: TStringField;
    tbFatProdValor: TCurrencyField;
    tbFatProdPerc: TFloatField;
    dsFatProd: TDataSource;
    TitleBand1: TQRBand;
    QRDBImage1: TQRDBImage;
    qrlTitulo: TQRLabel;
    QRDBText10: TQRDBText;
    tbFatProdQuant: TFloatField;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    tbFaturamentoDiferenca: TCurrencyField;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    procedure tbFaturamentoCalcFields(DataSet: TDataSet);
  private

  public

  end;

var
  qrFatPro: TqrFatPro;

implementation

{$R *.DFM}

procedure TqrFatPro.tbFaturamentoCalcFields(DataSet: TDataSet);
begin
  tbFaturamentoDiferenca.Value := tbFaturamentoTotalVenda.Value - tbFaturamentoTotalCusto.Value;
end;

end.
