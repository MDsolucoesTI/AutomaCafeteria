//////////////////////////////////////////////////////////////////////////
// Criação...........: 07-03-2001
// Ultima modificação: 14-06-2007
// Sistema...........: Olimpo Cafe - Automação de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitQRCReceber;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, DB, DBTables;

type
  TQRCreceber = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText5: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBand2: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBImage1: TQRDBImage;
    QRDBText8: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRDBText9: TQRDBText;
    tbCReceber: TTable;
    tbCReceberCodCRec: TAutoIncField;
    tbCReceberNumDoc: TStringField;
    tbCReceberCodDoc: TStringField;
    tbCReceberCodCli: TIntegerField;
    tbCReceberCodVen: TSmallintField;
    tbCReceberDataVen: TDateField;
    tbCReceberCodCServ: TIntegerField;
    tbCReceberDataEmis: TDateField;
    tbCReceberDataVenc: TDateField;
    tbCReceberCodHist: TStringField;
    tbCReceberValor: TCurrencyField;
    tbCReceberValorMulta: TCurrencyField;
    tbCReceberValorDesc: TCurrencyField;
    tbCReceberValorJuros: TCurrencyField;
    tbCReceberDataPaga: TDateField;
    tbCReceberValorPago: TCurrencyField;
    tbCReceberPago: TStringField;
    tbCReceberCodCCusto: TStringField;
    tbCReceberMultaDia: TDateField;
    tbCReceberPercMulta: TFloatField;
    tbCReceberDescDia: TDateField;
    tbCReceberPercDesc: TFloatField;
    tbCReceberJurosDia: TDateField;
    tbCReceberPercJuros: TFloatField;
    tbCReceberlkCliente: TStringField;
    tbCReceberLkTipoDoc: TStringField;
    tbCReceberCompHist: TStringField;
    tbCReceberlknome: TStringField;
    tbCReceberlkcpf: TStringField;
    tbCReceberLkEndereco: TStringField;
    tbCReceberlknumero: TStringField;
    tbCReceberlkbairro: TStringField;
    tbCReceberlkcidade: TStringField;
    tbCReceberlkuf: TStringField;
    tbCReceberlkcep: TStringField;
    tbCReceberPortador: TStringField;
    tbCReceberTipoPago: TStringField;
    tbCReceberNumBanco: TStringField;
    tbCReceberDescPago: TCurrencyField;
    tbCReceberMuJuPago: TCurrencyField;
    dsCReceber: TDataSource;
    QRBand5: TQRBand;
    SomaValor: TQRExpr;
    QRLabel1: TQRLabel;
  private

  public

  end;

var
  QRCreceber: TQRCreceber;

implementation

uses unitDmDados;

{$R *.DFM}

end.
