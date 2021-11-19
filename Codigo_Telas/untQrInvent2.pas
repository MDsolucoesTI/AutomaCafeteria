//////////////////////////////////////////////////////////////////////////
// Criação...........: 08-02-2001
// Ultima modificação: 24-06-2007
// Sistema...........: Olimpo Cafe - Automação de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit untQrInvent2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQrInvent2 = class(TQuickRep)
    QRBand1: TQRBand;
    QRDBImage1: TQRDBImage;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRBand2: TQRBand;
    QRShape1: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText8: TQRDBText;
    QRShape2: TQRShape;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
  private

  public

  end;

var
  QrInvent2: TQrInvent2;

implementation

uses unitDmDados;

{$R *.DFM}

end.
