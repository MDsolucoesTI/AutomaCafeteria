/////////////////////////////////////////////////////////////////////////
// Criação...........: 15-02-2001
// Ultima modificação: 16-06-2007
// Sistema...........: Olimpo Cafe - Automação de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit unitQrVendasCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls;

type
  TQrVendaCli = class(TForm)
    rpvendaCli: TQuickRep;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    TitleBand1: TQRBand;
    qrlTitulo: TQRLabel;
    QRDBImage1: TQRDBImage;
    qrSubDetVenda: TQRSubDetail;
    hbDetVenda: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText1: TQRDBText;
    qedbValor: TQRDBText;
    QRLabel4: TQRLabel;
    QRLabel2: TQRLabel;
    qrlValor: TQRLabel;
    QRDBText4: TQRDBText;
    QRShape2: TQRShape;
    qrlCod: TQRLabel;
    qrdbCod: TQRDBText;
    qrlNome: TQRLabel;
    qrdbNome: TQRDBText;
    QRShape1: TQRShape;
    QRLabel6: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel3: TQRLabel;
    qrdbPagto: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel9: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText6: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QrVendaCli: TQrVendaCli;

implementation

uses unitDmDados;

{$R *.dfm}

end.
