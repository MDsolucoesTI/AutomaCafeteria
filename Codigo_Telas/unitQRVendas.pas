/////////////////////////////////////////////////////////////////////////
// Criação...........: 05-03-2001
// Ultima modificação: 15-06-2007
// Sistema...........: Olimpo Cafe - Automação de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit unitQRVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, StdCtrls, Mask, DBCtrls, DB,
  DBTables;

type
  TQrVenda = class(TForm)
    rpVenda: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    TitleBand1: TQRBand;
    QRDBImage1: TQRDBImage;
    qrlTitulo: TQRLabel;
    qrlCod: TQRLabel;
    qrlNome: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    GroupHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRDBText10: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRBand1: TQRBand;
    QRExpr1: TQRExpr;
    tbVendas: TTable;
    tbVendasCodVen: TSmallintField;
    tbVendasDataven: TDateField;
    tbVendasHoraVen: TTimeField;
    tbVendasCodCli: TIntegerField;
    tbVendasValor: TCurrencyField;
    tbVendasDesconto: TCurrencyField;
    tbVendasCodFunc: TIntegerField;
    tbVendasUserName: TStringField;
    tbVendasCodIndex: TIntegerField;
    tbVendasLkNomeCli: TStringField;
    tbVendasValorFinal: TCurrencyField;
    tbVendasEntrega: TDateField;
    tbVendaslknomefunc: TStringField;
    tbVendasCaixa: TStringField;
    tbVendasCodForPag: TStringField;
    dsVendas: TDataSource;
    QRLabel4: TQRLabel;
    BaseDados: TDatabase;
    tbVisDetVen: TTable;
    tbVisDetVenDataVen: TDateField;
    tbVisDetVenCodVen: TSmallintField;
    tbVisDetVenCodMerc: TStringField;
    tbVisDetVenCustoUnit: TCurrencyField;
    tbVisDetVenPrecoUnit: TCurrencyField;
    tbVisDetVenQuant: TFloatField;
    tbVisDetVenComissao: TFloatField;
    tbVisDetVenNF: TStringField;
    tbVisDetVenLKnome: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QrVenda: TQrVenda;

implementation

uses unitDmDados;

{$R *.dfm}

end.
