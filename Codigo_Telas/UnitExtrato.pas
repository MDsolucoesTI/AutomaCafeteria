//////////////////////////////////////////////////////////////////////////
// Criação...........: 13-02-2001
// Ultima modificação: 28-06-2007
// Sistema...........: Olimpo Cafe - Automação de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitExtrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RxLookup, Mask, ToolEdit, JvLabel, EMsgDlg, fcLabel,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, JvComponent, JvTransBtn;

type
  TFrmExtrato = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel1: TfcLabel;
    Panel3: TLMDBackPanel;
    LMDBackPanel3: TLMDBackPanel;
    MsgDlg: TEvMsgDlg;
    JvLabel1: TJvLabel;
    EdtInicial: TDateEdit;
    EdtFinal: TDateEdit;
    edConta: TRxLookupEdit;
    cmbDestino: TComboBox;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    btnImprimir: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    procedure btnSairClick(Sender: TObject);
    procedure cmbDestinoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExtrato: TFrmExtrato;

implementation

{$R *.dfm}

procedure TFrmExtrato.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmExtrato.cmbDestinoExit(Sender: TObject);
begin
  Panel3.SetFocus;
end;

end.
