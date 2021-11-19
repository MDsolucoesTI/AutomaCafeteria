/////////////////////////////////////////////////////////////////////////
// Criação...........: 05-02-2001
// Ultima modificação: 05-07-2007
// Sistema...........: Olimpo Cafe - Automação de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitLocCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fcButton, fcImgBtn, StdCtrls, Grids, DBGrids, RXDBCtrl,
  RackCtls, RXCtrls, fcLabel, EGrad, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDBackPanel, EMsgDlg;

type
  TFrmLocCaixa = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel1: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    RxLabel3: TRxLabel;
    RxLabel1: TRxLabel;
    LEDButton1: TLEDButton;
    RxLabel2: TRxLabel;
    RxLabel7: TRxLabel;
    LEDButton2: TLEDButton;
    Cmbcampo: TComboBox;
    RxDBGrid1: TRxDBGrid;
    EdtCampo: TEdit;
    EdtValor: TEdit;
    fclLocCli: TfcImageBtn;
    fclSair: TfcImageBtn;
    MsgDlg: TEvMsgDlg;
    procedure fclSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLocCaixa: TFrmLocCaixa;

implementation

uses UnitPrincipal, unitDmDados;

{$R *.dfm}

procedure TFrmLocCaixa.fclSairClick(Sender: TObject);
begin
    Close;
end;

procedure TFrmLocCaixa.FormShow(Sender: TObject);
begin
  FrmPrincipal.StatusTeclas(True,'[PageUp] A=ABC [PageDown] A=a [F10] Localizar [ESC] Sai');
end;

end.
