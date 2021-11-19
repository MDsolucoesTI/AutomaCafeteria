//////////////////////////////////////////////////////////////////////////
// Criação...........: 07-03-2001
// Ultima modificação: 14-06-2007
// Sistema...........: Olimpo Cafe - Automação de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitQREstoque;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQREstoque = class(TQuickRep)
    QRBand1: TQRBand;
    QRDBImage1: TQRDBImage;
    QRLabel2: TQRLabel;
    QRBand2: TQRBand;
    QRShape1: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel8: TQRLabel;
    QRBand3: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText8: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRDBText1: TQRDBText;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
  private

  public

  end;

var
  QREstoque: TQREstoque;

implementation

uses unitDmDados;

{$R *.DFM}

end.
